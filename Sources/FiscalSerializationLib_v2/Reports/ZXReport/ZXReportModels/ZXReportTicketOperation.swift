//
//  ZXReportTicketOperation.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 10.12.2024.
//

import Foundation

struct ZXReportTicketOperations {
    static func createZXReportTicketOperationsResponse(zXReportTicketOperationsCpcr: [Kkm_Proto_ZXReport.TicketOperation]) throws -> [ZXReportTicketOperationResponse] {
        try zXReportTicketOperationsCpcr.map { ticketOperationCpcr in
            try ZXReportTicketOperation.createZXReportTicketOperationResponse(zXReportTicketOperationCpcr: ticketOperationCpcr)
        }
    }
}

struct ZXReportTicketOperation {
    static func createZXReportTicketOperationResponse(zXReportTicketOperationCpcr: Kkm_Proto_ZXReport.TicketOperation) throws -> ZXReportTicketOperationResponse {
        guard zXReportTicketOperationCpcr.hasOperation else {
            throw ZXReportErrorEnum.missingTaxOperationResponse
        }
        
        guard let operation = OperationTypeEnum(rawValue: UInt(zXReportTicketOperationCpcr.operation.rawValue)) else {
            throw ZXReportErrorEnum.notValideTaxOperationTypeResponse
        }
        
        let ticketsTotalCount = zXReportTicketOperationCpcr.ticketsTotalCount
        let ticketsCount = zXReportTicketOperationCpcr.ticketsCount
        let ticketsSum = Money.toDouble(protoMoney: zXReportTicketOperationCpcr.ticketsSum)
        let payments = try ZXReportTicketOperationPayments.createZXReportTicketOperationPaymentsResponse(zXReportTicketOperationPaymentsCpcr: zXReportTicketOperationCpcr.payments)
        let offlineCount = zXReportTicketOperationCpcr.offlineCount
        let discountSum = Money.toDouble(protoMoney: zXReportTicketOperationCpcr.discountSum)
        let changeSum = Money.toDouble(protoMoney: zXReportTicketOperationCpcr.changeSum)
        
        return ZXReportTicketOperationResponse.create(with: (operation, ticketsTotalCount, ticketsCount, ticketsSum, payments, offlineCount, discountSum, changeSum))
    }
}
