# [Language Choice](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project Templates/Base/Language Choice.xctemplate)

## TemplateInfo

### Identifier

- com.apple.dt.unit.languageChoice ( [plist](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project Templates/Base/Language Choice.xctemplate/TemplateInfo.plist) )

---

### Kind

- `Xcode.Xcode3.ProjectTemplateUnitKind`

### Options

- Default

	- `Swift`

- Description

	- `Your primary implementation language.`

- Identifier

	- `languageChoice`

- Name

	- `Language:`

- Required

	- YES

- Type

	- `popup`

- Values

	- `Swift`

	- `Objective-C`

- Variables

	- Objective-C

		- ibCustomModuleProvider

			- ``

		- moduleNamePrefixForClasses

			- ``

	- Swift

		- ibCustomModuleProvider

			- `target`

		- moduleNamePrefixForClasses

			- `$(PRODUCT_MODULE_NAME).`