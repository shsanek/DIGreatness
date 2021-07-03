public final class DIResolver
{
    private var nodes: [String: [DINode]] = [:]

    init(registrator: DIRegistrator) throws {
        try self.createNodes(registrator: registrator)
        try self.buildNodes()
    }
}

private extension DIResolver
{
    func createNodes(registrator: DIRegistrator) throws {
        registrator.builders.forEach { builder in
            let node = DINode(builder)
            self.addNode(node)
            self.addNode(builder.provider.make(with: node))
        }
    }

    func addNode(_ node: DINode) {
        if nodes[node.name] == nil {
            nodes[node.name] = []
        }
        nodes[node.name]?.append(node)
    }

    func buildNodes() throws {
        var errors: [Error] = []
        var context = DIValidateContext()
        nodes.forEach { container in
            container.value.forEach { node in
                do {
                    try buildNode(node: node, context: context)
                }
                catch {
                    context = DIValidateContext()
                    errors.append(error)
                }
            }
        }
        if errors.isEmpty == false {
            throw DIErrorsContainer(errors: errors)
        }
    }

    func buildNode(node: DINode, context: DIValidateContext, path: [DINode] = []) throws {
        if case .validated = node.state {
            return
        }
        if case .inProgress(let nodeContext) = node.state {
            if nodeContext === context {
                let text = "[\n\t" + (path + [node]).map { "\($0)" }.joined(separator: ",\n\t") + "\n]"
                throw DIError.customError(
                    "Found cyclic dependence:\(text)"
                )
            }
            return
        }
        node.state = .inProgress(context)

        var dependencies: [DINode] = []
        let path = path + [node]
        for dependency in node.builder.info.dependencies {
            dependencies.append(contentsOf: try self.buildDependency(dependency, node: node, context: context, path: path))
        }
        node.dependencies = dependencies
        node.state = .validated
        if case .singolton(let type) = node.builder.lifeTime, type == .preRun {
            _ = node.fetch([])
        }
    }

    func buildDependency(_ dependency: DISignatureDependency, node: DINode, context: DIValidateContext, path: [DINode]) throws -> [DINode] {
        let allAcceptNodes = nodes[dependency.identifier.name]?.filter { $0.identifier.checkAccept(signature: dependency.identifier) } ?? []
        if dependency.pool == false {
            if allAcceptNodes.count == 0 {
                throw DIError.customError(
                    // swiftlint:disable:next line_length
                    "Dependency for \(node.builder) no matching signatures \(dependency.identifier) found. Signatures for the given type: \(nodes[dependency.identifier.name]?.map(\.builder) ?? [])"
                )
            }
            else if allAcceptNodes.count > 1 {
                throw DIError.customError(
                    // swiftlint:disable:next line_length
                    "Dependency for \(node.builder) more than one matching signature registered \(dependency.identifier). Signatures for the given type: \(allAcceptNodes.map(\.builder))"
                )
            }
        }
        try allAcceptNodes.forEach { try buildNode(node: $0, context: context, path: path) }
        return allAcceptNodes
    }

    func resolve<Type>(tag: Any.Type, arguments: [Any], position: DICodePosition) throws -> Type {
        let argymentsType = arguments.map { type(of: $0) }
        let signature = DISignatureIdentifier(type: Type.self, inputs: argymentsType, tag: tag)
        let allAcceptNodes = self.nodes[signature.name]?.filter { $0.identifier.checkAccept(signature: signature) } ?? []
        if allAcceptNodes.count == 0 {
            throw DIError.customError(
                // swiftlint:disable:next line_length
                "For \(signature) in \(position) no matching signatures found. Signatures for the given type: \(nodes[signature.name]?.map(\.builder) ?? [])"
            )
        }
        else if allAcceptNodes.count > 1 {
            throw DIError.customError(
                // swiftlint:disable:next line_length
                "More than one matching signature registered \(signature) in \(position).  Signatures for the given type: \(allAcceptNodes.map(\.builder) )"
            )
        }
        let obj = allAcceptNodes[0].fetch(arguments)
        guard let result = obj as? Type else {
            throw DIError.customError(
                // swiftlint:disable:next line_length
                "More than one matching signature registered \(signature) in \(position). Signatures for the given type: \(allAcceptNodes.map(\.builder) )"
            )
        }
        return result
    }
}

public extension DIResolver
{
    func resolve<Type>(file: String = #file, line: Int = #line, tag: Any.Type = DIBaseTag.self, _ arguments: Any...) throws -> Type {
        let position = DICodePosition(file: file, line: line)
        return try resolve(tag: tag, arguments: arguments, position: position)
    }
}
