//
//  RegInfoTests.swift
//  FiscalSerializationLib_v2Tests
//
//  Created by Sergey Ivanov on 19.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Тесты для структуры `RegInfo`.
final class RegInfoTests: XCTestCase {

    /// Проверка успешной обработки валидного ответа.
    func testCreateRegInfoResponse_ValidResponse() throws {
        var regInfoResponse = Kkm_Proto_ServiceResponse.RegInfo()
        regInfoResponse.kkm = Kkm_Proto_KkmRegInfo.with {
            $0.fnsKkmID = "12345"
            $0.serialNumber = "67890"
            $0.kkmID = "54321"
        }
        
        regInfoResponse.pos = Kkm_Proto_PosRegInfo.with {
            $0.title = "Торговая точка"
            $0.address = "Адрес точки"
        }
        
        regInfoResponse.org = Kkm_Proto_OrgRegInfo.with {
            $0.title = "Организация"
            $0.address = "Адрес организации"
            $0.inn = "123456789012"
            $0.okved = "47.99"
        }

        let result = try RegInfo.createRegInfoResponse(regInfoResponse: regInfoResponse)
        XCTAssertEqual(result.kkm.kgdId, "12345")
        XCTAssertEqual(result.kkm.serialNumber, "67890")
        XCTAssertEqual(result.kkm.kkmOfdId, "54321")
        XCTAssertEqual(result.pos.title, "Торговая точка")
        XCTAssertEqual(result.pos.address, "Адрес точки")
        XCTAssertEqual(result.org.title, "Организация")
        XCTAssertEqual(result.org.address, "Адрес организации")
        XCTAssertEqual(result.org.iinOrBin, "123456789012")
        XCTAssertEqual(result.org.oked, "47.99")
    }

    /// Проверка отсутствия KKM.
    func testCreateRegInfoResponse_MissingKKM() {
        var regInfoResponse = Kkm_Proto_ServiceResponse.RegInfo()
        regInfoResponse.pos = Kkm_Proto_PosRegInfo.with {
            $0.title = "Торговая точка"
            $0.address = "Адрес точки"
        }
        
        regInfoResponse.org = Kkm_Proto_OrgRegInfo.with {
            $0.title = "Организация"
            $0.address = "Адрес организации"
            $0.inn = "123456789012"
            $0.okved = "47.99"
        }

        XCTAssertThrowsError(try RegInfo.createRegInfoResponse(regInfoResponse: regInfoResponse)) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createRegInfoResponse")
            XCTAssertEqual(nsError.code, 1)
            XCTAssertEqual(nsError.localizedDescription, "ОФД НАРУШИЛ ПРОТОКОЛ: Отсутствует информация о кассовом аппарате. Обратитесь в службу поддержки ОФД.")
        }
    }

    /// Проверка отсутствия POS.
    func testCreateRegInfoResponse_MissingPOS() {
        var regInfoResponse = Kkm_Proto_ServiceResponse.RegInfo()
        regInfoResponse.kkm = Kkm_Proto_KkmRegInfo.with {
            $0.fnsKkmID = "12345"
            $0.serialNumber = "67890"
            $0.kkmID = "54321"
        }
        
        regInfoResponse.org = Kkm_Proto_OrgRegInfo.with {
            $0.title = "Организация"
            $0.address = "Адрес организации"
            $0.inn = "123456789012"
            $0.okved = "47.99"
        }

        XCTAssertThrowsError(try RegInfo.createRegInfoResponse(regInfoResponse: regInfoResponse)) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createRegInfoResponse")
            XCTAssertEqual(nsError.code, 2)
            XCTAssertEqual(nsError.localizedDescription, "ОФД НАРУШИЛ ПРОТОКОЛ: Отсутствует информация о торговой точке. Обратитесь в службу поддержки ОФД.")
        }
    }

    /// Проверка отсутствия Org.
    func testCreateRegInfoResponse_MissingOrg() {
        var regInfoResponse = Kkm_Proto_ServiceResponse.RegInfo()
        regInfoResponse.kkm = Kkm_Proto_KkmRegInfo.with {
            $0.fnsKkmID = "12345"
            $0.serialNumber = "67890"
            $0.kkmID = "54321"
        }
        
        regInfoResponse.pos = Kkm_Proto_PosRegInfo.with {
            $0.title = "Торговая точка"
            $0.address = "Адрес точки"
        }

        XCTAssertThrowsError(try RegInfo.createRegInfoResponse(regInfoResponse: regInfoResponse)) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createRegInfoResponse")
            XCTAssertEqual(nsError.code, 3)
            XCTAssertEqual(nsError.localizedDescription, "ОФД НАРУШИЛ ПРОТОКОЛ: Отсутствует информация об организации. Обратитесь в службу поддержки ОФД.")
        }
    }
}
