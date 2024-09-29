// DO NOT EDIT.
// swift-format-ignore-file
// swiftlint:disable all
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: bind_taxation.proto
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

struct Kkm_Proto_BindedTaxation: Sendable {
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

  var taxes: [Kkm_Proto_BindedTaxation.BindedTax] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  struct BindedTax: Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    var taxType: UInt32 {
      get {return _taxType ?? 0}
      set {_taxType = newValue}
    }
    /// Returns true if `taxType` has been explicitly set.
    var hasTaxType: Bool {return self._taxType != nil}
    /// Clears the value of `taxType`. Subsequent reads from it will return its default value.
    mutating func clearTaxType() {self._taxType = nil}

    var percent: UInt32 {
      get {return _percent ?? 0}
      set {_percent = newValue}
    }
    /// Returns true if `percent` has been explicitly set.
    var hasPercent: Bool {return self._percent != nil}
    /// Clears the value of `percent`. Subsequent reads from it will return its default value.
    mutating func clearPercent() {self._percent = nil}

    var unknownFields = SwiftProtobuf.UnknownStorage()

    init() {}

    fileprivate var _taxType: UInt32? = nil
    fileprivate var _percent: UInt32? = nil
  }

  init() {}

  fileprivate var _taxationType: UInt32? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "kkm.proto"

extension Kkm_Proto_BindedTaxation: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".BindedTaxation"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "taxation_type"),
    2: .same(proto: "taxes"),
  ]

  public var isInitialized: Bool {
    if self._taxationType == nil {return false}
    if !SwiftProtobuf.Internal.areAllInitialized(self.taxes) {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt32Field(value: &self._taxationType) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.taxes) }()
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
    if !self.taxes.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.taxes, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_BindedTaxation, rhs: Kkm_Proto_BindedTaxation) -> Bool {
    if lhs._taxationType != rhs._taxationType {return false}
    if lhs.taxes != rhs.taxes {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_Proto_BindedTaxation.BindedTax: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = Kkm_Proto_BindedTaxation.protoMessageName + ".BindedTax"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "tax_type"),
    2: .same(proto: "percent"),
  ]

  public var isInitialized: Bool {
    if self._taxType == nil {return false}
    if self._percent == nil {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt32Field(value: &self._taxType) }()
      case 2: try { try decoder.decodeSingularUInt32Field(value: &self._percent) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._taxType {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._percent {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_Proto_BindedTaxation.BindedTax, rhs: Kkm_Proto_BindedTaxation.BindedTax) -> Bool {
    if lhs._taxType != rhs._taxType {return false}
    if lhs._percent != rhs._percent {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}