# Base_DefinitionsLanguage

## TemplateInfo

### Identifier

- com.apple.dt.unit.base_DefinitionsLanguage ( [directory](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Base_DefinitionsLanguage.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Base_DefinitionsLanguage.xctemplate/TemplateInfo.plist) )

---
<span id="m_Definitions">[Definitions](#a_Definitions)</span> | <span id="m_Options">[Options](#a_Options)</span>

### Definitions :  <span id="a_Definitions"/>[↩](#m_Definitions)

- `*:class:*` : 

```
@class ___*___;

```

- `*:comments` : 

```
//___FILEHEADER___

```

- `*:extension` : 

	- Beginning : 

	```
	@interface ___FILEBASENAME___ ()
	
	```

	- End : 

	```
	@end
	
	```

- `*:implementation` : 

	- Beginning : 

	```
	@implementation ___FILEBASENAME___
	
	```

	- End : `@end`

- `*:implementation:methods` : 

	- Beginning : ``

	- End : ``

- `*:implementation:methods:*` : 

	- Beginning : `___*___ {`

	- End : 

	```
	}
	
	
	```

	- Indent : `YES`

- `*:implementation:methods:init` : 

	- Beginning : 

	```
	- (instancetype)init {
	    self = [super init];
	    if (self) {
	```

	- End : 

	```
	    }
	    return self;
	}
	
	```

	- Indent : `2`

- `*:implementation:properties` : 

	- Beginning : ``

	- End : 

	```
	
	
	
	```

- `*:implementation:synthesize` : 

	- End : 

	```
	
	
	```

- `*:implementation:synthesize:*` : `@synthesize ___*___;`

- `*:imports` : 

	- Beginning : ``

	- End : 

	```
	
	
	```

- `*:imports:importFramework:*` : `#import <___*___/___*___.h>`

- `*:imports:importHeader:*` : `#import "___*___"`

- `*:interface` : 

	- Beginning : 

	```
	@interface ___*___
	
	```

	- End : 

	```
	
	@end
	
	```

### Kind : `Xcode.Xcode3.ProjectTemplateUnitKind`

### Options :  <span id="a_Options"/>[↩](#m_Options)

- 0 : 

	- Identifier : `languageChoice`

	- Units : 

		- `Objective-C` : 

			- Definitions : 

		- Swift : 

			- Definitions : 

				- `*:class:*` : ``

				- `*:implementation` : 

					- Beginning : 

					```
					class ___*___ {
					
					```

					- End : 

					```
					
					}
					
					```

					- Indent : `YES`

				- `*:implementation:methods:init` : 

					- Beginning : 

					```
					override init() {
					    super.init()
					
					```

					- End : 

					```
					}
					
					
					```

					- Indent : `YES`

				- `*:imports:importFramework:*` : `import ___*___`

				- `*:imports:importHeader:*` : ``