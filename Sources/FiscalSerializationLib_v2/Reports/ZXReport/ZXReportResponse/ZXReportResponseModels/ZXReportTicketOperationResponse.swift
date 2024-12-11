//
//  ZXReportTicketOperationResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 10.12.2024.
//

public struct ZXReportTicketOperationResponse: InternalConstructible {
    public let operation: OperationTypeEnum
    public let ticketsTotalCount: UInt32
    public let ticketsCount: UInt32
    public let ticketsSum: Double
    public let payments: [ZXReportTicketOperationPaymentResponse]
    public let offlineCount: UInt32
    public let discountSum: Double
    public let changeSum: Double
    
    private init(operation: OperationTypeEnum, ticketsTotalCount: UInt32, ticketsCount: UInt32, ticketsSum: Double, payments: [ZXReportTicketOperationPaymentResponse], offlineCount: UInt32, discountSum: Double, changeSum: Double) {
        self.operation = operation
        self.ticketsTotalCount = ticketsTotalCount
        self.ticketsCount = ticketsCount
        self.ticketsSum = ticketsSum
        self.payments = payments
        self.offlineCount = offlineCount
        self.discountSum = discountSum
        self.changeSum = changeSum
    }
    
    static func create(with data: (OperationTypeEnum,
                                   UInt32,
                                   UInt32,
                                   Double,
                                   [ZXReportTicketOperationPaymentResponse],
                                   UInt32,
                                   Double,
                                   Double)) -> ZXReportTicketOperationResponse {
        ZXReportTicketOperationResponse(operation: data.0, ticketsTotalCount: data.1, ticketsCount: data.2, ticketsSum: data.3, payments: data.4, offlineCount: data.5, discountSum: data.6, changeSum: data.7)
    }
}
