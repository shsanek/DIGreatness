public struct DISignatureIdentifier {
    var type: Any.Type
    var inputs: [Any.Type] = []
    var tag: Any.Type = DIBaseTag.self

    var name: String {
        return "\((type as? DIContainerType.Type)?.baseType ?? type)"
    }

    func checkAccept(signature: DISignatureIdentifier) -> Bool {
        return checkAccept(type: signature.type, inputType: type) &&
            tag == signature.tag &&
            checkInputs(inputs: signature.inputs)
    }

    private func checkInputs(inputs: [Any.Type]) -> Bool {
        guard inputs.count == self.inputs.count else {
            return false
        }
        for i in 0..<inputs.count {
            if checkAccept(type: self.inputs[i], inputType: inputs[i]) == false {
                return false
            }
        }
        return true
    }

    private func checkAccept(type: Any.Type?, inputType: Any.Type?) -> Bool {
        if type == nil, inputType == nil {
            return true
        }
        guard let type = type, let inputType = inputType else {
            return false
        }
        if let optionalInterface = type as? DIContainerType.Type, optionalInterface.baseType == inputType {
            return true
        }
        return type == inputType
    }
}

extension DISignatureIdentifier: CustomDebugStringConvertible {
    public var debugDescription: String {
        let inputs = self.inputs.map { "\($0)" }.joined(separator: ", ")
        if tag == DIBaseTag.self {
            return "<Signature: [\(inputs)] -> (\(type))>"
        }
        else {
            return "<Signature: #\(tag)#[\(inputs)] -> (\(type))>"
        }
    }
}
