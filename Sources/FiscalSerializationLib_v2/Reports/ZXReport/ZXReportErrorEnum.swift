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
    case notValidePaymentTypeResponse
    case missingTicketOperationResponse
    case notValideTicketOperationTypeResponse
    case missingMoneyPalcementOperationResponse
    case notValideMoneyPalcementOperationTypeResponse
    
    public var code: Int {
        switch self {
        case .missingTaxOperationResponse:
            return 1
        case .notValideTaxOperationTypeResponse:
            return 2
        case .notValideNonNullableSum:
            return 3
        case .notValidePaymentTypeResponse:
            return 4
        case .missingTicketOperationResponse:
            return 5
        case .notValideTicketOperationTypeResponse:
            return 6
        case .missingMoneyPalcementOperationResponse:
            return 7
        case .notValideMoneyPalcementOperationTypeResponse:
            return 8
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
        case .notValidePaymentTypeResponse:
            return "Ошибка разбора Z/X-отчёта от сервера ОФД: в разделе платежи ОФД прислал тип платежа которого нет в перечислении. Такое поведение сервера некорректно и нарушает установленный протокол обмена данными. Пожалуйста, обратитесь в службу поддержки ОФД для устранения проблемы."
        case .missingTicketOperationResponse:
            return "Ошибка разбора Z/X-отчёта от сервера ОФД: в разделе чеков отсутствует информация об операциях. Такое поведение сервера некорректно и нарушает установленный протокол обмена данными. Пожалуйста, обратитесь в службу поддержки ОФД для устранения проблемы."
        case .notValideTicketOperationTypeResponse:
            return "Ошибка разбора Z/X-отчёта от сервера ОФД: в разделе чеков ОФД прислал тип операций которого нет в перечислении. Такое поведение сервера некорректно и нарушает установленный протокол обмена данными. Пожалуйста, обратитесь в службу поддержки ОФД для устранения проблемы."
        case .missingMoneyPalcementOperationResponse:
            return "Ошибка разбора Z/X-отчёта от сервера ОФД: в разделе внесения/изъятия денег отсутствует информация об операциях. Такое поведение сервера некорректно и нарушает установленный протокол обмена данными. Пожалуйста, обратитесь в службу поддержки ОФД для устранения проблемы."
        case .notValideMoneyPalcementOperationTypeResponse:
            return "Ошибка разбора Z/X-отчёта от сервера ОФД: в разделе типов операций внесения/изъятия денег ОФД прислал тип операций которого нет в перечислении. Такое поведение сервера некорректно и нарушает установленный протокол обмена данными. Пожалуйста, обратитесь в службу поддержки ОФД для устранения проблемы."
        }
    }
}
