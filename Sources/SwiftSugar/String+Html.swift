import Foundation

public extension String {
    
    var htmlContents: String? {
        guard let url = URL(string: self) else {
            print("Error: Couldn't form URL from string: \(self)")
            return nil
        }
        do {
            let contents = try String(contentsOf: url)
            return contents
        } catch {
            print("Error: Couldn't load contents of: \(self)")
            return nil
        }
    }
    
    var percentEscaped: String {
        self.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
    }
}
