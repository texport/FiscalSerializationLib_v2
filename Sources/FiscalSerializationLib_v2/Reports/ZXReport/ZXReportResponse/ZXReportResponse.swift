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
        var ticketOperations: [ZXReportTicketOperationResponse]?
        var moneyPlacements: [ZXReportMoneyPlacementResponse]?
        var cashSum: Double
        var revenue: ZXReportRevenueResponse
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
        
        if zXReportCpcr.ticketOperations.count >= 1 {
            ticketOperations = try setupTicketOperations()
        }
        
        if zXReportCpcr.moneyPlacements.count >= 1 {
            moneyPlacements = try setupMoneyPlacements()
        }
        
        cashSum = Money.toDouble(protoMoney: zXReportCpcr.cashSum)
        
        revenue = try ZXReportRevenue.createZXReportRevenueResponse(zXReportRevenueCpcr: zXReportCpcr.revenue)
        
        if zXReportCpcr.nonNullableSums.count >= 1 {
            nonNullableSums = try setupNonNullableSums()
        }
        
        return ZXReportResponse.create(with: (dateTime: dateTimeResponse,
                                              openShiftTime: openShiftTimeResponse,
                                              closeShiftTime: closeShiftTimeResponse,
                                              shiftNumber: shiftNumberResponse,
                                              sections: sectionsResponse,
                                              operations: operationsResponse,
                                              discounts: discountsResponse,
                                              totalResult: totalResultResponse,
                                              taxes: taxes,
                                              startShiftNonNullableSums: startShiftNonNullableSums,
                                              ticketOperations: ticketOperations,
                                              moneyPlacements: moneyPlacements,
                                              cashSum: cashSum,
                                              revenue: revenue,
                                              nonNullableSums: nonNullableSums))
    }
    
    #warning("checksum - сейчас ОФД КТ и прото файлы нарушают протокол, согласно прото файлам ОФД может не прислать контрольную сумму.")
    
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
    
    private func setupTicketOperations() throws -> [ZXReportTicketOperationResponse] {
        try ZXReportTicketOperations.createZXReportTicketOperationsResponse(zXReportTicketOperationsCpcr: zXReportCpcr.ticketOperations)
    }
    
    private func setupMoneyPlacements() throws -> [ZXReportMoneyPlacementResponse] {
        try ZXReportMoneyPlacements.createZXReportMoneyPlacementsResponse(zXReportMoneyPlacementsCpcr: zXReportCpcr.moneyPlacements)
    }
}

public struct ZXReportResponse: InternalConstructible, Encodable {
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
    public let ticketOperations: [ZXReportTicketOperationResponse]?
    public let moneyPlacements: [ZXReportMoneyPlacementResponse]?
    public let cashSum: Double
    public let revenue: ZXReportRevenueResponse
    public let nonNullableSums: [ZXReportNonNullableSumResponse]?
    
    private init(dateTime: Date, openShiftTime: Date?, closeShiftTime: Date?, shiftNumber: UInt32, sections: [ZXReportSectionResponse]?, operations: [ZXReportOperationResponse]?, discounts: [ZXReportOperationResponse]?, totalResult: [ZXReportOperationResponse]?, taxes: [ZXReportTaxResponse]?, startShiftNonNullableSums: [ZXReportNonNullableSumResponse]?, ticketOperations: [ZXReportTicketOperationResponse]?, moneyPlacements: [ZXReportMoneyPlacementResponse]?, cashSum: Double, revenue: ZXReportRevenueResponse, nonNullableSums: [ZXReportNonNullableSumResponse]?) {
        self.dateTime = dateTime
        self.openShiftTime = openShiftTime
        self.closeShiftTime = closeShiftTime
        self.shiftNumber = shiftNumber
        self.sections = sections
        self.operations = operations
        self.discounts = discounts
        self.totalResult = totalResult
        self.taxes = taxes
        self.startShiftNonNullableSums = startShiftNonNullableSums
        self.ticketOperations = ticketOperations
        self.moneyPlacements = moneyPlacements
        self.cashSum = cashSum
        self.revenue = revenue
        self.nonNullableSums = nonNullableSums
    }
    
    static func create(with data: (dateTime: Date, openShiftTime: Date?, closeShiftTime: Date?, shiftNumber: UInt32, sections: [ZXReportSectionResponse]?, operations: [ZXReportOperationResponse]?, discounts: [ZXReportOperationResponse]?, totalResult: [ZXReportOperationResponse]?, taxes: [ZXReportTaxResponse]?, startShiftNonNullableSums: [ZXReportNonNullableSumResponse]?, ticketOperations: [ZXReportTicketOperationResponse]?, moneyPlacements: [ZXReportMoneyPlacementResponse]?, cashSum: Double, revenue: ZXReportRevenueResponse, nonNullableSums: [ZXReportNonNullableSumResponse]?)) -> ZXReportResponse {
        ZXReportResponse(dateTime: data.0, openShiftTime: data.1, closeShiftTime: data.2, shiftNumber: data.3, sections: data.4, operations: data.5, discounts: data.6, totalResult: data.7, taxes: data.8, startShiftNonNullableSums: data.9, ticketOperations: data.10, moneyPlacements: data.11, cashSum: data.12, revenue: data.13, nonNullableSums: data.14)
    }
    
    /// Ключи для кодирования данных.
    private enum CodingKeys: String, CodingKey {
        case dateTime
        case openShiftTime
        case closeShiftTime
        case shiftNumber
        case sections
        case operations
        case discounts
        case totalResult
        case taxes
        case startShiftNonNullableSums
        case ticketOperations
        case moneyPlacements
        case cashSum
        case revenue
        case nonNullableSums
    }

    /// Кодирует объект в заданный `Encoder`.
    ///
    /// - Parameter encoder: Объект `Encoder`, предоставленный вызывающей стороной.
    /// - Throws: Ошибка кодирования, если данные не могут быть закодированы.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(dateTime, forKey: .dateTime)
        if let openShiftTime = openShiftTime {
            try container.encode(openShiftTime, forKey: .openShiftTime)
        }
        if let closeShiftTime = closeShiftTime {
            try container.encode(closeShiftTime, forKey: .closeShiftTime)
        }
        try container.encode(shiftNumber, forKey: .shiftNumber)
        if let sections = sections {
            try container.encode(sections, forKey: .sections)
        }
        if let operations = operations {
            try container.encode(operations, forKey: .operations)
        }
        if let discounts = discounts {
            try container.encode(discounts, forKey: .discounts)
        }
        if let totalResult = totalResult {
            try container.encode(totalResult, forKey: .totalResult)
        }
        if let taxes = taxes {
            try container.encode(taxes, forKey: .taxes)
        }
        if let startShiftNonNullableSums = startShiftNonNullableSums {
            try container.encode(startShiftNonNullableSums, forKey: .startShiftNonNullableSums)
        }
        if let ticketOperations = ticketOperations {
            try container.encode(ticketOperations, forKey: .ticketOperations)
        }
        if let moneyPlacements = moneyPlacements {
            try container.encode(moneyPlacements, forKey: .moneyPlacements)
        }
        try container.encode(cashSum, forKey: .cashSum)
        try container.encode(revenue, forKey: .revenue)
        if let nonNullableSums = nonNullableSums {
            try container.encode(nonNullableSums, forKey: .nonNullableSums)
        }
    }
}
