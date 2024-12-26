//
//  CommandTicketResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 26.12.2024.
//

public struct CommandTicketResponse: InternalConstructible, ResponseProtocol {
    public let ofdName: OFD
    
    public let kkmUserToServer: KKM
    
    public let kkmServerToUser: KKM
    
    public let command: CommandResponse
    
    public let result: ResultResponse
    
    public let fiscalSign: String?
    public let urlTicketOfd: String?
    
    public let commandTicketRequest: CommandTicketRequest
    
    private init(ofdName: OFD, kkmUserToServer: KKM, kkmServerToUser: KKM, command: CommandResponse, result: ResultResponse, fiscalSign: String?, urlTicketOfd: String?, commandTicketRequest: CommandTicketRequest) {
        self.ofdName = ofdName
        self.kkmUserToServer = kkmUserToServer
        self.kkmServerToUser = kkmServerToUser
        self.command = command
        self.result = result
        self.fiscalSign = fiscalSign
        self.urlTicketOfd = urlTicketOfd
        self.commandTicketRequest = commandTicketRequest
    }
    
    static func create(with data: (OFD, KKM, KKM, CommandResponse, ResultResponse, String?, String?, CommandTicketRequest)) -> CommandTicketResponse {
        CommandTicketResponse(ofdName: data.0, kkmUserToServer: data.1, kkmServerToUser: data.2, command: data.3, result: data.4, fiscalSign: data.5, urlTicketOfd: data.6, commandTicketRequest: data.7)
    }
}
