enum DITestTag { }

protocol DIProtocol {
}

class DIA: DIProtocol {
}

struct DIB: DIProtocol {
    let a: DIA
}

struct DIC {
    let a: DIA
    let b: DIB
}

struct DID {
    let a: DIProtocol
    let b: () -> DIB
    let c: (_ a: DIB) -> DIC
}

struct DIE {
    let b: DIB

    var a: DIA? = nil
    var c: ((_ a: DIB) -> DIC)? = nil
}

final class DIСycle1 {
    init(next: DIСycle2) {
        self.next = next
    }
    
    let next: DIСycle2
}

final class DIСycle2 {
    init(next: DIСycle3) {
        self.next = next
    }
    
    let next: DIСycle3
}

final class DIСycle3 {
    init(next: DIСycle1) {
        self.next = next
    }
    
    let next: DIСycle1
}

struct DITestModel0 { }

struct DITestModel1 {
    let m0: DITestModel0
}

struct DITestModel2 {
    let m0: DITestModel0
    let m1: DITestModel1
}

struct DITestModel3 {
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
}

struct DITestModel4 {
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
}

struct DITestModel5 {
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
}

struct DITestModel6 {
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
    let m5: DITestModel5
}

struct DITestModel7 {
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
    let m5: DITestModel5
    let m6: DITestModel6
}

struct DITestModel8 {
    let m0: DITestModel0
    let m1: DITestModel1
    let m2: DITestModel2
    let m3: DITestModel3
    let m4: DITestModel4
    let m5: DITestModel5
    let m6: DITestModel6
    let m7: DITestModel7
}

struct DITestModel9 {
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

struct DITestModel10 {
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

struct DITestModel11 {
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

struct DITestModel12 {
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

struct DITestModel13 {
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

struct DITestModel14 {
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

struct DITestModel15 {
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
