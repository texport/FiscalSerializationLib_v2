//
//  ResultTypeEnumTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 18.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Тесты для проверки корректности работы перечисления `ResultTypeEnum`.
///
/// Эти тесты проверяют, что для каждого значения `ResultTypeEnum` возвращается правильное текстовое описание.
/// Это позволяет убедиться, что при изменении логики `description` или добавлении новых значений всё работает корректно.
final class ResultTypeEnumTests: XCTestCase {
    /// Тест успешного описания для команды `ok`.
    func testDescription_ok() {
        XCTAssertEqual(ResultTypeEnum.ok.description,
                       "Команда выполнена успешно, аппарат работает в штатном режиме.")
    }
    
    /// Тест описания для команды `unknownId`.
    func testDescription_unknownId() {
        XCTAssertEqual(ResultTypeEnum.unknownId.description,
                       "Неизвестный ID устройства. Аппарат не зарегистрирован в системе и должен заблокироваться.")
    }
    
    /// Тест описания для команды `invalidToken`.
    func testDescription_invalidToken() {
        XCTAssertEqual(ResultTypeEnum.invalidToken.description,
                       "Неверный токен, требуется сброс токена. Устройство блокируется до ввода корректного токена.")
    }
    
    /// Тест описания для команды `protocolError`.
    func testDescription_protocolError() {
        XCTAssertEqual(ResultTypeEnum.protocolError.description,
                       "Ошибка протокола, необходимо обратиться в сервисную службу.")
    }
    
    /// Тест описания для команды `unknownCommand`.
    func testDescription_unknownCommand() {
        XCTAssertEqual(ResultTypeEnum.unknownCommand.description,
                       "Неизвестная команда, ошибка протокола.")
    }
    
    /// Тест описания для команды `unsupportedCommand`.
    func testDescription_unsupportedCommand() {
        XCTAssertEqual(ResultTypeEnum.unsupportedCommand.description,
                       "Команда не поддерживается сервером.")
    }
    
    /// Тест описания для команды `invalidConfiguration`.
    func testDescription_invalidConfiguration() {
        XCTAssertEqual(ResultTypeEnum.invalidConfiguration.description,
                       "Неверные настройки устройства.")
    }
    
    /// Тест описания для команды `sslNotAllowed`.
    func testDescription_sslNotAllowed() {
        XCTAssertEqual(ResultTypeEnum.sslNotAllowed.description,
                       "Использование SSL запрещено.")
    }
    
    /// Тест описания для команды `invalidRequestNumber`.
    func testDescription_invalidRequestNumber() {
        XCTAssertEqual(ResultTypeEnum.invalidRequestNumber.description,
                       "Неправильный номер запроса.")
    }
    
    /// Тест описания для команды `invalidRetryRequest`.
    func testDescription_invalidRetryRequest() {
        XCTAssertEqual(ResultTypeEnum.invalidRetryRequest.description,
                       "Неправильная попытка повторного запроса.")
    }
    
    /// Тест описания для команды `cantCancelTicket`.
    func testDescription_cantCancelTicket() {
        XCTAssertEqual(ResultTypeEnum.cantCancelTicket.description,
                       "Невозможно отменить чек.")
    }
    
    /// Тест описания для команды `openShiftTimeoutExpired`.
    func testDescription_openShiftTimeoutExpired() {
        XCTAssertEqual(ResultTypeEnum.openShiftTimeoutExpired.description,
                       "Время открытой смены истекло.")
    }
    
    /// Тест описания для команды `invalidLoginPassword`.
    func testDescription_invalidLoginPassword() {
        XCTAssertEqual(ResultTypeEnum.invalidLoginPassword.description,
                       "Неправильное имя пользователя или пароль.")
    }
    
    /// Тест описания для команды `incorrectRequestData`.
    func testDescription_incorrectRequestData() {
        XCTAssertEqual(ResultTypeEnum.incorrectRequestData.description,
                       "Неверные входные данные.")
    }
    
    /// Тест описания для команды `notEnoughCash`.
    func testDescription_notEnoughCash() {
        XCTAssertEqual(ResultTypeEnum.notEnoughCash.description,
                       "Недостаточно наличных в кассе.")
    }
    
    /// Тест описания для команды `blocked`.
    func testDescription_blocked() {
        XCTAssertEqual(ResultTypeEnum.blocked.description,
                       "Касса заблокирована на сервере.")
    }
    
    /// Тест описания для команды `sameTaxpayerAndCustomer`.
    func testDescription_sameTaxpayerAndCustomer() {
        XCTAssertEqual(ResultTypeEnum.sameTaxpayerAndCustomer.description,
                       "Совпадает ИИН/БИН покупателя и продавца.")
    }
    
    /// Тест описания для команды `serviceTemporarilyUnavailable`.
    func testDescription_serviceTemporarilyUnavailable() {
        XCTAssertEqual(ResultTypeEnum.serviceTemporarilyUnavailable.description,
                       "Сервис временно недоступен.")
    }
    
    /// Тест описания для команды `unknownError`.
    func testDescription_unknownError() {
        XCTAssertEqual(ResultTypeEnum.unknownError.description,
                       "Неизвестная ошибка.")
    }
}
