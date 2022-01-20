public final class DINode
{
    let builder: DINodeBuilder

    private(set) var isProvider = false
    var singleton: Any?
    var dependencies: [DINode] = []
    var state: State = .notValidated

    lazy var name: String = {
        return identifier.name
    }()
    
    lazy var hash: Int = {
        return identifier.hash
    }()

    var identifier: DISignatureIdentifier {
        builder.info.identifier
    }

    init(_ builder: DINodeBuilder) {
        self.builder = builder
    }

    func makeProviderNode() -> DINode {
        let providerNode = self.builder.provider.make(with: self)
        providerNode.builder.info.dependencies.append(DISignatureDependency(identifier: self.identifier))
        providerNode.isProvider = true
        return providerNode
    }

    func fetch(_ arguments: [Any]) -> Any {
        let storage = DIBuilderDependencyStorage()
        return make(storage: storage, arguments)
    }

    func makeIfNeed(storage: DIBuilderDependencyStorage, _ arguments: [Any]) -> Any {
        switch builder.lifeTime {
        case .prototype:
            return make(storage: storage, arguments)
        case .objectGraph:
            return storage.fetchObject(node: self, arguments: arguments)
        case .single, .perRun:
            let result = singleton ?? make(storage: storage, arguments)
            singleton = result
            return result
        }
    }

    func make(storage: DIBuilderDependencyStorage, _ arguments: [Any]) -> Any {
        let container = DIBuilderDependencyPool(node: self, arguments: arguments, storage: storage)
        do {
            var result = try self.builder.maker(container)
            try self.builder.injectHandlers.forEach { handler in
                try handler(&result, container)
            }
            return result
        }
        catch {
            fatalError("\(error)")
        }
    }
}

extension DINode
{
    enum State
    {
        case notValidated
        case validated
        case inProgress(_ context: DIValidateContext)
        case validateError
    }
}

extension DINode: CustomDebugStringConvertible
{
    public var debugDescription: String {
        return "<Node \(self.identifier) \(builder.position)>"
    }
}
