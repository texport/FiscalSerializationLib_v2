//
//  CommandSystemRequest.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 27.12.2024.
//

public struct CommandSystemRequest: CommandProtocol, RequestProtocol {
    public private(set) var commandCode = CommandTypeEnum.commandSystem
}
