import XCTest
import DIGreatness

final class DIErrorsTests: XCTestCase
{
    func test01_errorSearchCycle() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DICycle1.init)
                try registrator.register(DICycle2.init)
                try registrator.register(DICycle3.init)
            }
            .res { res in
                _ = try res.resolve() as DICycle1
            }
        do {
            try DI.build([part])
        }
        catch DIError.error(let error) {
            XCTAssert(error.type == .cyclicDependency)
            return
        }
        XCTFail("error not found")
    }

    func test02_errorNoMatchingSignatures() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                try registrator.register(DITestC.init)
            }
            .res { res in
                _ = try res.resolve() as DITestC
            }
        do {
            try DI.build([part])
        }
        catch DIError.error(let error) {
            XCTAssert(error.type == .signatureNotFound)
            return
        }
        XCTFail("error not found")
    }

    func test03_errorNotUsedNode() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
            }
            .res { _ in
            }
        do {
            try DI.build([part])
        }
        catch DIError.error(let error) {
            XCTAssert(error.type == .notUsedNode)
            return
        }
        XCTFail("error not found")
    }

    func test04_errorNotRetain() throws {
        var resolver: DIResolver?
        let part = DITestPart()
            .reg { _ in
            }
            .res { res in
                resolver = res
            }
        do {
            try DI.build([part])
        }
        catch DIError.error(let error) {
            XCTAssert(error.type == .retainResolver)
            return
        }
        _ = resolver
        XCTFail("error not found")
    }

    func test05_errorMultiRegistration() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register(DITestA.init)
                try registrator.register(DITestA.init)
            }
            .res { res in
                _ = try res.resolve() as DITestA
            }
        do {
            try DI.build([part])
        }
        catch DIError.container(let container) {
            XCTAssert(container.diErrors.contains(where: { $0.type == .moreOneMatchingSignature }))
            return
        }
        XCTFail("error not found")
    }

    func test06_errorIncorectLifetime() throws {
        let part = DITestPart()
            .reg { registrator in
                try registrator.register { DITestB(a: diArg($0)) }.lifeTime(.single)
            }
            .res { _ in
            }
        do {
            try DI.build([part])
        }
        catch DIError.container(let container) {
            XCTAssert(container.diErrors.contains(where: { $0.type == .incorectLifetime }))
            return
        }
        XCTFail("error not found")
    }
}

extension DIErrorsTests
{
    static var allTests = [
        ("test01_errorSearchCycle", test01_errorSearchCycle),
        ("test02_errorNoMatchingSignatures", test02_errorNoMatchingSignatures),
        ("test03_errorNotUsedNode", test03_errorNotUsedNode),
        ("test04_errorNotRetain", test04_errorNotRetain),
        ("test05_errorMultiRegistration", test05_errorMultiRegistration),
        ("test06_errorIncorectLifetime", test06_errorIncorectLifetime),
    ]
}
