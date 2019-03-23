# [Bundle Base](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Bundle%20Base.xctemplate)

## TemplateInfo

### Identifier

- com.apple.dt.unit.bundleBase ( [plist](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Bundle%20Base.xctemplate/TemplateInfo.plist) )

### Ancestors

- com.apple.dt.unit.base ( [Base](Base.md), [directory](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Base.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Base.xctemplate/TemplateInfo.plist) )

---

### Kind

- `Xcode.Xcode3.ProjectTemplateUnitKind`

### Nodes

- `Info.plist:Identifier`

- `Info.plist:PlistVersion`

- `Info.plist:Executable`

- `Info.plist:BundleName`

- `Info.plist:DevelopmentRegion`

- `Info.plist:ProductVersion`

### Targets

- SharedSettings

	- INFOPLIST_FILE

		- `___PACKAGENAME___/Info.plist`

	- PRODUCT_BUNDLE_IDENTIFIER

		- `___VARIABLE_bundleIdentifierPrefix:bundleIdentifier___.___PACKAGENAMEASRFC1034IDENTIFIER___`