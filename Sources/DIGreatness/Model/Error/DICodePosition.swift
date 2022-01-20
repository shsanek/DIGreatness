import Foundation

struct DICodePosition
{
    let file: String
    let line: Int
}

extension DICodePosition: CustomDebugStringConvertible
{
    var debugDescription: String {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        return "<\(fileName): \(line)>"
    }
}
