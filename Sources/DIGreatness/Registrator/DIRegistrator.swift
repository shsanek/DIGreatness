public final class DIRegistrator {
    var builders = [DINodeBuilder]()

    func addItem<Type>(_ item: DINodeRegistrator<Type>) {
        self.builders.append(item.builder)
    }
}

extension DIRegistrator {
    @discardableResult
    public func register<Type>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping () -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { _ in maker() }
        )
        self.addItem(item)
        return item
    }
    
    @discardableResult
    public func register<Type, A1>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping (A1) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker(container.get()) }
        )
        try item.builder.addInput(A1.self)
        self.addItem(item)
        return item
    }
    
    @discardableResult
    public func register<Type, A1, A2>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping ((A1, A2)) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker((container.get(), container.get())) }
        )
        try item.builder.addInput(A1.self)
        try item.builder.addInput(A2.self)
        self.addItem(item)
        return item
    }
    
    @discardableResult
    public func register<Type, A1, A2, A3>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping ((A1, A2, A3)) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker((container.get(), container.get(), container.get())) }
        )
        try item.builder.addInput(A1.self)
        try item.builder.addInput(A2.self)
        try item.builder.addInput(A3.self)
        self.addItem(item)
        return item
    }
}
