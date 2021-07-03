protocol DIArgumentContainable
{
    static var objectType: Any.Type { get }
    static func updateProvider(_ provider: inout DIProvider) throws

    init(object: Any)
}

public struct DIArgumentContainer<Type>: DIArgumentContainable
{
    static var objectType: Any.Type {
        return Type.self
    }

    let object: Type

    init(object: Any) {
        guard let obj = object as? Type else {
            fatalError("[DI]Incorect argument type '\(object)' is not '\(Type.self)'")
        }
        self.object = obj
    }

    static func updateProvider(_ provider: inout DIProvider) throws {
        provider = try provider.addArgument(Type.self)
    }
}

public func diArg<Type>(_ container: DIArgumentContainer<Type>) -> Type
{
    return container.object
}
