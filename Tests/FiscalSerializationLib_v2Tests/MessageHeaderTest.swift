//
//  MessageHeaderTest.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 21.10.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

final class MessageHeaderTest: XCTestCase {
    
    private let hexString = """
A281CA00 38020000 45100300 06C29001 01000805 12020800 22290800 12250A11 0A0708E7 0F100B18 14120608 0E100718 0810016A 04080010 0072080A 04080010 00100032 F2030ABB 010A0508 0010CC04 12B101D0 A4D0B8D1 81D0BA2E 20D187D0 B5D0BA20 E2849620 4E554C4C 20D09AD0 BED0B420 D09AD09A D09C3A20 4E554C4C 20D09DD0 B5D0BED0 B1D185D0 BED0B4D0 B8D0BCD0 BE20D0BF D0B5D180 D0B5D0B9 D182D0B8 20D0BDD0 B020D0BF D180D0BE D182D0BE D0BAD0BE D0BB2032 2E302E32 20D094D0 BBD18F20 D0BFD180 D0BED0B2 D0B5D180 D0BAD0B8 20D187D0 B5D0BAD0 B020D0B7 D0B0D0B9 D0B4D0B8 D182D0B5 20D0BDD0 B020D181 D0B0D0B9 D1823A20 4E554C4C 1294020A 291A0C32 38313934 38323731 38323122 114B5443 44313131 37373337 31323737 39312A06 32303037 37331282 010A0954 54207365 7269616C 1275D0B3 2E20D090 D181D182 D0B0D0BD D0B02C20 D1802DD0 BD20D095 D181D0B8 D0BBD18C D181D0BA D0B8D0B9 2C2020D0 B32E20D0 90D181D1 82D0B0D0 BDD0B02C 20D09FD0 9A2022D0 9BD0B5D1 81D0BED0 B2D0BED0 B422202F 20D183D0 BB2E20D0 92D0BED1 81D18CD0 BCD0B0D1 8F20D181 D1822DD0 B520391A 620A2DD0 98D09F20 D09CD098 D0A7D09A D09020D0 9FD090D0 92D095D0 9B20D090 D09DD094 D0A0D095 D095D092 D098D0A7 1221D0B3 2E20D090 D181D182 D0B0D0BD D0B02C20 D09BD0B5 D0BDD0B8 D0BDD0B0 2033331A 0C393630 36323433 35303634 323001F2 011A0A11 76616C69 64617469 6F6E5F70 6F6C6963 79120536 35353335
"""
    private var mockDataResponse: Data = Data()
    
    private func mockData() {
        if let convertedData = DataConversionUtils.dataFromHexString(hexString) {
            mockDataResponse = convertedData
        } else {
            print("Ошибка преобразования hex-строки")
        }
    }
    
    func testConvertFromData() {
        mockData()
        
        do {
            // Десериализация заголовка из mockDataResponse
            let messageHeader = try MessageHeader.fromData(mockDataResponse)
            
            // Проверяем, что десериализация прошла успешно
            XCTAssertEqual(messageHeader.appCode, 0x81A2)
            XCTAssertEqual(messageHeader.version, 202)
            XCTAssertEqual(messageHeader.id, 200773)
            XCTAssertEqual(messageHeader.token, 26264070)
            XCTAssertEqual(messageHeader.reqNum, 1)
            
            print("Заголовок успешно десериализован: \(messageHeader)")
        } catch {
            XCTFail("Ошибка при десериализации заголовка: \(error)")
        }
    }
}
