import XCTest
import DIGreatness

final class DIGreatnessTests: XCTestCase {
    func test1() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init)
            }
            .res { resolver in
                let _ = try resolver.resolve() as DIA
            }
        try DI.load([part])
    }
    
    func test2() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init)
            }
            .res { resolver in
                let _ = try resolver.resolve() as DIA?
            }
        try DI.load([part])
    }
    
    func test3() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init)
            }
            .res { resolver in
                let maker = try resolver.resolve() as () -> DIA
                let _ = maker()
            }
        try DI.load([part])
    }
    
    func test4() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init)
                try registrator.register(DIB.init)
            }
            .res { resolver in
                let maker = try resolver.resolve() as () -> DIB
                let _ = maker()
            }
        try DI.load([part])
    }
    
    func test5() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register { DIB(a: diArg($0)) }
            }
            .res { resolver in
                let _ = try resolver.resolve(DIA()) as DIB
                let maker = try resolver.resolve() as (DIA) -> DIB
                let _ = maker(DIA())
            }
        try DI.load([part])
    }
    
    func test6() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init)
                try registrator.register(DIB.init)
                try registrator.register { DIB(a: diArg($0)) }
            }
            .res { resolver in
                let maker1 = try resolver.resolve() as (DIA) -> DIB
                let _ = maker1(DIA())
                let maker2 = try resolver.resolve() as () -> DIB
                let _ = maker2()
            }
        try DI.load([part])
    }

    func test7() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init)
                try registrator.register(DIB.init)
                try registrator.register(DIC.init)
            }
            .res { resolver in
                let c1 = try resolver.resolve() as DIC
                XCTAssert(c1.a === c1.b.a)
                
                let c2 = try resolver.resolve() as DIC
                XCTAssert(c2.a === c2.b.a)
                XCTAssert(c1.a !== c2.b.a)
            }
        try DI.load([part])
    }
    
    func test8() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init).lifeTime(.newEveryTime)
                try registrator.register(DIB.init)
                try registrator.register(DIC.init)
            }
            .res { resolver in
                let c1 = try resolver.resolve() as DIC
                XCTAssert(c1.a !== c1.b.a)
                
                let c2 = try resolver.resolve() as DIC
                XCTAssert(c2.a !== c2.b.a)
                XCTAssert(c1.a !== c2.b.a)
            }
        try DI.load([part])
    }
    
    func test9() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init).lifeTime(.singolton(.lazy))
                try registrator.register(DIB.init)
                try registrator.register(DIC.init)
            }
            .res { resolver in
                let c1 = try resolver.resolve() as DIC
                XCTAssert(c1.a === c1.b.a)
                
                let c2 = try resolver.resolve() as DIC
                XCTAssert(c2.a === c2.b.a)
                XCTAssert(c1.a === c2.b.a)
            }
        try DI.load([part])
    }
    
    func test10() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init)
                try registrator.register { $0 as DIA }
                    .map { $0 as DIProtocol }
                try registrator.register(DIB.init)
                try registrator.register { DIC(a: $0, b: diArg($1)) }
                try registrator.register(DID.init)
            }
            .res { resolver in
                let d = try resolver.resolve() as DID
                let _ = d.c(d.b())
            }
        try DI.load([part])
    }
    
    func test11() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init)
                try registrator.register { $0 as DIA }
                    .map { $0 as DIProtocol }
                    .lifeTime(.singolton(.lazy))
                    .tag(DITestTag.self)
                
                try registrator.register(DIB.init)
                try registrator.register { DIC(a: $0, b: diArg($1)) }
                try registrator.register { DID.init(a: diTag(tag: DITestTag.self, $0), b: $1, c: $2) }
            }
            .res { resolver in
                let _ = try resolver.resolve() as DID
            }
        try DI.load([part])
    }
    
    func test12() throws {
        let part1 = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init)
                try registrator.register { $0 as DIA }
                    .tag(DITestTag.self)
                    .map { $0 as DIProtocol }
                    .lifeTime(.singolton(.lazy))
                
                try registrator.register(DIB.init)
            }
            .res { resolver in
                let _ = try resolver.resolve() as DID
            }
        let part2 = DITestPart()
            .reg { registrator in
                try registrator.register { DIC(a: $0, b: diArg($1)) }
                try registrator.register { DID.init(a: diTag(tag: DITestTag.self, $0), b: $1, c: $2) }
            }
            .res { resolver in
                let _ = try resolver.resolve(tag: DITestTag.self) as DIProtocol
            }
        try DI.load([part1, part2])
    }
    
    func test13() throws {
        let part1 = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init)
                try registrator.register { $0 as DIA }
                    .tag(DITestTag.self)
                    .map { $0 as DIProtocol }
                    .lifeTime(.singolton(.lazy))
                
                try registrator.register(DIB.init)
            }
            .res { resolver in
                let _ = try resolver.resolve() as DID
            }
        let part2 = DITestPart()
            .reg { registrator in
                try registrator.register { DIC(a: $0, b: diArg($1)) }
                try registrator.register { DID.init(a: diTag(tag: DITestTag.self, $0), b: $1, c: $2) }
            }
            .res { resolver in
                let _ = try resolver.resolve(tag: DITestTag.self) as () -> DIProtocol
            }
        try DI.load([part1, part2])
    }
    
    func test14() throws {
        let part = DITestInjectPart()
        try DI.load([part])
        let b = part.bMaker()
        let _ = part.cMaker(b)
        XCTAssert(type(of: part.a) == DIA.self)
        XCTAssert(type(of: part.b) == DIB.self)
    }
    
    func test15() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init)

                try registrator.register { $0 as DIA }
                    .map { $0 as DIProtocol }
    
                try registrator.register(DIB.init)
                    .map { $0 as DIProtocol }
                
                try registrator.register {
                    diList($0) as [DIProtocol]
                }
            }
            .res { resolver in
                let protocols = try resolver.resolve() as [DIProtocol]
                XCTAssert(protocols.count == 2)
            }
        try DI.load([part])
    }
    
    func test16() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init)
                try registrator.register { $0 as DIA }
                    .map { $0 as DIProtocol }
                try registrator.register(DIB.init)
                try registrator.register { DIC(a: $0, b: diArg($1)) }
                try registrator.register(DIE.init)
                    .inject(\.a)
                    .inject(\.c)
            }
            .res { resolver in
                let e = try resolver.resolve() as DIE
                XCTAssert(e.a != nil)
                XCTAssert(e.c?(e.b) != nil)
            }
        try DI.load([part])
    }
    
    func test17() throws {
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
    
    func test18() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DIA.init)
                try registrator.register(DIC.init)
            }
            .res { resolver in
                _ = try resolver.resolve() as DIA
            }
        do {
            try DI.load([part])
        }
        catch {
            XCTAssert("\(error)".contains("no matching signatures"))
            return
        }
        XCTFail("no cyclic dependency found")
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
        ("test17", test17)
    ]
}
