// DO NOT EDIT.
// swift-format-ignore-file
// swiftlint:disable all
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: reginfo.proto
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

///*
/// @brief Дополнительная информация по ккт - регистрационные данные.
struct Kkm_Proto_KkmRegInfo: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  ////Регистрационный номер (код) точки приема платежей
  var pointOfPaymentNumber: String {
    get {return _pointOfPaymentNumber ?? String()}
    set {_pointOfPaymentNumber = newValue}
  }
  /// Returns true if `pointOfPaymentNumber` has been explicitly set.
  var hasPointOfPaymentNumber: Bool {return self._pointOfPaymentNumber != nil}
  /// Clears the value of `pointOfPaymentNumber`. Subsequent reads from it will return its default value.
  mutating func clearPointOfPaymentNumber() {self._pointOfPaymentNumber = nil}

  ////Номер платежного терминала
  var terminalNumber: String {
    get {return _terminalNumber ?? String()}
    set {_terminalNumber = newValue}
  }
  /// Returns true if `terminalNumber` has been explicitly set.
  var hasTerminalNumber: Bool {return self._terminalNumber != nil}
  /// Clears the value of `terminalNumber`. Subsequent reads from it will return its default value.
  mutating func clearTerminalNumber() {self._terminalNumber = nil}

  ////ID, выданный КГД
  var fnsKkmID: String {
    get {return _fnsKkmID ?? String()}
    set {_fnsKkmID = newValue}
  }
  /// Returns true if `fnsKkmID` has been explicitly set.
  var hasFnsKkmID: Bool {return self._fnsKkmID != nil}
  /// Clears the value of `fnsKkmID`. Subsequent reads from it will return its default value.
  mutating func clearFnsKkmID() {self._fnsKkmID = nil}

  //// Заводской номер ККМ
  var serialNumber: String {
    get {return _serialNumber ?? String()}
    set {_serialNumber = newValue}
  }
  /// Returns true if `serialNumber` has been explicitly set.
  var hasSerialNumber: Bool {return self._serialNumber != nil}
  /// Clears the value of `serialNumber`. Subsequent reads from it will return its default value.
  mutating func clearSerialNumber() {self._serialNumber = nil}

  //// Внутренний идентификатор начиная с версии 125
  var kkmID: String {
    get {return _kkmID ?? String()}
    set {_kkmID = newValue}
  }
  /// Returns true if `kkmID` has been explicitly set.
  var hasKkmID: Bool {return self._kkmID != nil}
  /// Clears the value of `kkmID`. Subsequent reads from it will return its default value.
  mutating func clearKkmID() {self._kkmID = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _pointOfPaymentNumber: String? = nil
  fileprivate var _terminalNumber: String? = nil
  fileprivate var _fnsKkmID: String? = nil
  fileprivate var _serialNumber: String? = nil
  fileprivate var _kkmID: String? = nil
}

///*
/// @brief Дополнительная информация по торговой точке - регистрационные данные.
struct Kkm_Proto_PosRegInfo: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  //// Название торговой точки
  var title: String {
    get {return _title ?? String()}
    set {_title = newValue}
  }
  /// Returns true if `title` has been explicitly set.
  var hasTitle: Bool {return self._title != nil}
  /// Clears the value of `title`. Subsequent reads from it will return its default value.
  mutating func clearTitle() {self._title = nil}

  //// Адрес торговой точки
  var address: String {
    get {return _address ?? String()}
    set {_address = newValue}
  }
  /// Returns true if `address` has been explicitly set.
  var hasAddress: Bool {return self._address != nil}
  /// Clears the value of `address`. Subsequent reads from it will return its default value.
  mutating func clearAddress() {self._address = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _title: String? = nil
  fileprivate var _address: String? = nil
}

///*
/// @brief Дополнительная информация по организации - регистрационные данные.
struct Kkm_Proto_OrgRegInfo: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  //// Название организации или ФИО индивидуального предпринимателя
  var title: String {
    get {return _title ?? String()}
    set {_title = newValue}
  }
  /// Returns true if `title` has been explicitly set.
  var hasTitle: Bool {return self._title != nil}
  /// Clears the value of `title`. Subsequent reads from it will return its default value.
  mutating func clearTitle() {self._title = nil}

  ////  Юр. адрес
  var address: String {
    get {return _address ?? String()}
    set {_address = newValue}
  }
  /// Returns true if `address` has been explicitly set.
  var hasAddress: Bool {return self._address != nil}
  /// Clears the value of `address`. Subsequent reads from it will return its default value.
  mutating func clearAddress() {self._address = nil}

  //// ИИН/БИН
  var inn: String {
    get {return _inn ?? String()}
    set {_inn = newValue}
  }
  /// Returns true if `inn` has been explicitly set.
  var hasInn: Bool {return self._inn != nil}
  /// Clears the value of `inn`. Subsequent reads from it will return its default value.
  mutating func clearInn() {self._inn = nil}

  //// Вид налогообложения
  var taxationType: UInt32 {
    get {return _taxationType ?? 0}
    set {_taxationType = newValue}
  }
  /// Returns true if `taxationType` has been explicitly set.
  var hasTaxationType: Bool {return self._taxationType != nil}
  /// Clears the value of `taxationType`. Subsequent reads from it will return its default value.
  mutating func clearTaxationType() {self._taxationType = nil}

  //// Вид деятельности
  var okved: String {
    get {return _okved ?? String()}
    set {_okved = newValue}
  }
  /// Returns true if `okved` has been explicitly set.
  var hasOkved: Bool {return self._okved != nil}
  /// Clears the value of `okved`. Subsequent reads from it will return its default value.
  mutating func clearOkved() {self._okved = nil}

  //// Тенант
  var tenantID: Int32 {
    get {return _tenantID ?? 0}
    set {_tenantID = newValue}
  }
  /// Returns true if `tenantID` has been explicitly set.
  var hasTenantID: Bool {return self._tenantID != nil}
  /// Clears the value of `tenantID`. Subsequent reads from it will return its default value.
  mutating func clearTenantID() {self._tenantID = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _title: String? = nil
  fileprivate var _address: String? = nil
  fileprivate var _inn: String? = nil
  fileprivate var _taxationType: UInt32? = nil
  fileprivate var _okved: String? = nil
  fileprivate var _tenantID: Int32? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "kkm.proto"

extension Kkm_Proto_KkmRegInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".KkmRegInfo"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "point_of_payment_number"),
    2: .standard(proto: "terminal_number"),
    3: .standard(proto: "fns_kkm_id"),
    4: .standard(proto: "serial_number"),
    5: .standard(proto: "kkm_id"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self._pointOfPaymentNumber) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._terminalNumber) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self._fnsKkmID) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self._serialNumber) }()
      case 5: try { try decoder.decodeSingularStringField(value: &self._kkmID) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._pointOfPaymentNumber {
      try visitor.visitSingularStringField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._terminalNumber {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._fnsKkmID {
      try visitor.visitSingularStringField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._serialNumber {
      try visitor.visitSingularStringField(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._kkmID {
      try visitor.visitSingularStringField(value: v, fieldNumber: 5)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_KkmRegInfo, rhs: Kkm_Proto_KkmRegInfo) -> Bool {
    if lhs._pointOfPaymentNumber != rhs._pointOfPaymentNumber {return false}
    if lhs._terminalNumber != rhs._terminalNumber {return false}
    if lhs._fnsKkmID != rhs._fnsKkmID {return false}
    if lhs._serialNumber != rhs._serialNumber {return false}
    if lhs._kkmID != rhs._kkmID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_Proto_PosRegInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".PosRegInfo"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "title"),
    2: .same(proto: "address"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self._title) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._address) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._title {
      try visitor.visitSingularStringField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._address {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_PosRegInfo, rhs: Kkm_Proto_PosRegInfo) -> Bool {
    if lhs._title != rhs._title {return false}
    if lhs._address != rhs._address {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_Proto_OrgRegInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".OrgRegInfo"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "title"),
    2: .same(proto: "address"),
    3: .same(proto: "inn"),
    4: .standard(proto: "taxation_type"),
    5: .same(proto: "okved"),
    6: .same(proto: "tenantId"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self._title) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._address) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self._inn) }()
      case 4: try { try decoder.decodeSingularUInt32Field(value: &self._taxationType) }()
      case 5: try { try decoder.decodeSingularStringField(value: &self._okved) }()
      case 6: try { try decoder.decodeSingularInt32Field(value: &self._tenantID) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._title {
      try visitor.visitSingularStringField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._address {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._inn {
      try visitor.visitSingularStringField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._taxationType {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._okved {
      try visitor.visitSingularStringField(value: v, fieldNumber: 5)
    } }()
    try { if let v = self._tenantID {
      try visitor.visitSingularInt32Field(value: v, fieldNumber: 6)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_OrgRegInfo, rhs: Kkm_Proto_OrgRegInfo) -> Bool {
    if lhs._title != rhs._title {return false}
    if lhs._address != rhs._address {return false}
    if lhs._inn != rhs._inn {return false}
    if lhs._taxationType != rhs._taxationType {return false}
    if lhs._okved != rhs._okved {return false}
    if lhs._tenantID != rhs._tenantID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}