# Cocoa Touch App Base

## TemplateInfo

### Identifier

- com.apple.dt.unit.cocoaTouchApplicationBase ( [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Cocoa%20Touch%20App%20Base.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Cocoa%20Touch%20App%20Base.xctemplate/TemplateInfo.plist) )

### Ancestors

- com.apple.dt.unit.applicationBase ( [**App Base**](App%20Base.md), [directory](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/App%20Base.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/App%20Base.xctemplate/TemplateInfo.plist) )

- com.apple.dt.unit.iosBase ( [**iOS Base**](iOS%20Base.md), [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/iOS%20Base.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/iOS%20Base.xctemplate/TemplateInfo.plist) )

- com.apple.dt.unit.languageChoice ( [**Language Choice**](Language%20Choice.md), [directory](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Language%20Choice.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Language%20Choice.xctemplate/TemplateInfo.plist) )

---

### Definitions : 

- `*:implementation:methods:applicationDidBecomeActive:comments` : 

```
// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
```

- `*:implementation:methods:applicationDidEnterBackground:comments` : 

```
// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

```

- `*:implementation:methods:applicationWillEnterForeground:comments` : 

```
// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
```

- `*:implementation:methods:applicationWillResignActive:comments` : 

```
// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.

```

- `*:implementation:methods:applicationWillTerminate:comments` : 

```
// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
```

- `Assets.xcassets` : 

	- AssetGeneration : 

		- Name : `AppIcon`

		- Platforms : 

			- iOS : `true`

		- Type : `appicon`

	- Path : `Images.xcassets`

	- SortOrder : `100`

- `Base.lproj/LaunchScreen.storyboard` : 

	- Path : `LaunchScreen.storyboard`

	- SortOrder : `101`

- `Info.plist:LaunchScreen` : 

```
<key>UILaunchStoryboardName</key>
<string>LaunchScreen</string>

```

- `Info.plist:UIRequiredDeviceCapabilities` : 

	- Beginning : 

	```
	<key>UIRequiredDeviceCapabilities</key>
	<array>
	```

	- End : `</array>`

	- Indent : `YES`

- `Info.plist:UIRequiredDeviceCapabilities:base` : `<string>armv7</string>`

- `Info.plist:iPhone` : 

```
<key>LSRequiresIPhoneOS</key>
<true/>

```

- `Info.plist:statusBarTintForNavBar` : 

```
<key>UIStatusBarTintParameters</key>
<dict>
    <key>UINavigationBar</key>
    <dict>
        <key>Style</key>
        <string>UIBarStyleDefault</string>
        <key>Translucent</key>
        <false/>
    </dict>
</dict>

```

### Kind : `Xcode.Xcode3.ProjectTemplateUnitKind`

### Nodes : 

`Info.plist:iPhone`

`Info.plist:UIRequiredDeviceCapabilities:base`

`Info.plist:LaunchScreen`

`Info.plist:UISupportedInterfaceOrientations~iPhone`

`Info.plist:UISupportedInterfaceOrientations~iPad`

`Assets.xcassets`

`Base.lproj/LaunchScreen.storyboard`

### Options : 

- Default : `true`

- Identifier : `hasUnitTests`

- Name : `Include Unit Tests`

- NotPersisted : `NO`

- SortOrder : `100`

- Type : `checkbox`

- Units : 

	- true : 

		- Components : 

			- Identifier : `com.apple.dt.unit.cocoaTouchApplicationUnitTestBundle`

			- Name : `___PACKAGENAME___Tests`

- Default : `true`

- Identifier : `hasUITests`

- Name : `Include UI Tests`

- NotPersisted : `NO`

- SortOrder : `101`

- Type : `checkbox`

- Units : 

	- true : 

		- Components : 

			- Identifier : `com.apple.dt.unit.cocoaTouchApplicationUITestBundle`

			- Name : `___PACKAGENAME___UITests`

- Identifier : `languageChoice`

- Units : 

	- `Objective-C` : 

		- Definitions : 

			- `*:implementation:methods:viewDidLoad:super` : 

			```
			[super viewDidLoad];
			// Do any additional setup after loading the view, typically from a nib.
			```

			- `AppDelegate.h:interface:window` : `@property (strong, nonatomic) UIWindow *window;
`

			- `AppDelegate.m:implementation:methods:applicationdidFinishLaunchingWithOptions:body` : `// Override point for customization after application launch.`

			- `AppDelegate.m:implementation:methods:applicationdidFinishLaunchingWithOptions:return` : `return YES;`

			- `main.m:main` : 

				- Beginning : `int main(int argc, char * argv[]) {`

				- End : `}`

				- Indent : `YES`

			- `main.m:main:UIApplicationMain` : 

			```
			@autoreleasepool {
			    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
			}
			
			```

		- Nodes : 

			`main.m:comments`

			`main.m:imports:importCocoa`

			`main.m:imports:importHeader:AppDelegate.h`

			`main.m:main:UIApplicationMain`

			`AppDelegate.h:comments`

			`AppDelegate.h:imports:importCocoa`

			`AppDelegate.h:interface(AppDelegate : UIResponder <UIApplicationDelegate>)`

			`AppDelegate.h:interface:window`

			`AppDelegate.m:comments`

			`AppDelegate.m:imports:importHeader:AppDelegate.h`

			`AppDelegate.m:extension`

			`AppDelegate.m:implementation:synthesize`

			

			```
			AppDelegate.m:implementation:methods:applicationdidFinishLaunchingWithOptions(- (BOOL\)application:(UIApplication *\)application didFinishLaunchingWithOptions:(NSDictionary *\)launchOptions)
			```

			`AppDelegate.m:implementation:methods:applicationdidFinishLaunchingWithOptions:body`

			`AppDelegate.m:implementation:methods:applicationdidFinishLaunchingWithOptions:return`

			

			```
			AppDelegate.m:implementation:methods:applicationWillResignActive(- (void\)applicationWillResignActive:(UIApplication *\)application)
			```

			`AppDelegate.m:implementation:methods:applicationWillResignActive:comments`

			

			```
			AppDelegate.m:implementation:methods:applicationDidEnterBackground(- (void\)applicationDidEnterBackground:(UIApplication *\)application)
			```

			`AppDelegate.m:implementation:methods:applicationDidEnterBackground:comments`

			

			```
			AppDelegate.m:implementation:methods:applicationWillEnterForeground(- (void\)applicationWillEnterForeground:(UIApplication *\)application)
			```

			`AppDelegate.m:implementation:methods:applicationWillEnterForeground:comments`

			

			```
			AppDelegate.m:implementation:methods:applicationDidBecomeActive(- (void\)applicationDidBecomeActive:(UIApplication *\)application)
			```

			`AppDelegate.m:implementation:methods:applicationDidBecomeActive:comments`

			

			```
			AppDelegate.m:implementation:methods:applicationWillTerminate(- (void\)applicationWillTerminate:(UIApplication *\)application)
			```

			`AppDelegate.m:implementation:methods:applicationWillTerminate:comments`

	- Swift : 

		- Definitions : 

			- `*:implementation:methods:viewDidLoad:super` : 

			```
			super.viewDidLoad()
			// Do any additional setup after loading the view, typically from a nib.
			```

			- `AppDelegate.swift:UIApplicationMain` : `@UIApplicationMain`

			- `AppDelegate.swift:implementation:methods:applicationdidFinishLaunchingWithOptions:body` : `// Override point for customization after application launch.`

			- `AppDelegate.swift:implementation:methods:applicationdidFinishLaunchingWithOptions:return` : `return true`

			- `AppDelegate.swift:implementation:properties:window` : `var window: UIWindow?`

		- Nodes : 

			`AppDelegate.swift:comments`

			`AppDelegate.swift:imports:importCocoa`

			`AppDelegate.swift:UIApplicationMain`

			`AppDelegate.swift:implementation(AppDelegate: UIResponder, UIApplicationDelegate)`

			`AppDelegate.swift:implementation:properties:window`

			

			```
			AppDelegate.swift:implementation:methods:applicationdidFinishLaunchingWithOptions(func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?\) -> Bool)
			```

			`AppDelegate.swift:implementation:methods:applicationdidFinishLaunchingWithOptions:body`

			`AppDelegate.swift:implementation:methods:applicationdidFinishLaunchingWithOptions:return`

			

			```
			AppDelegate.swift:implementation:methods:applicationWillResignActive(func applicationWillResignActive(_ application: UIApplication\))
			```

			`AppDelegate.swift:implementation:methods:applicationWillResignActive:comments`

			

			```
			AppDelegate.swift:implementation:methods:applicationDidEnterBackground(func applicationDidEnterBackground(_ application: UIApplication\))
			```

			`AppDelegate.swift:implementation:methods:applicationDidEnterBackground:comments`

			

			```
			AppDelegate.swift:implementation:methods:applicationWillEnterForeground(func applicationWillEnterForeground(_ application: UIApplication\))
			```

			`AppDelegate.swift:implementation:methods:applicationWillEnterForeground:comments`

			

			```
			AppDelegate.swift:implementation:methods:applicationDidBecomeActive(func applicationDidBecomeActive(_ application: UIApplication\))
			```

			`AppDelegate.swift:implementation:methods:applicationDidBecomeActive:comments`

			

			```
			AppDelegate.swift:implementation:methods:applicationWillTerminate(func applicationWillTerminate(_ application: UIApplication\))
			```

			`AppDelegate.swift:implementation:methods:applicationWillTerminate:comments`

### Targets : 

- SharedSettings : 

	- `ASSETCATALOG_COMPILER_APPICON_NAME` : `AppIcon`

	- `LD_RUNPATH_SEARCH_PATHS` : `$(inherited) @executable_path/Frameworks`

	- `TARGETED_DEVICE_FAMILY` : `1,2`

- TargetIdentifier : `com.apple.dt.cocoaTouchApplicationTarget`