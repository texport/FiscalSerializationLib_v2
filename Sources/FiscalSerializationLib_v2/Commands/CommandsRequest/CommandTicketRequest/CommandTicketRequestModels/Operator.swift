//
//  Operator.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 05.11.2024.
//

import Foundation

struct Operator {
    // MARK: - Public Methods
    
    /// Создает объект `Kkm_Proto_Operator` с проверкой корректности данных.
    ///
    /// - Parameters:
    ///   - code: Код оператора (должен быть больше 0).
    ///   - name: Имя оператора (должно быть валидным).
    /// - Throws: Ошибка, если данные не прошли проверку.
    /// - Returns: Объект типа `Kkm_Proto_Operator`.
    func createOperator(code: UInt32, name: String) throws -> Kkm_Proto_Operator {
        try validateCode(code)
        let trimmedAndCleanedName = try validateAndCleanName(name)
        
        var cashier = Kkm_Proto_Operator()
        cashier.code = code
        cashier.name = trimmedAndCleanedName
        
        return cashier
    }
    
    // MARK: - Private Methods
    
    /// Проверяет, что код оператора больше 0.
    ///
    /// - Parameter code: Код оператора.
    /// - Throws: Ошибка, если код меньше или равен 0.
    private func validateCode(_ code: UInt32) throws {
        guard code > 0 else {
            throw NSError(domain: "InvalidOperator", code: 1, userInfo: [NSLocalizedDescriptionKey: "Код оператора должен быть больше 0."])
        }
    }
    
    /// Проверяет и обрезает имя оператора, удаляя лишние пробелы и выполняя все необходимые проверки.
    ///
    /// - Parameter name: Имя оператора.
    /// - Throws: Ошибка, если имя не соответствует требованиям.
    /// - Returns: Обрезанное и очищенное имя оператора без лишних пробелов.
    private func validateAndCleanName(_ name: String) throws -> String {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedName = removeExtraSpaces(from: trimmedName)
        try validateNotEmptyAndLength(cleanedName)
        try validateAllowedCharacters(cleanedName)
        try validateMaxLength(cleanedName)
        return cleanedName
    }
    
    /// Удаляет лишние пробелы между словами, сокращая их до одного пробела.
    ///
    /// - Parameter name: Строка, из которой необходимо удалить лишние пробелы.
    /// - Returns: Строка без лишних пробелов между словами.
    private func removeExtraSpaces(from name: String) -> String {
        let components = name.split(separator: " ").map { String($0) }
        return components.joined(separator: " ")
    }
    
    /// Проверяет, что имя не пустое и длина не менее 2 символов.
    ///
    /// - Parameter name: Обрезанное имя оператора.
    /// - Throws: Ошибка, если имя пустое или состоит менее чем из 2 символов.
    private func validateNotEmptyAndLength(_ name: String) throws {
        guard !name.isEmpty, name.count >= 2 else {
            throw NSError(domain: "InvalidOperator", code: 2, userInfo: [NSLocalizedDescriptionKey: "Имя оператора не может быть пустым, содержать только пробелы и должно быть длиной не менее 2 символов."])
        }
    }
    
    /// Проверяет, что имя содержит только разрешенные символы (буквы, цифры и пробелы).
    ///
    /// - Parameter name: Обрезанное имя оператора.
    /// - Throws: Ошибка, если имя содержит недопустимые символы.
    private func validateAllowedCharacters(_ name: String) throws {
        let nameRegex = "^[a-zA-Zа-яА-ЯәіңғүұқөһӘІҢҒҮҰҚӨҺ0-9 ]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        guard namePredicate.evaluate(with: name) else {
            throw NSError(domain: "InvalidOperator", code: 3, userInfo: [NSLocalizedDescriptionKey: "Имя оператора должно содержать только буквы, цифры и пробелы."])
        }
    }
    
    /// Проверяет, что имя не превышает максимальную длину.
    ///
    /// - Parameter name: Обрезанное имя оператора.
    /// - Throws: Ошибка, если имя длиннее максимальной разрешенной длины.
    private func validateMaxLength(_ name: String) throws {
        let maxLength = 50
        guard name.count <= maxLength else {
            throw NSError(domain: "InvalidOperator", code: 4, userInfo: [NSLocalizedDescriptionKey: "Имя оператора не может быть длиннее \(maxLength) символов."])
        }
    }
}
