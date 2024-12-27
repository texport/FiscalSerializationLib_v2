//
//  PaymentTypeEnum.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 10.12.2024.
//

/// Перечисление, представляющее типы оплаты.
///
/// `PaymentTypeEnum` используется для обозначения различных способов оплаты,
/// таких как наличные, банковская карта и мобильные платежи. Каждое значение имеет уникальный числовой идентификатор (`UInt`),
/// строковый код, используемый в протоколе, и описание на русском языке.
///
/// Этот `enum` предоставляет удобный способ работы с типами оплаты
/// при взаимодействии с библиотекой.
///
/// - Примеры использования:
///   - Получение числового значения: `PaymentTypeEnum.cash.rawValue`
///   - Получение строкового кода: `PaymentTypeEnum.card.paymentCode`
///   - Получение описания на русском языке: `PaymentTypeEnum.mobile.description`
public enum PaymentTypeEnum: UInt, Encodable {
    /// Наличные
    case cash = 0
    /// Банковская карта
    case card = 1
    /// Мобильные платежи
    case mobile = 4

    /// Возвращает строковый код типа оплаты для использования в протоколе.
    ///
    /// - Пример: Для `.cash` возвращается "PAYMENT_CASH".
    public var paymentCode: String {
        switch self {
        case .cash:
            return "PAYMENT_CASH"
        case .card:
            return "PAYMENT_CARD"
        case .mobile:
            return "PAYMENT_MOBILE"
        }
    }

    /// Возвращает текстовое описание типа оплаты на русском языке.
    ///
    /// - Пример: Для `.card` возвращается "Банковская карта".
    public var description: String {
        switch self {
        case .cash:
            return "Наличные"
        case .card:
            return "Банковская карта"
        case .mobile:
            return "Мобильные платежи"
        }
    }
}
