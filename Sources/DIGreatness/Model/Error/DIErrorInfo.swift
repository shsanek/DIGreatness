public struct DIErrorInfo
{
    public let file: String
    public let line: Int
    public let description: String
    public let type: ErrorType
}

extension DIErrorInfo
{
    public enum ErrorType
    {
        case signatureNotFound
        case cyclicDependency
        case moreOneMatchingSignature
        case retainResolver
        case notUsedNode
        case maximumNumberOfArgumentsExceeded
        case incorectLifetime
        case incorectType
    }
}

extension DIErrorInfo: CustomDebugStringConvertible
{
    public var debugDescription: String {
        return "\(description)"
    }
}
