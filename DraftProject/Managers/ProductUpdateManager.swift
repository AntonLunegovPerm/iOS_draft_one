//
//  ProductUpdateManager.swift
//  DraftProject
//
//  Created by Антон Лунегов on 01.02.2023.
//

import Foundation

/// Модель обновления продукта. Если `count` или `isFavorite` равны `nil` , значит, это поле стоит игнорировать при применении обнволения.
struct ProductUpdate {
    let productId: String
    let count: Double?
    let isFavorite: Bool?
}

protocol ProductUpdateManagerProtocol {
    func subscribe(updateBlock: @escaping ([ProductUpdate]) -> ())
    
    func sendBasketCountUpdate(rawUpdate: [String : Double])
    func sendFavoritesUpdate(productId: String, isFavorite: Bool)
}

/// Объект, который принимает обновления продукта (изменили кол-во продукта в корзине или добавили/удалили из избранного) и позволяет подписчикам следить за этими обновлениями
final class ProductUpdateManager {

    private static let didUpdateProductNotificationName = Notification.Name(rawValue: "didUpdateProductNotificationName")
    static let shared = ProductUpdateManager()
    private init() {}
    
    func subscribe(updateBlock: @escaping ([ProductUpdate]) -> ()) {
        NotificationCenter.default.addObserver(
            forName: Self.didUpdateProductNotificationName,
            object: nil,
            queue: .main
        ) { not in
            DispatchQueue.main.async {
                guard let userInfo = not.userInfo as? [String : ProductUpdate] else { return }
                updateBlock(userInfo.map { $0.value })
            }
        }
    }
    
    func sendBasketCountUpdate(rawUpdate: [String : Double]) {
        let updates = rawUpdate.map { (key, value) in
            (key, ProductUpdate(productId: key, count: value, isFavorite: nil))
        }
        NotificationCenter.default.post(
            name: Self.didUpdateProductNotificationName,
            object: nil,
            userInfo: Dictionary(uniqueKeysWithValues: updates)
        )
    }
    
    func sendFavoritesUpdate(productId: String, isFavorite: Bool) {
        NotificationCenter.default.post(
            name: Self.didUpdateProductNotificationName,
            object: nil,
            userInfo: [productId : ProductUpdate(productId: productId, count: nil, isFavorite: isFavorite)]
        )
    }
    
    
    /// Уведомить Удалить продукты из корзины
    /// - Parameter productIds: id продуктов, которые  требуется удалить
    func sendRemoveProductsUpdate(productIds: [String]) {
        let rawUpdates = productIds.reduce(into: [String : Double]()) { result, productId in
            result[productId] = 0
        }
        
        sendBasketCountUpdate(rawUpdate: rawUpdates)
    }
}
