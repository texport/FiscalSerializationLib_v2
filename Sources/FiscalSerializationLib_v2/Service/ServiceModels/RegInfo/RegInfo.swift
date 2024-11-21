//
//  RegInfo.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

struct RegInfo {
    static func createRegInfoResponse(regInfoResponse: Kkm_Proto_ServiceResponse.RegInfo) throws -> RegInfoResponse {
        let kkm = try setupKkmRegInfoResponse(regInfoResponse: regInfoResponse)
        let pos = try setupPosRegInfoResponse(regInfoResponse: regInfoResponse)
        let org = try setupOrgRegInfoResponse(regInfoResponse: regInfoResponse)
        
        return RegInfoResponse(kkm: kkm, pos: pos, org: org)
    }
    
    private static func setupKkmRegInfoResponse(regInfoResponse: Kkm_Proto_ServiceResponse.RegInfo) throws -> KkmRegInfoResponse {
        try KkmRegInfo.createKkmRegInfoResponse(kkmRegInfoResponse: regInfoResponse.kkm)
    }
    
    private static func setupPosRegInfoResponse(regInfoResponse: Kkm_Proto_ServiceResponse.RegInfo) throws -> PosRegInfoResponse {
        try PosRegInfo.createPosRegInfoResponse(posRegInfoResponse: regInfoResponse.pos)
    }
    
    private static func setupOrgRegInfoResponse(regInfoResponse: Kkm_Proto_ServiceResponse.RegInfo) throws -> OrgRegInfoResponse {
        try OrgRegInfo.createOrgRegInfoResponse(orgRegInfoResponse: regInfoResponse.org)
    }
}
