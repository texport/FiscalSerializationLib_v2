//
//  InfoResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

public struct CommandInfoResponse: InternalConstructible, ResponseProtocol {
    public let ofdName: OFD
    public let kkm: KKM
    
    /// Какая команда отправлялась на сервер по мнению ОФД
    public let command: CommandResponse
    
    /// Результат работы обработки сообщения сервером ОФД
    public let result: ResultResponse
    
    /// Сервисная часть ответа от сервера ОФД
    public let service: ServiceResponse
    
    /// Часть с отчетом от сервера ОФД
    public let report: ZXReportResponse
    
    private init(ofdName: OFD, kkm: KKM, command: CommandResponse, result: ResultResponse, service: ServiceResponse, report: ZXReportResponse) {
        self.ofdName = ofdName
        self.kkm = kkm
        self.command = command
        self.result = result
        self.service = service
        self.report = report
    }
    
    static func create(with data: (ofdName: OFD, kkm: KKM, command: CommandResponse, result: ResultResponse, service: ServiceResponse, report: ZXReportResponse)) -> CommandInfoResponse {
        CommandInfoResponse(ofdName: data.0, kkm: data.1, command: data.2, result: data.3, service: data.4, report: data.5)
    }
}
