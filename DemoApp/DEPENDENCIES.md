DEPENDENCIES
===

Last edited: 2019/04/01

As described in [http://blog.mazur.me/DEPENDENCIES.md](http://blog.mazur.me/DEPENDENCIES.md) use this file to track all dependencies required by this project.

## Added via CocoaPods

### [Anchorage](https://github.com/Raizlabs/Anchorage)
- License: MIT
- A collection of operators and utilities that simplify iOS layout code.
- Because this project doesn't use Xibs or Storyboards all views are layouted manually and this library makes it much easier.

### [AppFolder](https://github.com/dreymonde/AppFolder)
- License: MIT
- A strong typed folder path structure to replace NSSearchPathForDirectoriesInDomains.
- This library helps ensuring all filepaths used inside of the app are strong typed, e.g. for getting the base path to the app's bundle in debug mode.

### [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack)
- License: BSD 3-Clause
- A configurable logger used for logging.
- Necessary for logging during development and to easily silence logs for release builds.

### [Periphery](https://github.com/peripheryapp/periphery)
- License: MIT
- Detects unused swift code.
- Not necessary, but helpful when trying to detect unused code in the project.

### [R.swift](https://github.com/mac-cain13/R.swift)
- License: MIT
- Build phase tool to create constants for localized text, colors, fonts, etc.
- Necessary to strong type any localizable strings, colors and images.

### [RxSwift & RxCocoa](https://github.com/ReactiveX/RxSwift)
- License: MIT
- A framework for using reactive programming in Swift and Cocoa.
- Necessary to simplify the bindings between a view and the logic.

### [SwiftFormat](https://github.com/nicklockwood/SwiftFormat)
- License: MIT
- Formats the swift code during the build phase to be consistent.
- Necessary to ensure the code is always conforming the formatting guitelines.

### [SwiftLint](https://github.com/realm/SwiftLint)
- License: MIT
- A linter to gather code metrics during the build phase.
- Necessary to inform about additional code smells.

### [WeaverDI](https://github.com/scribd/Weaver)
- License: MIT
- A dependency injection framework for Swift.
- Necessary for streamlining the injection of dependencies into scenes.

