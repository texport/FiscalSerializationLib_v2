//
//  ZXReportRevenueResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 11.12.2024.
//

public struct ZXReportRevenueResponse: InternalConstructible {
    public let sum: Double
    public let isNegative: Bool
    
    private init(sum: Double, isNegative: Bool) {
        self.sum = sum
        self.isNegative = isNegative
    }
    
    static func create(with data: (Double, Bool)) -> ZXReportRevenueResponse {
        ZXReportRevenueResponse(sum: data.0, isNegative: data.1)
    }
}
