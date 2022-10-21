#if canImport(TabularData)
import TabularData
import Foundation

@available(macOS 12, *)
public extension DataFrame {
    func write(to url: URL, completion: (() -> Void)? = nil) {
        do {
            try writeCSV(to: url)
            completion?()
        } catch {
            print("Error writing CSV: \(error)")
        }
    }
    
    static func read(from url: URL) -> DataFrame? {
        do {
            return try DataFrame(contentsOfCSVFile: url)
        } catch {
            print("Error reading CSV: \(error)")
            return nil
        }
    }
}
#endif
