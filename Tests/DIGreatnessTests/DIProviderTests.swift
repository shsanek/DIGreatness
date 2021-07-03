
import XCTest
import DIGreatness

final class DIProviderTests: XCTestCase
{

    /// Тест register на все доступное колчество аргументов
    func test1() throws {
        let part = self.makePart()

        part.res { res in
            let m0 = try res.resolve() as DITestModel0
            let m1 = try res.resolve(m0) as DITestModel1
            let m2 = try res.resolve(m0, m1) as DITestModel2
            let m3 = try res.resolve(m0, m1, m2) as DITestModel3
            let m4 = try res.resolve(m0, m1, m2, m3) as DITestModel4
            let m5 = try res.resolve(m0, m1, m2, m3, m4) as DITestModel5
            let m6 = try res.resolve(m0, m1, m2, m3, m4, m5) as DITestModel6
            let m7 = try res.resolve(m0, m1, m2, m3, m4, m5, m6) as DITestModel7
            let m8 = try res.resolve(m0, m1, m2, m3, m4, m5, m6, m7) as DITestModel8
            let m9 = try res.resolve(m0, m1, m2, m3, m4, m5, m6, m7, m8) as DITestModel9
            let m10 = try res.resolve(m0, m1, m2, m3, m4, m5, m6, m7, m8, m9) as DITestModel10
            let m11 = try res.resolve(m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10) as DITestModel11
            let m12 = try res.resolve(m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11) as DITestModel12
            let m13 = try res.resolve(m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12) as DITestModel13
            let m14 = try res.resolve(m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13) as DITestModel14
            _ = try res.resolve(m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14) as DITestModel15
        }

        try DI.load([part])
    }

    /// Тест register на все доступное колчество аргументов
    func test2() throws {
        let part = self.makePart()
        part.res { res in
            let m0 = (try res.resolve() as () -> DITestModel0)()

            let m1 = (try res.resolve() as (
                DITestModel0
            ) -> DITestModel1)(m0)

            let m2 = (try res.resolve() as (
                DITestModel0,
                DITestModel1
            ) -> DITestModel2)(m0, m1)

            let m3 = (try res.resolve() as (
                DITestModel0,
                DITestModel1,
                DITestModel2
            ) -> DITestModel3)(m0, m1, m2)

            let m4 = (try res.resolve() as (
                DITestModel0,
                DITestModel1,
                DITestModel2,
                DITestModel3
            ) -> DITestModel4)(m0, m1, m2, m3)

            let m5 = (try res.resolve() as (
                DITestModel0,
                DITestModel1,
                DITestModel2,
                DITestModel3,
                DITestModel4
            ) -> DITestModel5)(m0, m1, m2, m3, m4)

            let m6 = (try res.resolve() as (
                DITestModel0,
                DITestModel1,
                DITestModel2,
                DITestModel3,
                DITestModel4,
                DITestModel5
            ) -> DITestModel6)(m0, m1, m2, m3, m4, m5)

            let m7 = (try res.resolve() as (
                DITestModel0,
                DITestModel1,
                DITestModel2,
                DITestModel3,
                DITestModel4,
                DITestModel5,
                DITestModel6
            ) -> DITestModel7)(m0, m1, m2, m3, m4, m5, m6)

            let m8 = (try res.resolve() as (
                DITestModel0,
                DITestModel1,
                DITestModel2,
                DITestModel3,
                DITestModel4,
                DITestModel5,
                DITestModel6,
                DITestModel7
            ) -> DITestModel8)(m0, m1, m2, m3, m4, m5, m6, m7)

            let m9 = (try res.resolve() as (
                DITestModel0,
                DITestModel1,
                DITestModel2,
                DITestModel3,
                DITestModel4,
                DITestModel5,
                DITestModel6,
                DITestModel7,
                DITestModel8
            ) -> DITestModel9)(m0, m1, m2, m3, m4, m5, m6, m7, m8)

            let m10 = (try res.resolve() as (
                DITestModel0,
                DITestModel1,
                DITestModel2,
                DITestModel3,
                DITestModel4,
                DITestModel5,
                DITestModel6,
                DITestModel7,
                DITestModel8,
                DITestModel9
            ) -> DITestModel10)(m0, m1, m2, m3, m4, m5, m6, m7, m8, m9)

            let m11 = (try res.resolve() as (
                DITestModel0,
                DITestModel1,
                DITestModel2,
                DITestModel3,
                DITestModel4,
                DITestModel5,
                DITestModel6,
                DITestModel7,
                DITestModel8,
                DITestModel9,
                DITestModel10
            ) -> DITestModel11)(m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10)

            let m12 = (try res.resolve() as (
                DITestModel0,
                DITestModel1,
                DITestModel2,
                DITestModel3,
                DITestModel4,
                DITestModel5,
                DITestModel6,
                DITestModel7,
                DITestModel8,
                DITestModel9,
                DITestModel10,
                DITestModel11
            ) -> DITestModel12)(m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11)

            let m13 = (try res.resolve() as (
                DITestModel0,
                DITestModel1,
                DITestModel2,
                DITestModel3,
                DITestModel4,
                DITestModel5,
                DITestModel6,
                DITestModel7,
                DITestModel8,
                DITestModel9,
                DITestModel10,
                DITestModel11,
                DITestModel12
            ) -> DITestModel13)(m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12)

            let m14 = (try res.resolve() as (
                DITestModel0,
                DITestModel1,
                DITestModel2,
                DITestModel3,
                DITestModel4,
                DITestModel5,
                DITestModel6,
                DITestModel7,
                DITestModel8,
                DITestModel9,
                DITestModel10,
                DITestModel11,
                DITestModel12,
                DITestModel13
            ) -> DITestModel14)(m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13)

            _ = (try res.resolve() as (
                DITestModel0,
                DITestModel1,
                DITestModel2,
                DITestModel3,
                DITestModel4,
                DITestModel5,
                DITestModel6,
                DITestModel7,
                DITestModel8,
                DITestModel9,
                DITestModel10,
                DITestModel11,
                DITestModel12,
                DITestModel13,
                DITestModel14
            ) -> DITestModel15)(m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14)
        }
        try DI.load([part])
    }

    /// Тест register на все доступное колчество аргументов
    func test3() throws {
        let part = DITestPart()

        part.reg { reg in
            try reg.register(DITestModel0.init)
            try reg.register(DITestModel1.init)
            try reg.register(DITestModel2.init)
            try reg.register(DITestModel3.init)
            try reg.register(DITestModel4.init)
            try reg.register(DITestModel5.init)
            try reg.register(DITestModel6.init)
            try reg.register(DITestModel7.init)
            try reg.register(DITestModel8.init)
            try reg.register(DITestModel9.init)
            try reg.register(DITestModel10.init)
            try reg.register(DITestModel11.init)
            try reg.register(DITestModel12.init)
            try reg.register(DITestModel13.init)
            try reg.register(DITestModel14.init)
            try reg.register(DITestModel15.init)
        }

        part.res { res in
            _ = try res.resolve() as DITestModel0
            _ = try res.resolve() as DITestModel1
            _ = try res.resolve() as DITestModel2
            _ = try res.resolve() as DITestModel3
            _ = try res.resolve() as DITestModel4
            _ = try res.resolve() as DITestModel5
            _ = try res.resolve() as DITestModel6
            _ = try res.resolve() as DITestModel7
            _ = try res.resolve() as DITestModel8
            _ = try res.resolve() as DITestModel9
            _ = try res.resolve() as DITestModel10
            _ = try res.resolve() as DITestModel11
            _ = try res.resolve() as DITestModel12
            _ = try res.resolve() as DITestModel13
            _ = try res.resolve() as DITestModel14
            _ = try res.resolve() as DITestModel15
        }
        try DI.load([part])
    }
}

private extension DIProviderTests
{
    func makePart() -> DITestPart {
        let part = DITestPart()
        part.reg { reg in
            try reg.register(DITestModel0.init)
            try reg.register {
                DITestModel1(
                    m0: diArg($0)
                )
            }
            try reg.register {
                DITestModel2(
                    m0: diArg($0),
                    m1: diArg($1)
                )
            }
            try reg.register {
                DITestModel3(
                    m0: diArg($0),
                    m1: diArg($1),
                    m2: diArg($2)
                )
            }
            try reg.register {
                DITestModel4(
                    m0: diArg($0),
                    m1: diArg($1),
                    m2: diArg($2),
                    m3: diArg($3)
                )
            }
            try reg.register {
                DITestModel5(
                    m0: diArg($0),
                    m1: diArg($1),
                    m2: diArg($2),
                    m3: diArg($3),
                    m4: diArg($4)
                )
            }
            try reg.register {
                DITestModel6(
                    m0: diArg($0),
                    m1: diArg($1),
                    m2: diArg($2),
                    m3: diArg($3),
                    m4: diArg($4),
                    m5: diArg($5)
                )
            }
            try reg.register {
                DITestModel7(
                    m0: diArg($0),
                    m1: diArg($1),
                    m2: diArg($2),
                    m3: diArg($3),
                    m4: diArg($4),
                    m5: diArg($5),
                    m6: diArg($6)
                )
            }
            try reg.register {
                DITestModel8(
                    m0: diArg($0),
                    m1: diArg($1),
                    m2: diArg($2),
                    m3: diArg($3),
                    m4: diArg($4),
                    m5: diArg($5),
                    m6: diArg($6),
                    m7: diArg($7)
                )
            }
            try reg.register {
                DITestModel9(
                    m0: diArg($0),
                    m1: diArg($1),
                    m2: diArg($2),
                    m3: diArg($3),
                    m4: diArg($4),
                    m5: diArg($5),
                    m6: diArg($6),
                    m7: diArg($7),
                    m8: diArg($8)
                )
            }
            try reg.register {
                DITestModel10(
                    m0: diArg($0),
                    m1: diArg($1),
                    m2: diArg($2),
                    m3: diArg($3),
                    m4: diArg($4),
                    m5: diArg($5),
                    m6: diArg($6),
                    m7: diArg($7),
                    m8: diArg($8),
                    m9: diArg($9)
                )
            }
            try reg.register {
                DITestModel11(
                    m0: diArg($0),
                    m1: diArg($1),
                    m2: diArg($2),
                    m3: diArg($3),
                    m4: diArg($4),
                    m5: diArg($5),
                    m6: diArg($6),
                    m7: diArg($7),
                    m8: diArg($8),
                    m9: diArg($9),
                    m10: diArg($10)
                )
            }
            try reg.register {
                DITestModel12(
                    m0: diArg($0),
                    m1: diArg($1),
                    m2: diArg($2),
                    m3: diArg($3),
                    m4: diArg($4),
                    m5: diArg($5),
                    m6: diArg($6),
                    m7: diArg($7),
                    m8: diArg($8),
                    m9: diArg($9),
                    m10: diArg($10),
                    m11: diArg($11)
                )
            }
            try reg.register {
                DITestModel13(
                    m0: diArg($0),
                    m1: diArg($1),
                    m2: diArg($2),
                    m3: diArg($3),
                    m4: diArg($4),
                    m5: diArg($5),
                    m6: diArg($6),
                    m7: diArg($7),
                    m8: diArg($8),
                    m9: diArg($9),
                    m10: diArg($10),
                    m11: diArg($11),
                    m12: diArg($12)
                )
            }
            try reg.register {
                DITestModel14(
                    m0: diArg($0),
                    m1: diArg($1),
                    m2: diArg($2),
                    m3: diArg($3),
                    m4: diArg($4),
                    m5: diArg($5),
                    m6: diArg($6),
                    m7: diArg($7),
                    m8: diArg($8),
                    m9: diArg($9),
                    m10: diArg($10),
                    m11: diArg($11),
                    m12: diArg($12),
                    m13: diArg($13)
                )
            }
            try reg.register {
                DITestModel15(
                    m0: diArg($0),
                    m1: diArg($1),
                    m2: diArg($2),
                    m3: diArg($3),
                    m4: diArg($4),
                    m5: diArg($5),
                    m6: diArg($6),
                    m7: diArg($7),
                    m8: diArg($8),
                    m9: diArg($9),
                    m10: diArg($10),
                    m11: diArg($11),
                    m12: diArg($12),
                    m13: diArg($13),
                    m14: diArg($14)
                )
            }
        }
        return part
    }
}

extension DIProviderTests
{
    static var allTests = [
        ("test1", test1),
        ("test2", test2),
        ("test3", test3),
    ]
}
