// DO NOT EDIT.
// swift-format-ignore-file
// swiftlint:disable all
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: common.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

enum Kkm_Proto_DomainTypeEnum: SwiftProtobuf.Enum, Swift.CaseIterable {
  typealias RawValue = Int
  case domainTrading // = 0
  case domainServices // = 1
  case domainGasoil // = 2
  case domainHotels // = 3
  case domainTaxi // = 4
  case domainParking // = 5

  init() {
    self = .domainTrading
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .domainTrading
    case 1: self = .domainServices
    case 2: self = .domainGasoil
    case 3: self = .domainHotels
    case 4: self = .domainTaxi
    case 5: self = .domainParking
    default: return nil
    }
  }

  var rawValue: Int {
    switch self {
    case .domainTrading: return 0
    case .domainServices: return 1
    case .domainGasoil: return 2
    case .domainHotels: return 3
    case .domainTaxi: return 4
    case .domainParking: return 5
    }
  }

}

enum Kkm_Proto_OperationTypeEnum: SwiftProtobuf.Enum, Swift.CaseIterable {
  typealias RawValue = Int
  case operationBuy // = 0
  case operationBuyReturn // = 1
  case operationSell // = 2
  case operationSellReturn // = 3

  init() {
    self = .operationBuy
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .operationBuy
    case 1: self = .operationBuyReturn
    case 2: self = .operationSell
    case 3: self = .operationSellReturn
    default: return nil
    }
  }

  var rawValue: Int {
    switch self {
    case .operationBuy: return 0
    case .operationBuyReturn: return 1
    case .operationSell: return 2
    case .operationSellReturn: return 3
    }
  }

}

enum Kkm_Proto_PaymentTypeEnum: SwiftProtobuf.Enum, Swift.CaseIterable {
  typealias RawValue = Int
  case paymentCash // = 0
  case paymentCard // = 1
  case paymentCredit // = 2
  case paymentTare // = 3
  case paymentMobile // = 4

  init() {
    self = .paymentCash
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .paymentCash
    case 1: self = .paymentCard
    case 2: self = .paymentCredit
    case 3: self = .paymentTare
    case 4: self = .paymentMobile
    default: return nil
    }
  }

  var rawValue: Int {
    switch self {
    case .paymentCash: return 0
    case .paymentCard: return 1
    case .paymentCredit: return 2
    case .paymentTare: return 3
    case .paymentMobile: return 4
    }
  }

}

enum Kkm_Proto_UserRoleEnum: SwiftProtobuf.Enum, Swift.CaseIterable {
  typealias RawValue = Int

  /// Paymaster role
  case userRolePaymaster // = 1

  /// Chief paymaster role
  case userRoleChiefPaymaster // = 2

  /// Administrator role
  case userRoleAdministrator // = 3

  init() {
    self = .userRolePaymaster
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 1: self = .userRolePaymaster
    case 2: self = .userRoleChiefPaymaster
    case 3: self = .userRoleAdministrator
    default: return nil
    }
  }

  var rawValue: Int {
    switch self {
    case .userRolePaymaster: return 1
    case .userRoleChiefPaymaster: return 2
    case .userRoleAdministrator: return 3
    }
  }

}

enum Kkm_Proto_TicketAdTypeEnum: SwiftProtobuf.Enum, Swift.CaseIterable {
  typealias RawValue = Int
  case ticketAdOfd // = 0
  case ticketAdOrg // = 1
  case ticketAdPos // = 2
  case ticketAdKkm // = 3
  case ticketAdInfo // = 4

  init() {
    self = .ticketAdOfd
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .ticketAdOfd
    case 1: self = .ticketAdOrg
    case 2: self = .ticketAdPos
    case 3: self = .ticketAdKkm
    case 4: self = .ticketAdInfo
    default: return nil
    }
  }

  var rawValue: Int {
    switch self {
    case .ticketAdOfd: return 0
    case .ticketAdOrg: return 1
    case .ticketAdPos: return 2
    case .ticketAdKkm: return 3
    case .ticketAdInfo: return 4
    }
  }

}

///*
/// @brief Дата.
/// 
/// Структура, описывающая дату по григорианскому календарю.
struct Kkm_Proto_Date: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  //// Год в четырехзначном представлении, например: 2013.
  var year: UInt32 {
    get {return _year ?? 0}
    set {_year = newValue}
  }
  /// Returns true if `year` has been explicitly set.
  var hasYear: Bool {return self._year != nil}
  /// Clears the value of `year`. Subsequent reads from it will return its default value.
  mutating func clearYear() {self._year = nil}

  //// Месяц года в диапазоне 1-12.
  var month: UInt32 {
    get {return _month ?? 0}
    set {_month = newValue}
  }
  /// Returns true if `month` has been explicitly set.
  var hasMonth: Bool {return self._month != nil}
  /// Clears the value of `month`. Subsequent reads from it will return its default value.
  mutating func clearMonth() {self._month = nil}

  //// День месяца.
  var day: UInt32 {
    get {return _day ?? 0}
    set {_day = newValue}
  }
  /// Returns true if `day` has been explicitly set.
  var hasDay: Bool {return self._day != nil}
  /// Clears the value of `day`. Subsequent reads from it will return its default value.
  mutating func clearDay() {self._day = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _year: UInt32? = nil
  fileprivate var _month: UInt32? = nil
  fileprivate var _day: UInt32? = nil
}

///*
/// @brief Время.
/// 
/// Структура, описывающая время суток.
struct Kkm_Proto_Time: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  //// Час суток в диапазоне 0-23.
  var hour: UInt32 {
    get {return _hour ?? 0}
    set {_hour = newValue}
  }
  /// Returns true if `hour` has been explicitly set.
  var hasHour: Bool {return self._hour != nil}
  /// Clears the value of `hour`. Subsequent reads from it will return its default value.
  mutating func clearHour() {self._hour = nil}

  //// Минута часа в диапазоне 0-59.
  var minute: UInt32 {
    get {return _minute ?? 0}
    set {_minute = newValue}
  }
  /// Returns true if `minute` has been explicitly set.
  var hasMinute: Bool {return self._minute != nil}
  /// Clears the value of `minute`. Subsequent reads from it will return its default value.
  mutating func clearMinute() {self._minute = nil}

  //// Секунда в диапазоне 0-59.
  var second: UInt32 {
    get {return _second ?? 0}
    set {_second = newValue}
  }
  /// Returns true if `second` has been explicitly set.
  var hasSecond: Bool {return self._second != nil}
  /// Clears the value of `second`. Subsequent reads from it will return its default value.
  mutating func clearSecond() {self._second = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _hour: UInt32? = nil
  fileprivate var _minute: UInt32? = nil
  fileprivate var _second: UInt32? = nil
}

///*
/// @brief Дата и время.
/// 
/// Структура, описывающая момент времени.
struct Kkm_Proto_DateTime: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  //// Дата.
  var date: Kkm_Proto_Date {
    get {return _date ?? Kkm_Proto_Date()}
    set {_date = newValue}
  }
  /// Returns true if `date` has been explicitly set.
  var hasDate: Bool {return self._date != nil}
  /// Clears the value of `date`. Subsequent reads from it will return its default value.
  mutating func clearDate() {self._date = nil}

  //// Время.
  var time: Kkm_Proto_Time {
    get {return _time ?? Kkm_Proto_Time()}
    set {_time = newValue}
  }
  /// Returns true if `time` has been explicitly set.
  var hasTime: Bool {return self._time != nil}
  /// Clears the value of `time`. Subsequent reads from it will return its default value.
  mutating func clearTime() {self._time = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _date: Kkm_Proto_Date? = nil
  fileprivate var _time: Kkm_Proto_Time? = nil
}

///*
/// @brief Деньги.
/// 
/// Структура, описывающая деньги.
struct Kkm_Proto_Money: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  //// "Купюры".
  ////
  //// Количество основных денежных единиц базовой валюты, например: 230 рублей.
  var bills: UInt64 {
    get {return _bills ?? 0}
    set {_bills = newValue}
  }
  /// Returns true if `bills` has been explicitly set.
  var hasBills: Bool {return self._bills != nil}
  /// Clears the value of `bills`. Subsequent reads from it will return its default value.
  mutating func clearBills() {self._bills = nil}

  //// "Монеты".
  ////
  //// Количество разменных денежных единиц, например: 43 копейки.
  var coins: UInt32 {
    get {return _coins ?? 0}
    set {_coins = newValue}
  }
  /// Returns true if `coins` has been explicitly set.
  var hasCoins: Bool {return self._coins != nil}
  /// Clears the value of `coins`. Subsequent reads from it will return its default value.
  mutating func clearCoins() {self._coins = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _bills: UInt64? = nil
  fileprivate var _coins: UInt32? = nil
}

struct Kkm_Proto_Operator: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var code: UInt32 {
    get {return _code ?? 0}
    set {_code = newValue}
  }
  /// Returns true if `code` has been explicitly set.
  var hasCode: Bool {return self._code != nil}
  /// Clears the value of `code`. Subsequent reads from it will return its default value.
  mutating func clearCode() {self._code = nil}

  var name: String {
    get {return _name ?? String()}
    set {_name = newValue}
  }
  /// Returns true if `name` has been explicitly set.
  var hasName: Bool {return self._name != nil}
  /// Clears the value of `name`. Subsequent reads from it will return its default value.
  mutating func clearName() {self._name = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _code: UInt32? = nil
  fileprivate var _name: String? = nil
}

struct Kkm_Proto_TicketAdInfo: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var type: Kkm_Proto_TicketAdTypeEnum {
    get {return _type ?? .ticketAdOfd}
    set {_type = newValue}
  }
  /// Returns true if `type` has been explicitly set.
  var hasType: Bool {return self._type != nil}
  /// Clears the value of `type`. Subsequent reads from it will return its default value.
  mutating func clearType() {self._type = nil}

  var version: UInt64 {
    get {return _version ?? 0}
    set {_version = newValue}
  }
  /// Returns true if `version` has been explicitly set.
  var hasVersion: Bool {return self._version != nil}
  /// Clears the value of `version`. Subsequent reads from it will return its default value.
  mutating func clearVersion() {self._version = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _type: Kkm_Proto_TicketAdTypeEnum? = nil
  fileprivate var _version: UInt64? = nil
}

struct Kkm_Proto_TicketAd: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var info: Kkm_Proto_TicketAdInfo {
    get {return _info ?? Kkm_Proto_TicketAdInfo()}
    set {_info = newValue}
  }
  /// Returns true if `info` has been explicitly set.
  var hasInfo: Bool {return self._info != nil}
  /// Clears the value of `info`. Subsequent reads from it will return its default value.
  mutating func clearInfo() {self._info = nil}

  var text: String {
    get {return _text ?? String()}
    set {_text = newValue}
  }
  /// Returns true if `text` has been explicitly set.
  var hasText: Bool {return self._text != nil}
  /// Clears the value of `text`. Subsequent reads from it will return its default value.
  mutating func clearText() {self._text = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _info: Kkm_Proto_TicketAdInfo? = nil
  fileprivate var _text: String? = nil
}

struct Kkm_Proto_KeyValuePair: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var key: String {
    get {return _key ?? String()}
    set {_key = newValue}
  }
  /// Returns true if `key` has been explicitly set.
  var hasKey: Bool {return self._key != nil}
  /// Clears the value of `key`. Subsequent reads from it will return its default value.
  mutating func clearKey() {self._key = nil}

  var value: String {
    get {return _value ?? String()}
    set {_value = newValue}
  }
  /// Returns true if `value` has been explicitly set.
  var hasValue: Bool {return self._value != nil}
  /// Clears the value of `value`. Subsequent reads from it will return its default value.
  mutating func clearValue() {self._value = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _key: String? = nil
  fileprivate var _value: String? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "kkm.proto"

extension Kkm_Proto_DomainTypeEnum: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "DOMAIN_TRADING"),
    1: .same(proto: "DOMAIN_SERVICES"),
    2: .same(proto: "DOMAIN_GASOIL"),
    3: .same(proto: "DOMAIN_HOTELS"),
    4: .same(proto: "DOMAIN_TAXI"),
    5: .same(proto: "DOMAIN_PARKING"),
  ]
}

extension Kkm_Proto_OperationTypeEnum: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "OPERATION_BUY"),
    1: .same(proto: "OPERATION_BUY_RETURN"),
    2: .same(proto: "OPERATION_SELL"),
    3: .same(proto: "OPERATION_SELL_RETURN"),
  ]
}

extension Kkm_Proto_PaymentTypeEnum: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "PAYMENT_CASH"),
    1: .same(proto: "PAYMENT_CARD"),
    2: .same(proto: "PAYMENT_CREDIT"),
    3: .same(proto: "PAYMENT_TARE"),
    4: .same(proto: "PAYMENT_MOBILE"),
  ]
}

extension Kkm_Proto_UserRoleEnum: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "USER_ROLE_PAYMASTER"),
    2: .same(proto: "USER_ROLE_CHIEF_PAYMASTER"),
    3: .same(proto: "USER_ROLE_ADMINISTRATOR"),
  ]
}

extension Kkm_Proto_TicketAdTypeEnum: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "TICKET_AD_OFD"),
    1: .same(proto: "TICKET_AD_ORG"),
    2: .same(proto: "TICKET_AD_POS"),
    3: .same(proto: "TICKET_AD_KKM"),
    4: .same(proto: "TICKET_AD_INFO"),
  ]
}

extension Kkm_Proto_Date: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Date"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "year"),
    2: .same(proto: "month"),
    3: .same(proto: "day"),
  ]

  public var isInitialized: Bool {
    if self._year == nil {return false}
    if self._month == nil {return false}
    if self._day == nil {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt32Field(value: &self._year) }()
      case 2: try { try decoder.decodeSingularUInt32Field(value: &self._month) }()
      case 3: try { try decoder.decodeSingularUInt32Field(value: &self._day) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._year {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._month {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._day {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 3)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_Date, rhs: Kkm_Proto_Date) -> Bool {
    if lhs._year != rhs._year {return false}
    if lhs._month != rhs._month {return false}
    if lhs._day != rhs._day {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_Proto_Time: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Time"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "hour"),
    2: .same(proto: "minute"),
    3: .same(proto: "second"),
  ]

  public var isInitialized: Bool {
    if self._hour == nil {return false}
    if self._minute == nil {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt32Field(value: &self._hour) }()
      case 2: try { try decoder.decodeSingularUInt32Field(value: &self._minute) }()
      case 3: try { try decoder.decodeSingularUInt32Field(value: &self._second) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._hour {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._minute {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._second {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 3)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_Time, rhs: Kkm_Proto_Time) -> Bool {
    if lhs._hour != rhs._hour {return false}
    if lhs._minute != rhs._minute {return false}
    if lhs._second != rhs._second {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_Proto_DateTime: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".DateTime"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "date"),
    2: .same(proto: "time"),
  ]

  public var isInitialized: Bool {
    if self._date == nil {return false}
    if self._time == nil {return false}
    if let v = self._date, !v.isInitialized {return false}
    if let v = self._time, !v.isInitialized {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._date) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._time) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._date {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._time {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_DateTime, rhs: Kkm_Proto_DateTime) -> Bool {
    if lhs._date != rhs._date {return false}
    if lhs._time != rhs._time {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_Proto_Money: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Money"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "bills"),
    2: .same(proto: "coins"),
  ]

  public var isInitialized: Bool {
    if self._bills == nil {return false}
    if self._coins == nil {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt64Field(value: &self._bills) }()
      case 2: try { try decoder.decodeSingularUInt32Field(value: &self._coins) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._bills {
      try visitor.visitSingularUInt64Field(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._coins {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_Money, rhs: Kkm_Proto_Money) -> Bool {
    if lhs._bills != rhs._bills {return false}
    if lhs._coins != rhs._coins {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_Proto_Operator: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Operator"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "code"),
    2: .same(proto: "name"),
  ]

  public var isInitialized: Bool {
    if self._code == nil {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt32Field(value: &self._code) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._name) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._code {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._name {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_Operator, rhs: Kkm_Proto_Operator) -> Bool {
    if lhs._code != rhs._code {return false}
    if lhs._name != rhs._name {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_Proto_TicketAdInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".TicketAdInfo"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "type"),
    2: .same(proto: "version"),
  ]

  public var isInitialized: Bool {
    if self._type == nil {return false}
    if self._version == nil {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularEnumField(value: &self._type) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self._version) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._type {
      try visitor.visitSingularEnumField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._version {
      try visitor.visitSingularUInt64Field(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_TicketAdInfo, rhs: Kkm_Proto_TicketAdInfo) -> Bool {
    if lhs._type != rhs._type {return false}
    if lhs._version != rhs._version {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_Proto_TicketAd: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".TicketAd"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "info"),
    2: .same(proto: "text"),
  ]

  public var isInitialized: Bool {
    if self._info == nil {return false}
    if self._text == nil {return false}
    if let v = self._info, !v.isInitialized {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._info) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._text) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._info {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._text {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_TicketAd, rhs: Kkm_Proto_TicketAd) -> Bool {
    if lhs._info != rhs._info {return false}
    if lhs._text != rhs._text {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_Proto_KeyValuePair: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".KeyValuePair"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "key"),
    2: .same(proto: "value"),
  ]

  public var isInitialized: Bool {
    if self._key == nil {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self._key) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._value) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._key {
      try visitor.visitSingularStringField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._value {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_KeyValuePair, rhs: Kkm_Proto_KeyValuePair) -> Bool {
    if lhs._key != rhs._key {return false}
    if lhs._value != rhs._value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
