//
//  ZXReportSectionResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 27.11.2024.
//

import Foundation

public struct ZXReportSectionResponse: InternalConstructible {
    public let section: String
    public let operations: [ZXReportOperationResponse]
    
    private init(section: String, operations: [ZXReportOperationResponse]) {
        self.section = section
        self.operations = operations
    }
    
    static func create(with data: (String, [ZXReportOperationResponse])) -> ZXReportSectionResponse {
        return ZXReportSectionResponse(section: data.0, operations: data.1)
    }
}
