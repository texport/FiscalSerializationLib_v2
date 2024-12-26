/// Структура `Result` используется для обработки и интерпретации кодов ответов,
/// возвращаемых сервером оператора фискальных данных (ОФД).
///
/// ### Основные задачи:
/// - Проверка соответствия кода ответа протоколу.
/// - Интерпретация кода ответа и предоставление описания.
///
/// Данная структура применяется только для внутренней логики библиотеки и недоступна внешним пользователям.
///
/// ### Возможные ошибки:
/// - **CommandResultCodeError (Код ошибки 1)**: Код ответа не соответствует установленному протоколу.
/// - **CommandResultCodeLibError (Код ошибки 2)**: Код ответа соответствует протоколу, но не распознан библиотекой.
struct Result {
    /// Создает объект `ResultResponse` на основе кода ответа, полученного от сервера.
    ///
    /// - Parameters:
    ///   - result: Объект `Kkm_Proto_Result`, содержащий код ответа от сервера.
    /// - Returns: Объект `ResultResponse`, содержащий код ответа (`UInt32`) и его описание (`String`).
    /// - Throws:
    ///   - `CommandsErrorEnum.commandResultCodeError`: Если код ответа не соответствует протоколу ОФД.
    ///   - `CommandsErrorEnum.commandResultCodeLibError`: Если код ответа допустим, но не распознан библиотекой.
    static func createResultResponse(resultCpcr: Kkm_Proto_Result) throws -> ResultResponse {
        let resultCodeCpcr = resultCpcr.resultCode
        let resultTextCpcr = resultCpcr.resultText
        var resultText = "Тут должен быть текст кода"
        
        // Проверка на соответствие кода ответа протоколу
        guard let _ = Kkm_Proto_ResultTypeEnum(rawValue: Int(resultCodeCpcr)) else {
            throw CommandsErrorEnum.commandResultCodeError
        }
        
        // Проверка на возможность распознавания кода ответа библиотекой
        guard let resultCode = ResultTypeEnum(rawValue: resultCodeCpcr) else {
            throw CommandsErrorEnum.commandResultCodeLibError
        }
        
        if resultCodeCpcr == 0 {
            resultText = ResultTypeEnum.ok.description
        } else {
            resultText = resultTextCpcr
        }
        
        return ResultResponse.create(with: (resultCode.rawValue, resultText))
    }
}
