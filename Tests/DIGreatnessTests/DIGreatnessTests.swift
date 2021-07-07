import XCTest
import DIGreatness

final class DIGreatnessTests: XCTestCase
{

    /// Тест на resolve одного элемента
    func testResolve() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
            }
            .res { resolver in
                _ = try resolver.resolve() as DITestA
            }
        try DI.build([part])
    }

    /// Тест на resolve одного элемента при касте его типа optional
    func testResolveOptional() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
            }
            .res { resolver in
                _ = try resolver.resolve() as DITestA?
            }
        try DI.build([part])
    }

    /// Тест на resolve кложура для создания элемента
    func testResolveMaker() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
            }
            .res { resolver in
                let maker = try resolver.resolve() as () -> DITestA
                _ = maker()
            }
        try DI.build([part])
    }

    /// Тест на resolve элементов  которые связаны между собой
    func testResolveWithDependency() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                try registrator.register(DITestB.init)
            }
            .res { resolver in
                _ = try resolver.resolve() as DITestB
                let maker = try resolver.resolve() as () -> DITestB
                _ = maker()
            }
        try DI.build([part])
    }

    /// Тест на resolve элемента с внешними элементами
    func testResolveWithArgument() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register { DITestB(a: diArg($0)) }
            }
            .res { resolver in
                _ = try resolver.resolve(DITestA()) as DITestB
                let maker = try resolver.resolve() as (DITestA) -> DITestB
                _ = maker(DITestA())
            }
        try DI.build([part])
    }

    /// Тест на resolve элемента с несколькими зарегистрированными сигнатурами
    func testResolveMultiSignature() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                try registrator.register(DITestB.init)
                try registrator.register { DITestB(a: diArg($0)) }
            }
            .res { resolver in
                let maker1 = try resolver.resolve() as (DITestA) -> DITestB
                _ = maker1(DITestA())
                let maker2 = try resolver.resolve() as () -> DITestB
                _ = maker2()
            }
        try DI.build([part])
    }

    /// Тест базовой времени жизни элемента
    func testLifeTime() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                try registrator.register(DITestB.init)
                try registrator.register(DITestC.init)
            }
            .res { resolver in
                let c1 = try resolver.resolve() as DITestC
                XCTAssert(c1.a === c1.b.a)

                let c2 = try resolver.resolve() as DITestC
                XCTAssert(c2.a === c2.b.a)
                XCTAssert(c1.a !== c2.b.a)
            }
        try DI.build([part])
    }

    /// Тест .newEveryTime времени жизни элемента
    func testLifeTimeNewEveryTime() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                    .lifeTime(.prototype)
                try registrator.register(DITestB.init)
                try registrator.register(DITestC.init)
            }
            .res { resolver in
                let c1 = try resolver.resolve() as DITestC
                XCTAssert(c1.a !== c1.b.a)

                let c2 = try resolver.resolve() as DITestC
                XCTAssert(c2.a !== c2.b.a)
                XCTAssert(c1.a !== c2.b.a)
            }
        try DI.build([part])
    }

    /// Тест .singolton времени жизни элемента
    func testLifeTimeSingolton() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                    .lifeTime(.single)
                try registrator.register(DITestB.init)
                try registrator.register(DITestC.init)
            }
            .res { resolver in
                let c1 = try resolver.resolve() as DITestC
                XCTAssert(c1.a === c1.b.a)

                let c2 = try resolver.resolve() as DITestC
                XCTAssert(c2.a === c2.b.a)
                XCTAssert(c1.a === c2.b.a)
            }
        try DI.build([part])
    }

    /// Тест resolver с смешеными связями и внешними аргументами
    func testResolveWithDependencyAndExternalArgument() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                try registrator.register { $0 as DITestA }
                    .map { $0 as DITestProtocol }
                try registrator.register(DITestB.init)
                try registrator.register { DITestC(a: $0, b: diArg($1)) }
                try registrator.register(DITestD.init)
            }
            .res { resolver in
                let d = try resolver.resolve() as DITestD
                _ = d.c(d.b())
            }
        try DI.build([part])
    }

    /// Тест resolver с тэгам
    func testResolveWithTag() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                try registrator.register { $0 as DITestA }
                    .map { $0 as DITestProtocol }
                    .lifeTime(.single)
                    .tag(DITestTag.self)

                try registrator.register(DITestB.init)
                try registrator.register { DITestC(a: $0, b: diArg($1)) }
                try registrator.register { DITestD(a: diTag(tag: DITestTag.self, $0), b: $1, c: $2) }
            }
            .res { resolver in
                _ = try resolver.resolve() as DITestD
            }
        try DI.build([part])
    }

    /// Тест на  регстрацию нескольких Part
    func testResolveWithMultiPart() throws {
        let part1 = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                try registrator.register { $0 as DITestA }
                    .tag(DITestTag.self)
                    .map { $0 as DITestProtocol }
                    .lifeTime(.single)

                try registrator.register(DITestB.init)
            }
            .res { resolver in
                _ = try resolver.resolve() as DITestD
            }
        let part2 = DITestPart()
            .reg { registrator in
                try registrator.register { DITestC(a: $0, b: diArg($1)) }
                try registrator.register { DITestD(a: diTag(tag: DITestTag.self, $0), b: $1, c: $2) }
            }
            .res { resolver in
                _ = try resolver.resolve(tag: DITestTag.self) as DITestProtocol
            }
        try DI.build([part1, part2])
    }

    /// Проверка  Part
    func testPartInject() throws {
        let part = DITestInjectPart()
        try DI.build([part])
        let b = part.bMaker()
        _ = part.cMaker(b)
        XCTAssert(type(of: part.a) == DITestA.self)
        XCTAssert(type(of: part.b) == DITestB.self)
    }

    /// Тест всех элементов по заданой сигнатуре
    func testResolveList() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)

                try registrator.register { $0 as DITestA }
                    .map { $0 as DITestProtocol }

                try registrator.register(DITestB.init)
                    .map { $0 as DITestProtocol }

                try registrator.register {
                    diList($0) as [DITestProtocol]
                }
            }
            .res { resolver in
                let protocols = try resolver.resolve() as [DITestProtocol]
                XCTAssert(protocols.count == 2)
            }
        try DI.build([part])
    }

    /// Тест inject
    func testInject() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                try registrator.register { $0 as DITestA }
                    .map { $0 as DITestProtocol }
                try registrator.register(DITestB.init)
                try registrator.register { DITestC(a: $0, b: diArg($1)) }
                try registrator.register(DITestE.init)
                    .inject(\.a)
                    .inject(\.c)
            }
            .res { resolver in
                let e = try resolver.resolve() as DITestE
                let _ = try resolver.resolve() as DITestProtocol
                XCTAssert(e.a != nil)
                XCTAssert(e.c?(e.b) != nil)
            }
        try DI.build([part])
    }

    /// Тест проверки на циклы
    func testErrorSearchCycle() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DICycle1.init)
                try registrator.register(DICycle2.init)
                try registrator.register(DICycle3.init)
            }
            .res { res in
                let _ = try res.resolve() as DICycle1
            }
        do {
            try DI.build([part])
        }
        catch DIError.error(let error) {
            XCTAssert(error.type == .cyclicDependency)
            return
        }
        XCTFail("no cyclic dependency found")
    }

    /// Тест проверки на оцутсвие нужной сигнатуры
    func testErrorNoMatchingSignatures() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                try registrator.register(DITestC.init)
            }
            .res { res in
                let _ = try res.resolve() as DITestC
            }
        do {
            try DI.build([part])
        }
        catch DIError.error(let error) {
            XCTAssert(error.type == .signatureNotFound)
            return
        }
        XCTFail("no matching signatures found")
    }
}

extension DIGreatnessTests
{
    static var allTests = [
        ("testResolve", testResolve),
        ("testResolveOptional", testResolveOptional),
        ("testResolveMaker", testResolveMaker),
        ("testResolveWithDependency", testResolveWithDependency),
        ("testResolveWithArgument", testResolveWithArgument),
        ("testResolveMultiSignature", testResolveMultiSignature),
        ("testLifeTime", testLifeTime),
        ("testLifeTimeSingolton", testLifeTimeSingolton),
        ("testLifeTimeNewEveryTime", testLifeTimeNewEveryTime),
        ("testResolveWithDependencyAndExternalArgument", testResolveWithDependencyAndExternalArgument),
        ("testResolveWithTag", testResolveWithTag),
        ("testResolveWithMultiPart", testResolveWithMultiPart),
        ("testInject", testInject),
        ("testPartInject", testPartInject),
        ("testResolveList", testResolveList),
        ("testResolveWithMultiPart", testResolveWithMultiPart),
        ("testPartInject", testPartInject),
        ("testErrorSearchCycle", testErrorSearchCycle),
        ("testErrorNoMatchingSignatures", testErrorNoMatchingSignatures),
    ]
}
