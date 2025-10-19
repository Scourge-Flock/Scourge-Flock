import ScourgeService

public struct Service<S>: Resource
where S: ServiceDefinition {
    public let definition: S

    init(_ definition: S) {
        self.definition = definition
    }
}
