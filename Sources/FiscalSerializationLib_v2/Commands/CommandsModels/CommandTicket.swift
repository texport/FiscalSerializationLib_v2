//
//  CommandTicket.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 24.12.2024.
//

import Foundation
import SwiftProtobuf

struct CommandTicket {
    private static let headerSize = 18
    
    static func createCommandTicketRequestCpcr(commandTicket: CommandTicketRequest, kkmUserToServer: KKM) throws -> Data {
        let payloadCpcr = try CommandTicketRequestBuilder.createCommandTicketRequestCpcr(ticket: commandTicket)
        let headerCpcr = MessageHeader.toData(id: kkmUserToServer.idKkm, token: kkmUserToServer.tokenKkm, reqNum: kkmUserToServer.reqNum, payload: payloadCpcr)
        return headerCpcr + payloadCpcr
    }
    
    static func createCommandTicketResponse(ofd: OFD, kkmUserToServer: KKM, commandTicketResponseData: Data, commandTickerRequest: CommandTicketRequest) throws -> CommandTicketResponse {
        try CommandTicketResponseBuilder.createTicketResponse(ofdName: ofd, kkmUserToServer: kkmUserToServer, commandTicketResponseData: commandTicketResponseData, commandTicketRequest: commandTickerRequest)
    }
}
