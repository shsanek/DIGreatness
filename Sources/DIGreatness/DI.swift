// swiftlint:disable type_name

/// Use to register and retrieve dependencies
public enum DI
{
    /// Build parts
    ///
    /// First, each part will recursively call subpars
    /// Then each part will have DIPart.registration called
    /// Then each part will have DIPart.resolve called
    ///
    /// Usage:
    ///
    ///     let part1 = DITestPart1()
    ///     let part2 = DITestPart2()
    ///     try DI.build([part1, part2])
    ///
    /// - Throws: return DIError
    ///
    /// - Important Build with each part must be called at most once
    public static func build(_ parts: [DIPart]) throws {
        let parts = parts.flatMap(\.allParts)
        var errorsContainer = DIErrorsContainer()

        let registrator = makeRegistrator(parts, errorsContainer: &errorsContainer)
        var resolver = makeResolver(registrator, errorsContainer: &errorsContainer)

        weak var weakResolver = resolver

        resolve(parts, resolver: resolver, errorsContainer: &errorsContainer)

        errorsContainer.do {
            try resolver?.checkUseNodes()
        }

        resolver = nil
        if weakResolver != nil {
            errorsContainer.addError(DIError.customError(type: .retainResolver, "Was captured resolver"))
        }
        try errorsContainer.throwIfNeeded()
    }
}

private extension DI
{
    static func makeRegistrator(
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

    static func makeResolver(
        _ registrator: DIRegistrator,
        errorsContainer: inout DIErrorsContainer
    ) -> DIResolver? {
        var resolver: DIResolver?
        errorsContainer.do {
            resolver = try DIResolver(registrator: registrator)
        }
        return resolver
    }

    static func resolve(
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
