# BSDropper

[![CI Status](https://img.shields.io/travis/boraseoksoon@gmail.com/BSDropper.svg?style=flat)](https://travis-ci.org/boraseoksoon@gmail.com/BSDropper)
[![Version](https://img.shields.io/cocoapods/v/BSDropper.svg?style=flat)](https://cocoapods.org/pods/BSDropper)
[![License](https://img.shields.io/cocoapods/l/BSDropper.svg?style=flat)](https://cocoapods.org/pods/BSDropper)
[![Platform](https://img.shields.io/cocoapods/p/BSDropper.svg?style=flat)](https://cocoapods.org/pods/BSDropper)

<br>
<img src="https://firebasestorage.googleapis.com/v0/b/boraseoksoon-ff7d3.appspot.com/o/BSDropDown.png?alt=media&token=8a91d895-5aa5-41ed-bbe8-519227d2f7e1" width=360>
<br>


<b>Click youtube image below to watch BSDropper sample in action.</b>
<br>
<a href="http://www.youtube.com/watch?feature=player_embedded&v=zp9UFc6NDeo
" target="_blank"><img src="http://img.youtube.com/vi/zp9UFc6NDeo/0.jpg" 
alt="BSDropper" width="480" height="360" border="10" /></a>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
iOS 10.0+ <br>
Swift 4.2 + <br>

## How to use
BSDropper is easy to use.<br>

<b>Step 0. import BSDropper</b>
<br>
import at where you need 
<br>
```Swift
import BSDropper
```
<br>

<b>Step 1. Create Instance programmatically as an instance variable </b>
<br>
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

<b>Step2. Setup Dropper Instance</b>
<br>
Decleare an instance method to setup BSDropper instance as below. 
<br>
Below Icon resources are just images given in sample project. you can change as you wish. 
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
  guard let `self` = self else { return }

  self.dropper.show() { [weak self] in
    guard let `self` = self else { return }
    //
  }

  print("'\(topicTitle)' clicked.")
  }

  self.dropper.closureBtAlarm = { [weak self] in
    guard let `self` = self else { return }
    print("'Alarm clicked.")
  }

  self.dropper.closureBtMyPage = { [weak self] in
    guard let `self` = self else { return }
    print("'MyPage clicked.")
  }

  self.dropper.closureBtFilterPost = { [weak self] in
    guard let `self` = self else { return }
    print("'Filter clicked.")
  }
}
```
<b>Don't forget you must need to apply it in viewDidLoad.</b>
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

<b>Step3. Start Observing offset Y</b>
<br>
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

<br>
<b>That's all. well done on that. :) </b>
<br>
You can check how to use it easily through the supported example project. Please check that out if you need.
<br>


<br>
<br>
<br>
<br>
optionally, use searchBar delegate
<br>
There is UITextField designed to be used as search bar, you can use delegate optionally as well. 
<br>

```Swift
// MARK: - UITextFieldDelegate Methods -
extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField.isFirstResponder {
      textField.resignFirstResponder()
    }

    /// when search done key is clicked
    if textField.returnKeyType == .search {
      //
    }

    return true
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    ///
  }

  func textFieldDidBeginEditing(_ textField: UITextField) {
    ///
  }
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
