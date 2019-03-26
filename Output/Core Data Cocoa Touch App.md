# Core Data Cocoa Touch App

## TemplateInfo

### Identifier

- com.apple.dt.unit.coreDataCocoaTouchApplication ( [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Core%20Data%20Cocoa%20Touch%20App.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Core%20Data%20Cocoa%20Touch%20App.xctemplate/TemplateInfo.plist) )

### Ancestors

- com.apple.dt.unit.cocoaTouchApplicationBase ( [**Cocoa Touch App Base**](Cocoa%20Touch%20App%20Base.md), [directory](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Cocoa%20Touch%20App%20Base.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project%20Templates/iOS/Application/Cocoa%20Touch%20App%20Base.xctemplate/TemplateInfo.plist) )

---

### Kind : `Xcode.Xcode3.ProjectTemplateUnitKind`

### Options : 

- 0 : 

	- Default : `false`

	- Description : `Whether the application should use the Core Data framework for storage`

	- Identifier : `coreData`

	- Name : `Use Core Data`

	- SortOrder : `YES`

	- Type : `checkbox`

	- Units : 

		- true : 

			- 0 : 

				- Definitions : 

					- `___PACKAGENAMEASIDENTIFIER___.xcdatamodeld` : 

						- Path : `___PACKAGENAMEASIDENTIFIER___.xcdatamodeld`

						- SortOrder : `99`

				- Nodes : 

					- 0 : `___PACKAGENAMEASIDENTIFIER___.xcdatamodeld`

			- 1 : 

				- Definitions : 

					- `*:importCoreData` : 

					```
					#import <CoreData/CoreData.h>
					
					```

					- `AppDelegate.h:interface:coreData` : 

					```
					@property (readonly, strong) NSPersistentContainer *persistentContainer;
					
					- (void)saveContext;
					
					```

					- `AppDelegate.m:implementation:coreData` : 

					```
					#pragma mark - Core Data stack
					
					@synthesize persistentContainer = _persistentContainer;
					
					- (NSPersistentContainer *)persistentContainer {
					    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
					    @synchronized (self) {
					        if (_persistentContainer == nil) {
					            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"___PACKAGENAMEASIDENTIFIER___"];
					            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
					                if (error != nil) {
					                    // Replace this implementation with code to handle the error appropriately.
					                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
					                    
					                    /*
					                     Typical reasons for an error here include:
					                     * The parent directory does not exist, cannot be created, or disallows writing.
					                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
					                     * The device is out of space.
					                     * The store could not be migrated to the current model version.
					                     Check the error message to determine what the actual problem was.
					                    */
					                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
					                    abort();
					                }
					            }];
					        }
					    }
					    
					    return _persistentContainer;
					}
					
					#pragma mark - Core Data Saving support
					
					- (void)saveContext {
					    NSManagedObjectContext *context = self.persistentContainer.viewContext;
					    NSError *error = nil;
					    if ([context hasChanges] && ![context save:&error]) {
					        // Replace this implementation with code to handle the error appropriately.
					        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
					        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
					        abort();
					    }
					}
					
					```

					- `AppDelegate.m:implementation:methods:applicationWillTerminate:save` : 

					```
					// Saves changes in the application's managed object context before the application terminates.
					[self saveContext];
					
					```

				- Nodes : 

					- 0 : `AppDelegate.h:imports:importFramework:CoreData`

					- 1 : `AppDelegate.h:interface:coreData`

					- 2 : `AppDelegate.m:implementation:methods:applicationWillTerminate:save`

					- 3 : `AppDelegate.m:implementation:coreData`

				- RequiredOptions : 

					- languageChoice : `Objective-C`

			- 2 : 

				- Definitions : 

					- `AppDelegate.swift:implementation:coreData` : 

					```
					// MARK: - Core Data stack
					
					lazy var persistentContainer: NSPersistentContainer = {
					    /*
					     The persistent container for the application. This implementation
					     creates and returns a container, having loaded the store for the
					     application to it. This property is optional since there are legitimate
					     error conditions that could cause the creation of the store to fail.
					    */
					    let container = NSPersistentContainer(name: "___PACKAGENAMEASIDENTIFIER___")
					    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
					        if let error = error as NSError? {
					            // Replace this implementation with code to handle the error appropriately.
					            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
					             
					            /*
					             Typical reasons for an error here include:
					             * The parent directory does not exist, cannot be created, or disallows writing.
					             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
					             * The device is out of space.
					             * The store could not be migrated to the current model version.
					             Check the error message to determine what the actual problem was.
					             */
					            fatalError("Unresolved error \(error), \(error.userInfo)")
					        }
					    })
					    return container
					}()
					
					// MARK: - Core Data Saving support
					
					func saveContext () {
					    let context = persistentContainer.viewContext
					    if context.hasChanges {
					        do {
					            try context.save()
					        } catch {
					            // Replace this implementation with code to handle the error appropriately.
					            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
					            let nserror = error as NSError
					            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
					        }
					    }
					}
					
					```

					- `AppDelegate.swift:implementation:methods:applicationWillTerminate:save` : 

					```
					// Saves changes in the application's managed object context before the application terminates.
					self.saveContext()
					
					```

				- Nodes : 

					- 0 : `AppDelegate.swift:imports:importFramework:CoreData`

					- 1 : `AppDelegate.swift:implementation:methods:applicationWillTerminate:save`

					- 2 : `AppDelegate.swift:implementation:coreData`

				- RequiredOptions : 

					- languageChoice : `Swift`