struct Provider5<Type, A1, A2, A3, A4, A5>: DIProvider
{
    var inputs: [Any.Type] { [A1.self, A2.self, A3.self, A4.self, A5.self] }

    func returnType<Result>(_ result: Result.Type) -> DIProvider {
        return Provider5<Result, A1, A2, A3, A4, A5>()
    }

    func addArgument<Arg>(_ argument: Arg.Type) throws -> DIProvider {
        return Provider6<Type, A1, A2, A3, A4, A5, Arg>()
    }

    func make(with node: DINode) -> DINode {
        let handler: (A1, A2, A3, A4, A5) -> Type = { a1, a2, a3, a4, a5 in
            let obj = node.fetch([a1, a2, a3, a4, a5])
            guard let result = obj as? Type else {
                fatalError("[DI]Incorect type '\(obj)' is not '\(Type.self)'")
            }
            return result
        }
        let bulder = DINodeBuilder(
            position: node.builder.position,
            type: ((A1, A2, A3, A4, A5) -> Type).self, maker: { _ in
                handler
            }
        )
        bulder.info.identifier.tag = node.builder.info.identifier.tag
        return DINode(bulder)
    }
}
