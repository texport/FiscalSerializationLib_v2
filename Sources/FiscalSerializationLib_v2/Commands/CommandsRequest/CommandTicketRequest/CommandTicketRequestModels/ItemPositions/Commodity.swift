//
//  Commodity.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 04.11.2024.
//

import Foundation

struct Commodity {
    // MARK: - Public Methods

    /// Метод создает конкретную работу, товар, услугу
    ///
    /// - Parameters:
    ///   - name: Название товара, услуги или работы.
    ///   - sectionCode: Код секции.
    ///   - quantity: Количество товара в тысячных.
    ///   - price: Цена товара в формате `Kkm_Proto_Money`.
    ///   - taxes: Налоги, применяемые к товару.
    ///   - exciseStamp: Акцизная марка (опционально).
    ///   - barcode: Штрихкод товара (опционально).
    ///   - measureUnitCode: Код единицы измерения.
    /// - Throws: Ошибка, если имя невалидно.
    /// - Returns: Объект типа `Kkm_Proto_TicketRequest.Item.Commodity`.
    func createCommodity(name: String,
                             sectionCode: String,
                             quantity: UInt32,
                             price: Kkm_Proto_Money,
                             taxes: [Kkm_Proto_TicketRequest.Tax],
                             exciseStamp: String?,
                             barcode: String?,
                             measureUnitCode: UnitOfMeasurement) throws -> Kkm_Proto_TicketRequest.Item.Commodity {
        try validateName(name)
        try validateSectionCode(sectionCode)
        try validateQuantity(quantity)
        try validateMeasureUnitCode(measureUnitCode)
        try validateQuantityInThousands(quantity)
        if let exciseStamp = exciseStamp {
            try validateExciseStamp(exciseStamp)
        }
        if let barcode = barcode {
            try validateBarcode(barcode)
        }

        var itemCommodity = Kkm_Proto_TicketRequest.Item.Commodity()
        itemCommodity.name = name
        itemCommodity.sectionCode = sectionCode
        itemCommodity.quantity = quantity
        itemCommodity.price = price
        itemCommodity.sum = calculateSum(quantity: quantity, price: price)
        itemCommodity.taxes = taxes

        if let exciseStamp = exciseStamp {
            itemCommodity.exciseStamp = exciseStamp
        }

        if let barcode = barcode {
            itemCommodity.barcode = barcode
        }

        itemCommodity.measureUnitCode = measureUnitCode.rawValue
        itemCommodity.auxiliary = [Kkm_Proto_KeyValuePair]()

        return itemCommodity
    }

    // MARK: - Private Validation Methods

    /// Проверяет, что имя валидно и соответствует требуемым критериям.
    ///
    /// - Parameter name: Имя товара, услуги или работы.
    /// - Throws: Ошибка, если имя не соответствует требованиям.
    private func validateName(_ name: String) throws {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty, name.count >= 2 else {
            throw NSError(domain: "Commodity.validateName", code: 1, userInfo: [NSLocalizedDescriptionKey: "Название не может быть пустым, содержать только пробелы или быть менее 2-х символов"])
        }
    }

    /// Проверяет, что код секции не пустой и не состоит только из пробелов.
    ///
    /// - Parameter sectionCode: Код секции.
    /// - Throws: Ошибка, если код секции пустой или состоит только из пробелов.
    private func validateSectionCode(_ sectionCode: String) throws {
        guard !sectionCode.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(domain: "Commodity.validateSectionCode", code: 2, userInfo: [NSLocalizedDescriptionKey: "Код секции не может быть пустым или состоять только из пробелов."])
        }
    }

    /// Проверяет, что количество больше нуля.
    ///
    /// - Parameter quantity: Количество товара.
    /// - Throws: Ошибка, если количество меньше или равно нулю.
    private func validateQuantity(_ quantity: UInt32) throws {
        guard quantity > 0 else {
            throw NSError(domain: "Commodity.validateQuantity", code: 3, userInfo: [NSLocalizedDescriptionKey: "Количество должно быть больше нуля."])
        }
    }

    /// Проверяет, что количество указано в тысячных (например, 1000, 2000 и т.д.).
    ///
    /// - Parameter quantity: Количество товара.
    /// - Throws: Ошибка, если количество не указано в тысячных.
    private func validateQuantityInThousands(_ quantity: UInt32) throws {
        guard quantity % 1000 == 0 else {
            throw NSError(domain: "Commodity.validateQuantityInThousands", code: 4, userInfo: [NSLocalizedDescriptionKey: "Количество должно быть указано в тысячных (например, 1000, 2000 и т.д.)."])
        }
    }

    /// Проверяет, что акцизная марка не пустая и не состоит только из пробелов.
    ///
    /// - Parameter exciseStamp: Акцизная марка.
    /// - Throws: Ошибка, если акцизная марка пустая или состоит только из пробелов.
    private func validateExciseStamp(_ exciseStamp: String) throws {
        guard !exciseStamp.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(domain: "Commodity.validateExciseStamp", code: 5, userInfo: [NSLocalizedDescriptionKey: "Акцизная марка не может быть пустой или состоять только из пробелов."])
        }
    }

    /// Проверяет, что штрихкод соответствует заданному шаблону.
    ///
    /// - Parameter barcode: Штрихкод товара.
    /// - Throws: Ошибка, если штрихкод не соответствует шаблону.
    private func validateBarcode(_ barcode: String) throws {
        let regex = "^\\d{8}$|^\\d{12}$|^\\d{13}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        guard predicate.evaluate(with: barcode) else {
            throw NSError(domain: "Commodity.validateBarcode", code: 6, userInfo: [NSLocalizedDescriptionKey: "Штрихкод должен соответствовать одному из форматов: 8, 12 или 13 цифр."])
        }
    }

    /// Проверяет, что код единицы измерения существует в перечислении.
    ///
    /// - Parameter measureUnitCode: Код единицы измерения.
    /// - Throws: Ошибка, если код единицы измерения не соответствует ни одному из допустимых значений.
    private func validateMeasureUnitCode(_ measureUnitCode: UnitOfMeasurement) throws {
        guard UnitOfMeasurement(rawValue: measureUnitCode.rawValue) != nil else {
            throw NSError(domain: "Commodity.validateMeasureUnitCode", code: 7, userInfo: [NSLocalizedDescriptionKey: "Код единицы измерения не соответствует ни одному из допустимых значений."])
        }
    }

    // MARK: - Private Methods

    /// Метод для вычисления суммы на основе количества и цены позиции.
    ///
    /// - Parameters:
    ///   - quantity: Количество товара в тысячных.
    ///   - price: Цена товара.
    /// - Returns: Общая сумма в формате `Kkm_Proto_Money`.
    private func calculateSum(quantity: UInt32, price: Kkm_Proto_Money) -> Kkm_Proto_Money {
        var total = Kkm_Proto_Money()

        // Вычисляем общую сумму с учетом того, что quantity уже в тысячных
        total.bills = (price.bills * UInt64(quantity)) / 1000
        total.coins = (price.coins * quantity) / 1000

        // Если coins больше или равны 100, конвертируем их в bills
        if total.coins >= 100 {
            total.bills += UInt64(total.coins / 100)
            total.coins = total.coins % 100
        }

        return total
    }
}
