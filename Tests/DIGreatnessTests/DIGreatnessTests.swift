import XCTest
import DIGreatness

final class DIGreatnessTests: XCTestCase {

    /// Тест на resolve одного элемента
    func test1() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
            }
            .res { resolver in
                _ = try resolver.resolve() as DITestA
            }
        try DI.load([part])
    }

    /// Тест на resolve одного элемента при касте его типа optional
    func test2() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
            }
            .res { resolver in
                _ = try resolver.resolve() as DITestA?
            }
        try DI.load([part])
    }

    /// Тест на resolve кложура для создания элемента
    func test3() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
            }
            .res { resolver in
                let maker = try resolver.resolve() as () -> DITestA
                _ = maker()
            }
        try DI.load([part])
    }

    /// Тест на resolve элементов  которые связаны между собой
    func test4() throws {
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
        try DI.load([part])
    }

    /// Тест на resolve элемента с внешними элементами
    func test5() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register { DITestB(a: diArg($0)) }
            }
            .res { resolver in
                _ = try resolver.resolve(DITestA()) as DITestB
                let maker = try resolver.resolve() as (DITestA) -> DITestB
                _ = maker(DITestA())
            }
        try DI.load([part])
    }

    /// Тест на resolve элемента с несколькими харегистрированными сигнатурами
    func test6() throws {
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
        try DI.load([part])
    }

    /// Тест базовой времени жизни элемента
    func test7() throws {
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
        try DI.load([part])
    }

    /// Тест .newEveryTime времени жизни элемента
    func test8() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init).lifeTime(.newEveryTime)
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
        try DI.load([part])
    }

    /// Тест .singolton времени жизни элемента
    func test9() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init).lifeTime(.singolton(.lazy))
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
        try DI.load([part])
    }

    /// Тест resolver с смешеными связями и внешними аргументами
    func test10() throws {
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
        try DI.load([part])
    }

    /// Тест resolver с тэгам
    func test11() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                try registrator.register { $0 as DITestA }
                    .map { $0 as DITestProtocol }
                    .lifeTime(.singolton(.lazy))
                    .tag(DITestTag.self)

                try registrator.register(DITestB.init)
                try registrator.register { DITestC(a: $0, b: diArg($1)) }
                try registrator.register { DITestD(a: diTag(tag: DITestTag.self, $0), b: $1, c: $2) }
            }
            .res { resolver in
                _ = try resolver.resolve() as DITestD
            }
        try DI.load([part])
    }

    /// Тест на  регстрацию нескольких Part
    func test12() throws {
        let part1 = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                try registrator.register { $0 as DITestA }
                    .tag(DITestTag.self)
                    .map { $0 as DITestProtocol }
                    .lifeTime(.singolton(.lazy))

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
        try DI.load([part1, part2])
    }

    /// Проверка регстрации нескольких Part
    func test13() throws {
        let part = DITestInjectPart()
        try DI.load([part])
        let b = part.bMaker()
        _ = part.cMaker(b)
        XCTAssert(type(of: part.a) == DITestA.self)
        XCTAssert(type(of: part.b) == DITestB.self)
    }

    /// Тест всех элементов по заданой сигнатуре
    func test14() throws {
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
        try DI.load([part])
    }

    /// Тест inject
    func test15() throws {
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
                XCTAssert(e.a != nil)
                XCTAssert(e.c?(e.b) != nil)
            }
        try DI.load([part])
    }

    /// Тест проверки на циклы
    func test16() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DIСycle1.init)
                try registrator.register(DIСycle2.init)
                try registrator.register(DIСycle3.init)
            }
            .res { _ in
            }
        do {
            try DI.load([part])
        }
        catch {
            XCTAssert("\(error)".hasPrefix("Found cyclic dependence"))
            return
        }
        XCTFail("no cyclic dependency found")
    }

    /// Тест проверки на оцутсвие нужной сигнатуры
    func test17() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                try registrator.register(DITestC.init)
            }
            .res { _ in
            }
        do {
            try DI.load([part])
        }
        catch {
            XCTAssert("\(error)".contains("no matching signatures"))
            return
        }
        XCTFail("no matching signatures found")
    }
}

extension DIGreatnessTests {
    static var allTests = [
        ("test1", test1),
        ("test2", test2),
        ("test3", test3),
        ("test4", test4),
        ("test5", test5),
        ("test6", test6),
        ("test7", test7),
        ("test8", test8),
        ("test9", test9),
        ("test10", test10),
        ("test11", test11),
        ("test12", test12),
        ("test13", test13),
        ("test14", test14),
        ("test15", test15),
        ("test16", test16),
        ("test17", test17),
    ]
}
