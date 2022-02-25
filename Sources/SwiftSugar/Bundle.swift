import Foundation

public extension Bundle {
    func copyFilesFromBundleToDocumentsFolderWith(fileExtension: String) {
        guard let resourcesPath = resourcePath else {
            fatalError("Couldn't get path for Resources")
        }
        
        do {
            let dirContents = try FileManager.default.contentsOfDirectory(atPath: resourcesPath)
            let filteredFiles = dirContents.filter{ $0.contains(fileExtension)}
            for fileName in filteredFiles {
                let sourceURL = bundleURL.appendingPathComponent(fileName)
                let destURL = URL.documents.appendingPathComponent(fileName)
                do {
                    if !FileManager.default.fileExists(atPath: destURL.path) {
                        try FileManager.default.copyItem(at: sourceURL, to: destURL) }
                    }
                catch {
                    print("Error copying item: \(error)")
                }
            }
            print("Resource files copied")
        } catch {
            print("Error getting directory contents: \(error)")
        }
    }
}
