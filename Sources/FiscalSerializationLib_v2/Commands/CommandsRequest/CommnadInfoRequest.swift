//
//  CommadInfoRequest.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 11.12.2024.
//

public struct CommandInfoRequest: CommandProtocol, RequestProtocol {
    public private(set) var commandCode = CommandTypeEnum.commandInfo
}
