public enum DINodeRegistratorLifeTime
{
    case singolton(_ type: SingoltonType)
    case oneInBuild
    case newEveryTime
}

extension DINodeRegistratorLifeTime
{
    public enum SingoltonType{
        case lazy
        case preRun
    }
}
