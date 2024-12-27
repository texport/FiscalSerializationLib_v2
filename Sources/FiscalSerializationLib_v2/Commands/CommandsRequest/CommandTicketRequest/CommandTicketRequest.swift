//
//  Ticket.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 23.10.2024.
//

import Foundation

/// - Ticket - это структура конструктор, с помощью которой вы можете создать чек.
public struct CommandTicketRequest: CommandProtocol, RequestProtocol {
    public private(set) var commandCode = CommandTypeEnum.commandTicket
    /// -------------------------------------------------------------------------------------------
    /// - isTicketOnline - чек фискализируется в онлайн режиме или в оффлайн режиме(автономном).
    /// Если чек ранее уже пытался отправляться в ОФД, но не был доставлен
    /// то ставим false, иначе ставим true. Если isTicketOnline = false, параметр offlineTicketNumber обязателен к заполнению.
    public let isTicketOnline: Bool
    /// - offlineTicketNumber - если isTicketOnline = false, то этот параметр обязателен к заполнению. Этот параметр
    /// обозначается как Автономный фискальный признак, его нужно генерировать самостоятельно. На данном этапе вам
    /// нужно будет написать свой генератор фискальных признаков.
    // TODO: рассмотреть возможность создания своего генератора автономных фискальных признаков
    public let offlineTicketNumber: UInt32?
    
    public let offlinePeriodBeginYear: UInt32?
    public let offlinePeriodBeginMonth: UInt32?
    public let offlinePeriodBeginDay: UInt32?
    
    public let offlinePeriodBeginHour: UInt32?
    public let offlinePeriodBeginMinute: UInt32?
    public let offlinePeriodBeginSecond: UInt32?
    
    public let offlinePeriodEndYear: UInt32?
    public let offlinePeriodEndMonth: UInt32?
    public let offlinePeriodEndDay: UInt32?
    
    public let offlinePeriodEndHour: UInt32?
    public let offlinePeriodEndMinute: UInt32?
    public let offlinePeriodEndSecond: UInt32?
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// Информация о владельце кассового аппарата и о самом кассовом аппарате
    /// kgdId - регистрационный номер, который выдает КГД при регистрации кассового аппарата
    /// kkmOfdId - системный идентификатор, который выдает ОФД при регистрации у них на сайте
    /// kkmSerialNumber - заводской номер кассового аппарата, который маркируется на кассовом аппарате при его производстве
    /// title - имя компании владельца кассового аппарата
    /// address - юридический адрес компании владельца кассового аппарата
    /// iinOrBinOrg - ИИН или БИН компании владельца кассового аппарата
    /// oked - общий классификатор экономической деятельности компании владельца кассового аппарата
    public let kgdId: String
    public let kkmOfdId: String
    public let kkmSerialNumber: String
    
    public let title: String
    public let address: String
    public let iinOrBinOrg: String
    public let oked: String
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// НОМЕР СМЕНЫ
    /// Обязательно берем номер смены из Z-отчета, обычно это Номер смены предыдущего закрытого
    /// Z-Отчета + 1
    public let frShiftNumber: UInt32
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// Тип операции продажа(2)/возврат продажи(3)/покупка(0)/возврат покупки(1)
    public let operation: UInt
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// ДАТА
    /// год - четыре цифры(например 2024)
    /// месяц - диапазон 1-12
    /// день - диапазон 1-31
    public let year: UInt32
    public let month: UInt32
    public let day: UInt32
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// ВРЕМЯ
    /// часы - диапазон 0-23
    /// минуты и секунды - диапазон 0-59
    public let hour: UInt32
    public let minute: UInt32
    public let second:UInt32
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// КАССИР
    /// Кто провел операцию
    public let codeOperator: UInt32
    public let nameOperator: String
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// ПЛАТЕЖ НАЛИЧНЫМИ
    /// Покупатель может оплачивать разными способами оплаты.
    /// Могут быть комбо оплаты наличные + безналичные + мобильный платежи в одном ticket(чеке)
    /// billsTaken и coinsTaken - это сумма денег которую покупатель дал продавцу наличкой, если
    /// такая оплата вообще была, если наличными ничего не оплачивали, то не добавляем
    /// billsCashSum и coinsCashSum - какая сумма была оплачена наличными
    public let isCash: Bool
    public let billsCashSum: UInt64?
    public let coinsCashSum: UInt32?
    public let billsCashTaken: UInt64?
    public let coinsCashTaken: UInt32?
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// ПЛАТЕЖ КАРТОЙ
    /// billsCardhSum и coinsCardSum - это сколько покупатель заплатил картой
    public let isCard: Bool
    public let billsCardSum: UInt64?
    public let coinsCardSum: UInt32?
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// ПЛАТЕЖ QR КОДОМ
    /// Например если платеж был Kaspi QR или Halyk QR
    /// billsMobileSum и coinsMobileSum - это сколько покупатель заплатил QR платежем
    public let isMobile: Bool
    public let billsMobileSum: UInt64?
    public let coinsMobileSum: UInt32?
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// НАЛОГ НА ВЕСЬ ЧЕК
    /// Налог должен быть один либо на весь чек, либо на каждый item в ticket, если
    /// true, то передавать налог на каждый item нельзя
    /// tax - какой процент НДС. НДС может быть только двух видов, либо 0(0%), либо 12000(12%)
    /// billsTax - это целые тенге
    /// coinsTax - это тиыны указываются до 99
    public let isTicketAllTax: Bool
    public let tax: UInt32?
    public let billsTax: UInt64?
    public let coinsTax: UInt32?
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// СКИДКА НА ВЕСЬ ЧЕК
    /// Заполняем только в случае, если мы сделали скидку на весь чек, если
    /// скиндка есть, то наценку делать нельзя
    /// discountName - можно указать название скидки если есть, например "АКЦИЯ - 10%"\
    /// billsDiscount и coinsDiscount - сумма скидки в деньгах, например 500,00 тенге
    public let isTicketAllDiscount: Bool
    public let discountName: String?
    public let billsDiscount: UInt64?
    public let coinsDiscount: UInt32?
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// ИТОГИ ЧЕКА
    /// Тут нужно заполнить итоговые суммы по чеку
    /// billsTotal и coinsTotal - это общая сумма всего ticket(чека), используется для проверки
    /// внутри библиотеки
    public let billsTotal: UInt64
    public let coinsTotal: UInt32
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// ИНФОРМАЦИЯ О ПОКУПАТЕЛЕ
    /// Тут нужно заполнить информацию о покупателе если она указывается
    /// iinOrBin, phone, email - ИИН или БИН, телефон, почтовый ящик покупателя
    public let isCustomer: Bool
    public let iinOrBin: String?
    public let phone: String?
    public let email: String?
    /// -------------------------------------------------------------------------------------------
    
    public let ticketItems: [TicketItem]
    
    public init(isTicketOnline: Bool,
         offlineTicketNumber: UInt32?,
         offlinePeriodBeginYear: UInt32?,
         offlinePeriodBeginMonth: UInt32?,
         offlinePeriodBeginDay: UInt32?,
         offlinePeriodBeginHour: UInt32?,
         offlinePeriodBeginMinute: UInt32?,
         offlinePeriodBeginSecond: UInt32?,
         offlinePeriodEndYear: UInt32?,
         offlinePeriodEndMonth: UInt32?,
         offlinePeriodEndDay: UInt32?,
         offlinePeriodEndHour: UInt32?,
         offlinePeriodEndMinute: UInt32?,
         offlinePeriodEndSecond: UInt32?,
         kgdId: String,
         kkmOfdId: String,
         kkmSerialNumber: String,
         title: String,
         address: String,
         iinOrBinOrg: String,
         oked: String,
         frShiftNumber: UInt32,
         operation: UInt, year: UInt32, month: UInt32, day: UInt32, hour: UInt32, minute: UInt32, second: UInt32,
         codeOperator: UInt32, nameOperator: String,
         isCash: Bool, billsCashSum: UInt64?, coinsCashSum: UInt32?, billsCashTaken: UInt64?, coinsCashTaken: UInt32?,
         isCard: Bool, billsCardSum: UInt64?, coinsCardSum: UInt32?,
         isMobile: Bool, billsMobileSum: UInt64?, coinsMobileSum: UInt32?,
         isTicketAllTax: Bool, tax: UInt32?, billsTax: UInt64?, coinsTax: UInt32?,
         isTicketAllDiscount: Bool, discountName: String?, billsDiscount: UInt64?, coinsDiscount: UInt32?, billsTotal: UInt64, coinsTotal: UInt32,
         isCustomer: Bool, iinOrBin: String?, phone: String?, email: String?, ticketItems: [TicketItem]) throws {
        
        self.isTicketOnline = isTicketOnline
        
        // Проверка: если чек в оффлайн(автономномном) режиме, должен быть указан offlineTicketNumber
        if !isTicketOnline {
            guard let offlineNumber = offlineTicketNumber else {
                throw NSError(domain: "TicketInitialization", code: 1, userInfo: [NSLocalizedDescriptionKey: "Для оффлайн чека необходимо указать offlineTicketNumber"])
            }
            
            guard let offlinePeriodBeginYear = offlinePeriodBeginYear, let offlinePeriodBeginMonth = offlinePeriodBeginMonth, let offlinePeriodBeginDay = offlinePeriodBeginDay, let offlinePeriodBeginHour = offlinePeriodBeginHour, let offlinePeriodBeginMinute = offlinePeriodBeginMinute, let offlinePeriodBeginSecond = offlinePeriodBeginSecond else {
                throw NSError(domain: "TicketInitialization", code: 2, userInfo: [NSLocalizedDescriptionKey: "Для оффлайн чека необходимо заполнить все переменные начала оффлайн(автономного) режима offlinePeriodBegin"])
            }
            
            guard let offlinePeriodEndYear = offlinePeriodEndYear, let offlinePeriodEndMonth = offlinePeriodEndMonth, let offlinePeriodEndDay = offlinePeriodEndDay, let offlinePeriodEndHour = offlinePeriodEndHour, let offlinePeriodEndMinute = offlinePeriodEndMinute, let offlinePeriodEndSecond = offlinePeriodEndSecond else {
                throw NSError(domain: "TicketInitialization", code: 3, userInfo: [NSLocalizedDescriptionKey: "Для оффлайн чека необходимо заполнить все переменные завершения оффлайн(автономного) режима offlinePeriodEnd"])
            }
            
            self.offlineTicketNumber = offlineNumber
            
            self.offlinePeriodBeginYear = offlinePeriodBeginYear
            self.offlinePeriodBeginMonth = offlinePeriodBeginMonth
            self.offlinePeriodBeginDay = offlinePeriodBeginDay
            self.offlinePeriodBeginHour = offlinePeriodBeginHour
            self.offlinePeriodBeginMinute = offlinePeriodBeginMinute
            self.offlinePeriodBeginSecond = offlinePeriodBeginSecond

            self.offlinePeriodEndYear = offlinePeriodEndYear
            self.offlinePeriodEndMonth = offlinePeriodEndMonth
            self.offlinePeriodEndDay = offlinePeriodEndDay
            self.offlinePeriodEndHour = offlinePeriodEndHour
            self.offlinePeriodEndMinute = offlinePeriodEndMinute
            self.offlinePeriodEndSecond = offlinePeriodEndSecond
        } else {
            self.offlineTicketNumber = nil
            
            self.offlinePeriodBeginYear = 0
            self.offlinePeriodBeginMonth = 0
            self.offlinePeriodBeginDay = 0
            self.offlinePeriodBeginHour = 0
            self.offlinePeriodBeginMinute = 0
            self.offlinePeriodBeginSecond = 0
            
            self.offlinePeriodEndYear = 0
            self.offlinePeriodEndMonth = 0
            self.offlinePeriodEndDay = 0
            self.offlinePeriodEndHour = 0
            self.offlinePeriodEndMinute = 0
            self.offlinePeriodEndSecond = 0
        }
        
        self.kgdId = kgdId
        self.kkmOfdId = kkmOfdId
        self.kkmSerialNumber = kkmSerialNumber
        self.title = title
        self.address = address
        self.iinOrBinOrg = iinOrBinOrg
        self.oked = oked
        self.frShiftNumber = frShiftNumber
        self.operation = operation
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second
        self.codeOperator = codeOperator
        self.nameOperator = nameOperator
        
        self.isCash = isCash
        // Проверка: если в чеке есть наличные деньги
        if isCash {
            guard let billsCashSum = billsCashSum,
                  let coinsCashSum = coinsCashSum,
                  let billsCashTaken = billsCashTaken,
                  let coinsCashTaken = coinsCashTaken else {
                throw NSError(domain: "TicketInitialization", code: 2, userInfo: [NSLocalizedDescriptionKey: "Если в чеке есть наличные деньги, обязательно нужно заполнять какая сумма оплаты наличными деньгами и сколько покупатель дал наличных денег"])
            }
            
            self.billsCashSum = billsCashSum
            self.coinsCashSum = coinsCashSum
            self.billsCashTaken = billsCashTaken
            self.coinsCashTaken = coinsCashTaken
        } else {
            self.billsCashSum = nil
            self.coinsCashSum = nil
            self.billsCashTaken = nil
            self.coinsCashTaken = nil
        }
        
        self.isCard = isCard
        // Проверка: если в чеке есть оплата картой
        if isCard {
            guard let billsCardSum = billsCardSum,
                  let coinsCardSum = coinsCardSum else {
                throw NSError(domain: "TicketInitialization", code: 3, userInfo: [NSLocalizedDescriptionKey: "Если в чеке есть оплата картой, обязательно нужно заполнять суммы, оплаченные картой (billsCardhSum и coinsCardSum)"])
            }
            
            // Присваиваем значения, если они успешно извлечены
            self.billsCardSum = billsCardSum
            self.coinsCardSum = coinsCardSum
        } else {
            // Если нет оплаты картой, устанавливаем значения в nil
            self.billsCardSum = nil
            self.coinsCardSum = nil
        }
        
        self.isMobile = isMobile
        // Проверка: если в чеке есть мобильная оплата (QR)
        if isMobile {
            guard let billsMobileSum = billsMobileSum,
                  let coinsMobileSum = coinsMobileSum else {
                throw NSError(domain: "TicketInitialization", code: 4, userInfo: [NSLocalizedDescriptionKey: "Если в чеке есть мобильная оплата (QR), обязательно нужно заполнять суммы, оплаченные мобильным платежом (billsMobileSum и coinsMobileSum)"])
            }
            
            // Присваиваем значения, если они успешно извлечены
            self.billsMobileSum = billsMobileSum
            self.coinsMobileSum = coinsMobileSum
        } else {
            // Если нет мобильной оплаты, устанавливаем значения в nil
            self.billsMobileSum = nil
            self.coinsMobileSum = nil
        }
        
        self.isTicketAllTax = isTicketAllTax
        // Проверка: если налог на весь чек (isTicketAllTax)
        if isTicketAllTax {
            guard let tax = tax,
                  let billsTax = billsTax,
                  let coinsTax = coinsTax else {
                throw NSError(domain: "TicketInitialization", code: 5, userInfo: [NSLocalizedDescriptionKey: "Если налог на весь чек (isTicketAllTax), обязательно нужно заполнять tax, billsTax и coinsTax"])
            }
            
            // Присваиваем значения, если они успешно извлечены
            self.tax = tax
            self.billsTax = billsTax
            self.coinsTax = coinsTax
        } else {
            // Если налог на весь чек не используется, устанавливаем значения в nil
            self.tax = nil
            self.billsTax = nil
            self.coinsTax = nil
        }
        
        self.isTicketAllDiscount = isTicketAllDiscount
        // Проверка: если скидка на весь чек (isTicketAllDiscount)
        if isTicketAllDiscount {
            guard let discountName = discountName,
                  let billsDiscount = billsDiscount,
                  let coinsDiscount = coinsDiscount else {
                throw NSError(domain: "TicketInitialization", code: 6, userInfo: [NSLocalizedDescriptionKey: "Если скидка на весь чек (isTicketAllDiscount), обязательно нужно заполнять discountName, billsDiscount и coinsDiscount"])
            }
            
            // Присваиваем значения, если они успешно извлечены
            self.discountName = discountName
            self.billsDiscount = billsDiscount
            self.coinsDiscount = coinsDiscount
        } else {
            // Если скидка на весь чек не используется, устанавливаем значения в nil
            self.discountName = nil
            self.billsDiscount = nil
            self.coinsDiscount = nil
        }
        
        self.billsTotal = billsTotal
        self.coinsTotal = coinsTotal
        
        self.isCustomer = isCustomer
        // Проверка: если указано, что есть информация о покупателе (isCustomer)
        if isCustomer {
            guard iinOrBin != nil || phone != nil || email != nil else {
                throw NSError(domain: "TicketInitialization", code: 7, userInfo: [NSLocalizedDescriptionKey: "Если указано, что есть информация о покупателе (isCustomer), обязательно нужно заполнить хотя бы одно из полей: iinOrBin, phone или email"])
            }
            
            // Присваиваем значения, если хотя бы одно из них не nil
            self.iinOrBin = iinOrBin
            self.phone = phone
            self.email = email
        } else {
            // Если нет информации о покупателе, устанавливаем значения в nil
            self.iinOrBin = nil
            self.phone = nil
            self.email = nil
        }
        
        self.ticketItems = ticketItems
    }
}
