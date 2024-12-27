//
//  OFD.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 23.12.2024.
//

public struct OFD: InternalConstructible, Encodable {
    public let ip: String
    public let port: UInt16
    public let domain: String
    public let description: String
    
    private init(ip: String, port: UInt16, domain: String, description: String) {
        self.ip = ip
        self.port = port
        self.domain = domain
        self.description = description
    }
    
    static func create(with data: (ip: String, port: UInt16, domain: String, description: String)) -> OFD {
        OFD(ip: data.0, port: data.1, domain: data.2, description: data.3)
    }
    
    /// Ключи для кодирования данных.
    private enum CodingKeys: String, CodingKey {
        case ip
        case port
        case domain
        case description
    }

    /// Кодирует объект в заданный `Encoder`.
    ///
    /// - Parameter encoder: Объект `Encoder`, предоставленный вызывающей стороной.
    /// - Throws: Ошибка кодирования, если данные не могут быть закодированы.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ip, forKey: .ip)
        try container.encode(port, forKey: .port)
        try container.encode(domain, forKey: .domain)
        try container.encode(description, forKey: .description)
    }
}
