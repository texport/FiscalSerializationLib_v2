//
//  DataTime.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 31.10.2024.
//
import Foundation

/// Эта структура нужна для того что бы правильно работать с датой и временем
struct DateTime {
    func createDateTime(date: Kkm_Proto_Date, time: Kkm_Proto_Time) throws -> Kkm_Proto_DateTime {
        var dateTime = Kkm_Proto_DateTime()
        
        dateTime.date = date
        dateTime.time = time
        
        return dateTime
    }
    
    func createDate(year: UInt32, month: UInt32, day: UInt32) throws -> Kkm_Proto_Date {
        // Проверка на случай, если все значения равны нулю (разрешены в оффлайн периоде)
        if year == 0 && month == 0 && day == 0 {
            var protoDate = Kkm_Proto_Date()
            protoDate.year = year
            protoDate.month = month
            protoDate.day = day
            return protoDate
        }
        
        // Получаем текущую дату
        let currentDate = Date()
        let calendar = Calendar.current
        
        // Проверка на четырехзначный год и допустимый диапазон (не раньше, чем 3 года назад, не позже текущего года)
        let currentYear = calendar.component(.year, from: currentDate)
        let earliestYear = currentYear - 3
        
        guard (1000...9999).contains(Int(year)) else {
            throw NSError(domain: "InvalidDate", code: 1, userInfo: [NSLocalizedDescriptionKey: "Год должен быть четырехзначным числом."])
        }
        
        guard (earliestYear...currentYear).contains(Int(year)) else {
            throw NSError(domain: "InvalidDate", code: 2, userInfo: [NSLocalizedDescriptionKey: "Год должен быть в диапазоне от \(earliestYear) до \(currentYear)."])
        }
        
        // Проверка диапазона месяца
        guard (1...12).contains(Int(month)) else {
            throw NSError(domain: "InvalidDate", code: 3, userInfo: [NSLocalizedDescriptionKey: "Месяц должен быть в диапазоне от 1 до 12."])
        }
        
        // Проверка диапазона дня
        guard (1...31).contains(Int(day)) else {
            throw NSError(domain: "InvalidDate", code: 4, userInfo: [NSLocalizedDescriptionKey: "День должен быть в диапазоне от 1 до 31."])
        }
        
        // Проверка на корректность даты и не из будущего
        var dateComponents = DateComponents()
        dateComponents.year = Int(year)
        dateComponents.month = Int(month)
        dateComponents.day = Int(day)
        
        guard let date = calendar.date(from: dateComponents) else {
            throw NSError(domain: "InvalidDate", code: 5, userInfo: [NSLocalizedDescriptionKey: "Дата некорректна. Проверьте правильность дня, месяца и года."])
        }
        
        // Проверка на то, что дата не из будущего
        guard date <= currentDate else {
            throw NSError(domain: "InvalidDate", code: 6, userInfo: [NSLocalizedDescriptionKey: "Дата не может быть из будущего."])
        }
        
        // Если все проверки пройдены, создаем объект Kkm_Proto_Date
        var protoDate = Kkm_Proto_Date()
        protoDate.year = year
        protoDate.month = month
        protoDate.day = day
        
        return protoDate
    }
    
    func createTime(hour: UInt32, minute: UInt32, second: UInt32) throws -> Kkm_Proto_Time {
//        // Проверка на случай, если все значения равны нулю (разрешены в оффлайн периоде)
//        if hour == 0 && minute == 0 && second == 0 {
//            var time = Kkm_Proto_Time()
//            time.hour = hour
//            time.minute = minute
//            time.second = second
//            return time
//        }
        
        // Проверка диапазона часов
        guard (0...23).contains(Int(hour)) else {
            throw NSError(domain: "InvalidTime", code: 1, userInfo: [NSLocalizedDescriptionKey: "Часы должны быть в диапазоне от 0 до 23."])
        }
        
        // Проверка диапазона минут
        guard (0...59).contains(Int(minute)) else {
            throw NSError(domain: "InvalidTime", code: 2, userInfo: [NSLocalizedDescriptionKey: "Минуты должны быть в диапазоне от 0 до 59."])
        }
        
        // Проверка диапазона секунд
        guard (0...59).contains(Int(second)) else {
            throw NSError(domain: "InvalidTime", code: 3, userInfo: [NSLocalizedDescriptionKey: "Секунды должны быть в диапазоне от 0 до 59."])
        }
        
        // Если все проверки пройдены, создаем объект Kkm_Proto_Time
        var time = Kkm_Proto_Time()
        time.hour = hour
        time.minute = minute
        time.second = second
        
        return time
    }
}
