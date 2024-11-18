//
//  CommandTypeEnumTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 18.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Тесты для проверки корректности работы перечисления `CommandTypeEnum`.
///
/// Данные тесты проверяют, что для каждого типа команды возвращается корректное текстовое описание
/// через вычисляемое свойство `description`. Это помогает удостовериться, что изменения в логике
/// `description` не приведут к неожиданным результатам.
final class CommandTypeEnumTests: XCTestCase {
    
    /// Проверяет, что описание для команды `commandSystem` корректно.
    func testCommandSystemDescription() {
        let expectedDescription = """
        Системный обмен. Отправка серверу служебного пакета для проверки доступности соединения. \
        Используется для поддержания активного соединения и мониторинга доступности сервера.
        """
        XCTAssertEqual(CommandTypeEnum.commandSystem.description, expectedDescription)
    }
    
    /// Проверяет, что описание для команды `commandTicket` корректно.
    func testCommandTicketDescription() {
        let expectedDescription = """
        Фискализация. Передача данных чека на сервер и получение номера чека. \
        Используется для всех операций, связанных с продажами, возвратами и расчетами.
        """
        XCTAssertEqual(CommandTypeEnum.commandTicket.description, expectedDescription)
    }
    
    /// Проверяет, что описание для команды `commandCloseShift` корректно.
    func testCommandCloseShiftDescription() {
        let expectedDescription = """
        Закрытие смены. Фиксация окончания текущей кассовой смены на сервере. \
        Это необходимо для отчетности и учета сменных операций.
        """
        XCTAssertEqual(CommandTypeEnum.commandCloseShift.description, expectedDescription)
    }
    
    /// Проверяет, что описание для команды `commandReport` корректно.
    func testCommandReportDescription() {
        let expectedDescription = """
        Запрос отчетов (X и Z). Получение отчетов по продажам за смену. \
        X-отчет предоставляет данные по текущей смене, Z-отчет — итоговый за закрытую смену.
        """
        XCTAssertEqual(CommandTypeEnum.commandReport.description, expectedDescription)
    }
    
    /// Проверяет, что описание для команды `commandNomenclature` корректно.
    func testCommandNomenclatureDescription() {
        let expectedDescription = """
        Запрос номенклатуры. Синхронизация базы товаров между кассой и сервером ОФД. \
        Обновление актуальной номенклатуры для корректного учета товаров.
        """
        XCTAssertEqual(CommandTypeEnum.commandNomenclature.description, expectedDescription)
    }
    
    /// Проверяет, что описание для команды `commandInfo` корректно.
    func testCommandInfoDescription() {
        let expectedDescription = """
        Инициализация. Запрос информации о кассе и регистрационных данных при запуске устройства. \
        Получение настроек, параметров налогообложения и рекламных текстов.
        """
        XCTAssertEqual(CommandTypeEnum.commandInfo.description, expectedDescription)
    }
    
    /// Проверяет, что описание для команды `commandMoneyPlacement` корректно.
    func testCommandMoneyPlacementDescription() {
        let expectedDescription = """
        Внесение/снятие денег. Регистрация операций с наличностью (внесение или изъятие) в кассовом аппарате.
        """
        XCTAssertEqual(CommandTypeEnum.commandMoneyPlacement.description, expectedDescription)
    }
    
    /// Проверяет, что описание для команды `commandCancelTicket` корректно.
    func testCommandCancelTicketDescription() {
        let expectedDescription = """
        Отмена чека. Аннулирование последнего фискализированного чека. Доступно только для последней транзакции.
        """
        XCTAssertEqual(CommandTypeEnum.commandCancelTicket.description, expectedDescription)
    }
    
    /// Проверяет, что описание для команды `commandAuth` корректно.
    func testCommandAuthDescription() {
        let expectedDescription = """
        Авторизация. Проверка имени и пароля оператора для получения доступа к кассовой машине. \
        Позволяет серверу ОФД проверить права оператора и его роль.
        """
        XCTAssertEqual(CommandTypeEnum.commandAuth.description, expectedDescription)
    }
    
    /// Проверяет, что описание для команды `commandReserved` корректно.
    func testCommandReservedDescription() {
        let expectedDescription = """
        Зарезервировано. Эта команда используется для будущего расширения функциональности протокола.
        """
        XCTAssertEqual(CommandTypeEnum.commandReserved.description, expectedDescription)
    }
}
