# DIGreatness

Пока на русском

## Как пользоваться

```Swift
/// Наши классы
protocol DITestProtocol {
}

class DITestA: DIProtocol {
}

struct DITestB: DIProtocol {
    let a: DITestA
}

struct DITestC {
    let a: DITestA
    let b: DITestB
}

struct DITestD {
    let a: DITestProtocol
    let b: () -> DITestB
    let c: (_ a: DITestB) -> DITestC
}

struct DITestE {
    let b: DITestB

    var a: DITestA? = nil
    var c: ((_ a: DITestB) -> DITestC)? = nil
}
```

```Swift
/// Тэг если нужны

enum DITestTag { }
```

```Swift
/// Создаем Part
final class DITestInjectPart: DIPart
{
     /// Внешнии завсимости которые будут доступны после сборки
    @DIInject(tag: DITestTag.self) var b: DITestProtocol
    @DIInject var a: DITestProtocol
    @DIInject var bMaker: () -> DITestB
    @DIInject var cMaker: (DITestB) -> DITestC

    /// В случаи необходимости обьявите зависмости от других Part
    // var subpars: [DIPart]

     /// Регистрируем нужные компоненты
    func registration(_ registrator: DIRegistrator) throws {
        try registrator.register(DITestA.init)
        try registrator.register(DITestB.init)

        /// указываем время жизни
        try registrator.register(DITestD.init)
            .lifeTime(.single)

        /// спользуем каст для сохрания в DI с другим типом
        try registrator.register { $0 as DITestA }
            .map { $0 as DITestProtocol }

        /// Помечаем тэгом
        try registrator.register { $0 as DITestB }
            .map { $0 as DITestProtocol }
            .tag(DITestTag.self)

        /// Регистрируем с внешним аргументом
        try registrator.register { DITestC(a: $0, b: diArg($1)) }

        /// Регистрируем и инжектм зависимости в проперти
        try registrator.register(DITestE.init)
            .inject(\.a)
            .inject(\.c)
    }

//    Зависимости можно извлекать руками
//    func resolve(_ resolver: DIResolver) throws {
//        /// Чтобы при этом работал @DIInject
//        try autoInjection(resolver)
//        let e = try resolver() as DITestE
//    }
}
```

```Swift
/// создаем наш Part
let part = DITestInjectPart()

/// Загружаем все нужные Part
do {
    try DI.build([part])
}
catch {
	// обработка ошибок при сборке
}

/// Извлекаем из part наши Зависмости
let b = part.bMaker()
let c = part.cMaker(b)
```
