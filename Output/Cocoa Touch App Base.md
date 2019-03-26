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

		- 0 : 

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

- 0 : `Info.plist:iPhone`

- 1 : `Info.plist:UIRequiredDeviceCapabilities:base`

- 2 : `Info.plist:LaunchScreen`

- 3 : `Info.plist:UISupportedInterfaceOrientations~iPhone`

- 4 : `Info.plist:UISupportedInterfaceOrientations~iPad`

- 5 : `Assets.xcassets`

- 6 : `Base.lproj/LaunchScreen.storyboard`

### Options : 

- 0 : 

	- Default : `true`

	- Identifier : `hasUnitTests`

	- Name : `Include Unit Tests`

	- NotPersisted : `NO`

	- SortOrder : `100`

	- Type : `checkbox`

	- Units : 

		- true : 

			- Components : 

				- 0 : 

					- Identifier : `com.apple.dt.unit.cocoaTouchApplicationUnitTestBundle`

					- Name : `___PACKAGENAME___Tests`

- 1 : 

	- Default : `true`

	- Identifier : `hasUITests`

	- Name : `Include UI Tests`

	- NotPersisted : `NO`

	- SortOrder : `101`

	- Type : `checkbox`

	- Units : 

		- true : 

			- Components : 

				- 0 : 

					- Identifier : `com.apple.dt.unit.cocoaTouchApplicationUITestBundle`

					- Name : `___PACKAGENAME___UITests`

- 2 : 

	- Identifier : `languageChoice`

	- Units : 

		- `Objective-C` : 

			- Definitions : 

				- `*:implementation:methods:viewDidLoad:super` : 

				```
				[super viewDidLoad];
				// Do any additional setup after loading the view.
				```

				- `AppDelegate.h:interface:window` : 

				```
				@property (strong, nonatomic) UIWindow *window;
				
				```

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

				- 0 : `main.m:comments`

				- 1 : `main.m:imports:importCocoa`

				- 2 : `main.m:imports:importHeader:AppDelegate.h`

				- 3 : `main.m:main:UIApplicationMain`

				- 4 : `AppDelegate.h:comments`

				- 5 : `AppDelegate.h:imports:importCocoa`

				- 6 : `AppDelegate.h:interface(AppDelegate : UIResponder <UIApplicationDelegate>)`

				- 7 : `AppDelegate.h:interface:window`

				- 8 : `AppDelegate.m:comments`

				- 9 : `AppDelegate.m:imports:importHeader:AppDelegate.h`

				- 10 : `AppDelegate.m:extension`

				- 11 : `AppDelegate.m:implementation:synthesize`

				- 12 : 

				```
				AppDelegate.m:implementation:methods:applicationdidFinishLaunchingWithOptions(- (BOOL\)application:(UIApplication *\)application didFinishLaunchingWithOptions:(NSDictionary *\)launchOptions)
				```

				- 13 : `AppDelegate.m:implementation:methods:applicationdidFinishLaunchingWithOptions:body`

				- 14 : `AppDelegate.m:implementation:methods:applicationdidFinishLaunchingWithOptions:return`

				- 15 : 

				```
				AppDelegate.m:implementation:methods:applicationWillResignActive(- (void\)applicationWillResignActive:(UIApplication *\)application)
				```

				- 16 : `AppDelegate.m:implementation:methods:applicationWillResignActive:comments`

				- 17 : 

				```
				AppDelegate.m:implementation:methods:applicationDidEnterBackground(- (void\)applicationDidEnterBackground:(UIApplication *\)application)
				```

				- 18 : `AppDelegate.m:implementation:methods:applicationDidEnterBackground:comments`

				- 19 : 

				```
				AppDelegate.m:implementation:methods:applicationWillEnterForeground(- (void\)applicationWillEnterForeground:(UIApplication *\)application)
				```

				- 20 : `AppDelegate.m:implementation:methods:applicationWillEnterForeground:comments`

				- 21 : 

				```
				AppDelegate.m:implementation:methods:applicationDidBecomeActive(- (void\)applicationDidBecomeActive:(UIApplication *\)application)
				```

				- 22 : `AppDelegate.m:implementation:methods:applicationDidBecomeActive:comments`

				- 23 : 

				```
				AppDelegate.m:implementation:methods:applicationWillTerminate(- (void\)applicationWillTerminate:(UIApplication *\)application)
				```

				- 24 : `AppDelegate.m:implementation:methods:applicationWillTerminate:comments`

		- Swift : 

			- Definitions : 

				- `*:implementation:methods:viewDidLoad:super` : 

				```
				super.viewDidLoad()
				// Do any additional setup after loading the view.
				```

				- `AppDelegate.swift:UIApplicationMain` : `@UIApplicationMain`

				- `AppDelegate.swift:implementation:methods:applicationdidFinishLaunchingWithOptions:body` : `// Override point for customization after application launch.`

				- `AppDelegate.swift:implementation:methods:applicationdidFinishLaunchingWithOptions:return` : `return true`

				- `AppDelegate.swift:implementation:properties:window` : `var window: UIWindow?`

			- Nodes : 

				- 0 : `AppDelegate.swift:comments`

				- 1 : `AppDelegate.swift:imports:importCocoa`

				- 2 : `AppDelegate.swift:UIApplicationMain`

				- 3 : `AppDelegate.swift:implementation(AppDelegate: UIResponder, UIApplicationDelegate)`

				- 4 : `AppDelegate.swift:implementation:properties:window`

				- 5 : 

				```
				AppDelegate.swift:implementation:methods:applicationdidFinishLaunchingWithOptions(func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?\) -> Bool)
				```

				- 6 : `AppDelegate.swift:implementation:methods:applicationdidFinishLaunchingWithOptions:body`

				- 7 : `AppDelegate.swift:implementation:methods:applicationdidFinishLaunchingWithOptions:return`

				- 8 : 

				```
				AppDelegate.swift:implementation:methods:applicationWillResignActive(func applicationWillResignActive(_ application: UIApplication\))
				```

				- 9 : `AppDelegate.swift:implementation:methods:applicationWillResignActive:comments`

				- 10 : 

				```
				AppDelegate.swift:implementation:methods:applicationDidEnterBackground(func applicationDidEnterBackground(_ application: UIApplication\))
				```

				- 11 : `AppDelegate.swift:implementation:methods:applicationDidEnterBackground:comments`

				- 12 : 

				```
				AppDelegate.swift:implementation:methods:applicationWillEnterForeground(func applicationWillEnterForeground(_ application: UIApplication\))
				```

				- 13 : `AppDelegate.swift:implementation:methods:applicationWillEnterForeground:comments`

				- 14 : 

				```
				AppDelegate.swift:implementation:methods:applicationDidBecomeActive(func applicationDidBecomeActive(_ application: UIApplication\))
				```

				- 15 : `AppDelegate.swift:implementation:methods:applicationDidBecomeActive:comments`

				- 16 : 

				```
				AppDelegate.swift:implementation:methods:applicationWillTerminate(func applicationWillTerminate(_ application: UIApplication\))
				```

				- 17 : `AppDelegate.swift:implementation:methods:applicationWillTerminate:comments`

### Targets : 

- 0 : 

	- SharedSettings : 

		- `ASSETCATALOG_COMPILER_APPICON_NAME` : `AppIcon`

		- `LD_RUNPATH_SEARCH_PATHS` : `$(inherited) @executable_path/Frameworks`

		- `TARGETED_DEVICE_FAMILY` : `1,2`

	- TargetIdentifier : `com.apple.dt.cocoaTouchApplicationTarget`