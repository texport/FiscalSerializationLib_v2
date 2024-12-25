/// Структура `ResultResponse` представляет собой результат обработки ответа сервера
/// оператора фискальных данных (ОФД).
///
/// ### Основные задачи:
/// - Хранение кода ответа и текстового описания результата.
/// - Обеспечение безопасного создания экземпляров через фабричный метод `create(with:)`.
///
/// ### Свойства:
/// - `resultCode`: Код ответа (`UInt32`), определяющий результат операции.
/// - `resultText`: Текстовое описание результата (`String`).
///
/// ### Использование:
/// Экземпляры создаются только через фабричный метод, что гарантирует корректную инициализацию.
public struct ResultResponse: InternalConstructible {
    /// Код ответа, возвращённый сервером.
    public let resultCode: UInt32
    
    /// Текстовое описание результата.
    public let resultText: String
    
    /// Приватный инициализатор для ограничения создания экземпляров структуры.
    ///
    /// - Parameters:
    ///   - resultCode: Код ответа (`UInt32`).
    ///   - resultText: Текстовое описание (`String`).
    private init(resultCode: UInt32, resultText: String) {
        self.resultCode = resultCode
        self.resultText = resultText
    }
    
    /// Фабричный метод для создания экземпляра `ResultResponse`.
    ///
    /// - Parameter data: Кортеж, содержащий код ответа (`UInt32`) и текстовое описание (`String`).
    /// - Returns: Созданный экземпляр `ResultResponse`.
    static func create(with data: (UInt32, String)) -> ResultResponse {
        ResultResponse(resultCode: data.0, resultText: data.1)
    }
}
