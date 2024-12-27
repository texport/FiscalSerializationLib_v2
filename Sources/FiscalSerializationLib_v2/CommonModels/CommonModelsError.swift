import Foundation

public enum CommonModelsError: LocalizedError {
    case headerSizeError
    
    public var code: Int {
        switch self {
        case .headerSizeError:
            return 1
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .headerSizeError:
            return "Длинна заголовка должна быть 18 байт, Вы получили некорректный ответ. Отправьте сообщение повторно. Если ошибка повторяется, обратитесь к разработчику библиотеки."
        }
    }
}
