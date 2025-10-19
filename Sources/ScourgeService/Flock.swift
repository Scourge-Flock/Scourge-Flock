@attached(member, names: named(name))
@attached(extension, conformances: ServiceDefinition)
public macro Flock() = #externalMacro(module: "ScourgeServiceMacro", type: "FlockMacro")
