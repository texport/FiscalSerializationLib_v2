//
//  OfflinePeriod.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 22.11.2024.
//

struct OfflinePeriodRequest {
    static func createOfflinePeriod(offlinePeriodBegin: Kkm_Proto_DateTime, offlinePeriodEnd: Kkm_Proto_DateTime) throws -> Kkm_Proto_ServiceRequest.OfflinePeriod {
        var offlinePeriod = Kkm_Proto_ServiceRequest.OfflinePeriod()
        
        offlinePeriod.beginTime = offlinePeriodBegin
        offlinePeriod.endTime = offlinePeriodEnd
        
        return offlinePeriod
    }
}
