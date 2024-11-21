//
//  ServiceResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 18.11.2024.
//

class ServiceResponse {
    private let serviceResponse: Kkm_Proto_ServiceResponse
    var ads: [String]?
    var kkm: RegInfoResponse?
    
    init(serviceResponse: Kkm_Proto_ServiceResponse) throws {
        self.serviceResponse = serviceResponse
        try setupServiceResponse()
    }
    
    private func setupServiceResponse() throws {
        try setupAdsResponse()
        try setupRegInfoResponse()
    }
    
    // MARK: Рекламные тексты
    private func setupAdsResponse() throws {
        let adsResponseCpcr = serviceResponse.ticketAds
        
        if adsResponseCpcr.count >= 1 {
            ads = try createAdsResponse(adsResponseCpcr: adsResponseCpcr)
        }
    }
    
    private func createAdsResponse(adsResponseCpcr: [Kkm_Proto_TicketAd]) throws -> [String] {
        return adsResponseCpcr.map { $0.text }
    }
    
    // MARK: Инфо о ККМ с ОФД(RegInfo)
    private func setupRegInfoResponse() throws {
        let regInfoResponseCpcr = serviceResponse.regInfo
        kkm = try RegInfo.createRegInfoResponse(regInfoResponse: regInfoResponseCpcr)
    }
}
