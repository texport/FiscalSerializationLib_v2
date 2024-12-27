//
//  CommandMoneyPlacment.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 27.12.2024.
//

import SwiftProtobuf
import Foundation

struct CommandMoneyPlacement {
    static func createCommandMoneyPlacementRequestCpcr(commandMoneyPlacement: CommandMoneyPlacementRequest, kkmUserToServer: KKM) throws -> Data {
        let payloadCpcr = try CommandMoneyPlacementRequestBuilder.createRequestCpcr(commandMoneyPlacementRequest: commandMoneyPlacement)
        let payloadData = try KkmProto.serializeRequestCpcrToData(payloadCpcr: payloadCpcr)
        let headerCpcr = MessageHeader.toData(id: kkmUserToServer.idKkm, token: kkmUserToServer.tokenKkm, reqNum: kkmUserToServer.reqNum, payload: payloadData)
        return headerCpcr + payloadData
    }
    
    static func createCommandMoneyPlacementResponse(ofd: OFD, kkmUserToServer: KKM, commandMoneyPlacementResponseData: Data) throws -> CommandMoneyPlacementResponse {
        var serviceResponse: ServiceResponse?
        var zXReportResponse: ZXReportResponse?
        /// Создаем сущность ККМ которую прислал нам сервер ОФД
        let kkmServerToUser = try MessageHeader.fromData(commandMoneyPlacementResponseData).toKKM()
        
        /// Разбераем Payload от сервера ОФД
        let deserializePayloadCpcr = try KkmProto.deserializeResponseDataToCpcr(data: commandMoneyPlacementResponseData)
        
        /// Создаем команду
        let command = try Command.createCommandResponse(commandCpcr: deserializePayloadCpcr.command)
            
        /// Создаем результат обработки
        let result = try Result.createResultResponse(resultCpcr: deserializePayloadCpcr.result)
        
        // сервисная часть от сервера ОФД
        if deserializePayloadCpcr.hasService {
            serviceResponse = try ServiceResponseBuilder.createServiceResponse(from: deserializePayloadCpcr.service)
        }
        
        // часть по отчетам от сервера ОФД
        if deserializePayloadCpcr.hasReport {
            zXReportResponse = try ZXReportResponseBuilder.createZXReportResponse(from: deserializePayloadCpcr.report.zxReport)
        }
        
        return CommandMoneyPlacementResponse.create(with: (ofd, kkmUserToServer, kkmServerToUser, command, result, serviceResponse, zXReportResponse))
    }
}
