//
//  CommandMoneyPlacementRequest.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 27.12.2024.
//

import Foundation

public struct CommandMoneyPlacementRequest: CommandProtocol, RequestProtocol {
    public private(set) var commandCode = CommandTypeEnum.commandMoneyPlacement
    
    public let dateTime: String
    public let operation: MoneyPlacementEnum
    public let sum: Double
    public let isOffline: Bool
    public let shiftNumber: UInt32
    public let operatorCode: UInt32
    public let operatorName: String
}
