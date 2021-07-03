final class DINodeBuilder {
    var info: DIBuilderInformation
    var maker: (_ build: DIBuilderDependencyPool) throws -> Any
    var injectHandlers: [(_ object: inout Any, _ build: DIBuilderDependencyPool) throws -> Void] = []
    var provider: DIProvider
    var lifeTime: DINodeRegistratorLifeTime = .oneInBuild

    let position: DICodePosition

    init<Type>(
        position: DICodePosition,
        type: Type.Type,
        maker: @escaping (_ build: DIBuilderDependencyPool) throws -> Any
    ) {
        self.position = position
        self.maker = maker
        self.provider = Provider0<Type>()
        self.info = DIBuilderInformation(identifier: DISignatureIdentifier(type: type))
    }

    func addInput<Type>(_ type: Type.Type) throws {
        if let container = type as? DIContainable.Type {
            info.dependencies.append(container.signature)
            return
        }
        if let argumentContainer = type as? DIArgumentContainable.Type {
            if case .oneInBuild = lifeTime {
                lifeTime = .newEveryTime
            }
            if case .singolton(let type) = lifeTime, type == .preRun {
                throw DIError.customError(
                    "For \(self) impossible to add external arguments for singolton"
                )
            }
            info.identifier.inputs.append(argumentContainer.objectType)
            try argumentContainer.updateProvider(&provider)
            return
        }
        let signature = DISignatureIdentifier(type: Type.self, tag: DIBaseTag.self)
        info.dependencies.append(DISignatureDependency(identifier: signature))
    }
}

extension DINodeBuilder: CustomDebugStringConvertible {
    var debugDescription: String {
        return "<Node \(self.info.identifier) \(position)>"
    }
}
