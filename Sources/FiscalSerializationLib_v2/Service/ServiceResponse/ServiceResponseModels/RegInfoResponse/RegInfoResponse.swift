//
//  RegInfoResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

public struct RegInfoResponse: InternalConstructible {
    public let kkm: KkmRegInfoResponse
    public let pos: PosRegInfoResponse
    public let org: OrgRegInfoResponse
    
    private init(kkm: KkmRegInfoResponse, pos: PosRegInfoResponse, org: OrgRegInfoResponse) {
        self.kkm = kkm
        self.pos = pos
        self.org = org
    }
    
    static func create(with data: (kkm: KkmRegInfoResponse, pos: PosRegInfoResponse, org: OrgRegInfoResponse)) -> RegInfoResponse {
        RegInfoResponse(kkm: data.0, pos: data.1, org: data.2)
    }
}
