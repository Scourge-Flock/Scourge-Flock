import ScourgeService
import Testing

@testable import ScourgeFlock

@Flock
struct TestService {}

@Test func macroExpands() async throws {
    let service = Service(TestService())
    #expect(service.definition.name == "TestService")
}
