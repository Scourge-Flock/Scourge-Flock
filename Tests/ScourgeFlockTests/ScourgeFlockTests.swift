import ScourgeService
import Testing

@testable import ScourgeFlock

@Flock
struct TestService_Struct {}
@Flock
class TestService_Class {}

@Flock
struct TestService_ExistingName {
    public let name: String = "CustomName"
}

@Test func macroExpands() async throws {
    let serviceStruct = Service(TestService_Struct())
    #expect(serviceStruct.definition.name == "TestService_Struct")

    let serviceClass = Service(TestService_Class())
    #expect(serviceClass.definition.name == "TestService_Class")

    let serviceExisting = Service(TestService_ExistingName())
    #expect(serviceExisting.definition.name == "CustomName")
}
