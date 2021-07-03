struct Provider4<Type, A1, A2, A3, A4>: DIProvider {
    var inputs: [Any.Type] { [A1.self, A2.self, A3.self, A4.self] }

    func returnType<Result>(_ result: Result.Type) -> DIProvider {
        return Provider4<Result, A1, A2, A3, A4>()
    }

    func addArgument<Arg>(_ argument: Arg.Type) throws -> DIProvider {
        return Provider5<Type, A1, A2, A3, A4, Arg>()
    }
    
    func make(with node: DINode) -> DINode {
        let handler: (A1, A2, A3, A4) -> Type = { a1, a2, a3, a4 in
            let obj = node.fetch([a1, a2, a3, a4])
            guard let result = obj as? Type else {
                fatalError("[DI]Incorect type '\(obj)' is not '\(Type.self)'")
            }
            return result
        }
        let bulder = DINodeBuilder(
            position: node.builder.position,
            type: ((A1, A2, A3, A4)  -> Type).self, maker: { _ in
                handler
            }
        )
        bulder.info.identifier.tag = node.builder.info.identifier.tag
        return DINode(bulder)
    }
}
