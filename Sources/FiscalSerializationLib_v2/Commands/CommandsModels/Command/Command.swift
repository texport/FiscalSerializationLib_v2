//
//  Command.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 07.11.2024.
//

import Foundation

/// Внутренняя структура `Command`, используемая для обработки команд, возвращаемых сервером ОФД.
///
/// Данная структура и перечисление `CommandTypeEnum` применяются исключительно для внутренней логики библиотеки.
/// Внешние пользователи библиотеки не имеют доступа к этим компонентам.
///
/// Структура используется для интерпретации команд, получаемых от ОФД, и проверки их корректности.
///
/// ### Возможные ошибки:
/// - **Код ошибки 1**: Если код команды, полученный от ОФД, не соответствует протоколу.
/// - **Код ошибки 2**: Если код команды допустим по протоколу, но не распознан библиотекой.
struct Command {
    /// Обрабатывает команду, полученную от сервера ОФД.
    ///
    /// - Parameters:
    ///   - command: Тип команды из `Kkm_Proto_CommandTypeEnum`, полученный в ответе от сервера.
    ///
    /// - Returns: Кортеж, содержащий код команды (`UInt32`) и её описание (`String`).
    ///
    /// - Throws:
    ///   - Ошибка с кодом `1`, если код команды не соответствует протоколу ОФД.
    ///   - Ошибка с кодом `2`, если код команды допустим по протоколу, но не был распознан библиотекой.
    static func createCommandResponse(commandCpcr: Kkm_Proto_CommandTypeEnum) throws -> CommandResponse {
        let commandCpcr = commandCpcr.rawValue
        
        // Проверка на соответствие команды протоколу
        guard let _ = Kkm_Proto_CommandTypeEnum(rawValue: Int(commandCpcr)) else {
            throw NSError(
                domain: "createCommand",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: """
                    Полученный код команды от ОФД не соответствует протоколу. \
                    Обратитесь в службу поддержки ОФД, предоставив идентификатор кассы и код команды: \(commandCpcr).
                    """]
            )
        }
        
        // Проверка на возможность распознавания команды библиотекой
        guard let command = CommandTypeEnum(rawValue: UInt32(commandCpcr)) else {
            throw NSError(
                domain: "createCommand",
                code: 2,
                userInfo: [NSLocalizedDescriptionKey: """
                    Код команды от ОФД допустим по протоколу, но не распознан библиотекой. \
                    Обратитесь к разработчику библиотеки.
                    """]
            )
        }
        
        return CommandResponse.create(with: (command.rawValue, command.description))
    }
}

public struct CommandResponse: InternalConstructible {
    public let command: UInt32
    public let commandText: String
    
    private init(command: UInt32, commandText: String) {
        self.command = command
        self.commandText = commandText
    }
    
    static func create(with data: (UInt32, String)) -> CommandResponse {
        CommandResponse(command: data.0, commandText: data.1)
    }
}
