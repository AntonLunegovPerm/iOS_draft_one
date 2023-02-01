//
//  ProductListUpdating.swift
//  DraftProject
//
//  Created by Антон Лунегов on 01.02.2023.
//

import Foundation

/// Протокол для презентеров экранов, в которых есть слайдер(ы) с продуктами. Содержит общую логику обновления ячеек локально, без запросов к серверу. Источником обновлений, как правило, служит `ProductUpdateManager.didUpdateProductNotificationName` или
protocol ProductListUpdating: AnyObject {
    
    /// Массив со всеми вьюмоделями продуктовых ячеек на экране. Складывать/удалять оттуда элементы неоходимо вручную. Пример: `MainMenuPresenter`
    var productViewModels: [ProductListProductCollectionCellItem] { get set }
    
    var updateManager: ProductUpdateManager { get }
    
    /// Обновить продуктовые ячейки без перезапроса
    /// - parameter updates: Массив типа `ProductUpdate`, где содержится информация об обновлении продукта (ид продукта,
    ///  количество в корзине и признак избранного)
    func updateProductViewModels(updates: [ProductUpdate])
    
    /// Подписаться на уведомления об обновлении продуктов. Само обновление происходит в методе `updateProductViewModels(updateInfo: productViewModel:)`
    /// - Parameter preUpdateAction: closure
    func subscribeToProductsUpdates(preUpdateAction: (() -> Void)?)
}

extension ProductListUpdating {
    
    var updateManager: ProductUpdateManager { ProductUpdateManager.shared }
    
    func subscribeToProductsUpdates(preUpdateAction: (() -> Void)? = nil) {
        updateManager.subscribe { [weak self] updates in
            self?.updateProductViewModels(updates: updates)
        }
    }
    
    /// Пройтись по всем моделям ячеек продуктов на экране и обновить кол-во в корзине и избранном
    func updateProductViewModels(updates: [ProductUpdate]) {
        for update in updates {
            let products = productViewModels.filter { $0.product.id == update.productId }
            
            products.forEach { vm in
                // если мы сейчас в процессе выбора кол-ва товара, игнорируем обновления и "не вмешиваемся" в процесс
                if !vm.isEditing, let count = update.count {
                    vm.product.quantity = count
                    vm.updateCount?()
                }
                
                if let isFavorite = update.isFavorite {
                    vm.product.isFavorite = isFavorite
                    vm.updateFavorites?()
                }
            }
        }
    }
}

