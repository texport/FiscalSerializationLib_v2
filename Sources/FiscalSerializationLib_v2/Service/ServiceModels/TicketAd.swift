//
//  TicketAd.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 18.11.2024.
//

struct TicketAd {
    static func createTicketAdResponse(ticketAd: Kkm_Proto_TicketAd) throws -> String {
        return ticketAd.text
    }
}
