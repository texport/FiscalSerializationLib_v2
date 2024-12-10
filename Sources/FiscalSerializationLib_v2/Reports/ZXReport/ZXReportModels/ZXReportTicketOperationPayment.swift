//
//  ZXReportTicketOperationPayment.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 10.12.2024.
//

import Foundation

struct ZXReportTicketOperationPayments {
    static func createZXReportTicketOperationPaymentsResponse(zXReportTicketOperationPaymentsCpcr: [Kkm_Proto_ZXReport.TicketOperation.Payment]) throws -> [ZXReportTicketOperationPaymentResponse] {
        let payments = try zXReportTicketOperationPaymentsCpcr.map { paymentCpcr in
            try ZXReportTicketOperationPayment.createZXReportTicketOperationPaymentResponse(zXReportTicketOperationPaymentCpcr: paymentCpcr)
        }
        
        return payments
    }
}

struct ZXReportTicketOperationPayment {
    static func createZXReportTicketOperationPaymentResponse(zXReportTicketOperationPaymentCpcr: Kkm_Proto_ZXReport.TicketOperation.Payment) throws -> ZXReportTicketOperationPaymentResponse {
        guard let payment = PaymentTypeEnum(rawValue: UInt(zXReportTicketOperationPaymentCpcr.payment.rawValue)) else {
            throw ZXReportErrorEnum.notValidePaymentTypeResponse
        }
        
        let sum = Money.toDouble(protoMoney: zXReportTicketOperationPaymentCpcr.sum)
        let count = zXReportTicketOperationPaymentCpcr.count
        
        return ZXReportTicketOperationPaymentResponse.create(with: (payment, sum, count))
    }
}
