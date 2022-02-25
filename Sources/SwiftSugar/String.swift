import Foundation

public extension String {
    
    var htmlContentsFromUrlString: String? {
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

    var jsonContentsFromJsonString: [String: Any]? {
        guard let data = data(using: .utf8)
        else {
            print("Error: Couldn't scrape JSON object from string: \(self)")
            return nil
        }
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                print("Error: Couldn't parse JSON")
                return nil
            }
            return json
        } catch let error as NSError {
            print("Error: Failed to parse JSON: \(error.localizedDescription)")
            return nil
        }
    }

}
