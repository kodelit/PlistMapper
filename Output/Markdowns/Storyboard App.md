# [Storyboard App](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project Templates/iOS/Application/Storyboard App.xctemplate)

## TemplateInfo

### Identifier

- com.apple.dt.unit.storyboardApplication ( [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project Templates/iOS/Application/Storyboard App.xctemplate/TemplateInfo.plist) )

### Ancestors

- com.apple.dt.unit.cocoaTouchApplicationBase ( [Cocoa Touch App Base](Cocoa Touch App Base.md), [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project Templates/iOS/Application/Cocoa Touch App Base.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project Templates/iOS/Application/Cocoa Touch App Base.xctemplate/TemplateInfo.plist) )

---

### Definitions

- Info.plist:UIMainStoryboardFile

	```
	<key>UIMainStoryboardFile</key>
<string>Main</string>

	```

### Kind

- `Xcode.Xcode3.ProjectTemplateUnitKind`

### Nodes

- `Info.plist:UIMainStoryboardFile`

- `Base.lproj/Main.storyboard`

### Options

- Identifier

	- `languageChoice`

- Units

	- Objective-C

		- Definitions

			- *:implementation:methods:awakeFromNib:super

				- `[super awakeFromNib];`

	- Swift

		- Definitions

			- *:implementation:methods:awakeFromNib:super

				- `super.awakeFromNib()`