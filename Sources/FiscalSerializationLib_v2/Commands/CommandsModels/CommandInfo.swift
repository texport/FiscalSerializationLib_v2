import SwiftProtobuf
import Foundation

struct CommandInfo {
    private static let headerSize = 18
    
    static func createCommandInfoRequestCpcr(commandInfo: CommandInfoRequest, kkmUserToServer: KKM) throws -> Data {
        let payloadCpcr = try serializeCommandInfo(commandInfo: commandInfo)
        let headerCpcr = MessageHeader.toData(id: kkmUserToServer.idKkm, token: kkmUserToServer.tokenKkm, reqNum: kkmUserToServer.reqNum, payload: payloadCpcr)
        return headerCpcr + payloadCpcr	
    }
    
    static func createCommandInfoResponse(ofd: OFD, kkmUserToServer: KKM, commandInfoResponseData: Data) throws -> CommandInfoResponse {
        /// Создаем сущность ККМ которую прислал нам сервер ОФД
        let kkmServerToUser = try MessageHeader.fromData(commandInfoResponseData).toKKM()
        
        /// Разбераем Payload от сервера ОФД
        let deserializePayloadCommandInfoCpcr = try deserializeCommandInfoResponse(data: commandInfoResponseData)
        
        /// Создаем команду
        let command = try Command.createCommandResponse(commandCpcr: deserializePayloadCommandInfoCpcr.command)
        	
        /// Создаем результат обработки
        let result = try Result.createResultResponse(resultCpcr: deserializePayloadCommandInfoCpcr.result)
        
        // сервисная часть от сервера ОФД
        let serviceResponse = try ServiceResponseBuilder.createServiceResponse(from: deserializePayloadCommandInfoCpcr.service)
        
        // часть по отчетам от сервера ОФД
        let zXReportResponse = try ZXReportResponseBuilder.createZXReportResponse(from: deserializePayloadCommandInfoCpcr.report.zxReport)
        
        return CommandInfoResponse.create(with: (ofd, kkmUserToServer, kkmServerToUser, command, result, serviceResponse, zXReportResponse))
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
        // Проверяем, что данных достаточно для включения заголовка
        guard data.count > headerSize else {
            throw CommandsErrorEnum.commandLengthMessageError
        }
        
        // Отсекаем заголовок
        let payloadData = data.subdata(in: headerSize..<data.count)
        
        return try Kkm_Proto_Response(serializedBytes: payloadData)
    }
}
