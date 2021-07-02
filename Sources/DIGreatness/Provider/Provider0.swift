struct Provider0<Type>: DIProvider {
    var inputs: [Any.Type] { [] }
    func returnType<Result>(_ result: Result.Type) -> DIProvider {
        return Provider0<Result>()
    }

    func addArgument<Arg>(_ argument: Arg.Type) throws -> DIProvider {
        return Provider1<Type, Arg>()
    }
    
    func make(with node: DINode) -> DINode {
        let handler: () -> Type = {
            let obj = node.fetch([])
            guard let result = obj as? Type else {
                fatalError("[DI]Incorect type '\(obj)' is not '\(Type.self)'")
            }
            return result
        }
        let bulder = DINodeBuilder(
            position: node.builder.position,
            type: (() -> Type).self, maker: { _ in
                handler
            }
        )
        bulder.info.identifier.tag = node.builder.info.identifier.tag
        return DINode(bulder)
    }
}
