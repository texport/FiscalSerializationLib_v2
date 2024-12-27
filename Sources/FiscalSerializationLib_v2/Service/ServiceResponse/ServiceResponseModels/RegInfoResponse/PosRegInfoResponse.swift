//
//  PosRegInfoResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

public struct PosRegInfoResponse: InternalConstructible {
    public let title: String
    public let address: String
    
    private init(title: String, address: String) {
        self.title = title
        self.address = address
    }
    
    static func create(with data: (title: String, address: String)) -> PosRegInfoResponse {
        PosRegInfoResponse(title: data.0, address: data.1)
    }
}
