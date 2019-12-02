README
===

Last edited: 2019/12/02

This README explains the project and folder structure of this app.

To read and edit this file use a markdown editor, e.g. [MacDown](https://macdown.uranusjr.com)

# The project

Always open the project with the workspace file `DemoApp.xcworkspace`. (Don't use the `.xcodeproj` file)

Used Xcode version: 10.2.1

## Swift

Used version: Swift 5

### Comments

Use the language's [comment style](https://developer.apple.com/library/content/documentation/Xcode/Reference/xcode_markup_formatting_ref/#//apple_ref/doc/uid/TP40016497-CH2-SW1) to highlight parameters, return values and other pieces so they are accessible by Xcode's quick help.

### Documentation

Besides of this readme there is more docuementation located in the `Documentation` folder.

### Coding Style Guides

As coding style guide the commonly used guides are used which are automatically enforced by the command line tool SwiftFormat which becomes executed each time the project gets compiled. In essence this means a developer doesn't need to think about any guidelines the tool will automatically apply them.

### Base classes

In the `Globals/BaseClasses` folder some base classes are provided to derive from. Use them instead of deriving directly from `UIKit`, e.g. derive from `BaseViewController` instead of `UIViewController`. These are project specific and should include common code for all child classes.

### Logging

To log something use the `Log` class located in the embedded framework `Shared`. It encapsulates a concrete logging facility available throughout the whole app and any widgets, sub-frameworks, etc. So simply use something like `Log.debug("MyMessage")` in code.

## Dependencies

Always add new depending libraries through CocoaPods. Only if there is no possibility use a different option.

When installing new libraries or to update integrated libraries simply use the `updatePods.sh` script located in the `Tools` folder. If necessary make the script executable via `chmod u+x updatePods.sh`.

Always check in all dependant libraries into the repositiory to have a consistent state so the app can be compiled right out of the repo.

### CocoaPods

You only need to have [Cocoapods](https://cocoapods.org) installed when you want to add external dependencies. 

All pods are included in the repository and already linked with the workspace.

### Embedded Frameworks

Part of the app's code is outsourced into their own frameworks. They are embedded into the app and located in the `EmbeddedFrameworks` folder. They share code used in different modules, e.g. the app and a widget. Use them with their corresponding import statement.

Each framework has its own `README.md` file which describes the purpos of the framework and any notable information.

### Resources

The project's `Resources` folder contains non-code dependencies, like images managed by an asset catalog. However, these assets are only used by the main project, not by sub-modules like the widget. 

So globally used resources, e.g. a color asset catalog, are located in the `GlobalResources` folder and referenced by multiple targets besides the main app's target.

### Generated code

Some code becomes automatically generated, e.g. during the build phase. This code is located in a sub-folder of the `Generated` folder. Never modify these files manually because the changes will be overwritten.

## Build phase

Whenever the project gets build some tools are run in the build phase.

### SwiftFormat

The [SwiftFormat](https://github.com/nicklockwood/SwiftFormat) tool is integrated into the build phase so everytime when building the project all swift files in the project are getting formatted. This is to make sure the code is always respecting the coding styles.

### SwiftLint

As part of the build phase [SwiftLint](https://github.com/realm/SwiftLint) is integrated to enforce additional conventions not covered by Xcode. Always make sure all errors and warnings are solved or at least addressed appropriately.

## Strong types

Always try to use strongly typed references.

### R-swift

The project uses [R.swift](https://github.com/mac-cain13/R.swift) to create strong typed references to images, fonts, resources, colors and localized strings. Everytime the project gets build the `R.generated.swift` file will be created / updated automatically.

To reference those types always use R-swift, e.g.:

- `R.image.myIcon()`
- `R.font.myFont(size: 42)`
- `R.file.resourceUrl()`
- `R.color.myColor()`
- `R.string.localizable.myMessage()`

R.swift doesn't support multiple entitlements files in different targets, yet. Therefore, the command line for the main project includes the flag `--generators image,string,color,file,font` to include only the necessary file types. When additional types are needed they have to be added here. 

### AppFolder

For a strong type reference to the file system [AppFolder](https://github.com/dreymonde/AppFolder) is used. So instead of using `NSSearchPathForDirectoriesInDomains` simply use something like `AppFolder.Documents` or extend it to use own custom paths.

### Constants

Constants are defined in the files located in the `Constants` folder of the embedded framework `Shared`. They are all tailored into a struct called `Const` where extensions add additional sub-structs for specific types. Reference them like `Const.myType.myConst`.

### Configurations

For using different URLs, tokens, model, etc. for the different potential server modes (develop, staging, production) `Config.plist` files are provided. They are located in the subfolders in `Resources` matching the corresponding modes. During the build phase the correct file depending on the selected scheme is copied to the `Generated` folder and then included into the bundle. Theferfore, never modify the generated file, but the original in the resources folder.

The configuration is parsed from the `plist` file into a model located in the `Configuration` folder of the embedded framework `Shared`. So, when modifying the config file also modify the `ConfigModel` to match the changes and don't forget to alter also the other configuration files for the other modes.

The configuration file is also used for providing test flags for debugging. The config model has a `testFlags` dictionary with flags for specific test cases. The `testFlags` dictionary is optional so it can be dropped for the production build and not risking to provide sensitive debug data in the release binary. 

### Localized text

Always write output text (text which the user can read) into localizable strings files. Globally used strings go into the `Global.strings` file, all other specific use case strings go into their corresponding strings file mostly located in the scene's folder. Reference them via `R-swift`.

## App version

The app's version number (`CFBundleShortVersionString` e.g. `1.0`) is saved in the project's build settings as a user-defined setting named `APP_VERSION`. This has to be updated manually when a new app version release is targeted.

The app's build number (`CFBundleVersion` e.g. `42`) is saved in the `info.plist` file and the target's build settings in the `Versioning` section. This number should automatically be increased by a CI system when releasing a new version. To manually increment the version run `xcrun agvtool next-version -all`.

### Settings

When developing on new features in the app it may become necessary to introduce new default values for certain setting properties. For this the method `updateSettings()` of the `InternalSettings` class in `Shared` exists. Just extens this class when needed.

## Playgrounds

There is a folder named `Playgrounds` which contains some playgrounds to play with. They can import the pods of the app thus are a good entry point to try out some libraries or coding examples.

It's only possible to import code from the app into a playground if that code is located into a framework. Therefore the custom views are located into their own frameworks so they can be imported from a playground. To use this for testing purposes each custom view contains its own playground located next to the view's source code.

## Scenes

This folder contains the main code, the app's views and controllers. Each 'app view' is called a `Scene` and is independant from other scenes located in their own sub-folders.

The entry point for each scene is the class with the scene's name and `VC` added, e.g. `Scene1VC`. This represents the `ViewController` which is responsible for building up this scene, containing the view and any dependencies.

For passing values to the scene there is a `setup` file located in the scene's folder, e.g. `Scene1Setup.swift`. This describes the struct to inject as dependency into the new scene when creating it.

Other parts of a scene are the `Logic` and the `Display`. The former contains any business logic this scene implements while the latter manages the view, how to represent values and deliver interactions to the logic.

### Xibs & Storyboards

The project doesn't use Xibs or Storyboards to layout views or to design the navigation. Everything is done via code.

There are some Xibs in the project which only present the view  via `IBDesignable`. They are only meant to visualize the code during development. These Xibs are not added to a target and therefore not delivered with the app.

One 
