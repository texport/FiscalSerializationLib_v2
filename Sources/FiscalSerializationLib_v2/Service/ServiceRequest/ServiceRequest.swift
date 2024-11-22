//
//  ServiceRequest.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 31.10.2024.
//

import Foundation

/// Класс `ServiceRequest` отвечает за создание сервисной части для любого чека или отчета.
///
/// Этот класс используется внутренне библиотекой для формирования запросов на сервер оператора фискальных данных (ОФД).
/// Пользователям библиотеки не нужно напрямую использовать этот класс, так как он автоматически применяется в соответствующих местах.
///
/// ### Основные задачи:
/// - Формирование запроса для автономного режима (OfflinePeriod).
/// - Заполнение информации о кассе, торговой точке и организации (RegInfo).
/// - Установка дополнительных параметров, таких как рекламные тексты и вспомогательные данные.
final class ServiceRequest {
    private let ticketAdInfos: [Kkm_Proto_TicketAdInfo] = []
    private let auxiliary: [Kkm_Proto_KeyValuePair] = []
    
    private let kgdId: String
    private let kkmOfdId: String
    private let kkmSerialNumber: String
    
    private let title: String
    private let address: String
    private let iinOrBin: String
    private let oked: String
    
    private let isOnline: Bool
    private let offlinePeriodBegin: Kkm_Proto_DateTime
    private let offlinePeriodEnd: Kkm_Proto_DateTime
    private let getRegInfo: Bool
    
    private var _serviceRequest: Kkm_Proto_ServiceRequest?
    
    var serviceRequest: Kkm_Proto_ServiceRequest? {
        return _serviceRequest
    }
    
    /// Создает новый экземпляр `ServiceRequest`.
    ///
    /// - Parameters:
    ///   - kgdId: Регистрационный номер КГД.
    ///   - kkmOfdId: Системный идентификатор кассы в ОФД.
    ///   - kkmSerialNumber: Серийный номер кассового аппарата.
    ///   - title: Название организации.
    ///   - address: Адрес организации.
    ///   - iinOrBin: ИИН или БИН организации.
    ///   - oked: Код экономической деятельности (ОКЭД).
    ///   - isOnline: Флаг работы в онлайн-режиме.
    ///   - offlinePeriodBegin: Дата и время начала автономного режима.
    ///   - offlinePeriodEnd: Дата и время окончания автономного режима.
    ///   - getRegInfo: Флаг получения регистрационной информации.
    ///
    /// - Throws: Ошибка, если не удалось создать объект `Kkm_Proto_ServiceRequest`.
    init(kgdId: String, kkmOfdId: String, kkmSerialNumber: String, title: String, address: String, iinOrBin: String, oked: String, isOnline: Bool, offlinePeriodBegin: Kkm_Proto_DateTime, offlinePeriodEnd: Kkm_Proto_DateTime, getRegInfo: Bool) throws {
        self.kgdId = kgdId
        self.kkmOfdId = kkmOfdId
        self.kkmSerialNumber = kkmSerialNumber
        self.title = title
        self.address = address
        self.iinOrBin = iinOrBin
        self.oked = oked
        self.isOnline = isOnline
        self.offlinePeriodBegin = offlinePeriodBegin
        self.offlinePeriodEnd = offlinePeriodEnd
        self.getRegInfo = getRegInfo
        
        do {
            self._serviceRequest = try createServiceRequestCpcr()
        } catch {
            print("Ошибка при создании _serviceRequest: \(error)")
            self._serviceRequest = nil
        }
    }
    
    /// Создает объект запроса `Kkm_Proto_ServiceRequest`.
    ///
    /// - Throws: Ошибка, если не удалось создать объект.
    ///
    /// - Returns: Сформированный объект `Kkm_Proto_ServiceRequest`.
    private func createServiceRequestCpcr() throws -> Kkm_Proto_ServiceRequest {
        var serviceRequest = Kkm_Proto_ServiceRequest()
        
        /// Обробатываем автономный режим правильно, обязательно указываем сколько времени кассовый апппарат был в автономном режиме
        serviceRequest.offlinePeriod = try setupOfflinePeriodRequest(offlinePeriodBegin: offlinePeriodBegin, offlinePeriodEnd: offlinePeriodEnd)
        serviceRequest.getRegInfo = getRegInfo
        serviceRequest.ticketAdInfos = ticketAdInfos
        serviceRequest.auxiliary = auxiliary
        serviceRequest.regInfo = try setupRegInfoRequest(kgdId: kgdId, kkmOfdId: kkmOfdId, kkmSerialNumber: kkmSerialNumber, title: title, address: address, iinOrBin: iinOrBin, oked: oked)
        
        return serviceRequest
    }
    
    /// Создает информацию о кассе и организации для запроса.
    ///
    /// - Parameters:
    ///   - kgdId: Регистрационный номер КГД.
    ///   - kkmOfdId: Системный идентификатор кассы в ОФД.
    ///   - kkmSerialNumber: Серийный номер кассового аппарата.
    ///   - title: Название организации.
    ///   - address: Адрес организации.
    ///   - iinOrBin: ИИН или БИН организации.
    ///   - oked: Код экономической деятельности (ОКЭД).
    ///
    /// - Throws: Ошибка, если данные некорректны.
    ///
    /// - Returns: Объект `Kkm_Proto_ServiceRequest.RegInfo`, содержащий информацию о кассе и организации.
    private func setupRegInfoRequest(kgdId: String, kkmOfdId: String, kkmSerialNumber: String, title: String, address: String, iinOrBin: String, oked: String) throws -> Kkm_Proto_ServiceRequest.RegInfo {
        try RegInfo.createRegInfoRequest(kgdId: kgdId, kkmOfdId: kkmOfdId, kkmSerialNumber: kkmSerialNumber, title: title, address: address, iinOrBin: iinOrBin, oked: oked)
    }
    
    // TODO: Добавить возможность автозаполнение сервисной части из команды CommandInfo

    /// Создает параметры автономного режима.
    ///
    /// - Parameters:
    ///   - offlinePeriodBegin: Дата и время начала автономного режима.
    ///   - offlinePeriodEnd: Дата и время окончания автономного режима.
    ///
    /// - Throws: Ошибка, если параметры некорректны.
    ///
    /// - Returns: Объект `Kkm_Proto_ServiceRequest.OfflinePeriod`, содержащий параметры автономного режима.
    private func setupOfflinePeriodRequest(offlinePeriodBegin: Kkm_Proto_DateTime, offlinePeriodEnd: Kkm_Proto_DateTime) throws -> Kkm_Proto_ServiceRequest.OfflinePeriod {
        try OfflinePeriodRequest.createOfflinePeriod(offlinePeriodBegin: offlinePeriodBegin, offlinePeriodEnd: offlinePeriodEnd)
    }
}
