//
//  ItemCommodity.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 04.11.2024.
//

struct ItemCommodity {
    // MARK: Item
    /// В этом разделе мы не добавили ItemStornoCommodity/ItemStornoMarkup/ItemStornoDiscount,
    /// так как считаем их legacy от "железных касс" и излишней функцией.
    ///
    /// Метод для того чтобы создать `Item` с конкретной позицией товара/услуги.
    ///
    /// - Parameters:
    ///   - name: Название товара, услуги или работы.
    ///   - sectionCode: Код секции.
    ///   - quantity: Количество товара.
    ///   - price: Цена товара в формате `Kkm_Proto_Money`.
    ///   - taxes: Налоги, применяемые к товару.
    ///   - exciseStamp: Опциональная акцизная марка.
    ///   - barcode: Опциональный штрихкод товара.
    ///   - measureUnitCode: Код единицы измерения.
    ///
    /// - Throws: Ошибки, возникшие при создании объекта `Commodity`.
    ///
    /// - Returns: Объект типа `Kkm_Proto_TicketRequest.Item`.
    func createItemCommodity(name: String,
                             sectionCode: String,
                             quantity: UInt32,
                             price: Kkm_Proto_Money,
                             taxes: [Kkm_Proto_TicketRequest.Tax],
                             exciseStamp: String?,
                             barcode: String?,
                             measureUnitCode: UnitOfMeasurement) throws -> Kkm_Proto_TicketRequest.Item {
        var item = Kkm_Proto_TicketRequest.Item()

        // Устанавливаем тип элемента как товар (коммодити)
        item.type = Kkm_Proto_TicketRequest.Item.ItemTypeEnum.itemTypeCommodity

        // Создаем объект commodity, используя метод из Commodity.
        do {
            let commodity = try Commodity().createCommodity(
                name: name,
                sectionCode: sectionCode,
                quantity: quantity,
                price: price,
                taxes: taxes,
                exciseStamp: exciseStamp,
                barcode: barcode,
                measureUnitCode: measureUnitCode
            )
            item.commodity = commodity
        } catch {
            // Выбрасываем ошибку дальше или обрабатываем её, если необходимо
            throw error
        }

        return item
    }
}
