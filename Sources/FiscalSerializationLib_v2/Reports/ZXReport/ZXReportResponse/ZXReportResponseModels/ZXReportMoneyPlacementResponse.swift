//
//  ZXReportMoneyPlacementResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 11.12.2024.
//

import Foundation

public struct ZXReportMoneyPlacementResponse: InternalConstructible, Encodable {
    public let operation: MoneyPlacementEnum
    public let operationsTotalCount: UInt32
    public let operationsCount: UInt32
    public let operationsSum: Double
    public let offlineCount: UInt32
    
    private init(operation: MoneyPlacementEnum, operationsTotalCount: UInt32, operationsCount: UInt32, operationsSum: Double, offlineCount: UInt32) {
        self.operation = operation
        self.operationsTotalCount = operationsTotalCount
        self.operationsCount = operationsCount
        self.operationsSum = operationsSum
        self.offlineCount = offlineCount
    }
    
    static func create(with data: (MoneyPlacementEnum, UInt32, UInt32, Double, UInt32)) -> ZXReportMoneyPlacementResponse {
        ZXReportMoneyPlacementResponse(operation: data.0, operationsTotalCount: data.1, operationsCount: data.2, operationsSum: data.3, offlineCount: data.4)
    }
}
