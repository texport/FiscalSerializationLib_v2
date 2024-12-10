//
//  ZXReportSections.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 27.11.2024.
//

import Foundation

struct ZXReportSections {
    static func createZXReportSections(zXReportSectionsCpcr: [Kkm_Proto_ZXReport.Section]) throws -> [ZXReportSectionResponse] {
        let sections = try zXReportSectionsCpcr.map { sectionCpcr in
            try ZXReportSection.createZXReportSectionResponse(zXReportSectionCpcr: sectionCpcr)
        }
        
        return sections
    }
}
