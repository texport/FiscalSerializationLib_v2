//
//  Untitled.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

struct OrgRegInfo {
    static func createOrgRegInfoRequest(title: String, address: String, iinOrBin: String, oked: String) throws -> Kkm_Proto_OrgRegInfo {
        var orgRegInfo = Kkm_Proto_OrgRegInfo()
        
        orgRegInfo.title = title
        orgRegInfo.address = address
        orgRegInfo.inn = iinOrBin
        orgRegInfo.okved = oked
        
        return orgRegInfo
    }
    
    static func createOrgRegInfoResponse(orgRegInfoResponse: Kkm_Proto_OrgRegInfo) throws -> OrgRegInfoResponse {
        
        return OrgRegInfoResponse(title: orgRegInfoResponse.title,
                address: orgRegInfoResponse.address,
                iinOrBin: orgRegInfoResponse.inn,
                oked: orgRegInfoResponse.okved)
    }
}
