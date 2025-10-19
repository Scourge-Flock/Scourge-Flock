import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxMacros

@main
struct ScourgeServiceMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        FlockMacro.self
    ]
}

public struct FlockMacro: MemberMacro, ExtensionMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        let extensionDecl = try ExtensionDeclSyntax("extension \(type): ServiceDefinition") {}

        return [extensionDecl]
    }

    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let structDecl = declaration.as(StructDeclSyntax.self) else {
            throw MacroError.message("@Flock can only be applied to structs")
        }
        let namePropertyName = "name"

        let existingNameProperty = structDecl.memberBlock.members.first { member in
            guard let varDecl = member.decl.as(VariableDeclSyntax.self) else {
                return false
            }
            return varDecl.bindings.contains { binding in
                guard let pattern = binding.pattern.as(IdentifierPatternSyntax.self) else {
                    return false
                }
                return pattern.identifier.text == namePropertyName
            }
        }

        var declarations: [DeclSyntax] = []

        if existingNameProperty == nil {
            let structName = structDecl.name.text.trimmingCharacters(in: .whitespacesAndNewlines)
            let nameProperty = try VariableDeclSyntax(
                """
                public let \(raw: namePropertyName): String = "\(raw: structName)"
                """
            )
            declarations.append(DeclSyntax(nameProperty))
        }

        return declarations
    }

    enum MacroError: Error, CustomStringConvertible {
        case message(String)

        var description: String {
            switch self {
            case .message(let msg):
                return msg
            }
        }
    }
}
