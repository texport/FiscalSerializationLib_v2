/// Структура `CommandResponse` предназначена для представления результата обработки команды,
/// переданной сервером оператора фискальных данных (ОФД).
///
/// ### Основные задачи:
/// 1. Хранение кода команды и её текстового описания.
/// 2. Обеспечение создания экземпляров через статический фабричный метод `create(with:)`.
///
/// ### Свойства:
/// - `command`: Код команды, представленный в формате `UInt32`.
/// - `commandText`: Описание команды в виде строки.
///
/// ### Использование:
/// Структура создаётся только через фабричный метод, что гарантирует её корректную инициализацию.
public struct CommandResponse: InternalConstructible {
    /// Код команды, переданный сервером.
    public let command: UInt32

    /// Текстовое описание команды.
    public let commandText: String

    /// Приватный инициализатор для обеспечения создания экземпляров только через фабричный метод.
    private init(command: UInt32, commandText: String) {
        self.command = command
        self.commandText = commandText
    }

    /// Фабричный метод для создания экземпляра `CommandResponse`.
    ///
    /// - Parameter data: Кортеж, содержащий код команды (`UInt32`) и её описание (`String`).
    /// - Returns: Созданный экземпляр `CommandResponse`.
    static func create(with data: (UInt32, String)) -> CommandResponse {
        CommandResponse(command: data.0, commandText: data.1)
    }
}
