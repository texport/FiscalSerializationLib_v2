/// Структура `Command` предназначена для обработки команд, передаваемых сервером оператора фискальных данных (ОФД).
///
/// ### Основные задачи:
/// 1. Проверка корректности полученного кода команды.
/// 2. Интерпретация команды в соответствии с библиотекой.
///
/// Данная структура применяется исключительно для внутренней логики библиотеки и недоступна внешним пользователям.
///
/// ### Возможные ошибки:
/// - **CommandCodeError (Код ошибки 1)**: Команда не соответствует установленному протоколу.
/// - **CommandCodeLibError (Код ошибки 2)**: Команда соответствует протоколу, но не поддерживается библиотекой.
///
/// - Note:
/// Структура взаимодействует с перечислением `Kkm_Proto_CommandTypeEnum` для проверки допустимости команд и `CommandTypeEnum` для их интерпретации.
struct Command {
    /// Создает ответ на команду, переданную сервером.
    ///
    /// - Parameters:
    ///   - commandCpcr: Команда из перечисления `Kkm_Proto_CommandTypeEnum`, полученная от сервера.
    /// - Returns: Объект `CommandResponse`, содержащий код команды (`UInt32`) и описание (`String`).
    /// - Throws:
    ///   - `CommandsErrorEnum.commandCodeError`: Если код команды не соответствует установленному протоколу.
    ///   - `CommandsErrorEnum.commandCodeLibError`: Если код команды допустим, но не поддерживается библиотекой.
    static func createCommandResponse(commandCpcr: Kkm_Proto_CommandTypeEnum) throws -> CommandResponse {
        let commandRawValue = commandCpcr.rawValue
        
        // Проверка соответствия команды протоколу
        guard let _ = Kkm_Proto_CommandTypeEnum(rawValue: Int(commandRawValue)) else {
            throw CommandsErrorEnum.commandCodeError
        }
        
        // Проверка возможности интерпретации команды библиотекой
        guard let command = CommandTypeEnum(rawValue: UInt32(commandRawValue)) else {
            throw CommandsErrorEnum.commandCodeLibError
        }
        
        return CommandResponse.create(with: (command.rawValue, command.description))
    }
}
