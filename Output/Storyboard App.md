# Storyboard App

## TemplateInfo

### Identifier

- com.apple.dt.unit.storyboardApplication ( [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Storyboard%20App.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Storyboard%20App.xctemplate/TemplateInfo.plist) )

### Ancestors

- com.apple.dt.unit.cocoaTouchApplicationBase ( [**Cocoa Touch App Base**](Cocoa%20Touch%20App%20Base.md), [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Cocoa%20Touch%20App%20Base.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Cocoa%20Touch%20App%20Base.xctemplate/TemplateInfo.plist) )

---

### Definitions : 

- `Info.plist:UIMainStoryboardFile` : 

```
<key>UIMainStoryboardFile</key>
<string>Main</string>

```

### Kind : `Xcode.Xcode3.ProjectTemplateUnitKind`

### Nodes : 

- 0 : `Info.plist:UIMainStoryboardFile`

- 1 : `Base.lproj/Main.storyboard`

### Options : 

- 0 : 

	- Identifier : `languageChoice`

	- Units : 

		- `Objective-C` : 

			- Definitions : 

				- `*:implementation:methods:awakeFromNib:super` : `[super awakeFromNib];`

		- Swift : 

			- Definitions : 

				- `*:implementation:methods:awakeFromNib:super` : `super.awakeFromNib()`