# Storyboard App

## TemplateInfo

### Identifier

- com.apple.dt.unit.storyboardApplication ( [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Storyboard%20App.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Storyboard%20App.xctemplate/TemplateInfo.plist) )

### Ancestors

- com.apple.dt.unit.cocoaTouchApplicationBase ( [**Cocoa Touch App Base**](Cocoa%20Touch%20App%20Base.md), [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Cocoa%20Touch%20App%20Base.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Cocoa%20Touch%20App%20Base.xctemplate/TemplateInfo.plist) )

---
<span id="a_Definitions">[Definitions](#f_Definitions)</span> | <span id="a_Nodes">[Nodes](#f_Nodes)</span> | <span id="a_Options">[Options](#f_Options)</span>

### Definitions :  <span id="f_Definitions"/>[↩](#a_Definitions)

- `Info.plist:UIMainStoryboardFile` : 

```
<key>UIMainStoryboardFile</key>
<string>Main</string>

```

### Kind : `Xcode.Xcode3.ProjectTemplateUnitKind`

### Nodes :  <span id="f_Nodes"/>[↩](#a_Nodes)

- 0 : `Info.plist:UIMainStoryboardFile`

- 1 : `Base.lproj/Main.storyboard`

### Options :  <span id="f_Options"/>[↩](#a_Options)

- 0 : 

	- Identifier : `languageChoice`

	- Units : 

		- `Objective-C` : 

			- Definitions : 

				- `*:implementation:methods:awakeFromNib:super` : `[super awakeFromNib];`

		- Swift : 

			- Definitions : 

				- `*:implementation:methods:awakeFromNib:super` : `super.awakeFromNib()`