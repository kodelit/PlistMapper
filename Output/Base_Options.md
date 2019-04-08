# Base_Options

## TemplateInfo

### Identifier

- com.apple.dt.unit.base_Options ( [directory](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Base_Options.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Base_Options.xctemplate/TemplateInfo.plist) )

---
<span id="m_Options">[Options](#a_Options)</span>

### Kind : `Xcode.Xcode3.ProjectTemplateUnitKind`

### Options :  <span id="a_Options"/>[↩](#m_Options)

- 0 : 

	- Description : `Your new product's name`

	- EmptyReplacement : `ProductName`

	- Identifier : `productName`

	- Name : `Product Name:`

	- NotPersisted : `YES`

	- Required : `YES`

	- SortOrder : `-2`

	- Type : `text`

- 1 : 

	- Default : `___FULLUSERNAME___`

	- Description : `Your company's name`

	- Identifier : `organizationName`

	- Name : `Organization Name:`

	- Type : `text`

- 2 : 

	- Description : `Your organization's bundle identifier prefix`

	- EmptyReplacement : `com.yourcompany`

	- Identifier : `bundleIdentifierPrefix`

	- Name : `Organization Identifier:`

	- Required : `YES`

	- Type : `text`

- 3 : 

	- Default : `___VARIABLE_bundleIdentifierPrefix:bundleIdentifier___.___VARIABLE_productName:RFC1034Identifier___`

	- Description : `Your new product's bundle identifier`

	- Identifier : `bundleIdentifier`

	- Name : `Bundle Identifier:`

	- NotPersisted : `YES`

	- Type : `static`