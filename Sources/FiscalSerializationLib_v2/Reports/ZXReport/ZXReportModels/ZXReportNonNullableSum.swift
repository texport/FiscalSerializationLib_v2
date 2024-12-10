//
//  ZXReportNonNullableSum.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 09.12.2024.
//

import Foundation

struct ZXReportNonNullableSum {
    static func createZXReportNonNullableSumResponse(zXReportNonNullableSumCpcr: Kkm_Proto_ZXReport.NonNullableSum) throws -> ZXReportNonNullableSumResponse {
        guard let operation = OperationTypeEnum(rawValue: UInt(zXReportNonNullableSumCpcr.operation.rawValue)) else {
            throw ZXReportErrorEnum.notValideTaxOperationTypeResponse
        }
        
        let sum = Money.toDouble(protoMoney: zXReportNonNullableSumCpcr.sum)
        
        return ZXReportNonNullableSumResponse.create(with: (operation, sum))
    }
}

struct ZXReportNonNullableSums {
    static func createZXReportNonNullableSumsResponse(zXReportNonNullableSumsCpcr: [Kkm_Proto_ZXReport.NonNullableSum]) throws -> [ZXReportNonNullableSumResponse] {
        return try zXReportNonNullableSumsCpcr.map { zXReportNonNullableSum in
            try ZXReportNonNullableSum.createZXReportNonNullableSumResponse(zXReportNonNullableSumCpcr: zXReportNonNullableSum)
        }
    }
}
