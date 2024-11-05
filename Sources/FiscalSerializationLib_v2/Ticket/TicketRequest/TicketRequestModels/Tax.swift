//
//  Tax.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 01.11.2024.
//

import Foundation

/// Структура `Tax` предназначена для создания налоговых объектов в соответствии с протоколом Kkm_Proto_TicketRequest.
/// Включает методы для создания и проверки корректности налогов.
struct Tax {
    // MARK: - Методы
    
    /// Создает массив налогов на основе переданного процента и суммы.
    ///
    /// - Parameters:
    ///   - percent: Процент налога. Допустимые значения: 0 (0%) или 12000 (12%).
    ///   - sum: Объект `Kkm_Proto_Money`, представляющий сумму налога.
    /// - Throws: Генерирует ошибку, если процент или сумма налога некорректны.
    /// - Returns: Массив объектов `Kkm_Proto_TicketRequest.Tax`.
    func createTax(percent: UInt32, sum: Kkm_Proto_Money) throws -> [Kkm_Proto_TicketRequest.Tax] {
        // Проверка: процент должен быть равен 0 (0%) или 12000 (12%)
        guard percent == 0 || percent == 12000 else {
            throw NSError(domain: "createTax", code: 1, userInfo: [NSLocalizedDescriptionKey: "Значение процента должно быть равно 0(0%) или 12000(12%). У нас в стране нет других налоговых ставок."])
        }
        
        // Проверка: сумма налога должна быть корректной в зависимости от процента
        guard (percent == 0 && !checkSum(money: sum)) || (percent == 12000 && checkSum(money: sum)) else {
            throw NSError(domain: "createTax", code: 2, userInfo: [NSLocalizedDescriptionKey: "Если НДС 0%, то сумма не может быть больше 0. Если НДС 12%, сумма не может быть равна 0."])
        }
        
        var taxes: [Kkm_Proto_TicketRequest.Tax] = []
        var tax = Kkm_Proto_TicketRequest.Tax()
        
        // Устанавливаем значения для налога в соответствии с протоколом
        tax.taxType = 100 // В протоколе поддерживается только значение 100
        tax.percent = percent
        tax.sum = sum
        tax.isInTotalSum = true // НДС включен в стоимость товара, работы или услуги
        
        taxes.append(tax)
        return taxes
    }
    
    /// Проверяет, что сумма налога не равна нулю.
    ///
    /// - Parameter money: Объект `Kkm_Proto_Money` для проверки.
    /// - Returns: `true`, если сумма налога не равна нулю; иначе `false`.
    func checkSum(money: Kkm_Proto_Money) -> Bool {
        (money.bills != 0 && money.coins != 0) || (money.bills != 0 && money.coins == 0) || (money.bills == 0 && money.coins != 0)
    }
}
