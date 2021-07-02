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
