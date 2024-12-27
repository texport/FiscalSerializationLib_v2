import SwiftProtobuf
import Foundation

struct CommandSystem {
    private static let headerSize = 18
    
    static func createCommandSystemRequestCpcr(commandSystem: CommandSystemRequest, kkmUserToServer: KKM) throws -> Data {
        let payloadCpcr = try serializeCommandSystem(commandSystem: commandSystem)
        let headerCpcr = MessageHeader.toData(id: kkmUserToServer.idKkm, token: kkmUserToServer.tokenKkm, reqNum: kkmUserToServer.reqNum, payload: payloadCpcr)
        return headerCpcr + payloadCpcr
    }
    
    static func createCommandSystemResponse(ofd: OFD, kkmUserToServer: KKM, commandSystemResponseData: Data) throws -> CommandSystemResponse {
        var serviceResponse: ServiceResponse?
        
        /// Создаем сущность ККМ которую прислал нам сервер ОФД
        let kkmServerToUser = try MessageHeader.fromData(commandSystemResponseData).toKKM()
        
        /// Разбераем Payload от сервера ОФД
        let deserializePayloadCommandSystemCpcr = try deserializeCommandSystemResponse(data: commandSystemResponseData)
        
        /// Создаем команду
        let command = try Command.createCommandResponse(commandCpcr: deserializePayloadCommandSystemCpcr.command)
            
        /// Создаем результат обработки
        let result = try Result.createResultResponse(resultCpcr: deserializePayloadCommandSystemCpcr.result)
        
        // сервисная часть от сервера ОФД
        if deserializePayloadCommandSystemCpcr.hasService {
            serviceResponse = try ServiceResponseBuilder.createServiceResponse(from: deserializePayloadCommandSystemCpcr.service)
        }
        
        return CommandSystemResponse.create(with: (ofd, kkmUserToServer, kkmServerToUser, command, result, serviceResponse))
    }
    
    // Сериализация команды COMMAND_SYSTEM
    private static func serializeCommandSystem(commandSystem: CommandSystemRequest) throws -> Data {
        var request = Kkm_Proto_Request()
        request.command = Kkm_Proto_CommandTypeEnum.commandSystem
        let payload = try request.serializedData()
        
        return payload
    }
    
    // Десериализация ответа на команду COMMAND_SYSTEM
    private static func deserializeCommandSystemResponse(data: Data) throws -> Kkm_Proto_Response {
        // Проверяем, что данных достаточно для включения заголовка
        guard data.count > headerSize else {
            throw CommandsErrorEnum.commandLengthMessageError
        }
        
        // Отсекаем заголовок
        let payloadData = data.subdata(in: headerSize..<data.count)
        
        return try Kkm_Proto_Response(serializedBytes: payloadData)
    }
}
