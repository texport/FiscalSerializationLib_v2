//
//  ServiceRequest.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 31.10.2024.
//

import Foundation

/// - ServiceRequestBuilder - этот класс отвечает за создание сервисной части для любого чека/отчета.
/// Вам его использовать не нужно, он автоматически будет использоваться в тех местах, где это действительно необходимо
final class ServiceRequestBuilder {
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
    
    /// Метод создает сущность Kkm_Proto_ServiceRequest
    private func createServiceRequestCpcr() throws -> Kkm_Proto_ServiceRequest {
        var serviceRequest = Kkm_Proto_ServiceRequest()
        
        /// Обробатываем автономный режим правильно, обязательно указываем сколько времени кассовый апппарат был в автономном режиме
        serviceRequest.offlinePeriod = try createOfflinePeriod(offlinePeriodBegin: offlinePeriodBegin, offlinePeriodEnd: offlinePeriodEnd)
        serviceRequest.getRegInfo = getRegInfo
        serviceRequest.ticketAdInfos = ticketAdInfos
        serviceRequest.auxiliary = auxiliary
        serviceRequest.regInfo = try createRegInfo(kgdId: kgdId, kkmOfdId: kkmOfdId, kkmSerialNumber: kkmSerialNumber, title: title, address: address, iinOrBin: iinOrBin, oked: oked)
        
        return serviceRequest
    }
    
    /// Создаем RegInfo
    private func createRegInfo(kgdId: String, kkmOfdId: String, kkmSerialNumber: String, title: String, address: String, iinOrBin: String, oked: String) throws -> Kkm_Proto_ServiceRequest.RegInfo {
        var regInfo = Kkm_Proto_ServiceRequest.RegInfo()
        
        regInfo.kkm = try createKkmRegInfo(kgdId: kgdId, kkmOfdId: kkmOfdId, kkmSerialNumber: kkmSerialNumber)
        regInfo.org = try createOrgRegInfo(title: title, address: address, iinOrBin: iinOrBin, oked: oked)
        
        return regInfo
    }
    
    /// Метод создает сущность протокола Kkm_Proto_KkmRegInfo
    private func createKkmRegInfo(kgdId: String, kkmOfdId: String, kkmSerialNumber: String) throws -> Kkm_Proto_KkmRegInfo {
        var kkmRegInfo = Kkm_Proto_KkmRegInfo()
        
        kkmRegInfo.fnsKkmID = kgdId
        kkmRegInfo.kkmID = kkmOfdId
        kkmRegInfo.serialNumber = kkmSerialNumber
        
        return kkmRegInfo
    }
    
    /// - createOrgRegInfo - метод создает сущность протокола CPCR Kkm_Proto_OrgRegInfo
    // TODO: Добавить возможность автозаполнение сервисной части из команды CommandInfo
    private func createOrgRegInfo(title: String, address: String, iinOrBin: String, oked: String) throws -> Kkm_Proto_OrgRegInfo {
        var orgRegInfo = Kkm_Proto_OrgRegInfo()
        
        orgRegInfo.title = title
        orgRegInfo.address = address
        orgRegInfo.inn = iinOrBin
        orgRegInfo.okved = oked
        
        return orgRegInfo
    }
    
    /// Метод создает сущность CPCR OfflinePeriod
    private func createOfflinePeriod(offlinePeriodBegin: Kkm_Proto_DateTime, offlinePeriodEnd: Kkm_Proto_DateTime) throws -> Kkm_Proto_ServiceRequest.OfflinePeriod {
        var offlinePeriod = Kkm_Proto_ServiceRequest.OfflinePeriod()
        
        offlinePeriod.beginTime = offlinePeriodBegin
        offlinePeriod.endTime = offlinePeriodEnd
        
        return offlinePeriod
    }
}
