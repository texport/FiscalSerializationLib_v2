//
//  MoneyPlacementEnum.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 11.12.2024.
//

/// Перечисление, представляющее типы размещения денежных средств.
///
/// `MoneyPlacementEnum` используется для обозначения операций с денежными средствами,
/// таких как внесение денег в кассу и снятие денег из кассы. Каждое значение имеет уникальный
/// числовой идентификатор (`UInt`), строковый код, используемый в протоколе, и описание на русском языке.
///
/// Этот `enum` предоставляет удобный способ работы с операциями денежных средств
/// при взаимодействии с библиотекой.
///
/// - Примеры использования:
///   - Получение числового значения: `MoneyPlacementEnum.deposit.rawValue`
///   - Получение строкового кода: `MoneyPlacementEnum.withdrawal.placementCode`
///   - Получение описания на русском языке: `MoneyPlacementEnum.deposit.description`
public enum MoneyPlacementEnum: UInt, Encodable {
    /// Внесение денег в кассу
    case deposit = 0
    /// Снятие денег из кассы
    case withdrawal = 1

    /// Возвращает строковый код операции для использования в протоколе.
    ///
    /// - Пример: Для `.deposit` возвращается "MONEY_PLACEMENT_DEPOSIT".
    public var placementCode: String {
        switch self {
        case .deposit:
            return "MONEY_PLACEMENT_DEPOSIT"
        case .withdrawal:
            return "MONEY_PLACEMENT_WITHDRAWAL"
        }
    }

    /// Возвращает текстовое описание операции на русском языке.
    ///
    /// - Пример: Для `.withdrawal` возвращается "Снятие денег из кассы".
    public var description: String {
        switch self {
        case .deposit:
            return "Внесение денег в кассу"
        case .withdrawal:
            return "Снятие денег из кассы"
        }
    }
}
