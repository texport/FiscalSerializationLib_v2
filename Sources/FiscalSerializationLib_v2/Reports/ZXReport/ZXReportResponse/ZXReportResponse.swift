//
//  ZXReportResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 25.11.2024.
//

import Foundation

final class ZXReportResponseBuilder {
    private let zXReportCpcr: Kkm_Proto_ZXReport
    
    private init(zXReportCpcr: Kkm_Proto_ZXReport) {
        self.zXReportCpcr = zXReportCpcr
    }
    
    static func createZXReportResponse(from zXReportCpcr: Kkm_Proto_ZXReport) throws -> ZXReportResponse {
        let builder = ZXReportResponseBuilder(zXReportCpcr: zXReportCpcr)
        return try builder.setupZXReportResponse()
    }

    private func setupZXReportResponse() throws -> ZXReportResponse {
        var openShiftTimeResponse: Date?
        var closeShiftTimeResponse: Date?
        var sectionsResponse: [ZXReportSectionResponse]?
        var operationsResponse: [ZXReportOperationResponse]?
        var discountsResponse: [ZXReportOperationResponse]?
        var totalResultResponse: [ZXReportOperationResponse]?
        var taxes: [ZXReportTaxResponse]?
        var startShiftNonNullableSums: [ZXReportNonNullableSumResponse]?
        var nonNullableSums: [ZXReportNonNullableSumResponse]?
        
        let dateTimeResponse = try setupDateTime()
        
        #warning("openShiftTimeResponse - сейчас ОФД КТ и прото файлы нарушают протокол и не отправляет этот параметр если касса новая.")
        if zXReportCpcr.hasOpenShiftTime {
            openShiftTimeResponse = try setupOpenShiftTime()
        }
        
        #warning("closeShiftTimeResponse - сейчас ОФД КТ и прото файлы нарушают протокол и не отправляет этот параметр если касса новая.")
        if zXReportCpcr.hasCloseShiftTime {
            closeShiftTimeResponse = try setupCloseShiftTime()
        }
        
        let shiftNumberResponse = try setupShiftNumber()
        
        #warning("sections - сейчас ОФД КТ и прото файлы нарушают протокол и не отправляет этот параметр если касса новая.")
        if zXReportCpcr.sections.count >= 1 {
            sectionsResponse = try setupSections()
        }
        
        if zXReportCpcr.operations.count >= 1 {
            operationsResponse = try setupOperations()
        }
        
        if zXReportCpcr.discounts.count >= 1 {
            discountsResponse = try setupDiscounts()
        }
        
        if zXReportCpcr.totalResult.count >= 1 {
            totalResultResponse = try setupTotalResult()
        }
        
        if zXReportCpcr.taxes.count >= 1 {
            taxes = try setupTaxes()
        }
        
        if zXReportCpcr.startShiftNonNullableSums.count >= 1 {
            startShiftNonNullableSums = try setupStartShiftNonNullableSums()
        }
        
        if zXReportCpcr.nonNullableSums.count >= 1 {
            nonNullableSums = try setupNonNullableSums()
        }
        
        return ZXReportResponse(dateTime: dateTimeResponse,
                                openShiftTime: openShiftTimeResponse,
                                closeShiftTime: closeShiftTimeResponse,
                                shiftNumber: shiftNumberResponse,
                                sections: sectionsResponse,
                                operations: operationsResponse,
                                discounts: discountsResponse,
                                totalResult: totalResultResponse,
                                taxes: taxes,
                                startShiftNonNullableSums: startShiftNonNullableSums,
                                nonNullableSums: nonNullableSums)
    }
    
    private func setupDateTime() throws -> Date {
        try DateTime.createDateSwiftType(dateTimeCpcr: zXReportCpcr.dateTime)
    }
    
    private func setupOpenShiftTime() throws -> Date {
        try DateTime.createDateSwiftType(dateTimeCpcr: zXReportCpcr.openShiftTime)
    }
    
    private func setupCloseShiftTime() throws -> Date {
        try DateTime.createDateSwiftType(dateTimeCpcr: zXReportCpcr.closeShiftTime)
    }
    
    #warning("shiftNumber - сейчас ОФД КТ и прото файлы нарушают протокол, согласно прото файлам ОФД может не прислать номер смены.")
    private func setupShiftNumber() throws -> UInt32 {
        guard zXReportCpcr.hasShiftNumber else {
            throw NSError(
                domain: "setupShiftNumber",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "ОФД Нарушил протокол - ОФД прислал пустой номер смены, обратитесь в службу поддержки ОФД."]
            )
        }
        
        return zXReportCpcr.shiftNumber
    }
    
    private func setupSections() throws -> [ZXReportSectionResponse] {
        try ZXReportSections.createZXReportSections(zXReportSectionsCpcr: zXReportCpcr.sections)
    }
    
    private func setupOperations() throws -> [ZXReportOperationResponse] {
        try ZXReportOperations.createZXReportOperationsResponse(zXReportOperationsCpcr: zXReportCpcr.operations)
    }
    
    private func setupDiscounts() throws -> [ZXReportOperationResponse] {
        try ZXReportOperations.createZXReportOperationsResponse(zXReportOperationsCpcr: zXReportCpcr.discounts)
    }
    
    private func setupTotalResult() throws -> [ZXReportOperationResponse] {
        try ZXReportOperations.createZXReportOperationsResponse(zXReportOperationsCpcr: zXReportCpcr.totalResult)
    }
    
    private func setupTaxes() throws -> [ZXReportTaxResponse] {
        try ZXReportTaxes.createZXReportTaxesResponse(zXReportTaxesCpcr: zXReportCpcr.taxes)
    }
    
    private func setupStartShiftNonNullableSums() throws -> [ZXReportNonNullableSumResponse] {
        try ZXReportNonNullableSums.createZXReportNonNullableSumsResponse(zXReportNonNullableSumsCpcr: zXReportCpcr.startShiftNonNullableSums)
    }
    
    private func setupNonNullableSums() throws -> [ZXReportNonNullableSumResponse] {
        try ZXReportNonNullableSums.createZXReportNonNullableSumsResponse(zXReportNonNullableSumsCpcr: zXReportCpcr.nonNullableSums)
    }
}

public struct ZXReportResponse {
    public let dateTime: Date
    public let openShiftTime: Date?
    public let closeShiftTime: Date?
    public let shiftNumber: UInt32
    public let sections: [ZXReportSectionResponse]?
    public let operations: [ZXReportOperationResponse]?
    public let discounts: [ZXReportOperationResponse]?
    public let totalResult: [ZXReportOperationResponse]?
    public let taxes: [ZXReportTaxResponse]?
    public let startShiftNonNullableSums: [ZXReportNonNullableSumResponse]?
    public let nonNullableSums: [ZXReportNonNullableSumResponse]?
}
