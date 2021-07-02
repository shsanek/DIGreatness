public protocol DIPart {
    init()
    func registration(_ registrator: DIRegistrator) throws
    func resolve(_ resolver: DIResolver) throws
}

public extension DIPart {
    func autoInjection(_ resolver: DIResolver) throws {
        try Mirror(reflecting: self).children.forEach { (child) in
            try (child.value as? DIInjectable)?.resolve(resolver)
        }
    }

    func resolve(_ resolver: DIResolver) throws {
        try self.autoInjection(resolver)
    }
}
