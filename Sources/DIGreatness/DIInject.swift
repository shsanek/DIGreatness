/// Use to extract dependencies from DI
///
/// - Important Create only inside DIPart
/// - Important Only fetch values after call DI.build([DIPart]) with your parts
@propertyWrapper public final class DIInject<Type>: DIInjectable
{
    public var wrappedValue: Type {
        get {
            guard let value = self.value else {
                // swiftlint:disable:next line_length
                fatalError("[DI] You can only use DIInject inside DIPart, make sure DIPart has been loaded in \(self.position))")
            }
            return value
        }
    }

    private var value: Type?
    private let tag: Any.Type
    private let position: DICodePosition

    public init(file: String = #file, line: Int = #line, tag: Any.Type = DIBaseTag.self) {
        self.tag = tag
        self.position = DICodePosition(file: file, line: line)
    }

    func resolve(_ resolver: DIResolver) throws {
        self.value = try resolver.resolve(file: self.position.file, line: self.position.line, tag: tag) as Type
    }
}

protocol DIInjectable
{
    func resolve(_ resolver: DIResolver) throws
}
