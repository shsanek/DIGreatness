import XCTest
import DIGreatness

final class DIGreatnessTests: XCTestCase
{

    /// Тест на resolve одного элемента
    func test01_resolve() throws {
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
    func test02_resolveOptional() throws {
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
    func test03_resolveMaker() throws {
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
    func test04_resolveWithDependency() throws {
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
    func test05_resolveWithArgument() throws {
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
    func test06_resolveMultiSignature() throws {
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
    func test07_lifeTime() throws {
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
    func test08_lifeTimeNewEveryTime() throws {
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
    func test09_lifeTimeSingolton() throws {
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
    func test10_resolveWithDependencyAndExternalArgument() throws {
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
    func test11_resolveWithTag() throws {
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
    func test12_resolveWithMultiPart() throws {
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
    func test13_partInject() throws {
        let part = DITestInjectPart()
        try DI.build([part])
        let b = part.bMaker()
        _ = part.cMaker(b)
        XCTAssert(type(of: part.a) == DITestA.self)
        XCTAssert(type(of: part.b) == DITestB.self)
    }

    /// Тест всех элементов по заданой сигнатуре
    func test14_resolveList() throws {
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
    func test15_inject() throws {
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
                _ = try resolver.resolve() as DITestProtocol
                XCTAssert(e.a != nil)
                XCTAssert(e.c?(e.b) != nil)
            }
        try DI.build([part])
    }
}

extension DIGreatnessTests
{
    static var allTests = [
        ("test01_resolve", test01_resolve),
        ("test02_resolveOptional", test02_resolveOptional),
        ("test03_resolveMaker", test03_resolveMaker),
        ("test04_resolveWithDependency", test04_resolveWithDependency),
        ("test05_resolveWithArgument", test05_resolveWithArgument),
        ("test06_resolveMultiSignature", test06_resolveMultiSignature),
        ("test07_lifeTime", test07_lifeTime),
        ("test08_lifeTimeNewEveryTime", test08_lifeTimeNewEveryTime),
        ("test09_lifeTimeSingolton", test09_lifeTimeSingolton),
        ("test10_resolveWithDependencyAndExternalArgument", test10_resolveWithDependencyAndExternalArgument),
        ("test11_resolveWithTag", test11_resolveWithTag),
        ("test12_resolveWithMultiPart", test12_resolveWithMultiPart),
        ("test13_partInject", test13_partInject),
        ("test14_resolveList", test14_resolveList),
        ("test15_inject", test15_inject),
    ]
}
