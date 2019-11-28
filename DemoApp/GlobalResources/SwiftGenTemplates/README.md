#  SwiftGenTemplates

These stencil templates are used by SwiftGen to create type-safe references in the project's build phase. This happens in combination with the `.swiftgen.yml` files.

The original templates from SwiftGen 6.1.0 are used to create these custom templates. They were modified so that the resource references can be accessed through the `Const` namespace.

SwiftGen replaces therefore R-swift, but has some limitations. At first the templates have to be maintained and second they might not parse anything, for example `Symbol Image Sets` in asset catalogs and localized `StringDict` are not yet supported.
