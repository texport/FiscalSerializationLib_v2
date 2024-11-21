//
//  InfoResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

public struct InfoResponse {
    public let ofdName: OfdEnum
    public let idKkmOfd: UInt32
    public let tokenOfd: UInt32
    public let reqNumOfd: UInt16
    
    public let command: UInt32
    public let commandText: String
    
    public let resultCode: UInt32
    public let resultText: String
    
    /// Информаци о кассовом аппарате
    public let kgdId: String
    public let kkmOfdId: String
    public let kkmSerialNumber: String
    
    /// Информаци о торговой точке в которой находится кассовый аппарат
    public let namePos: String
    public let addressPos: String
    
    /// Информаци об организации которой пренадлежит кассыовый аппарат
    public let nameOrg: String
    public let addressOrg: String
    public let iinOrBin: String
    public let oked: String
    
    /// Рекламные тексты каоторые нужно печатать(если они есть)
    public let adsText: [String]?
}
