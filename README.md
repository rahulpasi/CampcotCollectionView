![LOGO](https://github.com/touchlane/CampcotCollectionView/blob/master/Assets/logo.svg)

[![Build Status](https://travis-ci.org/touchlane/CampcotCollectionView.svg?branch=master)](https://travis-ci.org/touchlane/CampcotCollectionView)
[![codecov](https://codecov.io/gh/touchlane/CampcotCollectionView/branch/master/graph/badge.svg)](https://codecov.io/gh/touchlane/CampcotCollectionView)
[![Version](https://img.shields.io/cocoapods/v/CampcotCollectionView.svg?style=flat)](http://cocoapods.org/pods/CampcotCollectionView)
[![License](https://img.shields.io/cocoapods/l/CampcotCollectionView.svg?style=flat)](http://cocoapods.org/pods/CampcotCollectionView)
[![Platform](https://img.shields.io/cocoapods/p/CampcotCollectionView.svg?style=flat)](http://cocoapods.org/pods/CampcotCollectionView)

This library provides a custom `UICollectionView` that allows to expand and collapse sections. Provides a simple API to manage collection view appearance.

![CampcotCollectionView](Example/Assets/campcot.gif)

# Requirements

* iOS 9.0+
* Xcode 9.0+
* Swift 4.0+

# Installation

## CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```$ gem install cocoapods```

To integrate SlideController into your Xcode project using CocoaPods, specify it in your ```Podfile```:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'CampcotCollectionView'
end
```

Then, run the following command:

```$ pod install```

# Usage

```swift
import CampcotCollectionView
```

1. Create CollectionView
```swift
let campcotCollectionView = CampcotCollectionView()
```
2. Add `campcotCollectionView` to view hierarchy.
3. Call `toggle` method on `campcotCollectionView`.
```swift
public func toggle(to section: Int,
                   offsetCorrection: CGFloat = default,
                   animated: Bool,
                   completion: ((Bool) -> Void)? = default)
```

# Documentation

### CampcotCollectionView

A Boolean value that determines whether the sections are expanded.
```swift
public var isExpanded: Bool { get }
```

Expands all the sections. Pins a section at index `section` to the top of view bounds.  
`offsetCorrection` - the offset for pinned section from the top. Default value of `offsetCorrection` is `0`.  
`animated` - if `true` expands sections with animation.  
`completion` - callback for animation. 
```swift
public func expand(from section: Int,
                   offsetCorrection: CGFloat = default,
                   animated: Bool, 
                   completion: ((Bool) -> Void)? = default)
```

Collapses all the sections. Pins a section at index `section` to the top of view bounds.  
`offsetCorrection` - the offset for pinned section from the top. Default value of `offsetCorrection` is `0`.  
`animated` - if `true` collapses sections with animation.  
`completion` - callback for animation. 
```swift
public func collapse(to section: Int,
                     offsetCorrection: CGFloat = default,
                     animated: Bool,
                     completion: ((Bool) -> Void)? = default)
```

Toggles current state from collapsed to expaned and vise versa. Pins a section at index `section` to the top of view bounds.  
`offsetCorrection` - the offset for pinned section from the top. Default value of `offsetCorrection` is `0`.  
`animated` - if `true` toggles sections with animation.  
`completion` - callback for animation. 
```swift
public func toggle(to section: Int,
                   offsetCorrection: CGFloat = default,
                   animated: Bool,
                   completion: ((Bool) -> Void)? = default)
```
___