//
//  CommandInfo.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 24.09.2024.
//

import SwiftProtobuf
import Foundation

struct CommandInfo {
    // Размер заголовка в байтах
    private let headerSize = 18
    
    // Сериализация команды COMMAND_INFO
    func serializeCommandInfo() throws -> Data {
        var request = Kkm_Proto_Request()
        request.command = .commandInfo
        
        // Сериализация Payload
        let payload = try request.serializedData()
        
        return payload
    }
    
    // Десериализация ответа на команду COMMAND_INFO
    func deserializeCommandInfoResponse(data: Data) throws -> Kkm_Proto_Response {
        // Проверяем, что данных достаточно для включения заголовка
        guard data.count > headerSize else {
            throw NSError(domain: "CommandInfoDeserializer", code: 2, userInfo: [NSLocalizedDescriptionKey: "Данных недостаточно"])
        }
        
        // Отсекаем заголовок
        let payloadData = data.subdata(in: headerSize..<data.count)
        
        // Десериализация данных
        let response = try Kkm_Proto_Response(serializedBytes: payloadData)
        
        // Возвращаем десериализованный ответ
        return response
    }
}
