//
//  KKM.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 11.12.2024.
//

public struct KKM {
    public let idKkm: UInt32
    public let tokenKkm: UInt32
    public let reqNum: UInt16
    public let kgdId: String
    public let kkmSerialNumber: String
    
    public init(idKkm: UInt32, tokenKkm: UInt32, reqNum: UInt16, kgdId: String, kkmSerialNumber: String) {
        self.idKkm = idKkm
        self.tokenKkm = tokenKkm
        self.reqNum = reqNum
        self.kgdId = kgdId
        self.kkmSerialNumber = kkmSerialNumber
    }
}
