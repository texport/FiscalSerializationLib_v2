//
//  TicketResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 06.11.2024.
//

public struct TicketResponse {
    private let ofdName: OfdEnum
    private let idKkmOfd: UInt32
    private let tokenOfd: UInt32
    private let reqNumOfd: UInt16
    
    private let command: UInt32
    private let commandText: String
    
    private let resultCode: UInt32
    private let resultText: String
    
    private let fiscalSign: String?
    private let urlTicketOfd: String?
    
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
