//
//  ResponseProtocol.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 11.12.2024.
//

protocol ResponseProtocol {
    var ofdName: OFD { get }
    var kkm: KKM { get }
    var command: CommandResponse { get }
    var result: ResultResponse { get }
}
