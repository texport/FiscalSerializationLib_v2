//
//  ZXReportOperation.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 25.11.2024.
//

import Foundation

/// Структура для обработки операций X/Z отчетов
///
/// `ZXReportOperation` предоставляет методы для создания ответа `ZXReportOperationResponse`
/// на основе данных, полученных от ОФД.
struct ZXReportOperation {
    
    /// Создает объект `ZXReportOperationResponse` на основе данных X/Z отчета
    ///
    /// Этот метод проверяет наличие всех обязательных данных в объекте `Kkm_Proto_ZXReport.Operation`.
    /// Если какие-либо данные отсутствуют или некорректны, генерируется ошибка.
    ///
    /// - Parameter ZXReportOperationCpcr: Объект операции, содержащий данные X/Z отчета.
    /// - Throws:
    ///   - `NSError` с кодом 1, если поле `operation` отсутствует.
    ///   - `NSError` с кодом 2, если поле `count` отсутствует.
    ///   - `NSError` с кодом 3, если поле `sum` отсутствует.
    ///   - `NSError` с кодом 4, если `operation` имеет значение, которое не соответствует `OperationTypeEnum`.
    /// - Returns: Объект `ZXReportOperationResponse` с информацией о типе операции, количестве и сумме.
    static func createZXReportOperationResponse(zXReportOperationCpcr: Kkm_Proto_ZXReport.Operation) throws -> (ZXReportOperationResponse) {
        guard zXReportOperationCpcr.hasOperation else {
            throw NSError(
                domain: "createZXReportOperationResponse",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Операция отсутствует в данных X/Z отчета."]
            )
        }
        
        guard zXReportOperationCpcr.hasCount else {
            throw NSError(
                domain: "createZXReportOperationResponse",
                code: 2,
                userInfo: [NSLocalizedDescriptionKey: "Количество операций отсутствует в данных X/Z отчета."]
            )
        }
        
        guard zXReportOperationCpcr.hasSum else {
            throw NSError(
                domain: "createZXReportOperationResponse",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "Сумма отсутствует в данных X/Z отчета."]
            )
        }
        
        let operationCpcr = zXReportOperationCpcr.operation.rawValue
        
        guard let operationType = OperationTypeEnum(rawValue: UInt(operationCpcr)) else {
            throw NSError(
                domain: "createZXReportOperationResponse",
                code: 4,
                userInfo: [NSLocalizedDescriptionKey: "ОФД НАРУШИЛ ПРОТОКОЛ: ОФД не прислал/прислал не верный тип операции в X/Z отчете. Обратитесь в службу поддержки ОФД."]
            )
        }
        
        let countCpcr = zXReportOperationCpcr.count
        let sumCpcr = zXReportOperationCpcr.sum
        let sumResponse = Money.toDouble(protoMoney: sumCpcr)
        
        return ZXReportOperationResponse.create(with: (operationType, countCpcr, sumResponse))
    }
}
