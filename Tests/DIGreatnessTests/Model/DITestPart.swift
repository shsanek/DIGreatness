import DIGreatness

final class DITestPart: DIPart {
    var registrationHandler: ((DIRegistrator) throws -> Void)?
    var resolveHandler: ((DIResolver) throws -> Void)?

    init() { }
    
    @discardableResult
    func reg(_ handler: @escaping (DIRegistrator) throws -> Void) -> Self {
        registrationHandler = handler
        return self
    }
    
    @discardableResult
    func res(_ handler: @escaping (DIResolver) throws -> Void) -> Self {
        resolveHandler = handler
        return self
    }

    func registration(_ registrator: DIRegistrator) throws {
        try self.registrationHandler?(registrator)
    }

    func resolve(_ resolver: DIResolver) throws {
        try self.resolveHandler?(resolver)
    }
}
