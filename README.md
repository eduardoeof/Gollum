# Gollum
**A Swift A/B Testing framework for iOS**

Before anything, let's check the lightspeed tutorial!
## Lightspeed Tutorial
#### Instalation (Cocoapods)
Add to your `Podfile`:
```rb
pod 'Gollum'
```
Then run the command below:
```
$ pod install
```
#### Usage
Create a `enum` for your A/B Test, passing for each case a string with version name (e.g. `A`) and its probability (e.g. `0.5`)
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
Check which version was selected:
```swift
if Gollum.instance.isVersionSelected(MyAdorableABTest.A) {
    view.backgroundColor = UIColor.redColor()
} else if Gollum.instance.isVersionSelected(MyAdorableABTest.B) {
    view.backgroundColor = UIColor.greenColor()
}
```
Oh boy, that was fast! Let's clarify some points.
