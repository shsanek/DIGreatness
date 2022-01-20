final class DIBuilderDependencyStorage
{
    private var objects: [Int: [(signature: DISignatureIdentifier, value: Any)]] = [:]

    func fetchObject(node: DINode, arguments: [Any]) -> Any {
        if objects[node.hash] == nil {
            objects[node.hash] = []
        }
        if let obj = objects[node.hash]?.first(where: { $0.signature.checkAccept(signature: node.identifier) }) {
            return obj.value
        }
        let obj = node.make(storage: self, arguments)
        objects[node.hash]?.append((signature: node.identifier, value: obj))
        return obj
    }
}
