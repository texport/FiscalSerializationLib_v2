//
//  CommandTicketResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 05.11.2024.
//

import Foundation

final class CommandTicketResponse {
    private let headerSize = 18
    
    private init() throws { }
    
    static func createCommandTicketResponseCpcr(data: Data) throws -> Kkm_Proto_Response {
        let commandTickerRespons = try CommandTicketResponse()
        return try commandTickerRespons.deserializeCommandTicketResponse(data: data)
    }
    
    private func deserializeCommandTicketResponse(data: Data) throws -> Kkm_Proto_Response {
        // Проверяем, что данных достаточно для включения заголовка
        guard data.count > headerSize else {
            throw NSError(domain: "CommandTicketDeserializer", code: 2, userInfo: [NSLocalizedDescriptionKey: "Данных недостаточно"])
        }
        
        // Отсекаем заголовок
        let payloadData = data.subdata(in: headerSize..<data.count)
        
        // Десериализация данных
        let response = try Kkm_Proto_Response(serializedBytes: payloadData)
        
        // Возвращаем десериализованный ответ
        return response
    }
}
