//
//  ZXReportTaxResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 28.11.2024.
//

import Foundation

public struct ZXReportTaxResponse: InternalConstructible {
    public let percent: UInt32
    public let operations: [ZXReportTaxOperationResponse]
    
    private init(percent: UInt32, operations: [ZXReportTaxOperationResponse]) {
        self.percent = percent
        self.operations = operations
    }
    
    static func create(with data: (UInt32, [ZXReportTaxOperationResponse])) -> ZXReportTaxResponse {
        return ZXReportTaxResponse(percent: data.0,
                                   operations: data.1)
    }
}
