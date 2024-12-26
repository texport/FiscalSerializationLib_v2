//
//  OperationTypeEnum.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 25.11.2024.
//

/// Перечисление, представляющее типы операций, выполняемых контрольно-кассовой машиной.
///
/// `OperationType` используется для обозначения различных типов транзакций,
/// таких как покупка, продажа и возврат. Каждое значение имеет уникальный числовой идентификатор (`UInt`),
/// строковый код, используемый в протоколе, и описание на русском языке.
///
/// Этот `enum` предоставляет удобный способ работы с типами операций
/// при взаимодействии с библиотекой.
///
/// - Примеры использования:
///   - Получение числового значения: `OperationType.buy.rawValue`
///   - Получение строкового кода: `OperationType.sell.operationCode`
///   - Получение описания на русском языке: `OperationType.buyReturn.description`
public enum OperationTypeEnum: UInt, Encodable {
    /// Покупка
    case buy = 0
    /// Возврат покупки
    case buyReturn = 1
    /// Продажа
    case sell = 2
    /// Возврат продажи
    case sellReturn = 3

    /// Возвращает строковый код операции для использования в протоколе.
    ///
    /// - Пример: Для `.buy` возвращается "OPERATION_BUY".
    public var operationCode: String {
        switch self {
        case .buy:
            return "OPERATION_BUY"
        case .buyReturn:
            return "OPERATION_BUY_RETURN"
        case .sell:
            return "OPERATION_SELL"
        case .sellReturn:
            return "OPERATION_SELL_RETURN"
        }
    }

    /// Возвращает текстовое описание операции на русском языке.
    ///
    /// - Пример: Для `.sellReturn` возвращается "Возврат продажи".
    public var description: String {
        switch self {
        case .buy:
            return "Покупка"
        case .buyReturn:
            return "Возврат покупки"
        case .sell:
            return "Продажа"
        case .sellReturn:
            return "Возврат продажи"
        }
    }
}
