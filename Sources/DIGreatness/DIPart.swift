public protocol DIPart
{
    init()
    var subpars: [DIPart] { get }
    func registration(_ registrator: DIRegistrator) throws
    func resolve(_ resolver: DIResolver) throws
}

public extension DIPart
{
    var subpars: [DIPart] {
        []
    }

    func autoInjection(_ resolver: DIResolver) throws {
        try Mirror(reflecting: self).children.forEach { child in
            try (child.value as? DIInjectable)?.resolve(resolver)
        }
    }

    func resolve(_ resolver: DIResolver) throws {
        try self.autoInjection(resolver)
    }
}

internal extension DIPart
{
    var allParts: [DIPart] {
        return self.subpars.flatMap { $0.allParts } + [self]
    }
}
