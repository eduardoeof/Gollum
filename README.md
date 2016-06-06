# Gollum
**A Swift A/B testing framework for iOS**

A/B testing (also known as split testing) is a good practice to test new concepts. Gollum is a A/B testing framework easy to use and inspired on some best practices in Swift, like:
* Value Types (structs and enums)
* Error Handling (ErrorType and throws)
* Compile time feedback

## Instalation (Cocoapods)
Add to your `Podfile`:
```rb
pod 'Gollum', :git => 'git@github.com:eduardoeof/Gollum.git', :tag => '0.1.0'
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
After registration, you can check which version was selected:
```swift
if Gollum.instance.isVersionSelected(MyAdorableABTest.A) {
    view.backgroundColor = UIColor.redColor()
} else if Gollum.instance.isVersionSelected(MyAdorableABTest.B) {
    view.backgroundColor = UIColor.greenColor()
}
```
## Objective-C
Because of some Swift's features, Gollum doens't work in Objective-C.

## License
Gollum is available under the MIT license. See the LICENSE file for more info.
