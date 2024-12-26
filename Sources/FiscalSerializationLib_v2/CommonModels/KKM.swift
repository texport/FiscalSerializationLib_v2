//
//  KKM.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 11.12.2024.
//

public struct KKM: Encodable {
    public let idKkm: UInt32
    public let tokenKkm: UInt32
    public let reqNum: UInt16
    public let kgdId: String?
    public let kkmSerialNumber: String?
    
    public init(idKkm: UInt32, tokenKkm: UInt32, reqNum: UInt16, kgdId: String?, kkmSerialNumber: String?) {
        self.idKkm = idKkm
        self.tokenKkm = tokenKkm
        self.reqNum = reqNum
        self.kgdId = kgdId
        self.kkmSerialNumber = kkmSerialNumber
    }
    
    /// Ключи для кодирования данных.
    private enum CodingKeys: String, CodingKey {
        case idKkm
        case tokenKkm
        case reqNum
        case kgdId
        case kkmSerialNumber
    }

    /// Кодирует объект в заданный `Encoder`.
    ///
    /// - Parameter encoder: Объект `Encoder`, предоставленный вызывающей стороной.
    /// - Throws: Ошибка кодирования, если данные не могут быть закодированы.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(idKkm, forKey: .idKkm)
        try container.encode(tokenKkm, forKey: .tokenKkm)
        try container.encode(reqNum, forKey: .reqNum)
        
        // Кодируем только непустые значения
        if let kgdId = kgdId {
            try container.encode(kgdId, forKey: .kgdId)
        }
        if let kkmSerialNumber = kkmSerialNumber {
            try container.encode(kkmSerialNumber, forKey: .kkmSerialNumber)
        }
    }
}
