import Foundation
import XCTest

extension Snapshotting where Value == String, Format == String {
  /// A snapshot strategy for comparing strings based on equality.
  public static let lines = Snapshotting(pathExtension: "txt", diffing: .lines)
}

extension Diffing where Value == String {
    /// A line-diffing strategy for UTF-8 text.
    public static let lines = Diffing(
        toData: { Data($0.utf8) },
        fromData: { String(decoding: $0, as: UTF8.self) },
        diff: { old, new in
            guard old != new else { return nil }
            let hunks = chunk(diff: SnapshotTesting.diff(
                old.split(separator: "\n", omittingEmptySubsequences: false).map(String.init),
                new.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
            ))
            let failure = hunks
                .flatMap { [$0.patchMark] + $0.lines }
                .joined(separator: "\n")
            return (failure, ["": failure])
    },
        attachment: { _, value in
            XCTAttachment(data: Data(value.utf8), uniformTypeIdentifier: "public.patch-file")
    })
}
