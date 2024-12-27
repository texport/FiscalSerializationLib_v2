//
//  ServiceResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 18.11.2024.
//

import Foundation

public struct ServiceResponse: InternalConstructible {
    public let regInfoResponse: RegInfoResponse?
    public let ads: [String]?
    
    private init(regInfoResponse: RegInfoResponse?, ads: [String]?) {
        self.regInfoResponse = regInfoResponse
        self.ads = ads
    }
    
    static func create(with data: (regInfoResponse: RegInfoResponse?, ads: [String]?)) -> ServiceResponse {
        ServiceResponse(regInfoResponse: data.0, ads: data.1)
    }
}
