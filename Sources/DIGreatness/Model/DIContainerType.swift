protocol DIContainerType {
    static var baseType: Any.Type { get }
}

extension Optional: DIContainerType {
    static var baseType: Any.Type {
        Wrapped.self
    }
}
