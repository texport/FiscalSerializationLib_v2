//
//  Untitled.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

struct PosRegInfo {
    static func createPosRegInfoResponse(posRegInfoResponse: Kkm_Proto_PosRegInfo) throws -> PosRegInfoResponse {
        return PosRegInfoResponse(title: posRegInfoResponse.title,
                address: posRegInfoResponse.address)
    }
}
