enum DITestTag
{
}

protocol DITestProtocol
{
}

final class DITestA: DITestProtocol
{
}

struct DITestB: DITestProtocol
{
    let a: DITestA
}

struct DITestC
{
    let a: DITestA
    let b: DITestB
}

struct DITestD
{
    let a: DITestProtocol
    let b: () -> DITestB
    let c: (_ a: DITestB) -> DITestC
}

struct DITestE
{
    let b: DITestB

    var a: DITestA?
    var c: ((_ a: DITestB) -> DITestC)?
}

final class DICycle1
{
    init(next: DICycle2) {
        self.next = next
    }

    let next: DICycle2
}

final class DICycle2
{
    init(next: DICycle3) {
        self.next = next
    }

    let next: DICycle3
}

final class DICycle3
{
    init(next: DICycle1) {
        self.next = next
    }

    let next: DICycle1
}

struct DITestModel0
{
}

struct DITestModel1
{
    let m0: DITestModel0
}

struct DITestModel2
{
    let m0: DITestModel0
    let m1: DITestModel1
}

struct DITestModel3
{
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
}

struct DITestModel4
{
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
}

struct DITestModel5
{
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
}

struct DITestModel6
{
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
    let m5: DITestModel5
}

struct DITestModel7
{
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
    let m5: DITestModel5
    let m6: DITestModel6
}

struct DITestModel8
{
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
    let m5: DITestModel5
    let m6: DITestModel6
    let m7: DITestModel7
}

struct DITestModel9
{
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
    let m5: DITestModel5
    let m6: DITestModel6
    let m7: DITestModel7
    let m8: DITestModel8
}

struct DITestModel10
{
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
    let m5: DITestModel5
    let m6: DITestModel6
    let m7: DITestModel7
    let m8: DITestModel8
    let m9: DITestModel9
}

struct DITestModel11
{
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
    let m5: DITestModel5
    let m6: DITestModel6
    let m7: DITestModel7
    let m8: DITestModel8
    let m9: DITestModel9
    let m10: DITestModel10
}

struct DITestModel12
{
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
    let m5: DITestModel5
    let m6: DITestModel6
    let m7: DITestModel7
    let m8: DITestModel8
    let m9: DITestModel9
    let m10: DITestModel10
    let m11: DITestModel11
}

struct DITestModel13
{
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
    let m5: DITestModel5
    let m6: DITestModel6
    let m7: DITestModel7
    let m8: DITestModel8
    let m9: DITestModel9
    let m10: DITestModel10
    let m11: DITestModel11
    let m12: DITestModel12
}

struct DITestModel14
{
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
    let m5: DITestModel5
    let m6: DITestModel6
    let m7: DITestModel7
    let m8: DITestModel8
    let m9: DITestModel9
    let m10: DITestModel10
    let m11: DITestModel11
    let m12: DITestModel12
    let m13: DITestModel13
}

struct DITestModel15
{
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
    let m5: DITestModel5
    let m6: DITestModel6
    let m7: DITestModel7
    let m8: DITestModel8
    let m9: DITestModel9
    let m10: DITestModel10
    let m11: DITestModel11
    let m12: DITestModel12
    let m13: DITestModel13
    let m14: DITestModel14
}
