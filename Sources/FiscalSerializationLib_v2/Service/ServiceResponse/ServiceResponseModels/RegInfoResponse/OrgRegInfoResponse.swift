//
//  OrgRegInfoResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

public struct OrgRegInfoResponse: InternalConstructible, Encodable {
    public let title: String
    public let address: String
    public let iinOrBin: String
    public let oked: String
    
    private init(title: String, address: String, iinOrBin: String, oked: String) {
        self.title = title
        self.address = address
        self.iinOrBin = iinOrBin
        self.oked = oked
    }
    
    static func create(with data: (title: String, address: String, iinOrBin: String, oked: String)) -> OrgRegInfoResponse {
        OrgRegInfoResponse(title: data.0, address: data.1, iinOrBin: data.2, oked: data.3)
    }
}
