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
    
    // Метод для десериализации заголовка из Data
    static func fromData(_ data: Data) throws -> MessageHeader {
        // Проверяем, что длина данных соответствует размеру заголовка (18 байт)
        guard data.count >= 18 else {
            throw NSError(domain: "MessageHeaderError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Неверный размер данных для заголовка"])
        }
        
        var offset = 0
        
        // Извлекаем поля заголовка по порядку, используя little-endian формат
        let appCode = data.subdata(in: offset..<offset+2).withUnsafeBytes { $0.load(as: UInt16.self) }.littleEndian
        offset += 2
        
        let version = data.subdata(in: offset..<offset+2).withUnsafeBytes { $0.load(as: UInt16.self) }.littleEndian
        offset += 2
        
        let size = data.subdata(in: offset..<offset+4).withUnsafeBytes { $0.load(as: UInt32.self) }.littleEndian
        offset += 4
        
        let id = data.subdata(in: offset..<offset+4).withUnsafeBytes { $0.load(as: UInt32.self) }.littleEndian
        offset += 4
        
        let token = data.subdata(in: offset..<offset+4).withUnsafeBytes { $0.load(as: UInt32.self) }.littleEndian
        offset += 4
        
        let reqNum = data.subdata(in: offset..<offset+2).withUnsafeBytes { $0.load(as: UInt16.self) }.littleEndian
        
        // Создаем объект заголовка с извлеченными данными
        return MessageHeader(appCode: appCode, version: version, size: size, id: id, token: token, reqNum: reqNum)
    }
}
