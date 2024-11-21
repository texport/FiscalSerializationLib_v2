//
//  KkmRegInfoTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Тесты для структуры `KkmRegInfo`.
final class KkmRegInfoTests: XCTestCase {
    
    // MARK: - Test Cases for createKkmRegInfoRequest
    
    /// Тест успешного создания объекта `Kkm_Proto_KkmRegInfo`.
    func testCreateKkmRegInfoRequest_Success() {
        do {
            let kkmRegInfo = try KkmRegInfo.createKkmRegInfoRequest(
                kgdId: "123456",
                kkmOfdId: "654321",
                kkmSerialNumber: "SN123456"
            )
            
            XCTAssertEqual(kkmRegInfo.fnsKkmID, "123456", "Некорректный КГД ID.")
            XCTAssertEqual(kkmRegInfo.kkmID, "654321", "Некорректный ID ОФД.")
            XCTAssertEqual(kkmRegInfo.serialNumber, "SN123456", "Некорректный серийный номер.")
        } catch {
            XCTFail("Тест не должен был завершиться ошибкой: \(error.localizedDescription)")
        }
    }
    
    /// Тест: КГД ID не может быть пустым или состоять только из пробелов.
    func testCreateKkmRegInfoRequest_InvalidKgdId() {
        XCTAssertThrowsError(try KkmRegInfo.createKkmRegInfoRequest(
            kgdId: "   ",
            kkmOfdId: "654321",
            kkmSerialNumber: "SN123456"
        )) { error in
            XCTAssertEqual((error as NSError).code, 1, "Ожидалась ошибка с кодом 1.")
        }
    }
    
    /// Тест: ID ОФД не может быть пустым или состоять только из пробелов.
    func testCreateKkmRegInfoRequest_InvalidKkmOfdId() {
        XCTAssertThrowsError(try KkmRegInfo.createKkmRegInfoRequest(
            kgdId: "123456",
            kkmOfdId: "   ",
            kkmSerialNumber: "SN123456"
        )) { error in
            XCTAssertEqual((error as NSError).code, 2, "Ожидалась ошибка с кодом 2.")
        }
    }
    
    /// Тест: Серийный номер не может быть пустым или состоять только из пробелов.
    func testCreateKkmRegInfoRequest_InvalidSerialNumber() {
        XCTAssertThrowsError(try KkmRegInfo.createKkmRegInfoRequest(
            kgdId: "123456",
            kkmOfdId: "654321",
            kkmSerialNumber: "   "
        )) { error in
            XCTAssertEqual((error as NSError).code, 3, "Ожидалась ошибка с кодом 3.")
        }
    }
    
    // MARK: - Test Cases for createKkmRegInfoResponse
    
    /// Тест успешного создания объекта `KkmRegInfoResponse`.
    func testCreateKkmRegInfoResponse_Success() {
        do {
            var kkmResponse = Kkm_Proto_KkmRegInfo()
            kkmResponse.fnsKkmID = "123456"
            kkmResponse.kkmID = "654321"
            kkmResponse.serialNumber = "SN123456"
            
            let response = try KkmRegInfo.createKkmRegInfoResponse(kkmRegInfoResponse: kkmResponse)
            
            XCTAssertEqual(response.kgdId, "123456", "Некорректный КГД ID в ответе.")
            XCTAssertEqual(response.serialNumber, "SN123456", "Некорректный серийный номер в ответе.")
            XCTAssertEqual(response.kkmOfdId, "654321", "Некорректный ID ОФД в ответе.")
        } catch {
            XCTFail("Тест не должен был завершиться ошибкой: \(error.localizedDescription)")
        }
    }
    
    /// Тест: КГД ID в ответе не может быть пустым.
    func testCreateKkmRegInfoResponse_InvalidKgdId() {
        XCTAssertThrowsError(try KkmRegInfo.createKkmRegInfoResponse(
            kkmRegInfoResponse: {
                var response = Kkm_Proto_KkmRegInfo()
                response.fnsKkmID = ""
                response.kkmID = "654321"
                response.serialNumber = "SN123456"
                return response
            }()
        )) { error in
            XCTAssertEqual((error as NSError).code, 1, "Ожидалась ошибка с кодом 1.")
        }
    }
    
    /// Тест: Серийный номер в ответе не может быть пустым.
    func testCreateKkmRegInfoResponse_InvalidSerialNumber() {
        XCTAssertThrowsError(try KkmRegInfo.createKkmRegInfoResponse(
            kkmRegInfoResponse: {
                var response = Kkm_Proto_KkmRegInfo()
                response.fnsKkmID = "123456"
                response.kkmID = "654321"
                response.serialNumber = ""
                return response
            }()
        )) { error in
            XCTAssertEqual((error as NSError).code, 2, "Ожидалась ошибка с кодом 2.")
        }
    }
    
    /// Тест: ID ОФД в ответе не может быть пустым.
    func testCreateKkmRegInfoResponse_InvalidKkmOfdId() {
        XCTAssertThrowsError(try KkmRegInfo.createKkmRegInfoResponse(
            kkmRegInfoResponse: {
                var response = Kkm_Proto_KkmRegInfo()
                response.fnsKkmID = "123456"
                response.kkmID = ""
                response.serialNumber = "SN123456"
                return response
            }()
        )) { error in
            XCTAssertEqual((error as NSError).code, 3, "Ожидалась ошибка с кодом 3.")
        }
    }
}
