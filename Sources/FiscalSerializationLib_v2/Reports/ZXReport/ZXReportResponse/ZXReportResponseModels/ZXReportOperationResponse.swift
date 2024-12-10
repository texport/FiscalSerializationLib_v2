//
//  ZXReportOperationResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 25.11.2024.
//

import Foundation

public struct ZXReportOperationResponse: InternalConstructible {
    public let operation: OperationTypeEnum
    public let count: UInt32
    public let sum: Double
    
    private init(operation: OperationTypeEnum, count: UInt32, sum: Double) {
        self.operation = operation
        self.count = count
        self.sum = sum
    }
    
    static func create(with data: (OperationTypeEnum, UInt32, Double)) -> ZXReportOperationResponse {
        return ZXReportOperationResponse(operation: data.0, count: data.1, sum: data.2)
    }
}
