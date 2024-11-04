//
//  DateTimeTest.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 01.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Класс тестов для проверки корректной работы структуры DateTime
final class DateTimeTests: XCTestCase {
    /// Экземпляр структуры DateTime для использования в тестах
    var dateTime: DateTime!
    
    /// Метод настройки перед каждым тестом
    override func setUp() {
        super.setUp()
        dateTime = DateTime()
    }
    
    /// Метод очистки после каждого теста
    override func tearDown() {
        dateTime = nil
        super.tearDown()
    }
    
    // MARK: - Тесты для createDateTime

    /// Тест для проверки корректного создания объекта Kkm_Proto_DateTime с правильной датой и временем
    func testCreateDateTime_ValidDateAndTime() throws {
        let date = Kkm_Proto_Date.with {
            $0.year = 2023
            $0.month = 5
            $0.day = 15
        }
        
        let time = Kkm_Proto_Time.with {
            $0.hour = 10
            $0.minute = 30
            $0.second = 45
        }
        
        let dateTimeResult = try dateTime.createDateTime(date: date, time: time)
        
        XCTAssertEqual(dateTimeResult.date.year, 2023)
        XCTAssertEqual(dateTimeResult.date.month, 5)
        XCTAssertEqual(dateTimeResult.date.day, 15)
        XCTAssertEqual(dateTimeResult.time.hour, 10)
        XCTAssertEqual(dateTimeResult.time.minute, 30)
        XCTAssertEqual(dateTimeResult.time.second, 45)
    }

    // MARK: - Тесты для createDate

    /// Тест для проверки создания корректной даты
    func testCreateDate_ValidDate() throws {
        let protoDate = try dateTime.createDate(year: 2023, month: 5, day: 15)
        
        XCTAssertEqual(protoDate.year, 2023)
        XCTAssertEqual(protoDate.month, 5)
        XCTAssertEqual(protoDate.day, 15)
    }
    
    /// Тест для создания нулевой даты (используется для оффлайн периода)
    func testCreateDate_ZeroDate() throws {
        let protoDate = try dateTime.createDate(year: 0, month: 0, day: 0)
        
        XCTAssertEqual(protoDate.year, 0)
        XCTAssertEqual(protoDate.month, 0)
        XCTAssertEqual(protoDate.day, 0)
    }
    
    /// Тест для проверки выброса ошибки при некорректном значении года (меньше четырехзначного)
    func testCreateDate_InvalidYear() {
        XCTAssertThrowsError(try dateTime.createDate(year: 999, month: 5, day: 15)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidDate")
            XCTAssertEqual((error as NSError).code, 1)
        }
    }
    
    /// Тест для проверки выброса ошибки при значении года больше 9999
    func testCreateDate_YearGreaterThan9999() {
        XCTAssertThrowsError(try dateTime.createDate(year: 10000, month: 5, day: 15)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidDate")
            XCTAssertEqual((error as NSError).code, 1)
        }
    }
    
    /// Тест для проверки выброса ошибки при некорректном значении месяца
    func testCreateDate_InvalidMonth() {
        XCTAssertThrowsError(try dateTime.createDate(year: 2023, month: 13, day: 15)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidDate")
            XCTAssertEqual((error as NSError).code, 2)
        }
    }
    
    /// Тест для проверки граничных значений месяца (1 и 12)
    func testCreateDate_BoundaryMonth() throws {
        let protoDateStart = try dateTime.createDate(year: 2023, month: 1, day: 15)
        let protoDateEnd = try dateTime.createDate(year: 2023, month: 12, day: 15)
        
        XCTAssertEqual(protoDateStart.month, 1)
        XCTAssertEqual(protoDateEnd.month, 12)
    }
    
    /// Тест для проверки выброса ошибки при некорректном значении дня
    func testCreateDate_InvalidDay() {
        XCTAssertThrowsError(try dateTime.createDate(year: 2023, month: 5, day: 32)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidDate")
            XCTAssertEqual((error as NSError).code, 3)
        }
    }
    
    /// Тест для проверки граничных значений дня (1 и 31)
    func testCreateDate_BoundaryDay() throws {
        let protoDateStart = try dateTime.createDate(year: 2023, month: 5, day: 1)
        let protoDateEnd = try dateTime.createDate(year: 2023, month: 5, day: 31)
        
        XCTAssertEqual(protoDateStart.day, 1)
        XCTAssertEqual(protoDateEnd.day, 31)
    }

    // MARK: - Тесты для createTime

    /// Тест для проверки создания корректного времени
    func testCreateTime_ValidTime() throws {
        let protoTime = try dateTime.createTime(hour: 10, minute: 30, second: 45)
        
        XCTAssertEqual(protoTime.hour, 10)
        XCTAssertEqual(protoTime.minute, 30)
        XCTAssertEqual(protoTime.second, 45)
    }
    
    /// Тест для проверки выброса ошибки при некорректном значении часов
    func testCreateTime_InvalidHour() {
        XCTAssertThrowsError(try dateTime.createTime(hour: 24, minute: 0, second: 0)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidTime")
            XCTAssertEqual((error as NSError).code, 1)
        }
    }
    
    /// Тест для проверки граничных значений часов (0 и 23)
    func testCreateTime_BoundaryHour() throws {
        let protoTimeStart = try dateTime.createTime(hour: 0, minute: 0, second: 0)
        let protoTimeEnd = try dateTime.createTime(hour: 23, minute: 59, second: 59)
        
        XCTAssertEqual(protoTimeStart.hour, 0)
        XCTAssertEqual(protoTimeEnd.hour, 23)
    }
    
    /// Тест для проверки выброса ошибки при некорректном значении минут
    func testCreateTime_InvalidMinute() {
        XCTAssertThrowsError(try dateTime.createTime(hour: 10, minute: 60, second: 0)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidTime")
            XCTAssertEqual((error as NSError).code, 2)
        }
    }
    
    /// Тест для проверки граничных значений минут (0 и 59)
    func testCreateTime_BoundaryMinute() throws {
        let protoTimeStart = try dateTime.createTime(hour: 10, minute: 0, second: 0)
        let protoTimeEnd = try dateTime.createTime(hour: 10, minute: 59, second: 0)
        
        XCTAssertEqual(protoTimeStart.minute, 0)
        XCTAssertEqual(protoTimeEnd.minute, 59)
    }
    
    /// Тест для проверки выброса ошибки при некорректном значении секунд
    func testCreateTime_InvalidSecond() {
        XCTAssertThrowsError(try dateTime.createTime(hour: 10, minute: 30, second: 60)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidTime")
            XCTAssertEqual((error as NSError).code, 3)
        }
    }
    
    /// Тест для проверки граничных значений секунд (0 и 59)
    func testCreateTime_BoundarySecond() throws {
        let protoTimeStart = try dateTime.createTime(hour: 10, minute: 30, second: 0)
        let protoTimeEnd = try dateTime.createTime(hour: 10, minute: 30, second: 59)
        
        XCTAssertEqual(protoTimeStart.second, 0)
        XCTAssertEqual(protoTimeEnd.second, 59)
    }
}
