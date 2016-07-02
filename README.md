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
Create a `enum` with `Version` type for your A/B test. Pass on each case a string with version name (e.g. `A`) and its probability (e.g. `0.5`), both separated by `:`.
```swift
enum MyABTest: Version {
    case A = "A:0.5"
    case B = "B:0.5"
}
```
Register the test's cases in Gollum:
```swift
try Gollum.instance.registerVersions([MyABTest.A, MyABTest.B])
```
After registration, you can check which version was selected using `getSelectedVersion`:

```swift
switch try! Gollum.instance.getSelectedVersion(MyAdorableABTest) {
case .A:
    view.backgroundColor = UIColor.redColor()
case .B:
    view.backgroundColor = UIColor.greenColor()
}
```
Or using `isVersionSelected`:

```swift
if try! Gollum.instance.isVersionSelected(MyAdorableABTest.A) {
    view.backgroundColor = UIColor.redColor()
} else if try! Gollum.instance.isVersionSelected(MyAdorableABTest.B) {
    view.backgroundColor = UIColor.greenColor()
}
```

## Error Handling
To avoid unexpected scenarios during an A/B testing, it's important treat errors. Gollum can throw these errors:
```swift
public enum GollumError: ErrorType {
    case VersionSyntaxError(String)
    case ProbabilitySumIncorrect(String)
    case EmptyVersionArrayPassed(String)
    case SelectedVersionNotFound(String)
}
```
If an A/B testing enum is created with wrong syntax, like missing version name or probability, the application will crash with error `VersionSyntaxError`:
```swift
enum MyABTest: Version {
    case A = ":0.5"
    case B = "B:0.5"
}
```
Error message:
```
fatal error: 'try!' expression unexpectedly raised an error: Gollum.GollumError.VersionSyntaxError("ABTest case expression must have name and probability values splitted by : (e.g. \"MyTestCaseA:0.5\")")
```
During an A/B test registration, the method `registerVersions` can throws `EmptyVersionArrayPassed`, `SelectedVersionNotFound` or `ProbabilitySumIncorrect` errors.

Also methods `getSelectedVersion` and `isVersionSelected` can throw `SelectedVersionNotFound` error.

## Objective-C
Because of some Swift's features, Gollum doesn't work in Objective-C.

## License
Gollum is available under the MIT license. See the LICENSE file for more info.
