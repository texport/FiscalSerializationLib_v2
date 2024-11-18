//
//  Result.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 06.11.2024.
//

import Foundation

/// Внутренняя структура `Result`, используемая для обработки кодов ответов, возвращаемых сервером оператора фискальных данных (ОФД).
///
/// Структура предназначена для интерпретации кодов ответа, полученных от сервера ОФД, и возвращает соответствующий код и описание.
/// Данная структура используется только для внутренней логики библиотеки и недоступна внешним пользователям.
///
/// ### Возможные ошибки:
/// - **Код ошибки 1**: Если код ответа, полученный от ОФД, не соответствует протоколу.
/// - **Код ошибки 2**: Если код ответа допустим по протоколу, но не распознан библиотекой.
struct Result {
    
    /// Обрабатывает код ответа, полученный от сервера ОФД.
    ///
    /// - Parameters:
    ///   - result: Объект `Kkm_Proto_Result`, содержащий код ответа от сервера.
    ///
    /// - Returns: Кортеж, содержащий код ответа (`UInt32`) и его описание (`String`).
    ///
    /// - Throws:
    ///   - Ошибка с кодом `1`, если код ответа не соответствует протоколу ОФД.
    ///   - Ошибка с кодом `2`, если код ответа допустим по протоколу, но не распознан библиотекой.
    static func createResult(result: Kkm_Proto_Result) throws -> (UInt32, String) {
        let resultCodeCpcr = result.resultCode
        
        // Проверка на соответствие кода ответа протоколу
        guard let _ = Kkm_Proto_ResultTypeEnum(rawValue: Int(resultCodeCpcr)) else {
            throw NSError(
                domain: "createResult",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: """
                    Полученный код ответа от ОФД не соответствует протоколу. \
                    Обратитесь в службу поддержки ОФД, предоставив идентификатор кассы, время попытки и код ответа: \(resultCodeCpcr).
                    """]
            )
        }
        
        // Проверка на возможность распознавания кода ответа библиотекой
        guard let resultCode = ResultTypeEnum(rawValue: resultCodeCpcr) else {
            throw NSError(
                domain: "createResult",
                code: 2,
                userInfo: [NSLocalizedDescriptionKey: """
                    Код ответа от ОФД допустим по протоколу, но не распознан библиотекой. \
                    Обратитесь к разработчику библиотеки.
                    """]
            )
        }
        
        return (resultCode.rawValue, resultCode.description)
    }
}

