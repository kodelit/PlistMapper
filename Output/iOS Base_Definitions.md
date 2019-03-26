# iOS Base_Definitions

## TemplateInfo

### Identifier

- com.apple.dt.unit.iosBase_Definitions ( [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/iOS%20Base_Definitions.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/iOS%20Base_Definitions.xctemplate/TemplateInfo.plist) )

---

### Definitions : 

- `*:imports:importCocoa` : `#import <UIKit/UIKit.h>`

- `*:imports:importCocoaForUmbrellaHeader` : `#import <UIKit/UIKit.h>`

- `Info.plist:UISupportedInterfaceOrientations~iPad` : 

```
<key>UISupportedInterfaceOrientations~ipad</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
    <string>UIInterfaceOrientationPortraitUpsideDown</string>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
</array>

```

- `Info.plist:UISupportedInterfaceOrientations~iPhone` : 

```
<key>UISupportedInterfaceOrientations</key>
<array>
     <string>UIInterfaceOrientationPortrait</string>
     <string>UIInterfaceOrientationLandscapeLeft</string>
     <string>UIInterfaceOrientationLandscapeRight</string>
</array>

```

### Kind : `Xcode.Xcode3.ProjectTemplateUnitKind`

### Options : 

- 0 : 

	- Identifier : `languageChoice`

	- Units : 

		- `Objective-C` : 

			- Definitions : 

				- `*:implementation:viewDidLoad` : 

					- Beginning : 

					```
					- (void)viewDidLoad {
					    [super viewDidLoad];
					    // Do any additional setup after loading the view.
					```

					- End : 

					```
					}
					
					```

					- Indent : `YES`

		- Swift : 

			- Definitions : 

				- `*:implementation:viewDidLoad` : 

					- Beginning : 

					```
					override func viewDidLoad() {
					    super.viewDidLoad()
					    // Do any additional setup after loading the view.
					```

					- End : 

					```
					}
					
					```

					- Indent : `YES`

				- `*:imports:importCocoa` : `import UIKit`