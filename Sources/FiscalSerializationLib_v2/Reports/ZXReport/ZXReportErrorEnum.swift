//
//  ZXReportErrorEnum.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 09.12.2024.
//

import Foundation

public enum ZXReportErrorEnum: LocalizedError {
    case missingTaxOperationResponse
    case notValideTaxOperationTypeResponse
    case notValideNonNullableSum
    
    public var code: Int {
        switch self {
        case .missingTaxOperationResponse:
            return 1
        case .notValideTaxOperationTypeResponse:
            return 2
        case .notValideNonNullableSum:
            return 3
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .missingTaxOperationResponse:
            return "Ошибка разбора Z/X-отчёта от сервера ОФД: в разделе налогов отсутствует информация об операциях. Такое поведение сервера некорректно и нарушает установленный протокол обмена данными. Пожалуйста, обратитесь в службу поддержки ОФД для устранения проблемы."
        case .notValideTaxOperationTypeResponse:
            return "Ошибка разбора Z/X-отчёта от сервера ОФД: в разделе типов операций налогов ОФД прислал тип операций которого нет в перечислении. Такое поведение сервера некорректно и нарушает установленный протокол обмена данными. Пожалуйста, обратитесь в службу поддержки ОФД для устранения проблемы."
        case .notValideNonNullableSum:
            return "Ошибка разбора Z/X-отчёта от сервера ОФД: в разделе необнуляемых сумм ОФД прислал тип операций которого нет в перечислении. Такое поведение сервера некорректно и нарушает установленный протокол обмена данными. Пожалуйста, обратитесь в службу поддержки ОФД для устранения проблемы."
        }
    }
}
