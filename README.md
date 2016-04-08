# GreedKeyboardManager

[![CI Status](http://img.shields.io/travis/greedlab/GreedKeyboardManager.svg?style=flat)](https://travis-ci.org/greedlab/GreedKeyboardManager)
[![Version](https://img.shields.io/cocoapods/v/GreedKeyboardManager.svg?style=flat)](http://cocoapods.org/pods/GreedKeyboardManager)
[![License](https://img.shields.io/cocoapods/l/GreedKeyboardManager.svg?style=flat)](http://cocoapods.org/pods/GreedKeyboardManager)
[![Platform](https://img.shields.io/cocoapods/p/GreedKeyboardManager.svg?style=flat)](http://cocoapods.org/pods/GreedKeyboardManager)

A solution for updating UIScrollView out of the the keyboard

## Installation

GreedKeyboardManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GreedKeyboardManager"
```

## Usage

```objc
#import "UIScrollView+GRKeyboardManager.h"

[_scrollView gr_keyboardManager];

```

## Develop

```shell
$ pod lib create GreedKeyboardManager --template-url=git@github.com:GreedBell/pod-template.git
$ cd GreedKeyboardManager
$ pod update --no-repo-update --project-directory=Example/
$ pod lib lint GreedKeyboardManager.podspec --verbose 
$ pod trunk push GreedKeyboardManager.podspec
```

## Author

Bell, bell@greedlab.com

## License

GreedKeyboardManager is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
