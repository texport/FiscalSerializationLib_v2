//
//  ZXReportSection.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 27.11.2024.
//

import Foundation

struct ZXReportSection {
    static func createZXReportSectionResponse(zXReportSectionCpcr: Kkm_Proto_ZXReport.Section) throws -> ZXReportSectionResponse {
        guard zXReportSectionCpcr.hasSectionCode else {
            throw NSError(
                domain: "createZXReportSectionResponse",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "В ответе от сервера ОФД нет ни одной секции, такого быть не может, обратитесь в службу поддержки ОФД."]
            )
        }
        
        let sectionCpcr = zXReportSectionCpcr.sectionCode
        let operationsCpcr = zXReportSectionCpcr.operations
        let sectionResponse = sectionCpcr
        
        guard operationsCpcr.count >= 1 else {
            throw NSError(
                domain: "createZXReportSectionResponse",
                code: 2,
                userInfo: [NSLocalizedDescriptionKey: "В ответе от сервера ОФД в секции под названием \(sectionCpcr), нет операций, такого быть не может, обратитесь в службу поддержки ОФД."]
            )
        }
        
        let operationsResponse = try operationsCpcr.map { operationCpcr in
            try ZXReportOperation.createZXReportOperationResponse(zXReportOperationCpcr: operationCpcr)
        }
        
        return ZXReportSectionResponse.create(with: (sectionResponse, operationsResponse))
    }
}
