//
//  CommandTicket.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 21.10.2024.
//

import SwiftProtobuf
import Foundation

// Класс-конфигуратор для создания чека
final class CommandTicketRequest {
    // Размер заголовка в байтах
    private let headerSize = 18
    
    // Основные сущности чека
    private let ticket: Ticket
    private let ticketItems: [TicketItem]
    private var ticketCpcr = Kkm_Proto_TicketRequest()
    private var ticketServiceRequest: Kkm_Proto_ServiceRequest?
    
    // Сущности приема типов оплаты
    // Наличные деньги
    private let isCash: Bool?
    private var taken: Kkm_Proto_Money?
    // Пластиковая карта
    private let isCard: Bool?
    // Мобильный платеж QR код
    private let isMobile: Bool?
    
    // Сущность налога на чек
    private let isTaxAllTicket: Bool
    
    // Сущность скидки на чек
    private let isDiscountAllTicket: Bool
    private var discount: Kkm_Proto_TicketRequest.Modifier?
    
    // Сущность онлайн чека
    private let isOnline: Bool
    private let isCustomer: Bool
    
    // Сущность итогов чека
    private var amounts: Kkm_Proto_TicketRequest.Amounts?
    
    /// Предпочтительный init, желательно работать по этому сценарию
    init(ticket: Ticket, ticketItems: [TicketItem]) throws {
        self.ticket = ticket
        self.ticketItems = ticketItems
        
        // Проверка: хотя бы один из параметров isCash, isCard или isMobile должен быть true
        guard ticket.isCash || ticket.isCard || ticket.isMobile else {
            throw NSError(domain: "TicketInitialization", code: 1, userInfo: [NSLocalizedDescriptionKey: "Должен быть выбран хотя бы один способ оплаты: наличные, карта или мобильный платеж."])
        }
        
        self.isOnline = ticket.isTicketOnline
        self.isCash = ticket.isCash
        self.isCard = ticket.isCard
        self.isMobile = ticket.isMobile
        self.isTaxAllTicket = ticket.isTicketAllTax
        self.isDiscountAllTicket = ticket.isTicketAllDiscount
        self.isCustomer = ticket.isCustomer
        
        try builderTicket()
    }
    
    private func builderTicket() throws {
        /// Записываем тип операции
        try self.ticketCpcr.operation = createOperation(type: ticket.operation)
        
        /// Проверка на отсутствие скидок если возврат
        if (ticketCpcr.operation.rawValue == 1 && isDiscountAllTicket) || (ticketCpcr.operation.rawValue == 3 && isDiscountAllTicket) {
            throw NSError(domain: "builderTicket", code: 1, userInfo: [NSLocalizedDescriptionKey: "При операциях возврат покупки или возврат продажи не может быть скидок вообще!!!"])
        }
        
        /// Создаем и записываем дату и время
        let dateTime = DateTime()
        let date = try dateTime.createDate(year: ticket.year, month: ticket.month, day: ticket.day)
        let time = try dateTime.createTime(hour: ticket.hour, minute: ticket.minute, second: ticket.second)
        try self.ticketCpcr.dateTime = dateTime.createDateTime(date: date, time: time)
        
        if !isOnline {
            // Проверка, что offlineTicketNumber не является nil и больше 0
            guard let offlineTicketNumber = ticket.offlineTicketNumber, offlineTicketNumber > 0 else {
                throw NSError(domain: "builderTicket", code: 1, userInfo: [NSLocalizedDescriptionKey: "Для онлайн-чека необходимо указать корректный номер оффлайн чека (offlineTicketNumber), отличающийся от 0."])
            }
            
            ticketCpcr.offlineTicketNumber = offlineTicketNumber
        }

        // Записываем номер смены
        ticketCpcr.frShiftNumber = ticket.frShiftNumber
        
        // Записываем кассира
        try ticketCpcr.operator = createOperator(code: ticket.codeOperator, name: ticket.nameOperator)
        
        try ticketCpcr.items = bodyBuilder()
        
        // Записываем платежи и их типы
        try ticketCpcr.payments = createPayments()
        
        // Записываем налог на чек если есть
        if isTaxAllTicket {
            // Проверяем, что все необходимые значения для налога не равны nil
            guard let billsTax = ticket.billsTax,
                  let coinsTax = ticket.coinsTax,
                  let taxPercent = ticket.tax else {
                throw NSError(domain: "builderTicket", code: 14, userInfo: [NSLocalizedDescriptionKey: "Невозможно записать налог на чек. Все значения для налога (billsTax, coinsTax, taxPercent) должны быть установлены."])
            }
            
            // Создаем объект Money на основе проверенных значений
            let moneyTax = try createMoney(bills: billsTax, coins: coinsTax)
            
            // Создаем и записываем налог
            try ticketCpcr.taxes = createTax(percent: taxPercent, sum: moneyTax)
        }
        
        try discount = createDiscount()
        
        // Записываем итог чека
        try ticketCpcr.amounts = createAmounts(payments: ticketCpcr.payments, total: createMoney(bills: ticket.billsTotal, coins: ticket.coinsTotal), taken: self.taken, discount: discount)
        
        if isCustomer {
            let phone = ticket.phone
            let email = ticket.email
            let iinOrBin = ticket.iinOrBin

            if let extensionOptions = try? createExtensionOptions(phone: phone, email: email, iinOrBin: iinOrBin) {
                ticketCpcr.extensionOptions = extensionOptions
            } else {
                throw NSError(domain: "builderTicket", code: 1, userInfo: [NSLocalizedDescriptionKey: "Не удалось создать опции для данных покупателя."])
            }
        }
        
        ticketServiceRequest = try createServiceRequestBuilder()
    }
    
    /// Создаем и заполняем список с работами, товарами, услугами
    private func bodyBuilder() throws -> [Kkm_Proto_TicketRequest.Item] {
        /// Проверка, что массив `ticketItems` не пуст
        guard ticketItems.count > 0 else {
            throw NSError(domain: "bodyBuilder", code: 1, userInfo: [NSLocalizedDescriptionKey: "Список товаров и услуг (ticketItems) не может быть пустым."])
        }
        
        var itemsCpcr = [Kkm_Proto_TicketRequest.Item]()
        
        for item in ticketItems {
            var itemCpcr = Kkm_Proto_TicketRequest.Item()
            
            let price = try createMoney(bills: item.billsPrice, coins: item.coinsPrice)
            var itemTaxs: [Kkm_Proto_TicketRequest.Tax] = []
            
            /// Проверяем есть ли НДС внутри позиции
            if item.isTicketItemTax {
                guard let tax = item.tax, let billsTax = item.billsTax, let coinsTax = item.coinsTax else {
                    throw NSError(domain: "bodyBuilder", code: 2, userInfo: [NSLocalizedDescriptionKey: "Налог на позицию (isTicketItemTax) указан, но значения tax, billsTax или coinsTax отсутствуют."])
                }
                
                itemTaxs = try createTax(percent: tax, sum: createMoney(bills: billsTax, coins: coinsTax))
            }
            
            /// Проверяем если возврат, то скидок не может быть
            if (item.isTicketItemDiscount && ticketCpcr.operation.rawValue == 1) || (item.isTicketItemDiscount && ticketCpcr.operation.rawValue == 3) {
                throw NSError(domain: "bodyBuilder", code: 3, userInfo: [NSLocalizedDescriptionKey: "При операциях возврат покупки или возврат продажи не может быть скидок вообще!!!"])
            }
            
            let itemCommodity = try createItemCommodity(name: item.nameTicketItem, sectionCode: item.sectionCode, quantity: item.quantity, price: price, taxes: itemTaxs, exciseStamp: item.dataMatrix, barcode: item.barcode, measureUnitCode: item.measureUnitCode.rawValue)

            itemCpcr = try createItem(type: Kkm_Proto_TicketRequest.Item.ItemTypeEnum.itemTypeCommodity, commodity: itemCommodity)
            itemsCpcr.append(itemCpcr)
            
            /// Если есть скидка на позицию
            if item.isTicketItemDiscount {
                guard !isDiscountAllTicket else {
                    throw NSError(domain: "bodyBuilder", code: 4, userInfo: [NSLocalizedDescriptionKey: "Скидка может быть только на позицию или на весь чек"])
                }
                
                guard let itemDiscountName = item.discountName else {
                    throw NSError(domain: "bodyBuilder", code: 5, userInfo: [NSLocalizedDescriptionKey: "У скидки обязательно должно быть имя"])
                }
                
                guard let itemBillsDiscount = item.billsDiscount, let itemCoinsDiscount = item.coinsDiscount else {
                    throw NSError(domain: "bodyBuilder", code: 6, userInfo: [NSLocalizedDescriptionKey: "У скидки обязательно должны быть суммы в billsDiscount и coinsDiscount"])
                }
                
                let itemCpcrDiscount = try createItem(type: Kkm_Proto_TicketRequest.Item.ItemTypeEnum.itemTypeDiscount, modifier: createModifier(name: itemDiscountName, sum: createMoney(bills: itemBillsDiscount, coins: itemCoinsDiscount)))
                
                itemsCpcr.append(itemCpcrDiscount)
                
                /// обязательно обновить счетчик общих скидок в amounts
            }
        }
        
        return itemsCpcr
    }
    
    // MARK: Operation - создание типа чека
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
    
    // MARK: OPERATOR - создаем кассира
    private func createOperator(code: UInt32, name: String) throws -> Kkm_Proto_Operator {
        // Проверка: код оператора должен быть больше 0
        guard code > 0 else {
            throw NSError(domain: "InvalidOperator", code: 1, userInfo: [NSLocalizedDescriptionKey: "Код оператора должен быть больше 0."])
        }
        
        // Проверка: имя оператора должно быть валидным
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty, trimmedName.count >= 2 else {
            throw NSError(domain: "InvalidOperator", code: 2, userInfo: [NSLocalizedDescriptionKey: "Имя оператора не может быть пустым, содержать только пробелы и должно быть длиной не менее 2 символов."])
        }
        
        var cashier = Kkm_Proto_Operator()
        cashier.code = code
        cashier.name = trimmedName
        
        return cashier
    }

    // MARK: Item
    /// В это мразделе мы не добавили ItemStornoCommodity/ItemStornoMarkup/ItemStornoDiscound
    /// так как считаем их legacy от "железных касс" и излишней функцией
    ///
    /// Метод для того что бы создать Item с конкретной позицией товара/услуги/товара
    private func createItem(type: Kkm_Proto_TicketRequest.Item.ItemTypeEnum,
                    commodity: Kkm_Proto_TicketRequest.Item.Commodity) throws -> Kkm_Proto_TicketRequest.Item {
        var item = Kkm_Proto_TicketRequest.Item()
        
        if type.rawValue == 1 {
            item.type = type
        } else {
            throw NSError(domain: "InvalidItemType", code: 1, userInfo: [NSLocalizedDescriptionKey: "Для товаров/услуг/работ type должен быть только 1(цифра один без ковычек)"])
        }
        
        item.commodity = commodity
        
        return item
    }
    
    /// Метод для того что бы создать скиндку на конкретный товар/работу/услугу
    /// Нельзя его использовать для пустого ticket, только если в ticket есть товар/работа/услуга
    private func createItem(type: Kkm_Proto_TicketRequest.Item.ItemTypeEnum,
                    modifier: Kkm_Proto_TicketRequest.Modifier) throws -> Kkm_Proto_TicketRequest.Item {
        // добавить главную проверку, если есть скинда/наценка на весь чек, то этот item нельзя создать
        var item = Kkm_Proto_TicketRequest.Item()
        
        if type.rawValue == 5 {
            item.type = type
        } else {
            throw NSError(domain: "InvalidItemType", code: 1, userInfo: [NSLocalizedDescriptionKey: "Для скидок type = 5"])
        }
        
        if type.rawValue == 5 {
            item.discount = modifier
        }
        
        return item
    }
    
    // MARK: ItemCommodity
    /// Метод создает конкретную работу, товар, услугу
    private func createItemCommodity(name: String,
                             sectionCode: String,
                             quantity: UInt32,
                             price: Kkm_Proto_Money,
                             taxes: [Kkm_Proto_TicketRequest.Tax],
                             exciseStamp: String?,
                             barcode: String?,
                             measureUnitCode: String) throws -> Kkm_Proto_TicketRequest.Item.Commodity {
        var itemCommodity = Kkm_Proto_TicketRequest.Item.Commodity()
        
        if (!isTaxAllTicket && taxes.count == 0) || (isTaxAllTicket && taxes.count > 0){
            throw NSError(domain: "InvalidTax", code: 1, userInfo: [NSLocalizedDescriptionKey: "Ошибка с передачей налогов: в чеке может быть либо налог на весь чек, либо налог на каждую позицию. Проверьте корректность входных данных"])
        }
        
        guard isValidName(name) else {
            throw NSError(domain: "InvalidName", code: 2, userInfo: [NSLocalizedDescriptionKey: "Название не может быть пустым, содержать только пробелы или быть менее 2-х символов"])
        }
        
        // Считаю что code использовать вообще не нужно
        
        itemCommodity.name = name
        itemCommodity.sectionCode = sectionCode
        itemCommodity.quantity = quantity
        itemCommodity.price = price
        itemCommodity.sum = calculateSum(quantity: quantity, price: price)
        itemCommodity.taxes = taxes
        
        if let exciseStamp = exciseStamp {
            itemCommodity.exciseStamp = exciseStamp
        }
        
        // Считаю что physicalLabel использовать вообще не нужно
        // Считаю что productId использовать вообще не нужно
        
        if let barcode = barcode {
            itemCommodity.barcode = barcode
        }
        
        itemCommodity.measureUnitCode = measureUnitCode
        itemCommodity.auxiliary = [Kkm_Proto_KeyValuePair]()
        
        return itemCommodity
    }
    
    // MARK: Modifier - создание скидки/наценки
    private func createModifier(name: String, sum: Kkm_Proto_Money) throws -> Kkm_Proto_TicketRequest.Modifier {
        var modifier = Kkm_Proto_TicketRequest.Modifier()
        
        modifier.name = name
        modifier.sum = sum
        modifier.taxes = [Kkm_Proto_TicketRequest.Tax]()
        modifier.auxiliary = [Kkm_Proto_KeyValuePair]()
        
        return modifier
    }
    
    // MARK: Payment - Чем покупатель оплачивал и в каком количестве
    /// Методы создает сущность протокола Kkm_Proto_TicketRequest.Payment в зависимости от типа оплаты
    ///
    /// Создаем массим payment
    private func createPayments() throws -> [Kkm_Proto_TicketRequest.Payment] {
        
        // Проверка: хотя бы один из типов оплаты должен быть установлен и равен true
        guard (isCard ?? false) || (isCash ?? false) || (isMobile ?? false) else {
            throw NSError(domain: "PaymentError", code: 13, userInfo: [NSLocalizedDescriptionKey: "Должен быть указан хотя бы один способ оплаты (наличные, карта или мобильный платеж)."])
        }
        
        var payments: [Kkm_Proto_TicketRequest.Payment] = []
        
        // Создание платежа наличными, если он используется
        if let isCash = isCash, isCash {
            let cashPayment = try createCashPayment()
            payments.append(cashPayment)
        }
        
        // Создание платежа картой, если он используется
        if let isCard = isCard, isCard {
            let cardPayment = try createCardPayment()
            payments.append(cardPayment)
        }
        
        // Создание мобильного платежа, если он используется
        if let isMobile = isMobile, isMobile {
            let mobilePayment = try createMobilePayment()
            payments.append(mobilePayment)
        }
        
        return payments
    }
    
    /// Если расчет был наличными деньгами
    private func createCashPayment() throws -> Kkm_Proto_TicketRequest.Payment {
        var payment = Kkm_Proto_TicketRequest.Payment()
        
        // Проверка: поле isCash должно быть установлено (true или false)
        guard let isCash = isCash else {
            throw NSError(domain: "PaymentError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Поле isCash должно быть установлено (true или false)."])
        }
        
        // Если расчет не наличными, проверяем, что данные по наличным платежам отсутствуют
        if !isCash {
            guard ticket.billsCashSum == nil,
                  ticket.coinsCashSum == nil,
                  ticket.billsCashTaken == nil,
                  ticket.coinsCashTaken == nil else {
                throw NSError(domain: "PaymentError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Если расчет не наличными, то данные по наличным платежам должны быть nil."])
            }
            // Ошибка, если данные по наличным присутствуют, но расчет не наличными
            throw NSError(domain: "PaymentError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Данные по наличным платежам указаны, но расчет не наличными."])
        }
        
        // Если расчет наличными, устанавливаем тип оплаты как наличные
        payment.type = Kkm_Proto_PaymentTypeEnum.paymentCash
        
        // Проверка на наличие суммы оплаты наличными
        guard let billsCashSum = ticket.billsCashSum, let coinsCashSum = ticket.coinsCashSum else {
            throw NSError(domain: "PaymentError", code: 4, userInfo: [NSLocalizedDescriptionKey: "Отсутствует сумма оплаты наличными."])
        }
        
        // Создаем сумму наличными
        try payment.sum = createMoney(bills: billsCashSum, coins: coinsCashSum)
        
        // Проверка наличия данных о переданных деньгах
        if let billsCashTaken = ticket.billsCashTaken, let coinsCashTaken = ticket.coinsCashTaken {
            // Создаем сумму на основе переданных данных или используем существующую
            try taken = (billsCashTaken == 0 && coinsCashTaken == 0) ? payment.sum : createMoney(bills: billsCashTaken, coins: coinsCashTaken)
        }
        
        return payment
    }
    
    /// Если расчет был картой
    private func createCardPayment() throws -> Kkm_Proto_TicketRequest.Payment {
        var payment = Kkm_Proto_TicketRequest.Payment()
        
        // Проверка: поле isCard должно быть установлено (true или false)
        guard let isCard = isCard else {
            throw NSError(domain: "PaymentError", code: 5, userInfo: [NSLocalizedDescriptionKey: "Поле isCard должно быть установлено (true или false)."])
        }
        
        // Если расчет не картой, проверяем, что данные по картам отсутствуют
        if !isCard {
            guard ticket.billsCardSum == nil, ticket.coinsCardSum == nil else {
                throw NSError(domain: "PaymentError", code: 6, userInfo: [NSLocalizedDescriptionKey: "Если расчет не картой, то данные по картам должны быть nil."])
            }
            // Ошибка, если данные по картам присутствуют, но расчет не картой
            throw NSError(domain: "PaymentError", code: 7, userInfo: [NSLocalizedDescriptionKey: "Данные по оплате картой указаны, но расчет не картой."])
        }
        
        // Если расчет картой, устанавливаем тип оплаты как картой
        payment.type = Kkm_Proto_PaymentTypeEnum.paymentCard
        
        // Проверка на наличие суммы оплаты картой
        guard let billsCardSum = ticket.billsCardSum, let coinsCardSum = ticket.coinsCardSum else {
            throw NSError(domain: "PaymentError", code: 8, userInfo: [NSLocalizedDescriptionKey: "Отсутствует сумма оплаты картой."])
        }
        
        // Создаем сумму картой
        try payment.sum = createMoney(bills: billsCardSum, coins: coinsCardSum)
        
        return payment
    }

    /// Если расчет был QR кодом
    private func createMobilePayment() throws -> Kkm_Proto_TicketRequest.Payment {
        var payment = Kkm_Proto_TicketRequest.Payment()
        
        // Проверка: поле isMobile должно быть установлено (true или false)
        guard let isMobile = isMobile else {
            throw NSError(domain: "PaymentError", code: 9, userInfo: [NSLocalizedDescriptionKey: "Поле isMobile должно быть установлено (true или false)."])
        }
        
        // Если расчет не мобильным платежом, проверяем, что данные по мобильным платежам отсутствуют
        if !isMobile {
            guard ticket.billsMobileSum == nil, ticket.coinsMobileSum == nil else {
                throw NSError(domain: "PaymentError", code: 10, userInfo: [NSLocalizedDescriptionKey: "Если расчет не мобильным платежом, то данные по мобильным платежам должны быть nil."])
            }
            // Ошибка, если данные по мобильным платежам присутствуют, но расчет не мобильным
            throw NSError(domain: "PaymentError", code: 11, userInfo: [NSLocalizedDescriptionKey: "Данные по мобильному платежу указаны, но расчет не мобильным."])
        }
        
        // Если расчет мобильным платежом, устанавливаем тип оплаты как мобильный платеж
        payment.type = Kkm_Proto_PaymentTypeEnum.paymentMobile
        
        // Проверка на наличие суммы оплаты мобильным платежом
        guard let billsMobileSum = ticket.billsMobileSum, let coinsMobileSum = ticket.coinsMobileSum else {
            throw NSError(domain: "PaymentError", code: 12, userInfo: [NSLocalizedDescriptionKey: "Отсутствует сумма мобильного платежа."])
        }
        
        // Создаем сумму мобильным платежом
        try payment.sum = createMoney(bills: billsMobileSum, coins: coinsMobileSum)
        
        return payment
    }
    
    // MARK: Taxes - НДС
    // Метод создает сущность протокола Kkm_Proto_TicketRequest.Tax для
    // ItemCommodity или TicketRequest
    private func createTax(percent: UInt32, sum: Kkm_Proto_Money) throws -> [Kkm_Proto_TicketRequest.Tax] {
        
        guard percent == 0 || percent == 12000 else {
            throw NSError(domain: "InvalidTaxPercent", code: 1, userInfo: [NSLocalizedDescriptionKey: "Значение процента должно быть равно 0(0%) или 12000(12%), у нас в стране нет других налоговых ставок"])
        }
        
        guard percent == 0 && !checkSum(money: sum) || percent == 12000 && checkSum(money: sum) else {
            throw NSError(domain: "InvalidTaxPercent", code: 2, userInfo: [NSLocalizedDescriptionKey: "Если НДС 0%, то сумма не может быть больше 0. Если НДС 12%, сумма не может быть равна 0"])
        }
        
        var taxes: [Kkm_Proto_TicketRequest.Tax] = []
        var tax = Kkm_Proto_TicketRequest.Tax()
        
        // Исключил taxationType, считаю что он не нужен
        
        // Согласно протоколу taxType нужно передавать 100, других значений в протоколе нету
        tax.taxType = 100
        tax.percent = percent
        tax.sum = sum
        // У нас в стране все компании НДС на товар, работы, услуги включают в стоимость
        tax.isInTotalSum = true
        taxes.append(tax)
        
        return taxes
    }
    
    // MARK: Amounts - Общий итог ticket(чека)
    // Метод создает сущность для протокола Kkm_Proto_TicketRequest.Amounts
    private func createAmounts(payments: [Kkm_Proto_TicketRequest.Payment],
                               total: Kkm_Proto_Money,
                               taken: Kkm_Proto_Money?,
                               discount: Kkm_Proto_TicketRequest.Modifier?) throws -> Kkm_Proto_TicketRequest.Amounts {
        guard payments.count > 0 else {
            throw NSError(domain: "InvalidAmountsPayments", code: 1, userInfo: [NSLocalizedDescriptionKey: "Не может быть такой ситуации, когда нет платежей вообще, в payments пусто"])
        }
        
        // Проверка: если есть единственный тип оплаты наличными и только он
        let onlyCashPayment = payments.count == 1 && payments.first?.type == .paymentCash
        
        // Если чек полностью оплачен наличными, сумма должна быть передана
        if onlyCashPayment {
            guard let taken = taken else {
                throw NSError(domain: "InvalidAmounts", code: 2, userInfo: [NSLocalizedDescriptionKey: "При оплате только наличными должна быть указана полученная сумма (taken)."])
            }
        }
        
        var amounts = Kkm_Proto_TicketRequest.Amounts()
        
        // Устанавливаем общую сумму
        amounts.total = total
        
        // Устанавливаем полученную сумму, если она есть
        if let taken = taken {
            amounts.taken = taken
            
            // Рассчитываем сдачу, если чек полностью оплачен наличными
            if onlyCashPayment {
                var changeBills = (taken.bills >= total.bills) ? (taken.bills - total.bills) : 0
                var changeCoins = (taken.coins >= total.coins) ? (taken.coins - total.coins) : 0
                
                // Учитываем пересчет монет в купюры, если нужно
                if taken.coins < total.coins && taken.bills > 0 {
                    changeCoins = (taken.coins + 100) - total.coins
                    changeBills -= 1
                }
                
                // Если сумма сдачи равна нулю, все равно создаем объект со сдачей 0
                var calculatedChange = Kkm_Proto_Money()
                calculatedChange.bills = changeBills
                calculatedChange.coins = changeCoins
                amounts.change = calculatedChange
            }
        }
        
        // Устанавливаем скидку, если она есть
        if let discount = discount {
            amounts.discount = discount
        }
        
        return amounts
    }

    // MARK: Discount - создаем и считаем скидки на весь чек
    private func createDiscount() throws -> Kkm_Proto_TicketRequest.Modifier? {
        /// Если скидка на весь чек, то пытаемся ее собрать
        /// обязательно нужно доделать этот метод, после того как сделаю уже позиции в чеке
        if isDiscountAllTicket {
            guard let billsDiscount = ticket.billsDiscount, let coinsDiscount = ticket.coinsDiscount else {
                throw NSError(domain: "DiscountError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Для скидки на весь чек необходимо указать сумму скидки (billsDiscount и coinsDiscount)."])
            }
            
            guard let name = ticket.discountName, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
                throw NSError(domain: "DiscountError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Название скидки не может быть пустым или состоять только из пробелов."])
            }
            
            return try createModifier(name: name, sum: createMoney(bills: billsDiscount, coins: coinsDiscount))
        } else {
            return nil
        }
    }
    
    // MARK: Customer - ифнормация о покупателе
    // Метод создает структуру клиента если это необходимо
    private func createExtensionOptions(phone: String?, email: String?, iinOrBin: String?) throws -> Kkm_Proto_TicketRequest.ExtensionOptions? {
        // Проверка, что хотя бы одно из полей передано
        guard phone != nil || email != nil || iinOrBin != nil else {
            throw NSError(domain: "ExtensionOptionsError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Необходимо указать хотя бы одно из полей: телефон, email или ИИН/БИН."])
        }
        
        var customer = Kkm_Proto_TicketRequest.ExtensionOptions()
        customer.auxiliary = [Kkm_Proto_KeyValuePair]()
        
        // Регулярное выражение для телефона (Казахстан) - формат +7XXXXXXXXXX
        let phoneRegex = "^\\+7\\d{10}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        if let phone = phone {
            guard phonePredicate.evaluate(with: phone) else {
                throw NSError(domain: "ExtensionOptionsError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Неверный формат телефона. Ожидается формат +7XXXXXXXXXX."])
            }
            customer.customerPhone = phone
        }
        
        // Регулярное выражение для email
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if let email = email {
            guard emailPredicate.evaluate(with: email) else {
                throw NSError(domain: "ExtensionOptionsError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Неверный формат email."])
            }
            customer.customerEmail = email
        }
        
        // Проверка ИИН/БИН - должно содержать только цифры и быть длиной 12 символов
        let iinOrBinRegex = "^\\d{12}$"
        let iinOrBinPredicate = NSPredicate(format: "SELF MATCHES %@", iinOrBinRegex)
        
        if let iinOrBin = iinOrBin {
            guard iinOrBinPredicate.evaluate(with: iinOrBin) else {
                throw NSError(domain: "ExtensionOptionsError", code: 4, userInfo: [NSLocalizedDescriptionKey: "Неверный формат ИИН/БИН. Ожидается 12-значное число, содержащее только цифры."])
            }
            customer.customerIinOrBin = iinOrBin
        }
        
        return customer
    }

    // MARK: MONEY
    private func createMoney(bills: UInt64, coins: UInt32) throws -> Kkm_Proto_Money {
        var money = Kkm_Proto_Money()
        
        money.bills = bills
        money.coins = coins
        
        return money
    }
    
    // MARK: SERVICE REQUEST
    /// Метод отвечает за создание сервисной части для чека
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
        
        serviceRequestBuilder = ServiceRequestBuilder(kgdId: ticket.kgdId, kkmOfdId: ticket.kkmOfdId, kkmSerialNumber: ticket.kkmSerialNumber, title: ticket.title, address: ticket.address, iinOrBin: ticket.iinOrBinOrg, oked: ticket.oked, isOnline: ticket.isTicketOnline, offlinePeriodBegin: offlinePeriodBegin, offlinePeriodEnd: offlinePeriodEnd, getRegInfo: true)
        
        // Безопасно извлекаем serviceRequest
        guard let serviceRequest = serviceRequestBuilder?.serviceRequest else {
            throw NSError(domain: "ServiceRequestBuilderError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Не удалось создать serviceRequest."])
        }

        return serviceRequest
    }
    
    // MARK: Методы Хелперы
    
    /// Нужно обязательно сделать проверку на то что quantity передается в тысячных
    
    // Проверка параметра Name для Commodity
    private func isValidName(_ name: String) -> Bool {
        // Регулярное выражение для проверки: строка не должна быть пустой, содержать только пробелы или состоять из одного символа
        let regex = "^(?!\\s*$).{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: name)
    }
    
    // Метод для вычисления суммы на основе количества в тысячных и цены
    private func calculateSum(quantity: UInt32, price: Kkm_Proto_Money) -> Kkm_Proto_Money {
        var total = Kkm_Proto_Money()

        // Вычисляем общую сумму с учетом того, что quantity уже в тысячных
        total.bills = (price.bills * UInt64(quantity)) / 1000
        total.coins = (price.coins * quantity) / 1000

        // Если coins больше 100, конвертируем их в bills
        if total.coins >= 100 {
            total.bills += UInt64(total.coins / 100)
            total.coins = total.coins % 100
        }

        return total
    }

    // Метод проверяет что Tax.sum != 0
    private func checkSum(money: Kkm_Proto_Money) -> Bool {
        (money.bills != 0 && money.coins != 0) || (money.bills != 0 && money.coins == 0) || (money.bills == 0 && money.coins != 0)
    }
    
    // MARK: ПУБЛИЧНЫЕ МЕТОДЫ
    func serializeCommandTicketRequest() throws -> Data {
        var request = Kkm_Proto_Request()
        request.command = .commandTicket
        request.ticket = ticketCpcr
        
        if let ticketRequestCpcr = ticketServiceRequest {
            request.service = ticketRequestCpcr
        } else {
            throw NSError(domain: "serializeCommandTicketRequest", code: 1, userInfo: [NSLocalizedDescriptionKey: "Что-то с ticketRequestCpcr, не получилось его извлечь."])
        }
        
        let payload = try request.serializedData()
        
        return payload
    }
    
    func deserializeCommandTicketResponse(data: Data) throws -> Kkm_Proto_Response {
        // Проверяем, что данных достаточно для включения заголовка
        guard data.count > headerSize else {
            throw NSError(domain: "CommandTicketDeserializer", code: 2, userInfo: [NSLocalizedDescriptionKey: "Данных недостаточно"])
        }
        
        // Отсекаем заголовок
        let payloadData = data.subdata(in: headerSize..<data.count)
        
        // Десериализация данных
        let response = try Kkm_Proto_Response(serializedBytes: payloadData)
        
        // Возвращаем десериализованный ответ
        return response
    }
}
