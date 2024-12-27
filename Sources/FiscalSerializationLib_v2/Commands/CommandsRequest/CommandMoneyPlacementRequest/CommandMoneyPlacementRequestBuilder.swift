//
//  CommandMoneyPlacementRequestBuilder.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 27.12.2024.
//

class CommandMoneyPlacementRequestBuilder {
    private let commandMoneyPlacementRequest: CommandMoneyPlacementRequest
    private var commandRequest = Kkm_Proto_Request()
    private var commandMoneyPlacementRequestCpcr = Kkm_Proto_MoneyPlacementRequest()
    
    private init(commandMoneyPlacementRequest: CommandMoneyPlacementRequest) throws {
        self.commandMoneyPlacementRequest = commandMoneyPlacementRequest
        try setup()
    }
    
    static func createRequestCpcr(commandMoneyPlacementRequest: CommandMoneyPlacementRequest) throws -> Kkm_Proto_Request {
        let builder = try CommandMoneyPlacementRequestBuilder(commandMoneyPlacementRequest: commandMoneyPlacementRequest)
        return builder.commandRequest
    }
    
    private func setup() throws {
        try setupCommand()
        try setupCommandMoneyPlacement()
    }
    
    private func setupCommand() throws {
        commandRequest.command = Kkm_Proto_CommandTypeEnum.commandMoneyPlacement
    }
    
    private func setupCommandMoneyPlacement() throws {
        try setupCommandMoneyPlacementRequest()
        commandRequest.moneyPlacement = commandMoneyPlacementRequestCpcr
    }
    
    private func setupCommandMoneyPlacementRequest() throws {
        try setupDateTime()
        try setupOperation()
        try setupSum()
        setupIsOffline()
        setupShiftNumber()
        try setupOperator()
    }
    
    private func setupDateTime() throws {
        let dateTime = commandMoneyPlacementRequest.dateTime
        commandMoneyPlacementRequestCpcr.datetime = try DateTime.createProtoDateTime(from: dateTime)
    }
    
    private func setupOperation() throws {
        let operation = commandMoneyPlacementRequest.operation
        
        if operation.rawValue == 0 {
            commandMoneyPlacementRequestCpcr.operation = Kkm_Proto_MoneyPlacementEnum.moneyPlacementDeposit
        } else {
            commandMoneyPlacementRequestCpcr.operation = Kkm_Proto_MoneyPlacementEnum.moneyPlacementWithdrawal
        }
    }
    
    private func setupSum() throws {
        let sum = commandMoneyPlacementRequest.sum
        
        commandMoneyPlacementRequestCpcr.sum = try Money.fromDouble(value: sum)
    }
    
    private func setupIsOffline() {
        let isOffline = commandMoneyPlacementRequest.isOffline
        
        commandMoneyPlacementRequestCpcr.isOffline = isOffline
    }
    
    private func setupShiftNumber() {
        let shiftNumber = commandMoneyPlacementRequest.shiftNumber
        
        commandMoneyPlacementRequestCpcr.frShiftNumber = shiftNumber
    }
    
    private func setupOperator() throws {
        let operatorCode = commandMoneyPlacementRequest.operatorCode
        let operatorName = commandMoneyPlacementRequest.operatorName
        
        commandMoneyPlacementRequestCpcr.operator = try Operator().createOperator(code: operatorCode, name: operatorName)
    }
}
