//
//  ZXReportTicketOperationPaymentResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 10.12.2024.
//

public struct ZXReportTicketOperationPaymentResponse: InternalConstructible {
    public let payment: PaymentTypeEnum
    public let sum: Double
    public let count: UInt32
    
    private init(payment: PaymentTypeEnum, sum: Double, count: UInt32) {
        self.payment = payment
        self.sum = sum
        self.count = count
    }
    
    static func create(with data: (PaymentTypeEnum, Double, UInt32)) -> ZXReportTicketOperationPaymentResponse {
        ZXReportTicketOperationPaymentResponse(payment: data.0, sum: data.1, count: data.2)
    }
}
