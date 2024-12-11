//
//  ZXReportRevenue.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 11.12.2024.
//

struct ZXReportRevenue {
    static func createZXReportRevenueResponse(zXReportRevenueCpcr: Kkm_Proto_ZXReport.Revenue) throws -> ZXReportRevenueResponse {
        let sum = Money.toDouble(protoMoney: zXReportRevenueCpcr.sum)
        let isNegative = zXReportRevenueCpcr.isNegative
        
        return ZXReportRevenueResponse.create(with: (sum, isNegative))
    }
}
