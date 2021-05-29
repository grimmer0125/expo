
/**
 `BaseModule` is just a stub class that fulfils `AnyModule` protocol requirement of public default initializer,
 but doesn't implement that protocol explicitly, though — it would have to provide a definition which would require
 other modules to use `override` keyword in the function returning the definition.
 */
open class BaseModule {
  required public init() {}
}

/**
 An alias for `AnyModule` extended by the `BaseModule` class that provides public default initializer.
 */
public typealias Module = AnyModule & BaseModule
