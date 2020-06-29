import Foundation
import XCTest

/// The ability to compare `Value`s and convert them to and from `Data`.
public struct Diffing<Value> {
  /// Converts a value _to_ data.
  public var toData: (Value) -> Data

  /// Produces a value _from_ data.
  public var fromData: (Data) -> Value

  /// Compares two values. If the values do not match, returns a failure message and artifacts describing the failure.
  public var diff: (Value, Value) -> (String, [String: Value])?
    
    /// Creates a test attachment from a given value
    public var attachment: (String?, Value) -> XCTAttachment?

  /// Creates a new `Diffing` on `Value`.
  ///
  /// - Parameters:
  ///   - toData: A function used to convert a value _to_ data.
  ///   - value: A value to convert into data.
  ///   - fromData: A function used to produce a value _from_ data.
  ///   - data: Data to convert into a value.
  ///   - diff: A function used to compare two values. If the values do not match, returns a failure message and artifacts describing the failure.
  ///   - lhs: A value to compare.
  ///   - rhs: Another value to compare.
  public init(
    toData: @escaping (_ value: Value) -> Data,
    fromData: @escaping (_ data: Data) -> Value,
    diff: @escaping (_ lhs: Value, _ rhs: Value) -> (String, [String: Value])?,
    attachment: @escaping (_ name: String?, _ value: Value) -> XCTAttachment?
    ) {
    self.toData = toData
    self.fromData = fromData
    self.diff = diff
    self.attachment = attachment
  }
}
