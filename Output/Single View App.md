# Single View App

## TemplateInfo

### Identifier

- com.apple.dt.unit.singleViewApplication ( [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Single%20View%20App.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Single%20View%20App.xctemplate/TemplateInfo.plist) )

### Ancestors

- com.apple.dt.unit.storyboardApplication ( [**Storyboard App**](Storyboard%20App.md), [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Storyboard%20App.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Storyboard%20App.xctemplate/TemplateInfo.plist) )

- com.apple.dt.unit.coreDataCocoaTouchApplication ( [**Core Data Cocoa Touch App**](Core%20Data%20Cocoa%20Touch%20App.md), [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Core%20Data%20Cocoa%20Touch%20App.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Core%20Data%20Cocoa%20Touch%20App.xctemplate/TemplateInfo.plist) )

---
<span id="a_Definitions">[Definitions](#f_Definitions)</span> | <span id="a_Options">[Options](#f_Options)</span>

### Concrete : `YES`

### Definitions :  <span id="f_Definitions"/>[↩](#a_Definitions)

- `Base.lproj/Main.storyboard` : 

	- Path : `Main.storyboard`

	- SortOrder : `99`

### Description : 

```
This template provides a starting point for an application that uses a single view. It provides a view controller to manage the view, and a storyboard or nib file that contains the view.
```

### Kind : `Xcode.Xcode3.ProjectTemplateUnitKind`

### Options :  <span id="f_Options"/>[↩](#a_Options)

- 0 : 

	- Identifier : `languageChoice`

	- Units : 

		- `Objective-C` : 

			- Nodes : 

				- 0 : `ViewController.h:comments`

				- 1 : `ViewController.h:imports:importCocoa`

				- 2 : `ViewController.h:interface(___FILEBASENAME___ : UIViewController)`

				- 3 : `ViewController.m:comments`

				- 4 : `ViewController.m:imports:importHeader:ViewController.h`

				- 5 : `ViewController.m:extension`

				- 6 : `ViewController.m:implementation:methods:viewDidLoad(- (void\)viewDidLoad)`

				- 7 : `ViewController.m:implementation:methods:viewDidLoad:super`

		- Swift : 

			- Nodes : 

				- 0 : `ViewController.swift:comments`

				- 1 : `ViewController.swift:imports:importCocoa`

				- 2 : `ViewController.swift:implementation(___FILEBASENAME___: UIViewController)`

				- 3 : `ViewController.swift:implementation:methods:viewDidLoad(override func viewDidLoad(\))`

				- 4 : `ViewController.swift:implementation:methods:viewDidLoad:super`

### SortOrder : `YES`