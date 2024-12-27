//
//  KkmProto.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 27.12.2024.
//

import Foundation

struct KkmProto {
    private static let headerSize = 18
    
    static func serializeRequestCpcrToData(payloadCpcr: Kkm_Proto_Request) throws -> Data {
        try payloadCpcr.serializedData()
    }
    
    static func deserializeResponseDataToCpcr(data: Data) throws -> Kkm_Proto_Response {
        // Проверяем, что данных достаточно для включения заголовка
        guard data.count > headerSize else {
            throw CommandsErrorEnum.commandLengthMessageError
        }
        
        // Отсекаем заголовок
        let payloadData = data.subdata(in: headerSize..<data.count)
        
        return try Kkm_Proto_Response(serializedBytes: payloadData)
    }
}
