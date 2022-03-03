import Foundation

public extension String {
    
    func write(to url: URL) {
        do {
            try write(to: url, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to write string to: \(url)")
        }
    }
}
