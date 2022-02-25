import Foundation

public extension URL {
    static var documents: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    static func documentsContents(withExtension pathExtension: String) -> [URL] {
        documents.directoryContents(withExtension: pathExtension)
    }
    
    static var documentsContents: [URL] {
        documents.directoryContents
    }
}

public extension URL {
    var directoryContents: [URL] {
        do {
            let files = try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil)
            return files
        } catch {
            print("Error getting directory contents: \(error)")
            return []
        }
    }
    
    func directoryContents(withExtension pathExtension: String) -> [URL] {
        directoryContents.filter({ $0.pathExtension == pathExtension })
    }
    
    var fileContents: String {
        do {
            return try String(contentsOf: self, encoding: .utf8)
        } catch {
            fatalError("Error reading files: \(error)")
        }
    }
}
