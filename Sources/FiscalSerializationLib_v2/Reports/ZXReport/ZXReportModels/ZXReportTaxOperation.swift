//
//  ZXReportTaxOperation.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 04.12.2024.
//

import Foundation

struct ZXReportTaxOperation {
    static func createZXReportTaxOperationResponse(zXReportTaxOperationCpcr: Kkm_Proto_ZXReport.Tax.TaxOperation) throws -> ZXReportTaxOperationResponse {
        guard zXReportTaxOperationCpcr.hasOperation else {
            throw ZXReportErrorEnum.missingTaxOperationResponse
        }
        
        guard let operation = OperationTypeEnum(rawValue: UInt(zXReportTaxOperationCpcr.operation.rawValue)) else {
            throw ZXReportErrorEnum.notValideTaxOperationTypeResponse
        }
        
        let turnover = Money.toDouble(protoMoney: zXReportTaxOperationCpcr.turnover)
        let turnoverWithoutTax = Money.toDouble(protoMoney: zXReportTaxOperationCpcr.turnoverWithoutTax)
        let sum = Money.toDouble(protoMoney: zXReportTaxOperationCpcr.sum)
        
        return ZXReportTaxOperationResponse.create(with: (operation, turnover, turnoverWithoutTax, sum))
    }
}
