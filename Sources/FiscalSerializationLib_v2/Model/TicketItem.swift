//
//  Item.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 23.10.2024.
//

import Foundation

struct TicketItem {
    /// -------------------------------------------------------------------------------------------
    /// НАЗВАНИЕ ТОВАРА/РАБОТЫ/УСЛУГИ
    /// Заполняется обязательно, не может быть пустым или с пробелами
    let nameTicketItem: String
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// КОД СЕКЦИИ
    /// Код секции это специальный код виртуального пространства в котором происходят операции
    /// Например заправки по коду секции отличают какое топливо они реализуют, прям так и называют АИ-92 и т.д.
    let sectionCode: String
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// КОЛИЧЕСТВО ТОВАРА/УСЛУГ/РАБОТ
    /// Заполняется в тысячник долях, например 1 = 1000 и т.д.
    let quantity: UInt32
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// Еденица измерения
    /// Согласно требованиям нужно использовать справочник едениц измерения ЭСФ(я не понимаю зачем...)
    /// Для удобства я сделал свой собственный, можете выбирать из этого Enum
    let measureUnitCode: UnitOfMeasurement
    /// -------------------------------------------------------------------------------------------

    /// -------------------------------------------------------------------------------------------
    /// ЦЕНА ОДНОЙ ЕДЕНИЦЫ ТОВАРА/РАБОТЫ/УСЛУГИ
    /// billsPrice и coinsPrice - это тенге и тиыны
    let billsPrice: UInt64
    let coinsPrice: UInt32
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// НАЛОГ НА ПОЗИЦИЮ
    /// Налог на позицию делать нельзя, если есть уже налог на весь чек
    /// Если вы хотите сделать налог на позицию, то нужно будет проставлять налог на каждую позицию в чеке
    /// tax - какой процент НДС. НДС может быть только двух видов, либо 0(0%), либо 12000(12%)
    /// billsTax - это целые тенге
    /// coinsTax - это тиыны указываются до 99
    let isTicketItemTax: Bool
    let tax: UInt32?
    let billsTax: UInt64?
    let coinsTax: UInt32?
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// СКИДКА НА ПОЗИЦИЮ
    /// Заполняем только в случае, если мы сделали скидку на позицию, если
    /// скиндка есть
    /// discountName - можно указать название скидки если есть, например "АКЦИЯ - 10%"\
    /// billsDiscount и coinsDiscount - сумма скидки в деньгах, например 500,00 тенге
    let isTicketItemDiscount: Bool
    let discountName: String?
    let billsDiscount: UInt64?
    let coinsDiscount: UInt32?
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// КОД МАРКИРОВКИ
    /// Заполняем если товар маркирован DataMatrix кодом, этот код передается в систему Маркировки
    let dataMatrix: String?
    /// -------------------------------------------------------------------------------------------
    
    /// -------------------------------------------------------------------------------------------
    /// ШТРИХКОД ТОВАРА/УСЛУГИ/РАБОТЫ
    /// EAN8 или EAN13 штрихкод товара
    let barcode: String?
    /// -------------------------------------------------------------------------------------------
    
    init(nameTicketItem: String, sectionCode: String, quantity: UInt32, measureUnitCode: UnitOfMeasurement, billsPrice: UInt64, coinsPrice: UInt32, isTicketItemTax: Bool, tax: UInt32?, billsTax: UInt64?, coinsTax: UInt32?, isTicketItemDiscount: Bool, discountName: String?, billsDiscount: UInt64?, coinsDiscount: UInt32?, dataMatrix: String?, barcode: String?) throws {

        self.nameTicketItem = nameTicketItem
        self.sectionCode = sectionCode
        self.quantity = quantity
        self.measureUnitCode = measureUnitCode
        self.billsPrice = billsPrice
        self.coinsPrice = coinsPrice
        
        self.isTicketItemTax = isTicketItemTax
        // Проверка: если налог на весь чек (isTicketAllTax)
        if isTicketItemTax {
            guard let tax = tax,
                  let billsTax = billsTax,
                  let coinsTax = coinsTax else {
                throw NSError(domain: "TicketInitialization", code: 1, userInfo: [NSLocalizedDescriptionKey: "Если налог на позицию (isTicketItemTax), обязательно нужно заполнять tax, billsTax и coinsTax"])
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
        
        self.isTicketItemDiscount = isTicketItemDiscount
        // Проверка: если скидка на позицию (isTicketItemDiscount)
        if isTicketItemDiscount {
            guard let discountName = discountName,
                  let billsDiscount = billsDiscount,
                  let coinsDiscount = coinsDiscount else {
                throw NSError(domain: "TicketInitialization", code: 2, userInfo: [NSLocalizedDescriptionKey: "Если скидка на позицию (isTicketItemDiscount), обязательно нужно заполнять discountName, billsDiscount и coinsDiscount"])
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
        
        self.dataMatrix = dataMatrix
        self.barcode = barcode
        
    }
}
