final class DIBuilderDependencyStorage
{
    private var objects: [String: [(signature: DISignatureIdentifier, value: Any)]] = [:]

    func fetchObject(node: DINode, arguments: [Any]) -> Any {
        if objects[node.name] == nil {
            objects[node.name] = []
        }
        if let obj = objects[node.name]?.first(where: { $0.signature.checkAccept(signature: node.identifier) }) {
            return obj.value
        }
        let obj = node.make(storage: self, arguments)
        objects[node.name]?.append((signature: node.identifier, value: obj))
        return obj
    }
}
