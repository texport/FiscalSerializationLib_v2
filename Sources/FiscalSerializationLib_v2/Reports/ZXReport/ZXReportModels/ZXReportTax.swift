//
//  ZXReportTax.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 09.12.2024.
//

import Foundation

struct ZXReportTaxes {
    static func createZXReportTaxesResponse(zXReportTaxesCpcr: [Kkm_Proto_ZXReport.Tax]) throws -> [ZXReportTaxResponse] {
        let taxes = try zXReportTaxesCpcr.map { taxCpcr in
            try ZXReportTax.createZXReportTaxResponse(zXReportTaxCpcr: taxCpcr)
        }
        
        return taxes
    }
}

struct ZXReportTax {
    static func createZXReportTaxResponse(zXReportTaxCpcr: Kkm_Proto_ZXReport.Tax) throws -> ZXReportTaxResponse {
        let percent = zXReportTaxCpcr.percent
        let operations = try zXReportTaxCpcr.operations.map { operationCpcr in
            try ZXReportTaxOperation.createZXReportTaxOperationResponse(zXReportTaxOperationCpcr: operationCpcr)
        }
        
        return ZXReportTaxResponse.create(with: (percent, operations))
    }
}
