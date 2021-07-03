struct Provider1<Type, A1>: DIProvider {
    var inputs: [Any.Type] { [A1.self] }

    func returnType<Result>(_ result: Result.Type) -> DIProvider {
        return Provider1<Result, A1>()
    }

    func addArgument<Arg>(_ argument: Arg.Type) throws -> DIProvider {
        return Provider2<Type, A1, Arg>()
    }

    func make(with node: DINode) -> DINode {
        let handler: (A1) -> Type = { a1 in
            let obj = node.fetch([a1])
            guard let result = obj as? Type else {
                fatalError("[DI]Incorect type '\(obj)' is not '\(Type.self)'")
            }
            return result
        }
        let bulder = DINodeBuilder(
            position: node.builder.position,
            type: ((A1) -> Type).self, maker: { _ in
                handler
            }
        )
        bulder.info.identifier.tag = node.builder.info.identifier.tag
        return DINode(bulder)
    }
}
