//
//  MessageHeader.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 24.09.2024.
//

import Foundation

/// Структура `MessageHeader` используется для формирования и обработки заголовков сообщений, отправляемых на сервер оператора фискальных данных (ОФД).
///
/// Заголовок сообщения включает в себя ключевые данные, такие как идентификатор приложения, версию протокола, размер полезной нагрузки, токен аутентификации и порядковый номер запроса.
/// Структура позволяет как формировать заголовок для отправки, так и извлекать его из полученных данных.
///
/// ### Формат заголовка (18 байт):
/// - `appCode` (2 байта): Код приложения, используемый для идентификации типа сообщений.
/// - `version` (2 байта): Версия протокола, по которому происходит взаимодействие.
/// - `size` (4 байта): Общий размер сообщения (включая заголовок и полезную нагрузку).
/// - `id` (4 байта): Уникальный идентификатор устройства.
/// - `token` (4 байта): Токен аутентификации, используемый для проверки доступа.
/// - `reqNum` (2 байта): Порядковый номер запроса, используемый для идентификации запросов и их повторов.
struct MessageHeader {
    let appCode: UInt16
    let version: UInt16
    let size: UInt32
    let id: UInt32
    let token: UInt32
    let reqNum: UInt16
    
    /// Создает заголовок сообщения в формате `Data` для отправки на сервер.
    ///
    /// - Parameters:
    ///   - id: Уникальный идентификатор устройства.
    ///   - token: Токен аутентификации.
    ///   - reqNum: Порядковый номер запроса.
    ///   - payload: Данные полезной нагрузки.
    ///
    /// - Returns: Объект `Data`, представляющий собой заголовок сообщения.
    static func toData(id: UInt32, token: UInt32, reqNum: UInt16, payload: Data) -> Data {
        let appCode: UInt16 = 0x81A2
        let versionProtocol: UInt16 = 202
        let size = UInt32(payload.count + 18)
        var header = Data()
        
        // Последовательно добавляем значения в формате "little-endian"
        header.append(contentsOf: withUnsafeBytes(of: appCode.littleEndian, Array.init))
        header.append(contentsOf: withUnsafeBytes(of: versionProtocol.littleEndian, Array.init))
        header.append(contentsOf: withUnsafeBytes(of: size.littleEndian, Array.init))
        header.append(contentsOf: withUnsafeBytes(of: id.littleEndian, Array.init))
        header.append(contentsOf: withUnsafeBytes(of: token.littleEndian, Array.init))
        header.append(contentsOf: withUnsafeBytes(of: reqNum.littleEndian, Array.init))
        
        return header
    }
    
    /// Десериализует данные из объекта `Data` в структуру `MessageHeader`.
    ///
    /// - Parameter data: Данные в формате `Data`, из которых необходимо извлечь заголовок.
    ///
    /// - Returns: Экземпляр структуры `MessageHeader`.
    ///
    /// - Throws: Ошибка, если длина данных меньше необходимого размера заголовка (18 байт).
    ///
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
        
        return MessageHeader(appCode: appCode, version: version, size: size, id: id, token: token, reqNum: reqNum)
    }
}
