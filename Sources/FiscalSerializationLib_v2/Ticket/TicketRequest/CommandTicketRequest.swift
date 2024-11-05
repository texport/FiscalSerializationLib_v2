//
//  CommandTicket.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 21.10.2024.
//

import Foundation

/// `CommandTicketRequest` - класс-конфигуратор для создания и сериализации фискальных чеков.
/// Этот класс обеспечивает правильную настройку и сбор данных для фискальных чеков, включая операции с товарами,
/// налоги, скидки, а также генерацию и сериализацию данных в формате, необходимом для отправки на сервер.
///
/// Основные задачи класса:
/// - Настройка параметров чека, включая дату, время, тип операции, список товаров и оплат.
/// - Генерация и сериализация данных чека в формате `Data`.
/// - Обработка ошибок и проверка корректности данных.
///
/// ### Пример использования:
/// ```swift
/// do {
///     let serializedData = try CommandTicketRequest.createCommandTicketRequestCpcr(ticket: myTicket, ticketItems: myTicketItems)
///     // Отправка serializedData на сервер
/// } catch {
///     print("Ошибка при создании чека: \(error)")
/// }
/// ```
final class CommandTicketRequest {
    
    // MARK: - Свойства
    private let ticket: Ticket
    private let ticketItems: [TicketItem]
    private var ticketCpcr = Kkm_Proto_TicketRequest()
    private var ticketServiceRequest = Kkm_Proto_ServiceRequest()

    // Сущность налога на чек
    private let isTaxAllTicket: Bool
    
    // Сущность скидки на чек
    private let isDiscountAllTicket: Bool
    
    // Сущность онлайн чека
    private let isOnline: Bool
    private let isCustomer: Bool
    
    // Сущность итогов чека
    private var amounts: Kkm_Proto_TicketRequest.Amounts?
    
    // MARK: - Инициализация
        
    /// Инициализирует объект `CommandTicketRequest` с данными о чеке и позициях товаров.
    /// - Parameters:
    ///   - ticket: Основная информация о чеке.
    ///   - ticketItems: Список позиций товаров.
    /// - Throws: Генерирует ошибку, если данные чека или товаров некорректны.
    private init(ticket: Ticket, ticketItems: [TicketItem]) throws {
        self.ticket = ticket
        self.ticketItems = ticketItems
        self.isOnline = ticket.isTicketOnline
        self.isTaxAllTicket = ticket.isTicketAllTax
        self.isDiscountAllTicket = ticket.isTicketAllDiscount
        self.isCustomer = ticket.isCustomer
        
        try setupTicket()
    }
    
    // MARK: - Публичные методы
        
    /// Создает и сериализует данные чека в формате `Data`.
    /// - Parameters:
    ///   - ticket: Основная информация о чеке.
    ///   - ticketItems: Список позиций товаров.
    /// - Returns: Сериализованные данные чека.
    /// - Throws: Генерирует ошибку, если данные чека некорректны.
    public static func createCommandTicketRequestCpcr(ticket: Ticket, ticketItems: [TicketItem]) throws -> Data {
        let commandTicketRequest = try CommandTicketRequest(ticket: ticket, ticketItems: ticketItems)
        return try commandTicketRequest.serializeCommandTicketRequest()
    }
    
    // MARK: - Настройка данных чека
        
    /// Настройка и сборка всех данных для чека.
    /// - Throws: Генерирует ошибку, если данные некорректны.
    private func setupTicket() throws {
        try setupOperation()
        try setupDateTime()
        try setupOfflineTicketNumber()
        try setupShiftNumber()
        try setupOperator()
        try setupItemPositions()
        try setupPayments()
        try setupTaxAllTicket()
        try setupAmounts()
        try setupExtensionOptions()
        ticketServiceRequest = try createServiceRequestBuilder()
    }
    
    // MARK: Operation
    /// Устанавливает тип операции для чека.
    /// - Throws: Генерирует ошибку, если тип операции некорректен.
    private func setupOperation() throws {
        ticketCpcr.operation = try createOperation(type: ticket.operation)
    }
    
    /// Создает объект типа операции на основе значения.
    /// - Parameter type: Код типа операции.
    /// - Returns: Значение `Kkm_Proto_OperationTypeEnum`.
    /// - Throws: Генерирует ошибку, если код типа операции некорректен.
    private func createOperation(type: UInt) throws -> Kkm_Proto_OperationTypeEnum {
        if type == 0 {
            return Kkm_Proto_OperationTypeEnum.operationBuy
        }
        
        if type == 1 {
            return Kkm_Proto_OperationTypeEnum.operationBuyReturn
        }
        
        if type == 2 {
            return Kkm_Proto_OperationTypeEnum.operationSell
        }
        
        if type == 3 {
            return Kkm_Proto_OperationTypeEnum.operationSellReturn
        }
        
        throw NSError(domain: "InvalidOperationType", code: 1, userInfo: [NSLocalizedDescriptionKey: "Недопустимый код типа операции. Допустимые значения: 0 (Покупка), 1 (Возврат покупки), 2 (Продажа), 3 (Возврат продажи)"])
    }
    
    // MARK: DateTime
    /// Устанавливает дату и время для чека.
    /// - Throws: Генерирует ошибку, если данные некорректны.
    private func setupDateTime() throws {
        ticketCpcr.dateTime = try dateTimeBuilder()
    }
    
    /// Создает объект даты и времени на основе данных чека.
    /// - Throws: Генерирует ошибку, если данные некорректны.
    private func dateTimeBuilder() throws -> Kkm_Proto_DateTime {
        let dateTime = DateTime()
        let date = try dateTime.createDate(year: ticket.year, month: ticket.month, day: ticket.day)
        let time = try dateTime.createTime(hour: ticket.hour, minute: ticket.minute, second: ticket.second)
        
        return try dateTime.createDateTime(date: date, time: time)
    }
    
    // MARK: OfflineTicketNumber
    /// Устанавливает номер оффлайн-чека, если чек не онлайн.
    /// - Throws: Генерирует ошибку, если номер чека некорректен.
    private func setupOfflineTicketNumber() throws {
        if !isOnline {
            // Проверка, что offlineTicketNumber не является nil и больше 0
            guard let offlineTicketNumber = ticket.offlineTicketNumber, offlineTicketNumber > 0 else {
                throw NSError(domain: "builderTicket", code: 2, userInfo: [NSLocalizedDescriptionKey: "Для онлайн-чека необходимо указать корректный номер оффлайн чека (offlineTicketNumber), отличающийся от 0."])
            }
            
            ticketCpcr.offlineTicketNumber = offlineTicketNumber
        }
    }
    
    // MARK: ShiftNumber
    /// Устанавливает номер смены для чека.
    private func setupShiftNumber() throws {
        ticketCpcr.frShiftNumber = ticket.frShiftNumber
    }
    
    // MARK: Operator
    /// Устанавливает данные оператора для чека.
    /// - Throws: Генерирует ошибку, если данные оператора некорректны.
    private func setupOperator() throws {
        ticketCpcr.operator = try Operator().createOperator(code: ticket.codeOperator, name: ticket.nameOperator)
    }
    
    // MARK: ItemPositions
    /// Устанавливает позиции товаров для чека.
    /// - Throws: Генерирует ошибку, если данные позиций некорректны.
    private func setupItemPositions() throws {
        let itemPositions = try ItemPositions().createItemPositions(ticketOperation: ticket.operation,
                                                                    isTaxAllTicket: isTaxAllTicket,
                                                                    isDiscountAllTicket: isDiscountAllTicket,
                                                                    ticketItems: ticketItems)
        ticketCpcr.items = itemPositions
    }
    
    // MARK: Payments
    /// Устанавливает данные о платежах для чека.
    /// - Throws: Генерирует ошибку, если данные платежей некорректны.
    private func setupPayments() throws {
        let payments = try Payments(isCash: ticket.isCash,
                                    billsCashSum: ticket.billsCashSum,
                                    coinsCashSum: ticket.coinsCashSum,
                                    isCard: ticket.isCard,
                                    billsCardSum: ticket.billsCardSum,
                                    coinsCardSum: ticket.coinsCardSum,
                                    isMobile: ticket.isMobile,
                                    billsMobileSum: ticket.billsMobileSum,
                                    coinsMobileSum: ticket.coinsMobileSum
        ).createPayments()

        ticketCpcr.payments = payments
    }
    
    // MARK: TaxAllTicket
    /// Устанавливает налог на чек, если он применяется ко всему чеку.
    /// - Throws: Генерирует ошибку, если данные налога некорректны.
    private func setupTaxAllTicket() throws {
        // Записываем налог на чек если есть
        if isTaxAllTicket {
            // Проверяем, что все необходимые значения для налога не равны nil
            guard let billsTax = ticket.billsTax,
                  let coinsTax = ticket.coinsTax,
                  let taxPercent = ticket.tax else {
                throw NSError(domain: "builderTicket", code: 4, userInfo: [NSLocalizedDescriptionKey: "Невозможно записать налог на чек. Все значения для налога (billsTax, coinsTax, taxPercent) должны быть установлены."])
            }
            
            // Создаем объект Money на основе проверенных значений
            let money = Money()
            let moneyTax = try money.createMoney(bills: billsTax, coins: coinsTax)
            
            // Создаем и записываем налог
            let taxes = Tax()
            try ticketCpcr.taxes = taxes.createTax(percent: taxPercent, sum: moneyTax)
        }
    }
    
    // MARK: Amounts
    /// Устанавливает итоговые суммы для чека.
    /// - Throws: Генерирует ошибку, если данные итогов некорректны.
    private func setupAmounts() throws {
        let taken = try checkTaken()
        let discountsSum = try discountBuilder()
        let money = Money()
        
        ticketCpcr.amounts = try Amounts().createAmounts(payments: ticketCpcr.payments, total: money.createMoney(bills: ticket.billsTotal, coins: ticket.coinsTotal), taken: taken, discount: discountsSum)
    }
    
    /// Проверяет и возвращает сумму наличных, если они были использованы.
    /// - Throws: Генерирует ошибку, если сумма некорректна.
    private func checkTaken() throws -> Kkm_Proto_Money? {
        if ticket.isCash {
            guard let billsCashTaken = ticket.billsCashTaken, let coinsCashTaken = ticket.coinsCashTaken,
                    let billsCashSum = ticket.billsCashSum, let coinsCashSum = ticket.coinsCashSum else {
                throw NSError(domain: "builderTicket", code: 5, userInfo: [NSLocalizedDescriptionKey: "В чеке есть оплата наличными, при оплате наличными параметры с billsCashSum, coinsCashSum, billsCashTaken, coinsCashTaken обязательны к заполнению."])
            }
            
            if (billsCashTaken < billsCashSum || coinsCashTaken < coinsCashSum) {
                throw NSError(domain: "builderTicket", code: 6, userInfo: [NSLocalizedDescriptionKey: "Сумма полученных денег при наличной оплате не может быть меньше суммы оплаты наличными. Сумма оплаты наличными: \(billsCashSum).\(coinsCashSum), Сумма полученных денег: \(billsCashTaken).\(coinsCashTaken)"])
            } else {
                let money = Money()
                return try money.createMoney(bills: billsCashTaken, coins: coinsCashTaken)
            }
        }
        
        return nil
    }
    
    /// Создает и возвращает модификатор скидки для чека, если она применяется ко всему чеку.
    /// - Throws: Генерирует ошибку, если данные скидки некорректны.
    private func discountBuilder() throws -> Kkm_Proto_TicketRequest.Modifier? {
        /// Проверка на отсутствие скидок если возврат
        if (ticketCpcr.operation.rawValue == 1 && isDiscountAllTicket) || (ticketCpcr.operation.rawValue == 3 && isDiscountAllTicket) {
            throw NSError(domain: "builderTicket", code: 1, userInfo: [NSLocalizedDescriptionKey: "При операциях возврат покупки или возврат продажи не может быть скидок вообще!!!"])
        }
        
        /// Если скидка на весь чек, то пытаемся ее собрать
        if isDiscountAllTicket {
            guard let billsDiscount = ticket.billsDiscount, let coinsDiscount = ticket.coinsDiscount else {
                throw NSError(domain: "DiscountError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Для скидки на весь чек необходимо указать сумму скидки (billsDiscount и coinsDiscount)."])
            }
            
            guard let name = ticket.discountName, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
                throw NSError(domain: "DiscountError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Название скидки не может быть пустым или состоять только из пробелов."])
            }
            
            let money = Money()
            let discount = Discount()
            return try discount.createDicountModifier(name: name, sum: money.createMoney(bills: billsDiscount, coins: coinsDiscount))
        } else {
            return nil
        }
    }
    
    // MARK: ExtensionOptions
    /// Устанавливает дополнительные параметры для чека, такие как телефон, email и ИИН/БИН.
    /// - Throws: Генерирует ошибку, если данные некорректны.
    private func setupExtensionOptions() throws {
        let extensionOptions = ExtensionOptions()
        ticketCpcr.extensionOptions = try extensionOptions.createExtensionOptions(
            phone: ticket.phone,
            email: ticket.email,
            iinOrBin: ticket.iinOrBin
        )
    }
    
    // MARK: SERVICE REQUEST
    /// Создает и возвращает объект сервисной части для чека.
    /// - Throws: Генерирует ошибку, если данные некорректны.
    private func createServiceRequestBuilder() throws -> Kkm_Proto_ServiceRequest {
        var serviceRequestBuilder: ServiceRequestBuilder?
        
        let dateTime = DateTime()
        
        // Извлекаем значения безопасно с использованием значений по умолчанию
        let offlinePeriodBeginYear = ticket.offlinePeriodBeginYear ?? 0
        let offlinePeriodBeginMonth = ticket.offlinePeriodBeginMonth ?? 0
        let offlinePeriodBeginDay = ticket.offlinePeriodBeginDay ?? 0
        let offlinePeriodBeginHour = ticket.offlinePeriodBeginHour ?? 0
        let offlinePeriodBeginMinute = ticket.offlinePeriodBeginMinute ?? 0
        let offlinePeriodBeginSecond = ticket.offlinePeriodBeginSecond ?? 0

        let offlinePeriodEndYear = ticket.offlinePeriodEndYear ?? 0
        let offlinePeriodEndMonth = ticket.offlinePeriodEndMonth ?? 0
        let offlinePeriodEndDay = ticket.offlinePeriodEndDay ?? 0
        let offlinePeriodEndHour = ticket.offlinePeriodEndHour ?? 0
        let offlinePeriodEndMinute = ticket.offlinePeriodEndMinute ?? 0
        let offlinePeriodEndSecond = ticket.offlinePeriodEndSecond ?? 0

        // Создаем даты и время для оффлайн периода
        let offlinePeriodBeginDate = try dateTime.createDate(year: offlinePeriodBeginYear, month: offlinePeriodBeginMonth, day: offlinePeriodBeginDay)
        let offlinePeriodBeginTime = try dateTime.createTime(hour: offlinePeriodBeginHour, minute: offlinePeriodBeginMinute, second: offlinePeriodBeginSecond)
        let offlinePeriodBegin = try dateTime.createDateTime(date: offlinePeriodBeginDate, time: offlinePeriodBeginTime)

        let offlinePeriodEndDate = try dateTime.createDate(year: offlinePeriodEndYear, month: offlinePeriodEndMonth, day: offlinePeriodEndDay)
        let offlinePeriodEndTime = try dateTime.createTime(hour: offlinePeriodEndHour, minute: offlinePeriodEndMinute, second: offlinePeriodEndSecond)
        let offlinePeriodEnd = try dateTime.createDateTime(date: offlinePeriodEndDate, time: offlinePeriodEndTime)
        
        serviceRequestBuilder = try ServiceRequestBuilder(kgdId: ticket.kgdId, kkmOfdId: ticket.kkmOfdId, kkmSerialNumber: ticket.kkmSerialNumber, title: ticket.title, address: ticket.address, iinOrBin: ticket.iinOrBinOrg, oked: ticket.oked, isOnline: ticket.isTicketOnline, offlinePeriodBegin: offlinePeriodBegin, offlinePeriodEnd: offlinePeriodEnd, getRegInfo: true)
        
        // Безопасно извлекаем serviceRequest
        guard let serviceRequest = serviceRequestBuilder?.serviceRequest else {
            throw NSError(domain: "ServiceRequestBuilderError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Не удалось создать serviceRequest."])
        }

        return serviceRequest
    }
    
    // MARK: Сериализация данных
    /// Сериализует данные чека в формат `Data`.
    /// - Returns: Сериализованные данные чека.
    /// - Throws: Генерирует ошибку, если сериализация не удалась.
    private func serializeCommandTicketRequest() throws -> Data {
        var request = Kkm_Proto_Request()
        request.command = .commandTicket
        request.ticket = ticketCpcr
        request.service = ticketServiceRequest
  
        return try request.serializedData()
    }
}
