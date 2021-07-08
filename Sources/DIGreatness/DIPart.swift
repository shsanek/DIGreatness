/// The part of the application that can interact with DI
///
/// Maintain in your object class to register it in DI
public protocol DIPart
{
    /// Parts that must also be connected to DI
    ///
    /// The default implementation returns an empty array
    var subpars: [DIPart] { get }

    /// Implement to register the dependencies of this part
    ///
    /// - Parameter registrator: DIRegistrator
    func registration(_ registrator: DIRegistrator) throws

    /// Implement to get the dependencies of this part
    ///
    /// The default implementation uses ' autoInjection(_ resolver: DIResolver)'
    ///
    /// - Important Do not try to keep DIResolver it is not safe, you will also get a 'retainResolver' exception
    ///
    /// - Parameter resolver: DIResolver
    func resolve(_ resolver: DIResolver) throws
}

public extension DIPart
{
    /// Default implementation
    var subpars: [DIPart] {
        []
    }

    /// Default implementation
    func registration(_ registrator: DIRegistrator) throws {
    }

    /// Default implementation
    func resolve(_ resolver: DIResolver) throws {
        try self.autoInjection(resolver)
    }

    /// Searches and fills all DIInject
    ///
    /// - Parameter resolver: use the resolver that was passed in 'DIPart.resolve(_ resolver: DIResolver)'
    func autoInjection(_ resolver: DIResolver) throws {
        try Mirror(reflecting: self).children.forEach { child in
            try (child.value as? DIInjectable)?.resolve(resolver)
        }
    }
}

internal extension DIPart
{
    var allParts: [DIPart] {
        return self.subpars.flatMap { $0.allParts } + [self]
    }
}
