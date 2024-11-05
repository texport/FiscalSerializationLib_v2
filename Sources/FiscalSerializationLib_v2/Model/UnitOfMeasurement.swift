//
//  UnitOfMeasurement.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 31.10.2024.
//

import Foundation

public enum UnitOfMeasurement: String {
    case piece = "796"
    case kilogram = "116"
    case service = "5114"
    case meter = "006"
    case liter = "112"
    case linearMeter = "021"
    case ton = "168"
    case hour = "356"
    case day = "359"
    case week = "360"
    case month = "362"
    case millimeter = "003"
    case centimeter = "004"
    case decimeter = "005"
    case unit = "642"
    case kilometer = "008"
    case hectogram = "160"
    case milligram = "161"
    case metricCarat = "162"
    case gram = "163"
    case microgram = "164"
    case cubicMillimeter = "110"
    case milliliter = "111"
    case squareMeter = "055"
    case hectare = "059"
    case squareKilometer = "061"
    case sheet = "625"
    case pack = "728"
    case roll = "736"
    case package = "778"
    case bottle = "868"
    case work = "931"
    case cubicMeter = "113"
    
    public struct Info {
        let nameRus: String
        let nameKaz: String
        let shortRus: String
        let shortKaz: String
    }
    
    public var info: Info {
        switch self {
        case .piece: return Info(nameRus: "Штука", nameKaz: "Дана", shortRus: "шт", shortKaz: "дана")
        case .kilogram: return Info(nameRus: "Килограмм", nameKaz: "Килограмм", shortRus: "кг", shortKaz: "кг")
        case .service: return Info(nameRus: "Услуга", nameKaz: "Қызмет", shortRus: "усл", shortKaz: "қзм")
        case .meter: return Info(nameRus: "Метр", nameKaz: "Метр", shortRus: "м", shortKaz: "м")
        case .liter: return Info(nameRus: "Литр", nameKaz: "Литр", shortRus: "л", shortKaz: "л")
        case .linearMeter: return Info(nameRus: "Погонный метр", nameKaz: "Өткел қума метр", shortRus: "пог.м", shortKaz: "өқм")
        case .ton: return Info(nameRus: "Тонна", nameKaz: "Тонна", shortRus: "т", shortKaz: "т")
        case .hour: return Info(nameRus: "Час", nameKaz: "Сағат", shortRus: "ч", shortKaz: "сағ")
        case .day: return Info(nameRus: "Сутки", nameKaz: "Тәулік", shortRus: "с", shortKaz: "тлк")
        case .week: return Info(nameRus: "Неделя", nameKaz: "Апта", shortRus: "нед", shortKaz: "апт")
        case .month: return Info(nameRus: "Месяц", nameKaz: "Ай", shortRus: "мес", shortKaz: "ай")
        case .millimeter: return Info(nameRus: "Миллиметр", nameKaz: "Миллиметр", shortRus: "мм", shortKaz: "мм")
        case .centimeter: return Info(nameRus: "Сантиметр", nameKaz: "Сантиметр", shortRus: "см", shortKaz: "см")
        case .decimeter: return Info(nameRus: "Дециметр", nameKaz: "Дециметр", shortRus: "дм", shortKaz: "дм")
        case .unit: return Info(nameRus: "Единица", nameKaz: "Бірлік", shortRus: "ед", shortKaz: "брл")
        case .kilometer: return Info(nameRus: "Километр", nameKaz: "Километр", shortRus: "км", shortKaz: "км")
        case .hectogram: return Info(nameRus: "Гектограмм", nameKaz: "Гектограмм", shortRus: "гг", shortKaz: "гг")
        case .milligram: return Info(nameRus: "Миллиграмм", nameKaz: "Миллиграмм", shortRus: "мг", shortKaz: "мг")
        case .metricCarat: return Info(nameRus: "Метрический карат", nameKaz: "Метрлік карат", shortRus: "мкар", shortKaz: "мкар")
        case .gram: return Info(nameRus: "Грамм", nameKaz: "Грамм", shortRus: "гр", shortKaz: "гр")
        case .microgram: return Info(nameRus: "Микрограмм", nameKaz: "Микрограмм", shortRus: "мкг", shortKaz: "мкг")
        case .cubicMillimeter: return Info(nameRus: "Кубический миллиметр", nameKaz: "Куб миллиметр", shortRus: "мм3", shortKaz: "мм3")
        case .milliliter: return Info(nameRus: "Миллилитр", nameKaz: "Миллилитр", shortRus: "мл", shortKaz: "мл")
        case .squareMeter: return Info(nameRus: "Квадратный метр", nameKaz: "Шаршы метр", shortRus: "м2", shortKaz: "м2")
        case .hectare: return Info(nameRus: "Гектар", nameKaz: "Гектар", shortRus: "га", shortKaz: "га")
        case .squareKilometer: return Info(nameRus: "Квадратный километр", nameKaz: "Шаршы километр", shortRus: "км2", shortKaz: "км2")
        case .sheet: return Info(nameRus: "Лист", nameKaz: "Парақ", shortRus: "лист", shortKaz: "прқ")
        case .pack: return Info(nameRus: "Пачка", nameKaz: "Бума", shortRus: "пач", shortKaz: "бм")
        case .roll: return Info(nameRus: "Рулон", nameKaz: "Орам", shortRus: "рул", shortKaz: "орам")
        case .package: return Info(nameRus: "Упаковка", nameKaz: "Орама", shortRus: "упак", shortKaz: "орм")
        case .bottle: return Info(nameRus: "Бутылка", nameKaz: "Бөтелке", shortRus: "бут", shortKaz: "бөт")
        case .work: return Info(nameRus: "Работа", nameKaz: "Жұмыс", shortRus: "раб", shortKaz: "жұм")
        case .cubicMeter: return Info(nameRus: "Метр кубический", nameKaz: "Куб метр", shortRus: "м3", shortKaz: "м3")
        }
    }
}
