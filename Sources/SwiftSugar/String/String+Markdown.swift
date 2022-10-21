#if os(iOS) || os(macOS)
import Foundation

@available(macOS 12, *)
public extension String {
    
    func toMarkdown() -> AttributedString {
        do {
            return try AttributedString(
                markdown: self,
                options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
            )
        } catch {
            print("Error parsing Markdown for string \(self): \(error)")
            return AttributedString(self)
        }
    }
}
#endif
