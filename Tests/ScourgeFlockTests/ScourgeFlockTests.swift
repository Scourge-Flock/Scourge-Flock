import ScourgeService
import Testing

@testable import ScourgeFlock

@Flock
struct TestService_Struct {}
@Flock
class TestService_Class {}

@Test func macroExpands() async throws {
    let serviceStruct = Service(TestService_Struct())
    #expect(serviceStruct.definition.name == "TestService_Struct")

    let serviceClass = Service(TestService_Class())
    #expect(serviceClass.definition.name == "TestService_Class")
}
