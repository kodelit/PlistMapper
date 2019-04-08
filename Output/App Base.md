# App Base

## TemplateInfo

### Identifier

- com.apple.dt.unit.applicationBase ( [directory](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/App%20Base.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/App%20Base.xctemplate/TemplateInfo.plist) )

### Ancestors

- com.apple.dt.unit.bundleBase ( [**Bundle Base**](Bundle%20Base.md), [directory](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Bundle%20Base.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Bundle%20Base.xctemplate/TemplateInfo.plist) )

---
<span id="m_Definitions">[Definitions](#a_Definitions)</span> | <span id="m_Nodes">[Nodes](#a_Nodes)</span> | <span id="m_Options">[Options](#a_Options)</span> | <span id="m_Targets">[Targets](#a_Targets)</span>

### Definitions :  <span id="a_Definitions"/>[↩](#m_Definitions)

- `Info.plist:PackageType` : 

```
<key>CFBundlePackageType</key>
<string>APPL</string>

```

- `main.m` : 

	- SortOrder : `999`

- `main.m:main` : 

	- Beginning : `int main(int argc, const char * argv[]) {`

	- End : `}`

	- Indent : `YES`

### Kind : `Xcode.Xcode3.ProjectTemplateUnitKind`

### Nodes :  <span id="a_Nodes"/>[↩](#m_Nodes)

- 0 : `Info.plist:PackageType`

### Options :  <span id="a_Options"/>[↩](#m_Options)

- 0 : 

	- Identifier : `languageChoice`

	- Units : 

		- Swift : 

			- Definitions : 

				- `main.swift` : 

					- SortOrder : `999`

				- `main.swift:main` : 

					- Beginning : ``

					- End : ``

### Targets :  <span id="a_Targets"/>[↩](#m_Targets)

- 0 : 

	- BuildPhases : 

		- 0 : 

			- Class : `Sources`

		- 1 : 

			- Class : `Frameworks`

		- 2 : 

			- Class : `Resources`

	- ProductType : `com.apple.product-type.application`