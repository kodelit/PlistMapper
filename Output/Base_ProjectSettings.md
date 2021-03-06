# Base_ProjectSettings

## TemplateInfo

### Identifier

- com.apple.dt.unit.base_ProjectSettings ( [directory](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Base_ProjectSettings.xctemplate), [plist](/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project%20Templates/Base/Base_ProjectSettings.xctemplate/TemplateInfo.plist) )

---
<span id="m_Options">[Options](#a_Options)</span> | <span id="m_Project">[Project](#a_Project)</span> | <span id="m_Targets">[Targets](#a_Targets)</span>

### Kind : `Xcode.Xcode3.ProjectTemplateUnitKind`

### Options :  <span id="a_Options"/>[↩](#m_Options)

- 0 : 

	- Identifier : `languageChoice`

	- Units : 

		- Swift : 

			- Project : 

				- Configurations : 

					- Debug : 

						- `SWIFT_ACTIVE_COMPILATION_CONDITIONS` : `DEBUG`

						- `SWIFT_OPTIMIZATION_LEVEL` : `-Onone`

					- Release : 

						- `SWIFT_COMPILATION_MODE` : `wholemodule`

						- `SWIFT_OPTIMIZATION_LEVEL` : `-O`

			- Targets : 

				- 0 : 

					- Concrete : `NO`

					- SharedSettings : 

						- `SWIFT_VERSION` : `5.0`

### Project :  <span id="a_Project"/>[↩](#m_Project)

- Configurations : 

	- Debug : 

		- `DEBUG_INFORMATION_FORMAT` : `dwarf`

		- `ENABLE_TESTABILITY` : `YES`

		- `GCC_DYNAMIC_NO_PIC` : `NO`

		- `GCC_OPTIMIZATION_LEVEL` : `0`

		- `GCC_PREPROCESSOR_DEFINITIONS` : `DEBUG=1 $(inherited)`

		- `MTL_ENABLE_DEBUG_INFO` : `INCLUDE_SOURCE`

		- `ONLY_ACTIVE_ARCH` : `YES`

	- Release : 

		- `DEBUG_INFORMATION_FORMAT` : `dwarf-with-dsym`

		- `ENABLE_NS_ASSERTIONS` : `NO`

		- `MTL_ENABLE_DEBUG_INFO` : `NO`

- SharedSettings : 

	- `ALWAYS_SEARCH_USER_PATHS` : `NO`

	- `CLANG_ANALYZER_NONNULL` : `YES`

	- `CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION` : `YES_AGGRESSIVE`

	- `CLANG_CXX_LANGUAGE_STANDARD` : `gnu++14`

	- `CLANG_CXX_LIBRARY` : `libc++`

	- `CLANG_ENABLE_MODULES` : `YES`

	- `CLANG_ENABLE_OBJC_ARC` : `YES`

	- `CLANG_ENABLE_OBJC_WEAK` : `YES`

	- `CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING` : `YES`

	- `CLANG_WARN_BOOL_CONVERSION` : `YES`

	- `CLANG_WARN_COMMA` : `YES`

	- `CLANG_WARN_CONSTANT_CONVERSION` : `YES`

	- `CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS` : `YES`

	- `CLANG_WARN_DIRECT_OBJC_ISA_USAGE` : `YES_ERROR`

	- `CLANG_WARN_DOCUMENTATION_COMMENTS` : `YES`

	- `CLANG_WARN_EMPTY_BODY` : `YES`

	- `CLANG_WARN_ENUM_CONVERSION` : `YES`

	- `CLANG_WARN_INFINITE_RECURSION` : `YES`

	- `CLANG_WARN_INT_CONVERSION` : `YES`

	- `CLANG_WARN_NON_LITERAL_NULL_CONVERSION` : `YES`

	- `CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF` : `YES`

	- `CLANG_WARN_OBJC_LITERAL_CONVERSION` : `YES`

	- `CLANG_WARN_OBJC_ROOT_CLASS` : `YES_ERROR`

	- `CLANG_WARN_RANGE_LOOP_ANALYSIS` : `YES`

	- `CLANG_WARN_STRICT_PROTOTYPES` : `YES`

	- `CLANG_WARN_SUSPICIOUS_MOVE` : `YES`

	- `CLANG_WARN_UNGUARDED_AVAILABILITY` : `YES_AGGRESSIVE`

	- `CLANG_WARN_UNREACHABLE_CODE` : `YES`

	- `CLANG_WARN__DUPLICATE_METHOD_MATCH` : `YES`

	- `COPY_PHASE_STRIP` : `NO`

	- `ENABLE_STRICT_OBJC_MSGSEND` : `YES`

	- `GCC_C_LANGUAGE_STANDARD` : `gnu11`

	- `GCC_NO_COMMON_BLOCKS` : `YES`

	- `GCC_WARN_64_TO_32_BIT_CONVERSION` : `YES`

	- `GCC_WARN_ABOUT_RETURN_TYPE` : `YES_ERROR`

	- `GCC_WARN_UNDECLARED_SELECTOR` : `YES`

	- `GCC_WARN_UNINITIALIZED_AUTOS` : `YES_AGGRESSIVE`

	- `GCC_WARN_UNUSED_FUNCTION` : `YES`

	- `GCC_WARN_UNUSED_VARIABLE` : `YES`

	- `MTL_FAST_MATH` : `YES`

### Targets :  <span id="a_Targets"/>[↩](#m_Targets)

- 0 : 

	- Concrete : `NO`

	- Configurations : 

		- Debug : 

		- Release : 

	- Name : `___PACKAGENAME___`

	- SharedSettings : 

		- `PRODUCT_NAME` : `$(TARGET_NAME)`