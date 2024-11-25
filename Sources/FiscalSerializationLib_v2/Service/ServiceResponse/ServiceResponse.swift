//
//  ServiceResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 18.11.2024.
//

import Foundation

/// Класс `ServiceResponse` обрабатывает ответ от сервера оператора фискальных данных (ОФД).
///
/// Класс преобразует данные из ответа протокола `Kkm_Proto_ServiceResponse` в удобный формат, включая:
/// - Рекламные тексты (`ads`)
/// - Регистрационную информацию (`RegInfo`)
///
/// ### Основные задачи:
/// - Проверка наличия обязательных данных в ответе.
/// - Настройка рекламных текстов.
/// - Настройка регистрационной информации, если она присутствует.
///
/// ### Особенности:
/// Если ответ содержит данные, но они не соответствуют требованиям протокола, выбрасывается `NSError`.
class ServiceResponse {
    
    /// Сырой ответ от ОФД.
    private let serviceResponse: Kkm_Proto_ServiceResponse
    
    /// Рекламные тексты, возвращённые ОФД. Может быть пустым массивом, если данных нет.
    var ads: [String]?
    
    /// Регистрационная информация о кассе, торговой точке и организации. Может быть `nil`, если данные отсутствуют.
    var kkm: RegInfoResponse?
    
    /// Инициализирует объект на основе ответа от ОФД.
    ///
    /// - Parameter serviceResponse: Объект ответа `Kkm_Proto_ServiceResponse`.
    /// - Throws: Ошибка, если данные некорректны или отсутствуют обязательные поля.
    init(serviceResponse: Kkm_Proto_ServiceResponse) throws {
        self.serviceResponse = serviceResponse
        try setupServiceResponse()
    }
    
    /// Настраивает данные из ответа сервера.
    ///
    /// Вызывает методы настройки рекламных текстов и регистрационной информации.
    /// Если регистрационная информация отсутствует, она не будет установлена.
    ///
    /// - Throws: Ошибка, если данные некорректны.
    private func setupServiceResponse() throws {
        try setupAdsResponse()
        
        // TODO: Считаю что это временное решение, ОФД работает с багами, ОФД в случае если передает сервисную часть всегда должен передавать RegInfo
        if serviceResponse.hasRegInfo {
            try setupRegInfoResponse()
        }
    }
    
    // MARK: Рекламные тексты
    
    /// Настраивает рекламные тексты из ответа.
    ///
    /// Проверяет наличие массива рекламных текстов. Если массив присутствует, преобразует его в массив строк.
    /// Если массив отсутствует, оставляет `ads` пустым.
    ///
    /// - Throws: Ошибка, если данные некорректны.
    private func setupAdsResponse() throws {
        let adsResponseCpcr = serviceResponse.ticketAds
        
        if adsResponseCpcr.count >= 1 {
            ads = createAdsResponse(adsResponseCpcr: adsResponseCpcr)
        }
    }
    
    /// Преобразует массив объектов `Kkm_Proto_TicketAd` в массив строк.
    ///
    /// - Parameter adsResponseCpcr: Массив рекламных текстов в формате протокола.
    /// - Returns: Массив строк.
    private func createAdsResponse(adsResponseCpcr: [Kkm_Proto_TicketAd]) -> [String] {
        return adsResponseCpcr.map { $0.text }
    }
    
    // MARK: Информация о ККМ (RegInfo)
    
    /// Настраивает регистрационную информацию о кассе, торговой точке и организации.
    ///
    /// Проверяет наличие данных и преобразует их в объект `RegInfoResponse`.
    ///
    /// - Throws: Ошибка, если данные некорректны.
    private func setupRegInfoResponse() throws {
        let regInfoResponseCpcr = serviceResponse.regInfo
        kkm = try RegInfo.createRegInfoResponse(regInfoResponse: regInfoResponseCpcr)
    }
}
