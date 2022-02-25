import Foundation

public extension URL {
    static var documents: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    static func documentsContents(withExtension fileExtension: String) -> [URL] {
        documents.contents.filter{ $0.pathExtension == fileExtension }
    }
}

public extension URL {
    var contents: [URL] {
        do {
            let files = try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil)
            return files
        } catch {
            print("Error getting directory contents: \(error)")
            return []
        }
    }
}
