protocol DIContainable {
    static var signature: DISignatureDependency { get }

    init(object: Any)
}

public struct DITagContainer<Tag, Type>: DIContainable {
    static var signature: DISignatureDependency {
        let signature = DISignatureIdentifier(type: Type.self, tag: Tag.self)
        return DISignatureDependency(identifier: signature, pool: false)
    }

    let object: Type

    init(object: Any) {
        guard let obj = object as? Type else {
            fatalError("[DI]Incorect argument type '\(object)' is not '\(Type.self)'")
        }
        self.object = obj
    }
}

public func diTag<Tag, Type>(tag: Tag.Type, _ container: DITagContainer<Tag, Type>) -> Type {
    return container.object
}
