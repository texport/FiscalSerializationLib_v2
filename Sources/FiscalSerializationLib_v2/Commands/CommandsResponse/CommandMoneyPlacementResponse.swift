//
//  CommandMoneyPlacementResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 27.12.2024.
//

public struct CommandMoneyPlacementResponse: InternalConstructible, ResponseProtocol {
    /// На какой ОФД отправлялась информация пользователем
    public let ofdName: OFD
    
    /// Информацию о ККМ от пользователя серверу ОФД
    public let kkmUserToServer: KKM
    
    /// Информацию о ККМ которую прислал сервера для пользователя
    public let kkmServerToUser: KKM
    
    /// Какая команда отправлялась на сервер по мнению ОФД
    public let command: CommandResponse
    
    /// Результат работы обработки сообщения сервером ОФД
    public let result: ResultResponse
    
    /// Сервисная часть ответа от сервера ОФД
    public let service: ServiceResponse?
    
    /// Часть с отчетом от сервера ОФД
    public let report: ZXReportResponse?
    
    private init(ofdName: OFD, kkmUserToServer: KKM, kkmServerToUser: KKM, command: CommandResponse, result: ResultResponse, service: ServiceResponse?, report: ZXReportResponse?) {
        self.ofdName = ofdName
        self.kkmUserToServer = kkmUserToServer
        self.kkmServerToUser = kkmServerToUser
        self.command = command
        self.result = result
        self.service = service
        self.report = report
    }
    
    static func create(with data: (ofdName: OFD, kkmUserToServer: KKM, kkmServerToUser: KKM, command: CommandResponse, result: ResultResponse, service: ServiceResponse?, report: ZXReportResponse?)) -> CommandMoneyPlacementResponse {
        CommandMoneyPlacementResponse(ofdName: data.0, kkmUserToServer: data.1, kkmServerToUser: data.2, command: data.3, result: data.4, service: data.5, report: data.6)
    }
}
