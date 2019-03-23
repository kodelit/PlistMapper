# [Single View App](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Single%20View%20App.xctemplate)

## TemplateInfo

### Identifier

- com.apple.dt.unit.singleViewApplication ( [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Single%20View%20App.xctemplate/TemplateInfo.plist) )

### Ancestors

- com.apple.dt.unit.storyboardApplication ( [Storyboard App](Storyboard App.md), [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Storyboard%20App.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Storyboard%20App.xctemplate/TemplateInfo.plist) )

- com.apple.dt.unit.coreDataCocoaTouchApplication ( [Core Data Cocoa Touch App](Core Data Cocoa Touch App.md), [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Core%20Data%20Cocoa%20Touch%20App.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Core%20Data%20Cocoa%20Touch%20App.xctemplate/TemplateInfo.plist) )

---

### Concrete

- YES

### Definitions

- Base.lproj/Main.storyboard

	- Path

		- `Main.storyboard`

	- SortOrder

		- 99

### Description

```
This template provides a starting point for an application that uses a single view. It provides a view controller to manage the view, and a storyboard or nib file that contains the view.
```

### Kind

- `Xcode.Xcode3.ProjectTemplateUnitKind`

### Options

- Identifier

	- `languageChoice`

- Units

	- Objective-C

		- Nodes

			- `ViewController.h:comments`

			- `ViewController.h:imports:importCocoa`

			- `ViewController.h:interface(___FILEBASENAME___ : UIViewController)`

			- `ViewController.m:comments`

			- `ViewController.m:imports:importHeader:ViewController.h`

			- `ViewController.m:extension`

			- `ViewController.m:implementation:methods:viewDidLoad(- (void\)viewDidLoad)`

			- `ViewController.m:implementation:methods:viewDidLoad:super`

	- Swift

		- Nodes

			- `ViewController.swift:comments`

			- `ViewController.swift:imports:importCocoa`

			- `ViewController.swift:implementation(___FILEBASENAME___: UIViewController)`

			- `ViewController.swift:implementation:methods:viewDidLoad(override func viewDidLoad(\))`

			- `ViewController.swift:implementation:methods:viewDidLoad:super`

### SortOrder

- YES