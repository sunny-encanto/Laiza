# laiza

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## to Remove lStar not found Error

dependency uni_links
Update compileSdkVersion and targetSdkVersion to 31

And add this code snippet in your android/build.gradle file at the very end.

configurations.all {
resolutionStrategy {
force 'androidx.core:core-ktx:1.6.0'
}
}