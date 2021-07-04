struct DIErrorInfo
{
    let file: String
    let line: Int
    let description: String
}

extension DIErrorInfo: CustomDebugStringConvertible
{
    var debugDescription: String {
        return "\(description)"
    }
}
