struct DIError: Error {
    let file: String
    let line: Int
    let description: String
    
    static func customError(file: String = #file, line: Int = #line, _ description: String) -> Self {
        DIError(file: file, line: line, description: description)
    }
}

extension DIError: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(description)"
    }
}

public struct DIErrorsContainer: Error {
    public let errors: [Error]
}

extension DIErrorsContainer: CustomDebugStringConvertible {
    public var debugDescription: String {
        return errors.map { "\($0)" }.joined(separator: "\n\n")
    }
}

struct DICodePosition {
    let file: String
    let line: Int
}

import Foundation

extension DICodePosition: CustomDebugStringConvertible {
    var debugDescription: String {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        return "<\(fileName): \(line)>"
    }
}
