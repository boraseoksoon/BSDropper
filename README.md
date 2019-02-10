# BSDropper

[![CI Status](https://img.shields.io/travis/boraseoksoon@gmail.com/BSDropper.svg?style=flat)](https://travis-ci.org/boraseoksoon@gmail.com/BSDropper)
[![Version](https://img.shields.io/cocoapods/v/BSDropper.svg?style=flat)](https://cocoapods.org/pods/BSDropper)
[![License](https://img.shields.io/cocoapods/l/BSDropper.svg?style=flat)](https://cocoapods.org/pods/BSDropper)
[![Platform](https://img.shields.io/cocoapods/p/BSDropper.svg?style=flat)](https://cocoapods.org/pods/BSDropper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
iOS 10.0+ <br>
Swift 4.2 + <br>

## How to use
BSDropper is easy to use.<br>

<b>Step 0. import BSDropper</b>
where you need 
<br>
```Swift
import BSDropper
```
<br>

<b>Step 1. Create Instance programmatically as an instance variable </b>
declare and create instance as an instance variable. 
<br>
Dropper is only supported in a programmatical way.  
<br>

```Swift
/**
* initiating dropper instance with setup here...
*/
private lazy var dropper: BSDropper = { [unowned self] in
  let dropper = BSDropper.initialization()
  return dropper
}()
```

<b>Step3. Start Observing offset Y</b>
apply observe API and check API at scrollViewDidScroll and scrollViewWillBeginDragging respectively.
<br>

```Swift
// MARK: - UITableView Delegate Methods -
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    /**
    * observe scrollView
    */
    dropper.observe(scrollView)
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    /**
    * checking offSet
    */
    dropper.check(offsetY: scrollView.contentOffset.y)
  }
}
```

Done. :)

<b>Step2. Setup Dropper Instance</b>
Decleare an instance method to setup BSDropper instance as below 
<br>

```Swift
func setUpDropper() -> Void {
  /**
  * add the dropper on top to get ready
  */
  self.view.addSubview(dropper)

  /**
  * Icon setup methods
  */
  dropper.setSearchTextFieldLeftImage(#imageLiteral(resourceName: "iconSearch"))
  dropper.setDropArrowImage(#imageLiteral(resourceName: "boardListOpen"))
  dropper.setMyPageIconImage(#imageLiteral(resourceName: "combinedShape"))
  dropper.setAlarmIconImage(#imageLiteral(resourceName: "alarmNotice"))
  dropper.setScrollViewOffSet(tvPost)

  /**
  * Search TextField Delegate
  */
  dropper.tfSearch.delegate = self

  /**
  * Events Listeners
  */
  dropper.closureBtTopicSelect = { [weak self] topicTitle in
    guard let `self` = self else { GUARD_PRETTY_FUNCTION(); return }

    self.dropper.show() { [weak self] in
    guard let `self` = self else { GUARD_PRETTY_FUNCTION(); return }
      //
    }

    print("'\(topicTitle)' clicked.")
  }

  self.dropper.closureBtAlarm = { [weak self] in
    guard let `self` = self else { GUARD_PRETTY_FUNCTION(); return }
    print("'Alarm clicked.")
  }

  self.dropper.closureBtMyPage = { [weak self] in
    guard let `self` = self else { GUARD_PRETTY_FUNCTION(); return }
    print("'MyPage clicked.")
  }

  self.dropper.closureBtFilterPost = { [weak self] in
    guard let `self` = self else { GUARD_PRETTY_FUNCTION(); return }
    print("'Filter clicked.")
  }
}
```

Don't forget you must need to apply it in viewDidLoad.
<br>
```Swift
override func viewDidLoad() {
  super.viewDidLoad()

  /**
  * apply dropper 
  */
  self.setUpDropper()
}
```

## Installation

BSDropper is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BSDropper'
```

## Author

boraseoksoon@gmail.com

## License

BSDropper is available under the MIT license. See the LICENSE file for more info.
