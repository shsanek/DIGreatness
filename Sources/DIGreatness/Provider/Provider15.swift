// swiftlint:disable line_length

struct Provider15<Type, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15>: DIProvider
{
    var inputs: [Any.Type] { [A1.self, A2.self, A3.self, A4.self, A5.self, A6.self, A7.self, A8.self, A9.self, A10.self, A11.self, A12.self, A13.self, A14.self, A15.self] }

    func returnType<Result>(_ result: Result.Type) -> DIProvider {
        return Provider15<Result, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15>()
    }

    func addArgument<Arg>(_ argument: Arg.Type) throws -> DIProvider {
        throw DIError.customError(
            type: .maximumNumberOfArgumentsExceeded,
            "The maximum number of arguments available is 15"
        )
    }

    func make(with node: DINode) -> DINode {
        let handler: (A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15) -> Type = { a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15 in
            let obj = node.fetch([a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15])
            guard let result = obj as? Type else {
                fatalError("[DI]Incorect type '\(obj)' is not '\(Type.self)'")
            }
            return result
        }
        let bulder = DINodeBuilder(
            position: node.builder.position,
            type: ((A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15) -> Type).self, maker: { _ in
                handler
            }
        )
        bulder.info.identifier.tag = node.builder.info.identifier.tag
        return DINode(bulder)
    }
}
