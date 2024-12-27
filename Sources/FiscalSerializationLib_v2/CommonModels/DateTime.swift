//
//  DataTime.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 31.10.2024.
//

import Foundation

/// - DateTime - эта структура нужна для того что бы правильно работать с датой и временем
struct DateTime {
    
    /// Создает объект `Kkm_Proto_DateTime`, объединяя дату и время
    /// - Parameters:
    ///   - date: Объект `Kkm_Proto_Date`, содержащий год, месяц и день
    ///   - time: Объект `Kkm_Proto_Time`, содержащий часы, минуты и секунды
    /// - Throws: Генерирует ошибку, если значения неверные
    /// - Returns: Объединенный объект `Kkm_Proto_DateTime`
    func createDateTime(date: Kkm_Proto_Date, time: Kkm_Proto_Time) throws -> Kkm_Proto_DateTime {
        var dateTime = Kkm_Proto_DateTime()
        
        dateTime.date = date
        dateTime.time = time
        
        return dateTime
    }
    
    /// Создает объект `Kkm_Proto_Date`, проверяя корректность введенных значений
    /// - Parameters:
    ///   - year: Четырехзначный год. Возможный диапазон от (текущий год - 3 года) до (текущий год)
    ///   - month: Месяц в диапазоне от 1 до 12
    ///   - day: День в диапазоне от 1 до 31
    /// - Throws: Генерирует ошибку, если значения года, месяца или дня некорректные
    /// - Returns: Объект `Kkm_Proto_Date` с проверенными значениями
    func createDate(year: UInt32, month: UInt32, day: UInt32) throws -> Kkm_Proto_Date {
        // Проверка на случай, если все значения равны нулю (разрешены в оффлайн периоде)
        if year == 0 && month == 0 && day == 0 {
            var protoDate = Kkm_Proto_Date()
            protoDate.year = year
            protoDate.month = month
            protoDate.day = day
            return protoDate
        }
        
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        let earliestYear = currentYear - 3
        
        guard (earliestYear...currentYear).contains(Int(year)) else {
            throw NSError(domain: "InvalidDate", code: 1, userInfo: [NSLocalizedDescriptionKey: "Год должен быть в диапазоне от \(earliestYear) до \(currentYear)."])
        }
        
        guard (1...12).contains(Int(month)) else {
            throw NSError(domain: "InvalidDate", code: 2, userInfo: [NSLocalizedDescriptionKey: "Месяц должен быть в диапазоне от 1 до 12."])
        }
        
        guard (1...31).contains(Int(day)) else {
            throw NSError(domain: "InvalidDate", code: 3, userInfo: [NSLocalizedDescriptionKey: "День должен быть в диапазоне от 1 до 31."])
        }
        
        var dateComponents = DateComponents()
        dateComponents.year = Int(year)
        dateComponents.month = Int(month)
        dateComponents.day = Int(day)
        
        guard let date = calendar.date(from: dateComponents) else {
            throw NSError(domain: "InvalidDate", code: 4, userInfo: [NSLocalizedDescriptionKey: "Дата некорректна. Проверьте правильность дня, месяца и года."])
        }
        
        var protoDate = Kkm_Proto_Date()
        protoDate.year = year
        protoDate.month = month
        protoDate.day = day
        
        return protoDate
    }
    
    /// Создает объект `Kkm_Proto_Time`, проверяя корректность времени
    /// - Parameters:
    ///   - hour: Часы (0...23)
    ///   - minute: Минуты (0...59)
    ///   - second: Секунды (0...59)
    /// - Throws: Генерирует ошибку, если значения времени некорректные
    /// - Returns: Объект `Kkm_Proto_Time` с проверенными значениями
    func createTime(hour: UInt32, minute: UInt32, second: UInt32) throws -> Kkm_Proto_Time {
        guard (0...23).contains(Int(hour)) else {
            throw NSError(domain: "InvalidTime", code: 1, userInfo: [NSLocalizedDescriptionKey: "Часы должны быть в диапазоне от 0 до 23."])
        }
        
        guard (0...59).contains(Int(minute)) else {
            throw NSError(domain: "InvalidTime", code: 2, userInfo: [NSLocalizedDescriptionKey: "Минуты должны быть в диапазоне от 0 до 59."])
        }
        
        guard (0...59).contains(Int(second)) else {
            throw NSError(domain: "InvalidTime", code: 3, userInfo: [NSLocalizedDescriptionKey: "Секунды должны быть в диапазоне от 0 до 59."])
        }
        
        var time = Kkm_Proto_Time()
        time.hour = hour
        time.minute = minute
        time.second = second
        
        return time
    }
    
    /// Создает объект `Date` из протокольного объекта `Kkm_Proto_DateTime`
    /// - Parameter dateTimeCpcr: Протокольный объект `Kkm_Proto_DateTime`, содержащий дату и время
    /// - Throws: Генерирует ошибку, если дата выходит за пределы последних 5 лет
    /// - Returns: Объект `Date`, объединяющий дату и время
    static func createDateSwiftType(dateTimeCpcr: Kkm_Proto_DateTime) throws -> Date {
        let year = Int(dateTimeCpcr.date.year)
        let month = Int(dateTimeCpcr.date.month)
        let day = Int(dateTimeCpcr.date.day)
        
        let hour = Int(dateTimeCpcr.time.hour)
        let minute = Int(dateTimeCpcr.time.minute)
        let second = Int(dateTimeCpcr.time.second)
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        let calendar = Calendar.current
        
        guard let date = calendar.date(from: dateComponents) else {
            throw NSError(
                domain: "InvalidDateTime",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Дата или время некорректны. Проверьте значения."]
            )
        }
        
        let currentDate = Date()
        guard let fiveYearsAgo = calendar.date(byAdding: .year, value: -5, to: currentDate),
              date >= fiveYearsAgo else {
            throw NSError(
                domain: "InvalidDateTime",
                code: 2,
                userInfo: [NSLocalizedDescriptionKey: "Дата должна быть не ранее чем 5 лет назад."]
            )
        }
        
        return date
    }
    
    /// Преобразует строку даты в формате `dd.MM.yyyy HH:mm:ss` в протокольный объект `Kkm_Proto_DateTime`
    /// - Parameter dateString: Строка даты в формате `dd.MM.yyyy HH:mm:ss`
    /// - Throws: Генерирует ошибку, если строка не соответствует формату или дата некорректна
    /// - Returns: Протокольный объект `Kkm_Proto_DateTime`
    static func createProtoDateTime(from dateString: String) throws -> Kkm_Proto_DateTime {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Преобразование строки в Date
        guard let swiftDate = dateFormatter.date(from: dateString) else {
            throw NSError(
                domain: "InvalidDateFormat",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Дата должна быть в формате dd.MM.yyyy HH:mm:ss."]
            )
        }
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Проверка, что дата не из будущего
        guard swiftDate <= currentDate else {
            throw NSError(
                domain: "InvalidDateTime",
                code: 2,
                userInfo: [NSLocalizedDescriptionKey: "Дата не может быть из будущего."]
            )
        }
        
        // Проверка, что дата не старше 5 лет
        guard let fiveYearsAgo = calendar.date(byAdding: .year, value: -5, to: currentDate), swiftDate >= fiveYearsAgo else {
            throw NSError(
                domain: "InvalidDateTime",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "Дата должна быть в пределах последних 5 лет."]
            )
        }
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: swiftDate)
        
        // Проверка валидности компонентов
        guard let year = components.year, year > 0,
              let month = components.month, (1...12).contains(month),
              let day = components.day, (1...31).contains(day),
              let hour = components.hour, (0...23).contains(hour),
              let minute = components.minute, (0...59).contains(minute),
              let second = components.second, (0...59).contains(second) else {
            throw NSError(
                domain: "InvalidDateTime",
                code: 4,
                userInfo: [NSLocalizedDescriptionKey: "Некорректные значения даты или времени."]
            )
        }
        
        var protoDate = Kkm_Proto_Date()
        protoDate.year = UInt32(year)
        protoDate.month = UInt32(month)
        protoDate.day = UInt32(day)
        
        var protoTime = Kkm_Proto_Time()
        protoTime.hour = UInt32(hour)
        protoTime.minute = UInt32(minute)
        protoTime.second = UInt32(second)
        
        var protoDateTime = Kkm_Proto_DateTime()
        protoDateTime.date = protoDate
        protoDateTime.time = protoTime
        
        return protoDateTime
    }
}
