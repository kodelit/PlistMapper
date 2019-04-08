# Storyboard App

## TemplateInfo

### Identifier

- com.apple.dt.unit.storyboardApplication ( [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Storyboard%20App.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Storyboard%20App.xctemplate/TemplateInfo.plist) )

### Ancestors

- com.apple.dt.unit.cocoaTouchApplicationBase ( [**Cocoa Touch App Base**](Cocoa%20Touch%20App%20Base.md), [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Cocoa%20Touch%20App%20Base.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Cocoa%20Touch%20App%20Base.xctemplate/TemplateInfo.plist) )

---
<span id="m_Definitions">[Definitions](#a_Definitions)</span> | <span id="m_Nodes">[Nodes](#a_Nodes)</span> | <span id="m_Options">[Options](#a_Options)</span>

### Definitions :  <span id="a_Definitions"/>[↩](#m_Definitions)

- `Info.plist:UIMainStoryboardFile` : 

```
<key>UIMainStoryboardFile</key>
<string>Main</string>

```

### Kind : `Xcode.Xcode3.ProjectTemplateUnitKind`

### Nodes :  <span id="a_Nodes"/>[↩](#m_Nodes)

- 0 : `Info.plist:UIMainStoryboardFile`

- 1 : `Base.lproj/Main.storyboard`

### Options :  <span id="a_Options"/>[↩](#m_Options)

- 0 : 

	- Identifier : `languageChoice`

	- Units : 

		- `Objective-C` : 

			- Definitions : 

				- `*:implementation:methods:awakeFromNib:super` : `[super awakeFromNib];`

		- Swift : 

			- Definitions : 

				- `*:implementation:methods:awakeFromNib:super` : `super.awakeFromNib()`