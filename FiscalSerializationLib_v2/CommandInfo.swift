//
//  CommandInfo.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 24.09.2024.
//

import SwiftProtobuf
import Foundation
import Network

struct CommandInfoSerializer {
    func serializeCommandInfo() throws -> Data {
        var request = Kkm_Proto_Request()
        request.command = .commandInfo
        
        // Сериализация Payload
        let payload = try request.serializedData()
        
        print("Payload (hex): \(payload.map { String(format: "%02hhx", $0) }.joined())")
        return payload
    }
}
