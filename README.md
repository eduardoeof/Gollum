# Gollum
**A Swift A/B testing framework for iOS**

[![Build Status](https://travis-ci.org/eduardoeof/Gollum.svg?branch=master)](https://travis-ci.org/eduardoeof/Gollum)
[![codecov.io](http://codecov.io/gh/eduardoeof/Gollum/coverage.svg?branch=master)](http://codecov.io/gh/eduardoeof/Gollum)
[![Code Climate](https://codeclimate.com/github/eduardoeof/Gollum/badges/gpa.svg)](https://codeclimate.com/github/eduardoeof/Gollum)


A/B testing (also known as split testing) is a good practice to test new concepts. Gollum is a A/B testing framework easy to use and inspired on some best practices in Swift, like:
* Value Types (structs and enums)
* Error Handling (ErrorType and throws)
* Compile time feedback

## Instalation (Cocoapods)
Add to your `Podfile`:
```rb
pod 'Gollum'
```
Then run the command below:
```
$ pod install
```

## Usage
Create a `enum` with `Version` type for your A/B test. Pass on each case a string with version name (e.g. `a`) and its probability (e.g. `0.5`), both separated by `:`.
```swift
enum MyABTest: Version {
    case a = "A:0.5"
    case b = "B:0.5"
}
```
Register the test's cases in Gollum:
```swift
try Gollum.instance.registerVersions([MyABTest.a, MyABTest.b])
```

After registration, you can check which version was selected using `getSelectedVersion`:
```swift
switch try Gollum.instance.getSelectedVersion(MyABTest.self) {
case .a:
    view.backgroundColor = UIColor.red
case .b:
    view.backgroundColor = UIColor.green
}
```

Or using `isVersionSelected`:
```swift
if try Gollum.instance.isVersionSelected(MyABTest.a) {
    view.backgroundColor = UIColor.red
} else if try Gollum.instance.isVersionSelected(MyABTest.b) {
    view.backgroundColor = UIColor.green
}
```

## Error Handling
To avoid unexpected scenarios during an A/B testing, it's important treat errors. Gollum can throw these errors:
```swift
public enum GollumError: Error {
    case versionSyntaxError(String)
    case probabilitySumIncorrect(String)
    case emptyVersionArrayPassed(String)
    case selectedVersionNotFound(String)
}
```

If an A/B testing enum is created with wrong syntax, like missing version name or probability, the application will crash with error `versionSyntaxError`:
```swift
enum MyABTest: Version {
    case a = ":0.5"
    case b = "B:0.5"
}
```

Error message:
```
fatal error: 'try!' expression unexpectedly raised an error: Gollum.GollumError.versionSyntaxError("ABTest case expression must have name and probability values splitted by : (e.g. \"MyTestCaseA:0.5\")")
```

During an A/B test registration, the method `registerVersions` can throws `emptyVersionArrayPassed`, `selectedVersionNotFound` or `probabilitySumIncorrect` errors.

Also methods `getSelectedVersion` and `isVersionSelected` can throw `selectedVersionNotFound` error.

## Objective-C
Because of some Swift's features, Gollum doesn't work in Objective-C.

## License
Gollum is available under the MIT license. See the LICENSE file for more info.

