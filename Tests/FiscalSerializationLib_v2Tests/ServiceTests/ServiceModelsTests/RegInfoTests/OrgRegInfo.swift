//
//  OrgRegInfoTests.swift
//  FiscalSerializationLib_v2Tests
//
//  Created by Sergey Ivanov on 19.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

final class OrgRegInfoTests: XCTestCase {
    
    // MARK: - Test Cases
    
    /// Тест успешного создания объекта запроса `Kkm_Proto_OrgRegInfo`.
    func testCreateOrgRegInfoRequest_Success() throws {
        let title = "ТОО \"Казахстанская Компания\""
        let address = "г. Алматы, ул. Абая, д. 1"
        let iinOrBin = "123456789012"
        let oked = "62010"
        
        let orgRegInfo = try OrgRegInfo.createOrgRegInfoRequest(
            title: title,
            address: address,
            iinOrBin: iinOrBin,
            oked: oked
        )
        
        XCTAssertEqual(orgRegInfo.title, title)
        XCTAssertEqual(orgRegInfo.address, address)
        XCTAssertEqual(orgRegInfo.inn, iinOrBin)
        XCTAssertEqual(orgRegInfo.okved, oked)
    }
    
    /// Тест ошибки при пустом названии организации.
    func testCreateOrgRegInfoRequest_EmptyTitle() throws {
        let address = "г. Алматы, ул. Абая, д. 1"
        let iinOrBin = "123456789012"
        let oked = "62010"
        
        XCTAssertThrowsError(try OrgRegInfo.createOrgRegInfoRequest(
            title: "",
            address: address,
            iinOrBin: iinOrBin,
            oked: oked
        )) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.code, 1)
        }
    }
    
    /// Тест ошибки при названии, содержащем только пробелы.
    func testCreateOrgRegInfoRequest_SpacesInTitle() throws {
        let title = "    "
        let address = "г. Алматы, ул. Абая, д. 1"
        let iinOrBin = "123456789012"
        let oked = "62010"
        
        XCTAssertThrowsError(try OrgRegInfo.createOrgRegInfoRequest(
            title: title,
            address: address,
            iinOrBin: iinOrBin,
            oked: oked
        )) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.code, 1)
        }
    }
    
    /// Тест ошибки при пустом адресе.
    func testCreateOrgRegInfoRequest_EmptyAddress() throws {
        let title = "ТОО \"Казахстанская Компания\""
        let iinOrBin = "123456789012"
        let oked = "62010"
        
        XCTAssertThrowsError(try OrgRegInfo.createOrgRegInfoRequest(
            title: title,
            address: "",
            iinOrBin: iinOrBin,
            oked: oked
        )) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.code, 2)
        }
    }
    
    /// Тест ошибки при адресе, содержащем только пробелы.
    func testCreateOrgRegInfoRequest_SpacesInAddress() throws {
        let title = "ТОО \"Казахстанская Компания\""
        let address = "   "
        let iinOrBin = "123456789012"
        let oked = "62010"
        
        XCTAssertThrowsError(try OrgRegInfo.createOrgRegInfoRequest(
            title: title,
            address: address,
            iinOrBin: iinOrBin,
            oked: oked
        )) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.code, 2)
        }
    }
    
    /// Тест успешного создания объекта ответа `OrgRegInfoResponse`.
    func testCreateOrgRegInfoResponse_Success() throws {
        let protoResponse = Kkm_Proto_OrgRegInfo.with {
            $0.title = "ТОО \"Казахстанская Компания\""
            $0.address = "г. Алматы, ул. Абая, д. 1"
            $0.inn = "123456789012"
            $0.okved = "62010"
        }
        
        let response = try OrgRegInfo.createOrgRegInfoResponse(orgRegInfoResponse: protoResponse)
        
        XCTAssertEqual(response.title, protoResponse.title)
        XCTAssertEqual(response.address, protoResponse.address)
        XCTAssertEqual(response.iinOrBin, protoResponse.inn)
        XCTAssertEqual(response.oked, protoResponse.okved)
    }
    
    /// Тест ошибки при пустом ИИН/БИН.
    func testCreateOrgRegInfoRequest_EmptyIinOrBin() throws {
        let title = "ТОО \"Казахстанская Компания\""
        let address = "г. Алматы, ул. Абая, д. 1"
        let oked = "62010"
        
        XCTAssertThrowsError(try OrgRegInfo.createOrgRegInfoRequest(
            title: title,
            address: address,
            iinOrBin: "",
            oked: oked
        )) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.code, 3)
        }
    }
    
    /// Тест ошибки при пустом ОКЭД.
    func testCreateOrgRegInfoRequest_EmptyOked() throws {
        let title = "ТОО \"Казахстанская Компания\""
        let address = "г. Алматы, ул. Абая, д. 1"
        let iinOrBin = "123456789012"
        
        XCTAssertThrowsError(try OrgRegInfo.createOrgRegInfoRequest(
            title: title,
            address: address,
            iinOrBin: iinOrBin,
            oked: ""
        )) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.code, 4)
        }
    }
}
