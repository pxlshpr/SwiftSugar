#if os(iOS)
import SwiftUI

@available(iOS 16, *)
public func sleepTask(_ seconds: Int, tolerance: Int = 1) async throws {
    try await Task.sleep(
        until: .now + .seconds(seconds),
        tolerance: .seconds(tolerance),
        clock: .suspending
    )
}

@available(iOS 16, *)
public func sleepTask(_ seconds: Double, tolerance: Double = 1) async throws {
    try await Task.sleep(
        until: .now + .seconds(seconds),
        tolerance: .seconds(tolerance),
        clock: .suspending
    )
}

#endif
