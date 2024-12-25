//
//  ItemPositions.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 05.11.2024.
//

import Foundation

/// Структура `ItemPositions` отвечает за создание и обработку позиций товаров, услуг или работ,
/// а также за расчет и объединение скидок для этих позиций.
struct ItemPositions {
    
    /// Создает массив позиций товаров и услуг, а также суммирует скидки, если они присутствуют.
    ///
    /// - Parameters:
    ///   - ticketOperation: Тип операции с чеком (0 - покупка, 1 - возврат покупки, 2 - продажа, 3 - возврат продажи).
    ///   - isTaxAllTicket: Флаг, указывающий, что налог применяется ко всему чеку.
    ///   - isDiscountAllTicket: Флаг, указывающий, что скидка применяется ко всему чеку.
    ///   - ticketItems: Массив объектов `TicketItem`, представляющих товары, услуги или работы в чеке.
    /// - Throws: Генерирует ошибку, если `ticketItems` пуст, или если обнаружены несоответствия в данных (например, некорректные налоги или скидки).
    /// - Returns: Кортеж, содержащий массив объектов `Kkm_Proto_TicketRequest.Item` и суммированную скидку `Kkm_Proto_TicketRequest.Modifier?`, если такая есть.
    func createItemPositions(ticketOperation: UInt, isTaxAllTicket: Bool, isDiscountAllTicket: Bool, ticketItems: [TicketItem]) throws -> [Kkm_Proto_TicketRequest.Item] {
        guard !ticketItems.isEmpty else {
            throw NSError(domain: "createItemPositions", code: 1, userInfo: [NSLocalizedDescriptionKey: "Список товаров и услуг (ticketItems) не может быть пустым."])
        }
        
        var itemsCpcr = [Kkm_Proto_TicketRequest.Item]()
        var itemsDiscount: Kkm_Proto_TicketRequest.Modifier?
        
        for item in ticketItems {
            let itemCommodity = try createItemCommodity(for: item, isTaxAllTicket: isTaxAllTicket, ticketOperation: ticketOperation)
            itemsCpcr.append(itemCommodity)
            
            if item.isTicketItemDiscount {
                try createItemDiscount(for: item, isDiscountAllTicket: isDiscountAllTicket, itemsCpcr: &itemsCpcr, itemsDiscount: &itemsDiscount)
            }
        }
        
        return (itemsCpcr)
    }
    
    // MARK: - Private Helper Methods
    
    /// Создает позицию товара, услуги или работы, применяет налоги и проверяет соответствие правилам операции с чеком.
    ///
    /// - Parameters:
    ///   - item: Объект `TicketItem`, представляющий товар, услугу или работу.
    ///   - isTaxAllTicket: Флаг, указывающий, что налог применяется ко всему чеку.
    ///   - ticketOperation: Тип операции с чеком.
    /// - Throws: Генерирует ошибку, если налог указан некорректно или если скидки недопустимы для данной операции.
    /// - Returns: Объект `Kkm_Proto_TicketRequest.Item`, представляющий позицию в чеке.
    private func createItemCommodity(for item: TicketItem, isTaxAllTicket: Bool, ticketOperation: UInt) throws -> Kkm_Proto_TicketRequest.Item {
        let money = Money()
        let price = try money.createMoney(bills: item.billsPrice, coins: item.coinsPrice)
        var itemTaxs: [Kkm_Proto_TicketRequest.Tax] = []
        
        if item.isTicketItemTax {
            guard !isTaxAllTicket else {
                throw NSError(domain: "createItemPositions", code: 2, userInfo: [NSLocalizedDescriptionKey: "Ошибка с передачей налогов: в чеке может быть либо налог на весь чек, либо налог на каждую позицию. Проверьте корректность входных данных"])
            }
            
            guard let tax = item.tax, let billsTax = item.billsTax, let coinsTax = item.coinsTax else {
                throw NSError(domain: "createItemPositions", code: 3, userInfo: [NSLocalizedDescriptionKey: "Налог на позицию (isTicketItemTax) указан, но значения tax, billsTax или coinsTax отсутствуют."])
            }
            
            let taxes = Tax()
            itemTaxs = try taxes.createTax(percent: tax, sum: money.createMoney(bills: billsTax, coins: coinsTax))
        }
        
        if (item.isTicketItemDiscount && (ticketOperation == 1 || ticketOperation == 3)) {
            throw NSError(domain: "createItemPositions", code: 4, userInfo: [NSLocalizedDescriptionKey: "При операциях возврат покупки или возврат продажи не может быть скидок вообще!!!"])
        }
        
        let itemCommodity = try ItemCommodity().createItemCommodity(
            name: item.nameTicketItem,
            sectionCode: item.sectionCode,
            quantity: item.quantity,
            price: price,
            taxes: itemTaxs,
            exciseStamp: item.dataMatrix,
            barcode: item.barcode,
            measureUnitCode: item.measureUnitCode
        )
        
        return itemCommodity
    }
    
    /// Создает скидку на позицию, проверяет корректность данных и добавляет её в список позиций.
    ///
    /// - Parameters:
    ///   - item: Объект `TicketItem`, для которого создается скидка.
    ///   - isDiscountAllTicket: Флаг, указывающий, что скидка применяется ко всему чеку.
    ///   - itemsCpcr: Список позиций чека, к которому добавляется скидка.
    ///   - itemsDiscount: Итоговая скидка, которая суммируется, если скидки уже были добавлены.
    /// - Throws: Генерирует ошибку, если данные для скидки некорректны.
    private func createItemDiscount(for item: TicketItem, isDiscountAllTicket: Bool, itemsCpcr: inout [Kkm_Proto_TicketRequest.Item], itemsDiscount: inout Kkm_Proto_TicketRequest.Modifier?) throws {
        guard !isDiscountAllTicket else {
            throw NSError(domain: "createItemPositions", code: 5, userInfo: [NSLocalizedDescriptionKey: "Скидка может быть только на позицию или на весь чек"])
        }
        
        guard let itemDiscountName = item.discountName else {
            throw NSError(domain: "createItemPositions", code: 6, userInfo: [NSLocalizedDescriptionKey: "У скидки обязательно должно быть имя"])
        }
        
        guard let itemBillsDiscount = item.billsDiscount, let itemCoinsDiscount = item.coinsDiscount else {
            throw NSError(domain: "createItemPositions", code: 7, userInfo: [NSLocalizedDescriptionKey: "У скидки обязательно должны быть суммы в billsDiscount и coinsDiscount"])
        }
        
        let money = Money()
        let itemDiscount = ItemDiscount()
        let itemCpcrDiscount = try itemDiscount.createItemDiscount(name: itemDiscountName, sum: money.createMoney(bills: itemBillsDiscount, coins: itemCoinsDiscount))
        
        itemsCpcr.append(itemCpcrDiscount)
    }
}
