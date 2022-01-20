final class DIBuilderDependencyPool
{
    let node: DINode
    let storage: DIBuilderDependencyStorage
    var arguments: [Any]

    init(node: DINode, arguments: [Any], storage: DIBuilderDependencyStorage) {
        self.node = node
        self.arguments = arguments
        self.storage = storage
    }

    func get<Type>(arguments: [Any] = []) -> Type {
        if let containable = Type.self as? DIContainable.Type {
            return getDependency(
                arguments: arguments,
                with: containable.signature,
                map: { containable.init(object: $0) }
            )
        }
        if let argumentContainer = Type.self as? DIArgumentContainable.Type {
            return getArgument(argumentContainer)
        }
        return getDependency(
            arguments: arguments,
            with: DISignatureDependency(identifier: .init(type: Type.self))
        )
    }

    private func getArgument<Type>(_ argumentContainer: DIArgumentContainable.Type) -> Type {
        let object = self.arguments.removeFirst()
        guard let result = argumentContainer.init(object: object) as? Type else {
            fatalError("[DI] Incorect type '\(object)' is not '\(Type.self)'")
        }
        return result
    }

    private func getDependency<Type>(
        arguments: [Any],
        with signature: DISignatureDependency,
        map: (Any) -> Any = { $0 }
    ) -> Type {
        let dependencies = node.dependencies
            .filter { $0.identifier.checkAccept(signature: signature.identifier) }
            .map { $0.makeIfNeed(storage: storage, arguments) }

        let object: Any
        if signature.pool {
            object = map(dependencies)
        }
        else {
            if dependencies.count == 0 {
                fatalError("[DI] Node with '\(signature)' not found")
            }
            object = map(dependencies[0])
        }
        guard let result = object as? Type else {
            fatalError("[DI] Incorect type '\(object)' is not '\(Type.self)'")
        }
        return result
    }
}
