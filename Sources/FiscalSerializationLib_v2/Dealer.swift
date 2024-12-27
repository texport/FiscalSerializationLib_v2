//
//  Dealer.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 11.12.2024.
//

import Foundation

public struct Dealer {
    static func makeDelivery(command: CommandProtocol, ofd: OFD, kkm: KKM) throws -> ResponseProtocol {
        switch command.commandCode {
        case .commandSystem:
            let commandSystemRequestCpcr = try CommandSystem.createCommandSystemRequestCpcr(commandSystem: command as! CommandSystemRequest, kkmUserToServer: kkm)
            let commandSystemResponseCpcr = try OfdConnector.shared.sendToServer(message: commandSystemRequestCpcr, serverIP: ofd.ip, serverPort: ofd.port)
            
            return try CommandSystem.createCommandSystemResponse(ofd: ofd, kkmUserToServer: kkm, commandSystemResponseData: commandSystemResponseCpcr)
        case .commandInfo:
            let commandInfoRequestCpcr = try CommandInfo.createCommandInfoRequestCpcr(commandInfo: command as! CommandInfoRequest, kkmUserToServer: kkm)
            let commandInfoResponseCpcr = try OfdConnector.shared.sendToServer(message: commandInfoRequestCpcr, serverIP: ofd.ip, serverPort: ofd.port)
            
            return try CommandInfo.createCommandInfoResponse(ofd: ofd, kkmUserToServer: kkm, commandInfoResponseData: commandInfoResponseCpcr)
        case .commandTicket:
            let commandTicketRequestCpcr = try CommandTicket.createCommandTicketRequestCpcr(commandTicket: command as! CommandTicketRequest, kkmUserToServer: kkm)
            let commandTicketResponseCpcr = try OfdConnector.shared.sendToServer(message: commandTicketRequestCpcr, serverIP: ofd.ip, serverPort: ofd.port)
            
            return try CommandTicket.createCommandTicketResponse(ofd: ofd, kkmUserToServer: kkm, commandTicketResponseData: commandTicketResponseCpcr, commandTickerRequest: command as! CommandTicketRequest)
        case .commandMoneyPlacement:
            let commandMoneyPlacementRequestCpcr = try CommandMoneyPlacement.createCommandMoneyPlacementRequestCpcr(commandMoneyPlacement: command as! CommandMoneyPlacementRequest, kkmUserToServer: kkm)
            let commandTicketResponseCpcr = try OfdConnector.shared.sendToServer(message: commandMoneyPlacementRequestCpcr, serverIP: ofd.ip, serverPort: ofd.port)
            
            return try CommandMoneyPlacement.createCommandMoneyPlacementResponse(ofd: ofd, kkmUserToServer: kkm, commandMoneyPlacementResponseData: commandTicketResponseCpcr)
        default:
            throw NSError(domain: "Dealer", code: -1, userInfo: [
                            NSLocalizedDescriptionKey: "Неизвестный тип команды"
            ])
        }
    }
}
