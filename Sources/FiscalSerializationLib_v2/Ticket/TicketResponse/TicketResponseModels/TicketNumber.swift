//
//  TicketNumber.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 07.11.2024.
//

import Foundation

/// Структура `TicketNumber` предназначена для валидации и обработки фискальных признаков (номеров чеков).
///
/// Метод `createTicketNumber` проверяет, что номер чека не является пустым, и возвращает его в случае корректности.
/// Если номер чека пустой, метод выбрасывает ошибку с подробным описанием проблемы.
struct TicketNumber {
    
    /// Создаёт фискальный признак (номер чека).
    ///
    /// - Parameter ticketNumber: Строка, представляющая номер чека.
    ///
    /// - Returns: Строка с номером чека, если он не пустой.
    ///
    /// - Throws: Ошибка с кодом `1`, если номер чека пустой.
    static func createTicketNumber(ticketNumber: String) throws -> String {
        guard !ticketNumber.isEmpty else {
            throw NSError(
                domain: "TicketNumber",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: """
                    ОФД отправил пустой фискальный признак. ОФД нарушил протокол. Обратитесь в службу поддержки ОФД. \
                    Предоставьте ОФД идентификатор кассы, время попытки отправки транзакции, и сообщите информацию о пустом фискальном признаке.
                    """]
            )
        }
        return ticketNumber
    }
}
