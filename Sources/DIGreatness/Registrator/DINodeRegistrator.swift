public struct DINodeRegistrator<Type>
{
    let builder: DINodeBuilder

    init(
        position: DICodePosition,
        type: Type.Type,
        maker: @escaping (_ build: DIBuilderDependencyPool) throws -> Any
    ) {
        self.builder = DINodeBuilder(position: position, type: type, maker: maker)
    }

    init(
        _ builder: DINodeBuilder
    ) {
        self.builder = builder
    }
}

extension DINodeRegistrator
{
    @discardableResult
    public func map<NewType>(_ map: @escaping (Type) -> NewType) -> DINodeRegistrator<NewType> {
        self.builder.injectHandlers.append { obj, _ in
            guard let object = obj as? Type else {
                assertionFailure("[DI]Incorect type '\(obj)' is not '\(Type.self)'")
                return
            }
            obj = map(object)
        }
        self.builder.info.identifier.type = NewType.self
        self.builder.provider = self.builder.provider.returnType(NewType.self)
        return DINodeRegistrator<NewType>(self.builder)
    }

    @discardableResult
    public func tag<TagType>(_ tag: TagType.Type) -> Self {
        self.builder.info.identifier.tag = tag
        return self
    }

    @discardableResult
    public func inject<PropertyType>(_ path: WritableKeyPath<Type, PropertyType>) throws -> Self {
        try self.builder.addInput(PropertyType.self)
        self.builder.injectHandlers.append { obj, container in
            guard var object = obj as? Type else {
                assertionFailure("[DI]Incorect type '\(obj)' is not '\(Type.self)'")
                return
            }
            object[keyPath: path] = container.get() as PropertyType
            obj = object
        }
        return self
    }

    @discardableResult
    public func lifeTime(_ lifeTime: DINodeRegistratorLifeTime) throws -> Self {
        if builder.info.identifier.inputs.count > 0 {
            if case .oneInBuild = lifeTime {
                throw DIError.customError(
                    "For \(self.builder) it is impossible to set the state because there are external arguments"
                )
            }
            if case .singolton(let type) = lifeTime, type == .preRun {
                throw DIError.customError(
                    "For \(self.builder) it is impossible to set the state because there are external arguments"
                )
            }
        }
        self.builder.lifeTime = lifeTime
        return self
    }
}
