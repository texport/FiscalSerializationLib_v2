//
//  DataConversionUtils.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 21.10.2024.
//

import Foundation

struct DataConversionUtils {
    static func dataFromHexString(_ hex: String) -> Data? {
        var data = Data()
        var hex = hex.replacingOccurrences(of: " ", with: "")

        if hex.count % 2 != 0 {
            return nil
        }

        while !hex.isEmpty {
            let subIndex = hex.index(hex.startIndex, offsetBy: 2)
            let byteString = hex[..<subIndex]
            hex = String(hex[subIndex...])

            if var num = UInt8(byteString, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        return data
    }
}
