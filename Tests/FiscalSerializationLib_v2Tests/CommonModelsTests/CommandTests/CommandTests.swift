//
//  CommandTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 18.11.2024.
//

//import XCTest
//@testable import FiscalSerializationLib_v2
//
///// Тесты для проверки корректности работы функции `createCommand`
/////
///// Данные тесты проверяют, что метод `createCommand` корректно создаёт команду на основе переданного типа команды.
///// Это позволяет удостовериться, что команда возвращает правильные код и описание для заданного типа.
//class CommandTests: XCTestCase {
//    /// Тест успешного создания команды с корректным типом команды.
//    ///
//    /// Проверяет, что при передаче типа команды `commandTicket` функция `createCommand`:
//    /// - Возвращает корректный код команды, соответствующий `CommandTypeEnum.commandTicket.rawValue`.
//    /// - Возвращает корректное описание, соответствующее `CommandTypeEnum.commandTicket.description`.
//    /// - Не выбрасывает исключений при корректных входных данных.
//    func testCreateCommand_Success() {
//        // Подготавливаем тестовые данные
//        let commandType = Kkm_Proto_CommandTypeEnum.commandTicket
//        
//        do {
//            // Выполняем создание команды
//            let (commandCode, commandDescription) = try Command.createCommand(command: commandType)
//            
//            // Проверяем, что код команды соответствует ожидаемому значению
//            XCTAssertEqual(commandCode, CommandTypeEnum.commandTicket.rawValue, "Неверный код команды")
//            
//            // Проверяем, что описание команды соответствует ожидаемому значению
//            XCTAssertEqual(commandDescription, CommandTypeEnum.commandTicket.description, "Неверное описание команды")
//        } catch {
//            // Если была выброшена ошибка, тест провален
//            XCTFail("Не ожидалась ошибка: \(error.localizedDescription)")
//        }
//    }
//}
