//
//  OFD.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 23.12.2024.
//

public struct OFD: InternalConstructible {
    public let ip: String
    public let port: UInt16
    public let domain: String
    public let description: String
    
    private init(ip: String, port: UInt16, domain: String, description: String) {
        self.ip = ip
        self.port = port
        self.domain = domain
        self.description = description
    }
    
    static func create(with data: (ip: String, port: UInt16, domain: String, description: String)) -> OFD {
        OFD(ip: data.0, port: data.1, domain: data.2, description: data.3)
    }
}
