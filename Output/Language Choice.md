# Language Choice

## TemplateInfo

### Identifier

- com.apple.dt.unit.languageChoice ( [directory](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Language%20Choice.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Language%20Choice.xctemplate/TemplateInfo.plist) )

---

### Kind : `Xcode.Xcode3.ProjectTemplateUnitKind`

### Options : 

- 0 : 

	- Default : `Swift`

	- Description : `Your primary implementation language.`

	- Identifier : `languageChoice`

	- Name : `Language:`

	- Required : `YES`

	- Type : `popup`

	- Values : 

		- 0 : `Swift`

		- 1 : `Objective-C`

	- Variables : 

		- `Objective-C` : 

			- ibCustomModuleProvider : ``

			- moduleNamePrefixForClasses : ``

		- Swift : 

			- ibCustomModuleProvider : `target`

			- moduleNamePrefixForClasses : `$(PRODUCT_MODULE_NAME).`