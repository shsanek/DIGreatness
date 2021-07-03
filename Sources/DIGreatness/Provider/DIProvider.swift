protocol DIProvider
{
    var inputs: [Any.Type] { get }
    func returnType<Result>(_ result: Result.Type) -> DIProvider
    func addArgument<Arg>(_ argument: Arg.Type) throws -> DIProvider
    func make(with node: DINode) -> DINode
}
