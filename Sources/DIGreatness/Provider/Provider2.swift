struct Provider2<Type, A1, A2>: DIProvider {
    var inputs: [Any.Type] { [A1.self, A2.self] }

    func returnType<Result>(_ result: Result.Type) -> DIProvider {
        return Provider2<Result, A1, A2>()
    }

    func addArgument<Arg>(_ argument: Arg.Type) throws -> DIProvider {
        throw DIError.customError(
            "The maximum number of arguments available is 2"
        )
    }
    
    func make(with node: DINode) -> DINode {
        let handler: (A1, A2) -> Type = { a1, a2 in
            let obj = node.fetch([a1, a2])
            guard let result = obj as? Type else {
                fatalError("[DI]Incorect type '\(obj)' is not '\(Type.self)'")
            }
            return result
        }
        let bulder = DINodeBuilder(
            position: node.builder.position,
            type: ((A1, A2) -> Type).self, maker: { _ in
                handler
            }
        )
        bulder.info.identifier.tag = node.builder.info.identifier.tag
        return DINode(bulder)
    }
}
