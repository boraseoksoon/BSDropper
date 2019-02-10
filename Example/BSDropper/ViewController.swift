//
//  ViewController.swift
//  BSDropper
//
//  Created by Seoksoon Jang on 09/02/2019.
//  Copyright © 2019 JSS. All rights reserved.
//

import UIKit
import BSDropper

class ViewController: UIViewController {

  // MARK: - IBOutlet, IBAction Methods -

  /**
   * initiating dropper instance with setup here...
   */
  private lazy var dropper: BSDropper = { [unowned self] in
    let dropper = BSDropper.initialization()
    return dropper
  }()
  
  @IBOutlet var tvPost: UITableView! {
    didSet {
      tvPost.delegate = self
      tvPost.dataSource = self
      
      tvPost.separatorStyle = .none
      tvPost.tableFooterView = UIView()
      
      tvPost.backgroundColor = UIColor.white
      
      tvPost.estimatedRowHeight = 200
      tvPost.rowHeight = UITableViewAutomaticDimension
    }
  }
  
  // MARK: - Instance Variables Methods -
  private var isDidLayoutFinish: Bool = false
  
  // MARK: - ViewController LifeCycle Delegate Methods -
  override func viewDidLoad() {
    super.viewDidLoad()

    self.setUpDropper()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    isDidLayoutFinish = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

// MARK: - Own methods -
extension ViewController {
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
  
  fileprivate func showTransition(targetView: UIView, completion: (() -> (Void))? = nil) -> Void {
    UIView.transition(with: targetView, duration: 0.25, options: [.transitionCrossDissolve], animations: {
      targetView.alpha = 1.0
    }, completion: { _ in
      completion?()
    })
  }
  
  fileprivate func hideTransitionView(targetView: UIView, completion: (() -> (Void))? = nil) -> Void {
    UIView.transition(with: targetView, duration: 0.25, options: [.transitionCrossDissolve], animations: {
      targetView.alpha = 0.0
    }, completion: { _ in
      completion?()
    })
  }
}

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
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
      }
      return cell
    }()
    
    cell.textLabel?.text = "BSDropper"
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
}

// MARK: - UITextFieldDelegate Methods -
extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField.isFirstResponder {
      textField.resignFirstResponder()
    }
    
    /// when done
    if textField.returnKeyType == .search {
      let targetVC = SampleViewController.instantiate(from: .Main)
      let navVC = UINavigationController(rootViewController: targetVC)
      navVC.setNavigationBarHidden(true, animated: false)
      self.present(navVC, animated: true, completion: nil)
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
