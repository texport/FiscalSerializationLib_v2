//
//  ZXReportOperations.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 25.11.2024.
//

import Foundation

struct ZXReportOperations {
    static func createZXReportOperationsResponse(zXReportOperationsCpcr: [Kkm_Proto_ZXReport.Operation]) throws -> [ZXReportOperationResponse] {
        return try zXReportOperationsCpcr.map { operation in
            let response = try ZXReportOperation.createZXReportOperationResponse(zXReportOperationCpcr: operation)
            return response
        }
    }
}
