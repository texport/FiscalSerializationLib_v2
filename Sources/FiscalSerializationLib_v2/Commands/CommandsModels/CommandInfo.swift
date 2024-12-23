//
//  CommandInfo.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 24.09.2024.
//

import SwiftProtobuf
import Foundation

struct CommandInfo {
    static func createCommandInfoRequestCpcr(commandInfo: CommandInfoRequest, kkm: KKM) throws -> Data {
        let payloadCpcr = try serializeCommandInfo(commandInfo: commandInfo)
        let headerCpcr = MessageHeader.toData(id: kkm.idKkm, token: kkm.tokenKkm, reqNum: kkm.reqNum, payload: payloadCpcr)
        var messageCpcr = Data()
        messageCpcr.append(headerCpcr)
        messageCpcr.append(payloadCpcr)
        
        return messageCpcr
    }
    
    static func createCommandInfoResponse(ofd: OFD, kkm: KKM, commandInfoResponseData: Data) throws -> CommandInfoResponse {
        // декодируем то что получили
        let deserializeHeaderCommandInfo = try MessageHeader.fromData(commandInfoResponseData)
        let deserializePayloadCommandInfoCpcr = try deserializeCommandInfoResponse(data: commandInfoResponseData)
        
        let command = try Command.createCommandResponse(commandCpcr: deserializePayloadCommandInfoCpcr.command)
        let result = try Result.createResultResponse(result: deserializePayloadCommandInfoCpcr.result)
        
        // сервисная часть от сервера ОФД
        let serviceResponse = try ServiceResponseBuilder.createServiceResponse(from: deserializePayloadCommandInfoCpcr.service)
        
        // часть по отчетам от сервера ОФД
        let zXReportResponse = try ZXReportResponseBuilder.createZXReportResponse(from: deserializePayloadCommandInfoCpcr.report.zxReport)
        
        return CommandInfoResponse.create(with: (ofd, kkm, command, result, serviceResponse, zXReportResponse))
    }
    
    // Сериализация команды COMMAND_INFO
    private static func serializeCommandInfo(commandInfo: CommandInfoRequest) throws -> Data {
        var request = Kkm_Proto_Request()
        request.command = Kkm_Proto_CommandTypeEnum.commandInfo
        let payload = try request.serializedData()
        
        return payload
    }
    
    // Десериализация ответа на команду COMMAND_INFO
    private static func deserializeCommandInfoResponse(data: Data) throws -> Kkm_Proto_Response {
        let headerSize = 18
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
