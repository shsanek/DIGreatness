struct Provider9<Type, A1, A2, A3, A4, A5, A6, A7, A8, A9>: DIProvider {
    var inputs: [Any.Type] { [A1.self, A2.self, A3.self, A4.self, A5.self, A6.self, A7.self, A8.self, A9.self] }

    func returnType<Result>(_ result: Result.Type) -> DIProvider {
        return Provider9<Result, A1, A2, A3, A4, A5, A6, A7, A8, A9>()
    }

    func addArgument<Arg>(_ argument: Arg.Type) throws -> DIProvider {
        return Provider10<Type, A1, A2, A3, A4, A5, A6, A7, A8, A9, Arg>()
    }
    
    func make(with node: DINode) -> DINode {
        let handler: (A1, A2, A3, A4, A5, A6, A7, A8, A9) -> Type = { a1, a2, a3, a4, a5, a6, a7, a8, a9 in
            let obj = node.fetch([a1, a2, a3, a4, a5, a6, a7, a8, a9])
            guard let result = obj as? Type else {
                fatalError("[DI]Incorect type '\(obj)' is not '\(Type.self)'")
            }
            return result
        }
        let bulder = DINodeBuilder(
            position: node.builder.position,
            type: ((A1, A2, A3, A4, A5, A6, A7, A8, A9)  -> Type).self, maker: { _ in
                handler
            }
        )
        bulder.info.identifier.tag = node.builder.info.identifier.tag
        return DINode(bulder)
    }
}
