//
//  ZXReportNonNullableSumResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 09.12.2024.
//

public struct ZXReportNonNullableSumResponse: InternalConstructible, Encodable {
    public let operation: OperationTypeEnum
    public let sum: Double
    
    private init(operation: OperationTypeEnum, sum: Double) {
        self.operation = operation
        self.sum = sum
    }
    
    static func create(with data: (OperationTypeEnum, Double)) -> ZXReportNonNullableSumResponse {
        return ZXReportNonNullableSumResponse(operation: data.0, sum: data.1)
    }
}
