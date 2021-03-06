public enum DIError: Error
{
    case error(_ info: DIErrorInfo)
    case container(_ container: DIErrorsContainer)
}

extension DIError
{
    static func customError(
        file: String = #file,
        line: Int = #line,
        type: DIErrorInfo.ErrorType,
        _ description: String
    ) -> Self {
        return .error(DIErrorInfo(file: file, line: line, description: description, type: type))
    }
}

extension DIError: CustomDebugStringConvertible
{
    public var debugDescription: String {
        switch self {
        case .error(let info):
            return "\(info)"
        case .container(let container):
            return "\(container)"
        }
    }
}
