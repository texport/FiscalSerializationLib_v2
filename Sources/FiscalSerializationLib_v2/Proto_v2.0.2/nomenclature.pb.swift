// DO NOT EDIT.
// swift-format-ignore-file
// swiftlint:disable all
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: nomenclature.proto
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

struct Kkm_Proto_NomenclatureRequest: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var currentVersion: UInt32 {
    get {return _currentVersion ?? 0}
    set {_currentVersion = newValue}
  }
  /// Returns true if `currentVersion` has been explicitly set.
  var hasCurrentVersion: Bool {return self._currentVersion != nil}
  /// Clears the value of `currentVersion`. Subsequent reads from it will return its default value.
  mutating func clearCurrentVersion() {self._currentVersion = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _currentVersion: UInt32? = nil
}

struct Kkm_Proto_NomenclatureResponse: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var version: UInt32 {
    get {return _version ?? 0}
    set {_version = newValue}
  }
  /// Returns true if `version` has been explicitly set.
  var hasVersion: Bool {return self._version != nil}
  /// Clears the value of `version`. Subsequent reads from it will return its default value.
  mutating func clearVersion() {self._version = nil}

  var createdTime: Kkm_Proto_DateTime {
    get {return _createdTime ?? Kkm_Proto_DateTime()}
    set {_createdTime = newValue}
  }
  /// Returns true if `createdTime` has been explicitly set.
  var hasCreatedTime: Bool {return self._createdTime != nil}
  /// Clears the value of `createdTime`. Subsequent reads from it will return its default value.
  mutating func clearCreatedTime() {self._createdTime = nil}

  var elements: [Kkm_Proto_NomenclatureResponse.Element] = []

  var result: Kkm_Proto_NomenclatureResponse.NomenclatureResultTypeEnum {
    get {return _result ?? .resultTypeOk}
    set {_result = newValue}
  }
  /// Returns true if `result` has been explicitly set.
  var hasResult: Bool {return self._result != nil}
  /// Clears the value of `result`. Subsequent reads from it will return its default value.
  mutating func clearResult() {self._result = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum ElementTypeEnum: SwiftProtobuf.Enum, Swift.CaseIterable {
    typealias RawValue = Int
    case group // = 0
    case item // = 1

    init() {
      self = .group
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .group
      case 1: self = .item
      default: return nil
      }
    }

    var rawValue: Int {
      switch self {
      case .group: return 0
      case .item: return 1
      }
    }

  }

  enum NomenclatureResultTypeEnum: SwiftProtobuf.Enum, Swift.CaseIterable {
    typealias RawValue = Int
    case resultTypeOk // = 0
    case resultTypeVersionIsActual // = 1
    case resultTypeNoVersion // = 2

    init() {
      self = .resultTypeOk
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .resultTypeOk
      case 1: self = .resultTypeVersionIsActual
      case 2: self = .resultTypeNoVersion
      default: return nil
      }
    }

    var rawValue: Int {
      switch self {
      case .resultTypeOk: return 0
      case .resultTypeVersionIsActual: return 1
      case .resultTypeNoVersion: return 2
      }
    }

  }

  struct Tax: Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    var taxationType: UInt32 {
      get {return _taxationType ?? 0}
      set {_taxationType = newValue}
    }
    /// Returns true if `taxationType` has been explicitly set.
    var hasTaxationType: Bool {return self._taxationType != nil}
    /// Clears the value of `taxationType`. Subsequent reads from it will return its default value.
    mutating func clearTaxationType() {self._taxationType = nil}

    var taxType: UInt32 {
      get {return _taxType ?? 0}
      set {_taxType = newValue}
    }
    /// Returns true if `taxType` has been explicitly set.
    var hasTaxType: Bool {return self._taxType != nil}
    /// Clears the value of `taxType`. Subsequent reads from it will return its default value.
    mutating func clearTaxType() {self._taxType = nil}

    var taxPercent: UInt32 {
      get {return _taxPercent ?? 0}
      set {_taxPercent = newValue}
    }
    /// Returns true if `taxPercent` has been explicitly set.
    var hasTaxPercent: Bool {return self._taxPercent != nil}
    /// Clears the value of `taxPercent`. Subsequent reads from it will return its default value.
    mutating func clearTaxPercent() {self._taxPercent = nil}

    var unknownFields = SwiftProtobuf.UnknownStorage()

    init() {}

    fileprivate var _taxationType: UInt32? = nil
    fileprivate var _taxType: UInt32? = nil
    fileprivate var _taxPercent: UInt32? = nil
  }

  struct Item: @unchecked Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    var article: String {
      get {return _storage._article ?? String()}
      set {_uniqueStorage()._article = newValue}
    }
    /// Returns true if `article` has been explicitly set.
    var hasArticle: Bool {return _storage._article != nil}
    /// Clears the value of `article`. Subsequent reads from it will return its default value.
    mutating func clearArticle() {_uniqueStorage()._article = nil}

    var barcode: String {
      get {return _storage._barcode ?? String()}
      set {_uniqueStorage()._barcode = newValue}
    }
    /// Returns true if `barcode` has been explicitly set.
    var hasBarcode: Bool {return _storage._barcode != nil}
    /// Clears the value of `barcode`. Subsequent reads from it will return its default value.
    mutating func clearBarcode() {_uniqueStorage()._barcode = nil}

    var description_p: String {
      get {return _storage._description_p ?? String()}
      set {_uniqueStorage()._description_p = newValue}
    }
    /// Returns true if `description_p` has been explicitly set.
    var hasDescription_p: Bool {return _storage._description_p != nil}
    /// Clears the value of `description_p`. Subsequent reads from it will return its default value.
    mutating func clearDescription_p() {_uniqueStorage()._description_p = nil}

    var purchasePrice: Kkm_Proto_Money {
      get {return _storage._purchasePrice ?? Kkm_Proto_Money()}
      set {_uniqueStorage()._purchasePrice = newValue}
    }
    /// Returns true if `purchasePrice` has been explicitly set.
    var hasPurchasePrice: Bool {return _storage._purchasePrice != nil}
    /// Clears the value of `purchasePrice`. Subsequent reads from it will return its default value.
    mutating func clearPurchasePrice() {_uniqueStorage()._purchasePrice = nil}

    var sellPrice: Kkm_Proto_Money {
      get {return _storage._sellPrice ?? Kkm_Proto_Money()}
      set {_uniqueStorage()._sellPrice = newValue}
    }
    /// Returns true if `sellPrice` has been explicitly set.
    var hasSellPrice: Bool {return _storage._sellPrice != nil}
    /// Clears the value of `sellPrice`. Subsequent reads from it will return its default value.
    mutating func clearSellPrice() {_uniqueStorage()._sellPrice = nil}

    var discountPercent: UInt32 {
      get {return _storage._discountPercent ?? 0}
      set {_uniqueStorage()._discountPercent = newValue}
    }
    /// Returns true if `discountPercent` has been explicitly set.
    var hasDiscountPercent: Bool {return _storage._discountPercent != nil}
    /// Clears the value of `discountPercent`. Subsequent reads from it will return its default value.
    mutating func clearDiscountPercent() {_uniqueStorage()._discountPercent = nil}

    var discountSum: Kkm_Proto_Money {
      get {return _storage._discountSum ?? Kkm_Proto_Money()}
      set {_uniqueStorage()._discountSum = newValue}
    }
    /// Returns true if `discountSum` has been explicitly set.
    var hasDiscountSum: Bool {return _storage._discountSum != nil}
    /// Clears the value of `discountSum`. Subsequent reads from it will return its default value.
    mutating func clearDiscountSum() {_uniqueStorage()._discountSum = nil}

    var markupPercent: UInt32 {
      get {return _storage._markupPercent ?? 0}
      set {_uniqueStorage()._markupPercent = newValue}
    }
    /// Returns true if `markupPercent` has been explicitly set.
    var hasMarkupPercent: Bool {return _storage._markupPercent != nil}
    /// Clears the value of `markupPercent`. Subsequent reads from it will return its default value.
    mutating func clearMarkupPercent() {_uniqueStorage()._markupPercent = nil}

    var markupSum: Kkm_Proto_Money {
      get {return _storage._markupSum ?? Kkm_Proto_Money()}
      set {_uniqueStorage()._markupSum = newValue}
    }
    /// Returns true if `markupSum` has been explicitly set.
    var hasMarkupSum: Bool {return _storage._markupSum != nil}
    /// Clears the value of `markupSum`. Subsequent reads from it will return its default value.
    mutating func clearMarkupSum() {_uniqueStorage()._markupSum = nil}

    var taxes: [Kkm_Proto_NomenclatureResponse.Tax] {
      get {return _storage._taxes}
      set {_uniqueStorage()._taxes = newValue}
    }

    var measureCount: UInt32 {
      get {return _storage._measureCount ?? 0}
      set {_uniqueStorage()._measureCount = newValue}
    }
    /// Returns true if `measureCount` has been explicitly set.
    var hasMeasureCount: Bool {return _storage._measureCount != nil}
    /// Clears the value of `measureCount`. Subsequent reads from it will return its default value.
    mutating func clearMeasureCount() {_uniqueStorage()._measureCount = nil}

    var measureTitle: String {
      get {return _storage._measureTitle ?? String()}
      set {_uniqueStorage()._measureTitle = newValue}
    }
    /// Returns true if `measureTitle` has been explicitly set.
    var hasMeasureTitle: Bool {return _storage._measureTitle != nil}
    /// Clears the value of `measureTitle`. Subsequent reads from it will return its default value.
    mutating func clearMeasureTitle() {_uniqueStorage()._measureTitle = nil}

    var measureFractional: Bool {
      get {return _storage._measureFractional ?? false}
      set {_uniqueStorage()._measureFractional = newValue}
    }
    /// Returns true if `measureFractional` has been explicitly set.
    var hasMeasureFractional: Bool {return _storage._measureFractional != nil}
    /// Clears the value of `measureFractional`. Subsequent reads from it will return its default value.
    mutating func clearMeasureFractional() {_uniqueStorage()._measureFractional = nil}

    /// since version 201
    var measureUnitCode: String {
      get {return _storage._measureUnitCode ?? String()}
      set {_uniqueStorage()._measureUnitCode = newValue}
    }
    /// Returns true if `measureUnitCode` has been explicitly set.
    var hasMeasureUnitCode: Bool {return _storage._measureUnitCode != nil}
    /// Clears the value of `measureUnitCode`. Subsequent reads from it will return its default value.
    mutating func clearMeasureUnitCode() {_uniqueStorage()._measureUnitCode = nil}

    var unknownFields = SwiftProtobuf.UnknownStorage()

    init() {}

    fileprivate var _storage = _StorageClass.defaultInstance
  }

  struct Element: Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    var type: Kkm_Proto_NomenclatureResponse.ElementTypeEnum {
      get {return _type ?? .group}
      set {_type = newValue}
    }
    /// Returns true if `type` has been explicitly set.
    var hasType: Bool {return self._type != nil}
    /// Clears the value of `type`. Subsequent reads from it will return its default value.
    mutating func clearType() {self._type = nil}

    var title: String {
      get {return _title ?? String()}
      set {_title = newValue}
    }
    /// Returns true if `title` has been explicitly set.
    var hasTitle: Bool {return self._title != nil}
    /// Clears the value of `title`. Subsequent reads from it will return its default value.
    mutating func clearTitle() {self._title = nil}

    var parentGroupID: UInt64 {
      get {return _parentGroupID ?? 0}
      set {_parentGroupID = newValue}
    }
    /// Returns true if `parentGroupID` has been explicitly set.
    var hasParentGroupID: Bool {return self._parentGroupID != nil}
    /// Clears the value of `parentGroupID`. Subsequent reads from it will return its default value.
    mutating func clearParentGroupID() {self._parentGroupID = nil}

    var id: UInt64 {
      get {return _id ?? 0}
      set {_id = newValue}
    }
    /// Returns true if `id` has been explicitly set.
    var hasID: Bool {return self._id != nil}
    /// Clears the value of `id`. Subsequent reads from it will return its default value.
    mutating func clearID() {self._id = nil}

    /// required if type == ITEM
    var item: Kkm_Proto_NomenclatureResponse.Item {
      get {return _item ?? Kkm_Proto_NomenclatureResponse.Item()}
      set {_item = newValue}
    }
    /// Returns true if `item` has been explicitly set.
    var hasItem: Bool {return self._item != nil}
    /// Clears the value of `item`. Subsequent reads from it will return its default value.
    mutating func clearItem() {self._item = nil}

    var unknownFields = SwiftProtobuf.UnknownStorage()

    init() {}

    fileprivate var _type: Kkm_Proto_NomenclatureResponse.ElementTypeEnum? = nil
    fileprivate var _title: String? = nil
    fileprivate var _parentGroupID: UInt64? = nil
    fileprivate var _id: UInt64? = nil
    fileprivate var _item: Kkm_Proto_NomenclatureResponse.Item? = nil
  }

  init() {}

  fileprivate var _version: UInt32? = nil
  fileprivate var _createdTime: Kkm_Proto_DateTime? = nil
  fileprivate var _result: Kkm_Proto_NomenclatureResponse.NomenclatureResultTypeEnum? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "kkm.proto"

extension Kkm_Proto_NomenclatureRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".NomenclatureRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "current_version"),
  ]

  public var isInitialized: Bool {
    if self._currentVersion == nil {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt32Field(value: &self._currentVersion) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._currentVersion {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 1)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_NomenclatureRequest, rhs: Kkm_Proto_NomenclatureRequest) -> Bool {
    if lhs._currentVersion != rhs._currentVersion {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_Proto_NomenclatureResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".NomenclatureResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "version"),
    2: .standard(proto: "created_time"),
    3: .same(proto: "elements"),
    4: .same(proto: "result"),
  ]

  public var isInitialized: Bool {
    if self._version == nil {return false}
    if self._result == nil {return false}
    if let v = self._createdTime, !v.isInitialized {return false}
    if !SwiftProtobuf.Internal.areAllInitialized(self.elements) {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt32Field(value: &self._version) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._createdTime) }()
      case 3: try { try decoder.decodeRepeatedMessageField(value: &self.elements) }()
      case 4: try { try decoder.decodeSingularEnumField(value: &self._result) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._version {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._createdTime {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    if !self.elements.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.elements, fieldNumber: 3)
    }
    try { if let v = self._result {
      try visitor.visitSingularEnumField(value: v, fieldNumber: 4)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_NomenclatureResponse, rhs: Kkm_Proto_NomenclatureResponse) -> Bool {
    if lhs._version != rhs._version {return false}
    if lhs._createdTime != rhs._createdTime {return false}
    if lhs.elements != rhs.elements {return false}
    if lhs._result != rhs._result {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_Proto_NomenclatureResponse.ElementTypeEnum: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "GROUP"),
    1: .same(proto: "ITEM"),
  ]
}

extension Kkm_Proto_NomenclatureResponse.NomenclatureResultTypeEnum: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "RESULT_TYPE_OK"),
    1: .same(proto: "RESULT_TYPE_VERSION_IS_ACTUAL"),
    2: .same(proto: "RESULT_TYPE_NO_VERSION"),
  ]
}

extension Kkm_Proto_NomenclatureResponse.Tax: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = Kkm_Proto_NomenclatureResponse.protoMessageName + ".Tax"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "taxation_type"),
    2: .standard(proto: "tax_type"),
    3: .standard(proto: "tax_percent"),
  ]

  public var isInitialized: Bool {
    if self._taxationType == nil {return false}
    if self._taxType == nil {return false}
    if self._taxPercent == nil {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt32Field(value: &self._taxationType) }()
      case 2: try { try decoder.decodeSingularUInt32Field(value: &self._taxType) }()
      case 3: try { try decoder.decodeSingularUInt32Field(value: &self._taxPercent) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._taxationType {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._taxType {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._taxPercent {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 3)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_NomenclatureResponse.Tax, rhs: Kkm_Proto_NomenclatureResponse.Tax) -> Bool {
    if lhs._taxationType != rhs._taxationType {return false}
    if lhs._taxType != rhs._taxType {return false}
    if lhs._taxPercent != rhs._taxPercent {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_Proto_NomenclatureResponse.Item: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = Kkm_Proto_NomenclatureResponse.protoMessageName + ".Item"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "article"),
    2: .same(proto: "barcode"),
    3: .same(proto: "description"),
    6: .standard(proto: "purchase_price"),
    7: .standard(proto: "sell_price"),
    8: .standard(proto: "discount_percent"),
    9: .standard(proto: "discount_sum"),
    10: .standard(proto: "markup_percent"),
    11: .standard(proto: "markup_sum"),
    12: .same(proto: "taxes"),
    13: .standard(proto: "measure_count"),
    14: .standard(proto: "measure_title"),
    15: .standard(proto: "measure_fractional"),
    16: .standard(proto: "measure_unit_code"),
  ]

  fileprivate class _StorageClass {
    var _article: String? = nil
    var _barcode: String? = nil
    var _description_p: String? = nil
    var _purchasePrice: Kkm_Proto_Money? = nil
    var _sellPrice: Kkm_Proto_Money? = nil
    var _discountPercent: UInt32? = nil
    var _discountSum: Kkm_Proto_Money? = nil
    var _markupPercent: UInt32? = nil
    var _markupSum: Kkm_Proto_Money? = nil
    var _taxes: [Kkm_Proto_NomenclatureResponse.Tax] = []
    var _measureCount: UInt32? = nil
    var _measureTitle: String? = nil
    var _measureFractional: Bool? = nil
    var _measureUnitCode: String? = nil

    #if swift(>=5.10)
      // This property is used as the initial default value for new instances of the type.
      // The type itself is protecting the reference to its storage via CoW semantics.
      // This will force a copy to be made of this reference when the first mutation occurs;
      // hence, it is safe to mark this as `nonisolated(unsafe)`.
      static nonisolated(unsafe) let defaultInstance = _StorageClass()
    #else
      static let defaultInstance = _StorageClass()
    #endif

    private init() {}

    init(copying source: _StorageClass) {
      _article = source._article
      _barcode = source._barcode
      _description_p = source._description_p
      _purchasePrice = source._purchasePrice
      _sellPrice = source._sellPrice
      _discountPercent = source._discountPercent
      _discountSum = source._discountSum
      _markupPercent = source._markupPercent
      _markupSum = source._markupSum
      _taxes = source._taxes
      _measureCount = source._measureCount
      _measureTitle = source._measureTitle
      _measureFractional = source._measureFractional
      _measureUnitCode = source._measureUnitCode
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  public var isInitialized: Bool {
    return withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if _storage._purchasePrice == nil {return false}
      if _storage._sellPrice == nil {return false}
      if let v = _storage._purchasePrice, !v.isInitialized {return false}
      if let v = _storage._sellPrice, !v.isInitialized {return false}
      if let v = _storage._discountSum, !v.isInitialized {return false}
      if let v = _storage._markupSum, !v.isInitialized {return false}
      if !SwiftProtobuf.Internal.areAllInitialized(_storage._taxes) {return false}
      return true
    }
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every case branch when no optimizations are
        // enabled. https://github.com/apple/swift-protobuf/issues/1034
        switch fieldNumber {
        case 1: try { try decoder.decodeSingularStringField(value: &_storage._article) }()
        case 2: try { try decoder.decodeSingularStringField(value: &_storage._barcode) }()
        case 3: try { try decoder.decodeSingularStringField(value: &_storage._description_p) }()
        case 6: try { try decoder.decodeSingularMessageField(value: &_storage._purchasePrice) }()
        case 7: try { try decoder.decodeSingularMessageField(value: &_storage._sellPrice) }()
        case 8: try { try decoder.decodeSingularUInt32Field(value: &_storage._discountPercent) }()
        case 9: try { try decoder.decodeSingularMessageField(value: &_storage._discountSum) }()
        case 10: try { try decoder.decodeSingularUInt32Field(value: &_storage._markupPercent) }()
        case 11: try { try decoder.decodeSingularMessageField(value: &_storage._markupSum) }()
        case 12: try { try decoder.decodeRepeatedMessageField(value: &_storage._taxes) }()
        case 13: try { try decoder.decodeSingularUInt32Field(value: &_storage._measureCount) }()
        case 14: try { try decoder.decodeSingularStringField(value: &_storage._measureTitle) }()
        case 15: try { try decoder.decodeSingularBoolField(value: &_storage._measureFractional) }()
        case 16: try { try decoder.decodeSingularStringField(value: &_storage._measureUnitCode) }()
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every if/case branch local when no optimizations
      // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
      // https://github.com/apple/swift-protobuf/issues/1182
      try { if let v = _storage._article {
        try visitor.visitSingularStringField(value: v, fieldNumber: 1)
      } }()
      try { if let v = _storage._barcode {
        try visitor.visitSingularStringField(value: v, fieldNumber: 2)
      } }()
      try { if let v = _storage._description_p {
        try visitor.visitSingularStringField(value: v, fieldNumber: 3)
      } }()
      try { if let v = _storage._purchasePrice {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
      } }()
      try { if let v = _storage._sellPrice {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
      } }()
      try { if let v = _storage._discountPercent {
        try visitor.visitSingularUInt32Field(value: v, fieldNumber: 8)
      } }()
      try { if let v = _storage._discountSum {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 9)
      } }()
      try { if let v = _storage._markupPercent {
        try visitor.visitSingularUInt32Field(value: v, fieldNumber: 10)
      } }()
      try { if let v = _storage._markupSum {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 11)
      } }()
      if !_storage._taxes.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._taxes, fieldNumber: 12)
      }
      try { if let v = _storage._measureCount {
        try visitor.visitSingularUInt32Field(value: v, fieldNumber: 13)
      } }()
      try { if let v = _storage._measureTitle {
        try visitor.visitSingularStringField(value: v, fieldNumber: 14)
      } }()
      try { if let v = _storage._measureFractional {
        try visitor.visitSingularBoolField(value: v, fieldNumber: 15)
      } }()
      try { if let v = _storage._measureUnitCode {
        try visitor.visitSingularStringField(value: v, fieldNumber: 16)
      } }()
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_NomenclatureResponse.Item, rhs: Kkm_Proto_NomenclatureResponse.Item) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._article != rhs_storage._article {return false}
        if _storage._barcode != rhs_storage._barcode {return false}
        if _storage._description_p != rhs_storage._description_p {return false}
        if _storage._purchasePrice != rhs_storage._purchasePrice {return false}
        if _storage._sellPrice != rhs_storage._sellPrice {return false}
        if _storage._discountPercent != rhs_storage._discountPercent {return false}
        if _storage._discountSum != rhs_storage._discountSum {return false}
        if _storage._markupPercent != rhs_storage._markupPercent {return false}
        if _storage._markupSum != rhs_storage._markupSum {return false}
        if _storage._taxes != rhs_storage._taxes {return false}
        if _storage._measureCount != rhs_storage._measureCount {return false}
        if _storage._measureTitle != rhs_storage._measureTitle {return false}
        if _storage._measureFractional != rhs_storage._measureFractional {return false}
        if _storage._measureUnitCode != rhs_storage._measureUnitCode {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_Proto_NomenclatureResponse.Element: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = Kkm_Proto_NomenclatureResponse.protoMessageName + ".Element"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "type"),
    3: .same(proto: "title"),
    4: .standard(proto: "parent_group_id"),
    5: .same(proto: "id"),
    6: .same(proto: "item"),
  ]

  public var isInitialized: Bool {
    if self._type == nil {return false}
    if self._title == nil {return false}
    if self._id == nil {return false}
    if let v = self._item, !v.isInitialized {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularEnumField(value: &self._type) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self._title) }()
      case 4: try { try decoder.decodeSingularUInt64Field(value: &self._parentGroupID) }()
      case 5: try { try decoder.decodeSingularUInt64Field(value: &self._id) }()
      case 6: try { try decoder.decodeSingularMessageField(value: &self._item) }()
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
    try { if let v = self._title {
      try visitor.visitSingularStringField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._parentGroupID {
      try visitor.visitSingularUInt64Field(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._id {
      try visitor.visitSingularUInt64Field(value: v, fieldNumber: 5)
    } }()
    try { if let v = self._item {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_NomenclatureResponse.Element, rhs: Kkm_Proto_NomenclatureResponse.Element) -> Bool {
    if lhs._type != rhs._type {return false}
    if lhs._title != rhs._title {return false}
    if lhs._parentGroupID != rhs._parentGroupID {return false}
    if lhs._id != rhs._id {return false}
    if lhs._item != rhs._item {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
