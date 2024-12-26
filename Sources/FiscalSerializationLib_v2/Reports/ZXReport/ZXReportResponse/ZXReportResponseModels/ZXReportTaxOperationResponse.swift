//
//  ZXReportTaxOperationResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 04.12.2024.
//

import Foundation

public struct ZXReportTaxOperationResponse: InternalConstructible, Encodable {
    public let operation: OperationTypeEnum
    public let turnover: Double
    public let turnoverWithoutTax: Double
    public let sum: Double
    
    private init(operation: OperationTypeEnum, turnover: Double, turnoverWithoutTax: Double, sum: Double) {
        self.operation = operation
        self.turnover = turnover
        self.turnoverWithoutTax = turnoverWithoutTax
        self.sum = sum
    }
    
    static func create(with data: (OperationTypeEnum, Double, Double, Double)) -> ZXReportTaxOperationResponse {
        return ZXReportTaxOperationResponse(
            operation: data.0,
            turnover: data.1,
            turnoverWithoutTax: data.2,
            sum: data.3
        )
    }
}
