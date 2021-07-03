public struct DIListContainer<Tag, Type>: DIContainable {
    static var signature: DISignatureDependency {
        let signature = DISignatureIdentifier(type: Type.self, tag: Tag.self)
        return DISignatureDependency(identifier: signature, pool: true)
    }

    let objects: [Type]

    init(object: Any) {
        guard let array = object as? [Any] else {
            fatalError("[DI]Incorect argument type '\(object)' is not 'Array'")
        }
        self.objects = array.map { object in
            guard let obj = object as? Type else {
                fatalError("[DI]Incorect argument type '\(object)' is not '\(Type.self)'")
            }
            return obj
        }
    }
}

public func diList<Tag, Type>(tag: Tag.Type, _ container: DIListContainer<Tag, Type>) -> [Type] {
    return container.objects
}

public func diList<Type>(_ container: DIListContainer<DIBaseTag, Type>) -> [Type] {
    return container.objects
}
