//
//  KkmRegInfoResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

public struct KkmRegInfoResponse: InternalConstructible, Encodable {
    public let kgdId: String
    public let serialNumber: String
    public let kkmOfdId: String
    
    private init(kgdId: String, serialNumber: String, kkmOfdId: String) {
        self.kgdId = kgdId
        self.serialNumber = serialNumber
        self.kkmOfdId = kkmOfdId
    }
    
    static func create(with data: (kgdId: String, serialNumber: String, kkmOfdId: String)) -> KkmRegInfoResponse {
        KkmRegInfoResponse(kgdId: data.0, serialNumber: data.1, kkmOfdId: data.2)
    }
}
