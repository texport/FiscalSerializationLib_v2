//
//  CommandsErrorEnum.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 24.12.2024.
//

import Foundation

public enum CommandsErrorEnum: LocalizedError {
    case commandCodeError
    case commandCodeLibError
    case commandResultCodeError
    case commandResultCodeLibError
    case commandLengthMessageError
    
    public var code: Int {
        switch self {
        case .commandCodeError:
            return 1
        case .commandCodeLibError:
            return 2
        case .commandResultCodeError:
            return 3
        case .commandResultCodeLibError:
            return 4
        case .commandLengthMessageError:
            return 5
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .commandCodeError:
            return "Полученный код команды от ОФД не соответствует протоколу. Обратитесь в службу поддержки ОФД."
        case .commandCodeLibError:
            return "Код команды от ОФД допустим по протоколу, но не распознан библиотекой. Обратитесь к разработчику библиотеки."
        case .commandResultCodeError:
            return "Полученный код ответа от ОФД не соответствует протоколу. Обратитесь в службу поддержки ОФД."
        case .commandResultCodeLibError:
            return "Код ответа от ОФД допустим по протоколу, но не распознан библиотекой. Обратитесь к разработчику библиотеки."
        case .commandLengthMessageError:
            return "От сервера ОФД пришло короткое сообщение. Мы не можем его расшифровать. Попробуйте переотправить сообщение которые вы отправляли. Если ошибка повторяется, обратитесь к разработчику библиотеки."
        }
    }
}
