//
//  ItemDiscount.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 05.11.2024.
//

import Foundation

struct ItemDiscount {
    /// Метод для того что бы создать скиндку на конкретный товар/работу/услугу
    /// Нельзя его использовать для пустого ticket, только если в ticket есть товар/работа/услуга
    func createItemDiscount(name: String, sum: Kkm_Proto_Money) throws -> Kkm_Proto_TicketRequest.Item {
        var item = Kkm_Proto_TicketRequest.Item()
        
        
        item.type = Kkm_Proto_TicketRequest.Item.ItemTypeEnum.itemTypeDiscount
        
        do {
            let discount = try Discount().createDicountModifier(name: name, sum: sum)
            item.discount = discount
        } catch {
            throw error
        }
        
        return item
    }
}
