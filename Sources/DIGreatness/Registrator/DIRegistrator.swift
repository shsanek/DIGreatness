public final class DIRegistrator {
    var builders = [DINodeBuilder]()

    func addItem<Type>(_ item: DINodeRegistrator<Type>) {
        self.builders.append(item.builder)
    }
}

// swiftlint:disable line_length
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

    @discardableResult
    public func register<Type, A1, A2, A3, A4>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping ((A1, A2, A3, A4)) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker((container.get(), container.get(), container.get(), container.get())) }
        )
        try item.builder.addInput(A1.self)
        try item.builder.addInput(A2.self)
        try item.builder.addInput(A3.self)
        try item.builder.addInput(A4.self)
        self.addItem(item)
        return item
    }

    @discardableResult
    public func register<Type, A1, A2, A3, A4, A5>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping ((A1, A2, A3, A4, A5)) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker((container.get(), container.get(), container.get(), container.get(), container.get())) }
        )
        try item.builder.addInput(A1.self)
        try item.builder.addInput(A2.self)
        try item.builder.addInput(A3.self)
        try item.builder.addInput(A4.self)
        try item.builder.addInput(A5.self)
        self.addItem(item)
        return item
    }

    @discardableResult
    public func register<Type, A1, A2, A3, A4, A5, A6>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping ((A1, A2, A3, A4, A5, A6)) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker((container.get(), container.get(), container.get(), container.get(), container.get(), container.get())) }
        )
        try item.builder.addInput(A1.self)
        try item.builder.addInput(A2.self)
        try item.builder.addInput(A3.self)
        try item.builder.addInput(A4.self)
        try item.builder.addInput(A5.self)
        try item.builder.addInput(A6.self)
        self.addItem(item)
        return item
    }

    @discardableResult
    public func register<Type, A1, A2, A3, A4, A5, A6, A7>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping ((A1, A2, A3, A4, A5, A6, A7)) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker((container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get())) }
        )
        try item.builder.addInput(A1.self)
        try item.builder.addInput(A2.self)
        try item.builder.addInput(A3.self)
        try item.builder.addInput(A4.self)
        try item.builder.addInput(A5.self)
        try item.builder.addInput(A6.self)
        try item.builder.addInput(A7.self)
        self.addItem(item)
        return item
    }

    @discardableResult
    public func register<Type, A1, A2, A3, A4, A5, A6, A7, A8>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping ((A1, A2, A3, A4, A5, A6, A7, A8)) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker((container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get())) }
        )
        try item.builder.addInput(A1.self)
        try item.builder.addInput(A2.self)
        try item.builder.addInput(A3.self)
        try item.builder.addInput(A4.self)
        try item.builder.addInput(A5.self)
        try item.builder.addInput(A6.self)
        try item.builder.addInput(A7.self)
        try item.builder.addInput(A8.self)
        self.addItem(item)
        return item
    }

    @discardableResult
    public func register<Type, A1, A2, A3, A4, A5, A6, A7, A8, A9>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping ((A1, A2, A3, A4, A5, A6, A7, A8, A9)) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker((container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get())) }
        )
        try item.builder.addInput(A1.self)
        try item.builder.addInput(A2.self)
        try item.builder.addInput(A3.self)
        try item.builder.addInput(A4.self)
        try item.builder.addInput(A5.self)
        try item.builder.addInput(A6.self)
        try item.builder.addInput(A7.self)
        try item.builder.addInput(A8.self)
        try item.builder.addInput(A9.self)
        self.addItem(item)
        return item
    }

    @discardableResult
    public func register<Type, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping ((A1, A2, A3, A4, A5, A6, A7, A8, A9, A10)) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker((container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get())) }
        )
        try item.builder.addInput(A1.self)
        try item.builder.addInput(A2.self)
        try item.builder.addInput(A3.self)
        try item.builder.addInput(A4.self)
        try item.builder.addInput(A5.self)
        try item.builder.addInput(A6.self)
        try item.builder.addInput(A7.self)
        try item.builder.addInput(A8.self)
        try item.builder.addInput(A9.self)
        try item.builder.addInput(A10.self)
        self.addItem(item)
        return item
    }

    @discardableResult
    public func register<Type, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping ((A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11)) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker((container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get())) }
        )
        try item.builder.addInput(A1.self)
        try item.builder.addInput(A2.self)
        try item.builder.addInput(A3.self)
        try item.builder.addInput(A4.self)
        try item.builder.addInput(A5.self)
        try item.builder.addInput(A6.self)
        try item.builder.addInput(A7.self)
        try item.builder.addInput(A8.self)
        try item.builder.addInput(A9.self)
        try item.builder.addInput(A10.self)
        try item.builder.addInput(A11.self)
        self.addItem(item)
        return item
    }

    @discardableResult
    public func register<Type, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping ((A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12)) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker((container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get())) }
        )
        try item.builder.addInput(A1.self)
        try item.builder.addInput(A2.self)
        try item.builder.addInput(A3.self)
        try item.builder.addInput(A4.self)
        try item.builder.addInput(A5.self)
        try item.builder.addInput(A6.self)
        try item.builder.addInput(A7.self)
        try item.builder.addInput(A8.self)
        try item.builder.addInput(A9.self)
        try item.builder.addInput(A10.self)
        try item.builder.addInput(A11.self)
        try item.builder.addInput(A12.self)
        self.addItem(item)
        return item
    }

    @discardableResult
    public func register<Type, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping ((A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13)) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker((container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get())) }
        )
        try item.builder.addInput(A1.self)
        try item.builder.addInput(A2.self)
        try item.builder.addInput(A3.self)
        try item.builder.addInput(A4.self)
        try item.builder.addInput(A5.self)
        try item.builder.addInput(A6.self)
        try item.builder.addInput(A7.self)
        try item.builder.addInput(A8.self)
        try item.builder.addInput(A9.self)
        try item.builder.addInput(A10.self)
        try item.builder.addInput(A11.self)
        try item.builder.addInput(A12.self)
        try item.builder.addInput(A13.self)
        self.addItem(item)
        return item
    }

    @discardableResult
    public func register<Type, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping ((A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14)) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker((container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get())) }
        )
        try item.builder.addInput(A1.self)
        try item.builder.addInput(A2.self)
        try item.builder.addInput(A3.self)
        try item.builder.addInput(A4.self)
        try item.builder.addInput(A5.self)
        try item.builder.addInput(A6.self)
        try item.builder.addInput(A7.self)
        try item.builder.addInput(A8.self)
        try item.builder.addInput(A9.self)
        try item.builder.addInput(A10.self)
        try item.builder.addInput(A11.self)
        try item.builder.addInput(A12.self)
        try item.builder.addInput(A13.self)
        try item.builder.addInput(A14.self)
        self.addItem(item)
        return item
    }

    @discardableResult
    public func register<Type, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15>(
        file: String = #file,
        line: Int = #line,
        _ maker: @escaping ((A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15)) -> Type
    ) throws -> DINodeRegistrator<Type> {
        let position = DICodePosition(file: file, line: line)
        let item = DINodeRegistrator(
            position: position,
            type: Type.self,
            maker: { container in maker((container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get(), container.get())) }
        )
        try item.builder.addInput(A1.self)
        try item.builder.addInput(A2.self)
        try item.builder.addInput(A3.self)
        try item.builder.addInput(A4.self)
        try item.builder.addInput(A5.self)
        try item.builder.addInput(A6.self)
        try item.builder.addInput(A7.self)
        try item.builder.addInput(A8.self)
        try item.builder.addInput(A9.self)
        try item.builder.addInput(A10.self)
        try item.builder.addInput(A11.self)
        try item.builder.addInput(A12.self)
        try item.builder.addInput(A13.self)
        try item.builder.addInput(A14.self)
        try item.builder.addInput(A15.self)
        self.addItem(item)
        return item
    }
}
