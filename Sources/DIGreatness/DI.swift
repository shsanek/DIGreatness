public enum DI
{
    public static func load(_ parts: [DIPart]) throws {
        let parts = parts.flatMap(\.allParts)
        var errors: [Error] = []
        let registrator = DIRegistrator()
        parts.forEach {
            do {
                try $0.registration(registrator)
            }
            catch {
                if let container = error as? DIErrorsContainer {
                    errors.append(contentsOf: container.errors)
                }
                else {
                    errors.append(error)
                }
            }
        }
        var container: DIResolver? = try DIResolver(registrator: registrator)
        weak var weakContainer = container
        if let container = container {
            parts.forEach {
                do {
                    try $0.resolve(container)
                }
                catch {
                    if let container = error as? DIErrorsContainer {
                        errors.append(contentsOf: container.errors)
                    }
                    else {
                        errors.append(error)
                    }
                }
            }
        }

        container = nil
        if weakContainer != nil {
            errors.append(DIError.customError(
                "Was captured resolver"
            ))
        }
        if errors.isEmpty == false {
            throw DIErrorsContainer(errors: errors)
        }
    }
}
