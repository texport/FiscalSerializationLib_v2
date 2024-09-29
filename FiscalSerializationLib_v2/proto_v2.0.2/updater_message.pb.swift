// DO NOT EDIT.
// swift-format-ignore-file
// swiftlint:disable all
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: updater_message.proto
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

enum Kkm_FdSvc_Proto_RequestTypeEnum: SwiftProtobuf.Enum, Swift.CaseIterable {
  typealias RawValue = Int
  case requestCheckUpdates // = 1
  case requestPostUpdateStatus // = 2

  init() {
    self = .requestCheckUpdates
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 1: self = .requestCheckUpdates
    case 2: self = .requestPostUpdateStatus
    default: return nil
    }
  }

  var rawValue: Int {
    switch self {
    case .requestCheckUpdates: return 1
    case .requestPostUpdateStatus: return 2
    }
  }

}

enum Kkm_FdSvc_Proto_ResultTypeEnum: SwiftProtobuf.Enum, Swift.CaseIterable {
  typealias RawValue = Int
  case resultOk // = 0
  case resultUnknownRequest // = 1
  case resultUnregisteredKkm // = 2
  case resultSystemError // = 3

  init() {
    self = .resultOk
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .resultOk
    case 1: self = .resultUnknownRequest
    case 2: self = .resultUnregisteredKkm
    case 3: self = .resultSystemError
    default: return nil
    }
  }

  var rawValue: Int {
    switch self {
    case .resultOk: return 0
    case .resultUnknownRequest: return 1
    case .resultUnregisteredKkm: return 2
    case .resultSystemError: return 3
    }
  }

}

struct Kkm_FdSvc_Proto_Request: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var requestType: Kkm_FdSvc_Proto_RequestTypeEnum {
    get {return _requestType ?? .requestCheckUpdates}
    set {_requestType = newValue}
  }
  /// Returns true if `requestType` has been explicitly set.
  var hasRequestType: Bool {return self._requestType != nil}
  /// Clears the value of `requestType`. Subsequent reads from it will return its default value.
  mutating func clearRequestType() {self._requestType = nil}

  var kkmID: UInt32 {
    get {return _kkmID ?? 0}
    set {_kkmID = newValue}
  }
  /// Returns true if `kkmID` has been explicitly set.
  var hasKkmID: Bool {return self._kkmID != nil}
  /// Clears the value of `kkmID`. Subsequent reads from it will return its default value.
  mutating func clearKkmID() {self._kkmID = nil}

  /// required if request_type == REQUEST_CHECK_UPDATES 
  var updatesCheck: Kkm_FdSvc_Proto_CheckUpdatesRequest {
    get {return _updatesCheck ?? Kkm_FdSvc_Proto_CheckUpdatesRequest()}
    set {_updatesCheck = newValue}
  }
  /// Returns true if `updatesCheck` has been explicitly set.
  var hasUpdatesCheck: Bool {return self._updatesCheck != nil}
  /// Clears the value of `updatesCheck`. Subsequent reads from it will return its default value.
  mutating func clearUpdatesCheck() {self._updatesCheck = nil}

  /// required if request_type == REQUEST_POST_UPDATE_STATUS 
  var updateStatus: Kkm_FdSvc_Proto_PostUpdateStatusRequest {
    get {return _updateStatus ?? Kkm_FdSvc_Proto_PostUpdateStatusRequest()}
    set {_updateStatus = newValue}
  }
  /// Returns true if `updateStatus` has been explicitly set.
  var hasUpdateStatus: Bool {return self._updateStatus != nil}
  /// Clears the value of `updateStatus`. Subsequent reads from it will return its default value.
  mutating func clearUpdateStatus() {self._updateStatus = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _requestType: Kkm_FdSvc_Proto_RequestTypeEnum? = nil
  fileprivate var _kkmID: UInt32? = nil
  fileprivate var _updatesCheck: Kkm_FdSvc_Proto_CheckUpdatesRequest? = nil
  fileprivate var _updateStatus: Kkm_FdSvc_Proto_PostUpdateStatusRequest? = nil
}

struct Kkm_FdSvc_Proto_Result: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var resultCode: Kkm_FdSvc_Proto_ResultTypeEnum {
    get {return _resultCode ?? .resultOk}
    set {_resultCode = newValue}
  }
  /// Returns true if `resultCode` has been explicitly set.
  var hasResultCode: Bool {return self._resultCode != nil}
  /// Clears the value of `resultCode`. Subsequent reads from it will return its default value.
  mutating func clearResultCode() {self._resultCode = nil}

  var message: String {
    get {return _message ?? String()}
    set {_message = newValue}
  }
  /// Returns true if `message` has been explicitly set.
  var hasMessage: Bool {return self._message != nil}
  /// Clears the value of `message`. Subsequent reads from it will return its default value.
  mutating func clearMessage() {self._message = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _resultCode: Kkm_FdSvc_Proto_ResultTypeEnum? = nil
  fileprivate var _message: String? = nil
}

struct Kkm_FdSvc_Proto_Response: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var requestType: Kkm_FdSvc_Proto_RequestTypeEnum {
    get {return _requestType ?? .requestCheckUpdates}
    set {_requestType = newValue}
  }
  /// Returns true if `requestType` has been explicitly set.
  var hasRequestType: Bool {return self._requestType != nil}
  /// Clears the value of `requestType`. Subsequent reads from it will return its default value.
  mutating func clearRequestType() {self._requestType = nil}

  var kkmID: UInt32 {
    get {return _kkmID ?? 0}
    set {_kkmID = newValue}
  }
  /// Returns true if `kkmID` has been explicitly set.
  var hasKkmID: Bool {return self._kkmID != nil}
  /// Clears the value of `kkmID`. Subsequent reads from it will return its default value.
  mutating func clearKkmID() {self._kkmID = nil}

  var result: Kkm_FdSvc_Proto_Result {
    get {return _result ?? Kkm_FdSvc_Proto_Result()}
    set {_result = newValue}
  }
  /// Returns true if `result` has been explicitly set.
  var hasResult: Bool {return self._result != nil}
  /// Clears the value of `result`. Subsequent reads from it will return its default value.
  mutating func clearResult() {self._result = nil}

  /// required if request_type == REQUEST_CHECK_UPDATES 
  var updateAction: Kkm_FdSvc_Proto_UpdateAction {
    get {return _updateAction ?? Kkm_FdSvc_Proto_UpdateAction()}
    set {_updateAction = newValue}
  }
  /// Returns true if `updateAction` has been explicitly set.
  var hasUpdateAction: Bool {return self._updateAction != nil}
  /// Clears the value of `updateAction`. Subsequent reads from it will return its default value.
  mutating func clearUpdateAction() {self._updateAction = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _requestType: Kkm_FdSvc_Proto_RequestTypeEnum? = nil
  fileprivate var _kkmID: UInt32? = nil
  fileprivate var _result: Kkm_FdSvc_Proto_Result? = nil
  fileprivate var _updateAction: Kkm_FdSvc_Proto_UpdateAction? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "kkm.fd_svc.proto"

extension Kkm_FdSvc_Proto_RequestTypeEnum: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "REQUEST_CHECK_UPDATES"),
    2: .same(proto: "REQUEST_POST_UPDATE_STATUS"),
  ]
}

extension Kkm_FdSvc_Proto_ResultTypeEnum: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "RESULT_OK"),
    1: .same(proto: "RESULT_UNKNOWN_REQUEST"),
    2: .same(proto: "RESULT_UNREGISTERED_KKM"),
    3: .same(proto: "RESULT_SYSTEM_ERROR"),
  ]
}

extension Kkm_FdSvc_Proto_Request: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Request"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "request_type"),
    2: .standard(proto: "kkm_id"),
    3: .standard(proto: "updates_check"),
    4: .standard(proto: "update_status"),
  ]

  public var isInitialized: Bool {
    if self._requestType == nil {return false}
    if self._kkmID == nil {return false}
    if let v = self._updatesCheck, !v.isInitialized {return false}
    if let v = self._updateStatus, !v.isInitialized {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularEnumField(value: &self._requestType) }()
      case 2: try { try decoder.decodeSingularUInt32Field(value: &self._kkmID) }()
      case 3: try { try decoder.decodeSingularMessageField(value: &self._updatesCheck) }()
      case 4: try { try decoder.decodeSingularMessageField(value: &self._updateStatus) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._requestType {
      try visitor.visitSingularEnumField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._kkmID {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._updatesCheck {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._updateStatus {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_FdSvc_Proto_Request, rhs: Kkm_FdSvc_Proto_Request) -> Bool {
    if lhs._requestType != rhs._requestType {return false}
    if lhs._kkmID != rhs._kkmID {return false}
    if lhs._updatesCheck != rhs._updatesCheck {return false}
    if lhs._updateStatus != rhs._updateStatus {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_FdSvc_Proto_Result: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Result"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "result_code"),
    2: .same(proto: "message"),
  ]

  public var isInitialized: Bool {
    if self._resultCode == nil {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularEnumField(value: &self._resultCode) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._message) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._resultCode {
      try visitor.visitSingularEnumField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._message {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_FdSvc_Proto_Result, rhs: Kkm_FdSvc_Proto_Result) -> Bool {
    if lhs._resultCode != rhs._resultCode {return false}
    if lhs._message != rhs._message {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Kkm_FdSvc_Proto_Response: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Response"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "request_type"),
    2: .standard(proto: "kkm_id"),
    3: .same(proto: "result"),
    4: .standard(proto: "update_action"),
  ]

  public var isInitialized: Bool {
    if self._requestType == nil {return false}
    if self._kkmID == nil {return false}
    if self._result == nil {return false}
    if let v = self._result, !v.isInitialized {return false}
    if let v = self._updateAction, !v.isInitialized {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularEnumField(value: &self._requestType) }()
      case 2: try { try decoder.decodeSingularUInt32Field(value: &self._kkmID) }()
      case 3: try { try decoder.decodeSingularMessageField(value: &self._result) }()
      case 4: try { try decoder.decodeSingularMessageField(value: &self._updateAction) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._requestType {
      try visitor.visitSingularEnumField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._kkmID {
      try visitor.visitSingularUInt32Field(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._result {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._updateAction {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Kkm_FdSvc_Proto_Response, rhs: Kkm_FdSvc_Proto_Response) -> Bool {
    if lhs._requestType != rhs._requestType {return false}
    if lhs._kkmID != rhs._kkmID {return false}
    if lhs._result != rhs._result {return false}
    if lhs._updateAction != rhs._updateAction {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
