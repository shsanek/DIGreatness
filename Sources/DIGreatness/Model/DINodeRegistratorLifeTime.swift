public enum DILifeTime
{
    /// The object is only one in the application. Initialization by call `DI.load`
    case single
    /// The object is only one in the one run.
    case perRun
    /// The object is created every time, but during the creation will be created once
    case objectGraph
    /// The object is created every time
    case prototype
}
