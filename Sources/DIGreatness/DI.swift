// swiftlint:disable type_name
public enum DI
{
    public static func build(_ parts: [DIPart]) throws {
        let parts = parts.flatMap(\.allParts)
        var errorsContainer = DIErrorsContainer()

        let registrator = makeRegistrator(parts, errorsContainer: &errorsContainer)
        var resolver = makeResolver(registrator, errorsContainer: &errorsContainer)

        weak var weakResolver = resolver

        resolve(parts, resolver: resolver, errorsContainer: &errorsContainer)

        resolver = nil
        if weakResolver != nil {
            errorsContainer.addError(DIError.customError("Was captured resolver"))
        }

        try errorsContainer.throwIfNeeded()
    }

    private static func makeRegistrator(
        _ parts: [DIPart],
        errorsContainer: inout DIErrorsContainer
    ) -> DIRegistrator {
        let registrator = DIRegistrator()
        parts.forEach { part in
            errorsContainer.do {
                try part.registration(registrator)
            }
        }
        return registrator
    }

    private static func makeResolver(
        _ registrator: DIRegistrator,
        errorsContainer: inout DIErrorsContainer
    ) -> DIResolver? {
        var resolver: DIResolver?
        errorsContainer.do {
            resolver = try DIResolver(registrator: registrator)
        }
        return resolver
    }

    private static func resolve(
        _ parts: [DIPart],
        resolver: DIResolver?,
        errorsContainer: inout DIErrorsContainer
    ) {
        if let resolver = resolver {
            parts.forEach { part in
                errorsContainer.do {
                    try part.resolve(resolver)
                }
            }
        }
    }
}
