//
//  TicketResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 06.11.2024.
//

public struct TicketResponse: InternalConstructible {
    public let ofdName: OfdEnum
    public let idKkmOfd: UInt32
    public let tokenOfd: UInt32
    public let reqNumOfd: UInt16
    
    public let command: UInt32
    public let commandText: String
    
    public let resultCode: UInt32
    public let resultText: String
    
    public let fiscalSign: String?
    public let urlTicketOfd: String?
    
    init(ofdName: OfdEnum, idKkmOfd: UInt32, tokenOfd: UInt32, reqNumOfd: UInt16,
         command: UInt32, commandText: String,
         resultCode: UInt32, resultText: String,
         fiscalSign: String?, urlTicketOfd: String?) {
        self.ofdName = ofdName
        self.idKkmOfd = idKkmOfd
        self.tokenOfd = tokenOfd
        self.reqNumOfd = reqNumOfd
        self.command = command
        self.commandText = commandText
        self.resultCode = resultCode
        self.resultText = resultText
        self.fiscalSign = fiscalSign
        self.urlTicketOfd = urlTicketOfd
    }
}
