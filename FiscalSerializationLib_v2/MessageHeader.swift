//
//  MessageHeader.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 24.09.2024.
//

import Foundation

// Структура для формирования заголовка
struct MessageHeader {
    var appCode: UInt16
    var version: UInt16
    var size: UInt32
    var id: UInt32
    var token: UInt32
    var reqNum: UInt16
    
    func toData() -> Data {
        var data = Data()
        
        // Последовательно добавляем значения в формате "little-endian"
        data.append(contentsOf: withUnsafeBytes(of: appCode.littleEndian, Array.init))
        data.append(contentsOf: withUnsafeBytes(of: version.littleEndian, Array.init))
        data.append(contentsOf: withUnsafeBytes(of: size.littleEndian, Array.init))
        data.append(contentsOf: withUnsafeBytes(of: id.littleEndian, Array.init))
        data.append(contentsOf: withUnsafeBytes(of: token.littleEndian, Array.init))
        data.append(contentsOf: withUnsafeBytes(of: reqNum.littleEndian, Array.init))
        
        return data
    }
}
