import Foundation

public func post(_ names: [Notification.Name]) {
    for name in names {
        post(name)
    }
}

public func post(_ name: Notification.Name) {
    NotificationCenter.default.post(name: name, object: nil)
}
