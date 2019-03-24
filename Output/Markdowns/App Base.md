# App Base

## TemplateInfo

### Identifier

- com.apple.dt.unit.applicationBase ( [directory](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/App%20Base.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/App%20Base.xctemplate/TemplateInfo.plist) )

### Ancestors

- com.apple.dt.unit.bundleBase ( [Bundle Base](Bundle%20Base.md), [directory](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Bundle%20Base.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Bundle%20Base.xctemplate/TemplateInfo.plist) )

---

### Definitions : 

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

### Nodes : 

`Info.plist:PackageType`

### Options : 

- Identifier : `languageChoice`

- Units : 

	- Swift : 

		- Definitions : 

			- `main.swift` : 

				- SortOrder : `999`

			- `main.swift:main` : 

				- Beginning : ``

				- End : ``

### Targets : 

- BuildPhases : 

	- Class : `Sources`

	- Class : `Frameworks`

	- Class : `Resources`

- ProductType : `com.apple.product-type.application`