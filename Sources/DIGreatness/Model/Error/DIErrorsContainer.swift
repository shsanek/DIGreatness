public struct DIErrorsContainer
{
    public var errors: [Error] = []

    public var diErrors: [DIErrorInfo] {
        self.errors.compactMap { $0 as? DIError }.compactMap { error -> DIErrorInfo? in
            if case .error(let info) = error {
                return info
            }
            return nil
        }
    }
}

extension DIErrorsContainer
{
    mutating func `do`(_ block: () throws -> Void) {
        do {
            try block()
        }
        catch DIError.container(let container) {
            self.errors.append(contentsOf: container.errors)
        }
        catch {
            self.errors.append(error)
        }
    }

    mutating func addError(_ error: Error) {
        self.errors.append(error)
    }

    func throwIfNeeded() throws {
        if errors.isEmpty == false {
            if errors.count == 1 {
                throw self.errors[0]
            }
            else {
                throw DIError.container(self)
            }
        }
    }
}

extension DIErrorsContainer: CustomDebugStringConvertible
{
    public var debugDescription: String {
        return errors.map { "\($0)" }.joined(separator: "\n\n")
    }
}
