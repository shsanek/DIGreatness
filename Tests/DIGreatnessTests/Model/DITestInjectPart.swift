import DIGreatness

final class DITestInjectPart: DIPart {
    @DIInject(tag: DITestTag.self) var b: DIProtocol
    @DIInject var a: DIProtocol
    @DIInject var bMaker: () -> DIB
    @DIInject var cMaker: (DIB) -> DIC

    func registration(_ registrator: DIRegistrator) throws {
        try registrator.register(DIA.init)
        try registrator.register { $0 as DIA }
            .map { $0 as DIProtocol }
        try registrator.register { $0 as DIB }
            .map { $0 as DIProtocol }
            .tag(DITestTag.self)
        try registrator.register(DIB.init)
        try registrator.register { DIC(a: $0, b: diArg($1)) }
        try registrator.register(DID.init)
    }
}
