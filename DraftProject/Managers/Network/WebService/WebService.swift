//
//  WebService.swift
//  DraftProject
//
//  Created by LAV on 31.01.2023.
//

import UIKit
import Alamofire
import Reachability
import RxSwift
import Localize_Swift

final class WebService {
    static let shared = WebService()
    let session: Alamofire.Session
    let reachability: Reachability
    private(set) var connection = Reachability.Connection.unavailable
    
    init() {
        var defaultHeaders = [String:String]()
//        defaultHeaders["apikey"] = Config.Networking.apiKey
//        defaultHeaders["lang"] = Localize.currentLanguage()
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
//        configuration.timeoutIntervalForRequest = Config.Networking.requestsTimeout
        session = Alamofire.Session(configuration: configuration)
        reachability = (try? Reachability(hostname: URL(string: "Config.Networking.serverUrl")!.host!))!
        reachability.whenReachable = { reachability in
            self.connection = reachability.connection
            NotificationCenter.default.post(name: WebService.connectionBecameAvailable, object: nil)
        }
        reachability.whenUnreachable = { _ in
            self.connection = .unavailable
            NotificationCenter.default.post(name: WebService.connectionBecameUnavailable, object: nil)
        }
        
        do {
            try reachability.startNotifier()
            connection = reachability.connection
        } catch {
            NSLog("Unable to start notifier: \(error)")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged(notification:)), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    @objc func languageChanged(notification: Notification) {
        session.sessionConfiguration.httpAdditionalHeaders?["lang"] = Localize.currentLanguage()
    }
}

extension WebService {
    @discardableResult
    func download<RequestBodyType>(resource: Resource<RequestBodyType, URL, URL>, destinationURL: URL) -> Single<URL> {
        
        return Single<URL>.create { (observer) -> Disposable in
            
            let destination: DownloadRequest.Destination  = { _, _ in
                return (destinationURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            
            let request = self.session.download(resource.url, method: resource.method, parameters: resource.body, encoder: resource.bodyEncoder, headers: resource.headers, to: destination).cURLDescription(calling: self.printRequest(log:)).validate().response { (response) -> Void in
                self.printResponse(log: response.debugDescription)
                
                if response.error != nil {
                    let downloadError = WSError(error: response.error!)
//                    observer(.error(downloadError))
                }
                else {
                    if let parsedResponse = response.fileURL.flatMap(resource.parse) {
//                        observer(.success(parsedResponse))
                    }
                    else {
//                        observer(.error(WSError(errorType: .badResponseData)))
                    }
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    @discardableResult
    func load<RequestBodyType, ParsedResponseType>(resource: Resource<RequestBodyType, Data, ParsedResponseType>) -> Single<ParsedResponseType> {
        
        return Single<ParsedResponseType>.create { (observer) -> Disposable in
            let request = self.session.request(resource.url, method: resource.method, parameters: resource.body, encoder: resource.bodyEncoder, headers: resource.headers, interceptor: nil, requestModifier: nil).cURLDescription(calling: self.printRequest(log:)).response { (response) -> Void in
                self.handle(response: response, resource: resource, observer: observer)
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    @discardableResult
    func upload<RequestBodyType, ParsedResponseType>(fileAt fileURL: URL, to resource: Resource<RequestBodyType, Data, ParsedResponseType>) -> Single<ParsedResponseType> {
        
        return Single<ParsedResponseType>.create { (observer) -> Disposable in
            let request = self.session.upload(fileURL, to: resource.url, method: resource.method, headers: resource.headers).cURLDescription(calling: self.printRequest(log:)).response { (response) in
                self.handle(response: response, resource: resource, observer: observer)
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func upload<RequestBodyType, ParsedResponseType>(multipartFormData: @escaping (MultipartFormData) -> (), to resource: Resource<RequestBodyType, Data, ParsedResponseType>) -> (uploadProgress: Observable<Double>, completion: Single<ParsedResponseType>) {
        var progressObserver: AnyObserver<Double>?
        
        let progress = Observable<Double>.create { (observer) -> Disposable in
            progressObserver = observer
            return Disposables.create()
        }
        
        let completion = Single<ParsedResponseType>.create { (observer) -> Disposable in
            let request = self.session.upload(multipartFormData: multipartFormData, to: resource.url, method: resource.method, headers: resource.headers)
                .cURLDescription(calling: self.printRequest(log:))
                .uploadProgress(closure: { (progress) in
                    progressObserver?.on(.next(progress.fractionCompleted))
                })
                .response { (response) in
                self.handle(response: response, resource: resource, observer: observer)
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
        return (uploadProgress: progress, completion: completion)
    }
    
    func handle<RequestBodyType, ParsedResponseType>(response: AFDataResponse<Data?>, resource: Resource<RequestBodyType, Data, ParsedResponseType>, observer: (SingleEvent<ParsedResponseType>) -> ()) {
        printResponse(log: response.debugDescription)
        let parsedResponse = response.data.flatMap(resource.parse)
        let downloadError = WSError(response: response)
        if parsedResponse != nil && downloadError == nil {
            observer(.success(parsedResponse!))
        }
        else {
//            observer(.error(downloadError ?? WSError(errorType: .badResponseData)))
        }
    }
    
    func cancelAllTasks() {
        self.session.cancelAllRequests()
    }
    
    private func printRequest(log: String) {
        #if DEBUG
        let log = """

        🟢 Request sent: \(log)
        
        """
        print(log)
        #endif
    }
    
    private func printResponse(log: String) {
        #if DEBUG
        let log = """

        🟢 Response received: \(log)
        
        """
        print(log)
        #endif
    }
}

extension WebService {
    static let connectionBecameAvailable = Notification.Name(rawValue: "ConnectionBecameAvailable")
    static let connectionBecameUnavailable = Notification.Name(rawValue: "ConnectionBecameUnavailable")
}

struct WebServiceResponseParser {
    static func passthrough<T>(response: T) -> T {
        return response
    }
    
    static func json<T: Decodable>(data: Data, to: T) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(T.self, from: data)
    }
}

struct WSError: Error, CustomStringConvertible, CustomDebugStringConvertible {
    enum ErrorType: Int {
        case badRequest = -100
        case unauthenticated
        case forbidden
        case notFound
        case methodNotAllowed
        case validationError
        case notAcceptable
        case serverError
        case badResponseData
        case noConnection
        case cancelled
        case timedOut
        case unknown
        
        case unknownAPIError = 0
        case modelValidationError = 1
        case duplicateUserName = 1000
        case userLockedOut = 1001
        case accessTokenExpired = 1002
        case unauthorized = 1003
        case wrongCode = 1100
        case codeDoesNotExist = 1102
        case errorSendingSms = 1103
    }
    
    struct ErrorBody: Decodable {
        let errorCode: Int
        let errors: [String]?
        
        init(errorCode: Int, errors: [String]?) {
            self.errorCode = errorCode
            self.errors = errors
        }
    }
    
    private(set) var errorType: ErrorType
    private(set) var body: ErrorBody? = nil
    var messageOrDescription: String {
        return body?.errors?.joined(separator: "\n") ?? description
    }
    
    var description: String {
        var errorMsg: String = ""
        switch errorType {
        case .badRequest:
//            errorMsg = R.string.localizable.errorBadRequest()
            break
        case .unauthenticated:
//            errorMsg = R.string.localizable.errorUnauthenticated()
            break
        case .forbidden:
//            errorMsg = R.string.localizable.errorForbidden()
            break
        case .notFound:
//            errorMsg = R.string.localizable.errorNotFound()
            break
        case .methodNotAllowed:
//            errorMsg = R.string.localizable.errorMethodNotAllowed()
            break
        case .validationError:
//            errorMsg = R.string.localizable.errorValidation()
            break
        case .notAcceptable:
//            errorMsg = R.string.localizable.errorNotAcceptable()
            break
        case .noConnection:
//            errorMsg = R.string.localizable.errorNoConnection()
            break
        case .serverError:
//            errorMsg = R.string.localizable.errorServer()
            break
        case .badResponseData:
//            errorMsg = R.string.localizable.errorBadResponseData()
            break
        case .cancelled:
//            errorMsg = R.string.localizable.errorCancelled()
            break
        case .timedOut:
//            errorMsg = R.string.localizable.errorTimedOut()
            break
        default:
//            errorMsg = R.string.localizable.errorUnknown()
            break
        }
        return errorMsg
    }
    
    var debugDescription: String {
        return description
    }
}

extension WSError {
    init?(response: AFDataResponse<Data?>) {
        switch response.result {
        case .success(let data):
            
            let statusCode = response.response?.statusCode ?? 0
            
            switch statusCode {
            case 200...299:
                return nil
            case 400:
                self.init(errorType: .badRequest)
            case 401:
                self.init(errorType: .unauthenticated)
            case 403:
                self.init(errorType: .forbidden)
            case 404:
                self.init(errorType: .notFound)
            case 405:
                self.init(errorType: .methodNotAllowed)
            case 406:
                self.init(errorType: .notAcceptable)
            case 422:
                self.init(errorType: .validationError)
            case 500:
                self.init(errorType: .serverError)
            default:
                self.init(errorType: .unknown)
            }
            
            if let data = data {
                body = try? JSONDecoder().decode(ErrorBody.self, from: data)
                if let errorCode = body?.errorCode, let errorType = ErrorType(rawValue: errorCode) {
                    self.errorType = errorType
                }
            }
            
        case .failure(let err):
            self.init(error: err)
        }
    }
    
    init(error: AFError) {
        switch error {
        case .explicitlyCancelled:
            errorType = .cancelled
        case .invalidURL, .sessionDeinitialized, .urlRequestValidationFailed:
            errorType = .badRequest
        default:
            errorType = (error.underlyingError as NSError?)?.webServiceErrorType ?? .unknown
        }
    }
    
    init?(error: NSError) {
        guard let errorType = error.webServiceErrorType else {
            return nil
        }
        
        self.errorType = errorType
    }
    
    static var unknown: WSError {
        return WSError(errorType: .unknown)
    }
}

private extension NSError {
    var webServiceErrorType: WSError.ErrorType? {
        switch code {
        case NSURLErrorUserCancelledAuthentication, NSURLErrorUserAuthenticationRequired:
            return .unauthenticated
        case NSURLErrorCancelled:
            return .cancelled
        case NSURLErrorBadURL, NSURLErrorUnsupportedURL:
            return .badRequest
        case NSURLErrorTimedOut:
            return .timedOut
        case NSURLErrorCannotConnectToHost, NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet:
            return .noConnection
        case NSURLErrorBadServerResponse:
            return .serverError
        default:
            return nil
        }
    }
}

enum MIMEType: String {
    case binaryFile = "application/octet-stream"
    case imageJpeg = "image/jpeg"
    case imagePng = "image/png"
    case audioWav = "audio/wav"
}

extension MultipartFormData {
    func append(_ data: Data, withName name: String, mimeType: MIMEType, fileName: String? = nil) {
        var fileName = fileName
        if fileName == nil {
            switch mimeType {
            case .binaryFile:
                fileName = "file"
            case .imageJpeg:
                fileName = "image.jpg"
            case .imagePng:
                fileName = "image.png"
            case .audioWav:
                fileName = "audio.wav"
            }
        }
        
        append(data, withName: name, fileName: fileName, mimeType: mimeType.rawValue)
    }
}

