public struct CommandSystemResponse: InternalConstructible, ResponseProtocol {
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
    
    private init(ofdName: OFD, kkmUserToServer: KKM, kkmServerToUser: KKM, command: CommandResponse, result: ResultResponse, service: ServiceResponse?) {
        self.ofdName = ofdName
        self.kkmUserToServer = kkmUserToServer
        self.kkmServerToUser = kkmServerToUser
        self.command = command
        self.result = result
        self.service = service
    }
    
    static func create(with data: (ofdName: OFD, kkmUserToServer: KKM, kkmServerToUser: KKM, command: CommandResponse, result: ResultResponse, service: ServiceResponse?)) -> CommandSystemResponse {
        CommandSystemResponse(ofdName: data.0, kkmUserToServer: data.1, kkmServerToUser: data.2, command: data.3, result: data.4, service: data.5)
    }
}
