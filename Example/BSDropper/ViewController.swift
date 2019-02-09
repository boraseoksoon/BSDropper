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
    if let dropper = Bundle(for: BSDropper.self).loadNibNamed(BSDropper.XIB_NAME_CONSTANT,
                                                   owner:self,
                                                   options:nil)?[0] as? BSDropper {
      dropper.frame = CGRect(
        x: 0,
        y: 0,
        width: BSDropper.WIDTH,
        height: BSDropper.HEIGHT
      )
      
      /// 검색 텍스트 필드는 HomeController의 델리게이트로 받음.
      dropper.tfSearch.delegate = self
      
      /// 기타 나머지 UI 유저 인풋들은 클로져로 한번에 처리한다.
      dropper.closureBtTopicSelect = { [weak self] topicTitle in
        guard let `self` = self else { GUARD_PRETTY_FUNCTION(); return }
        
        print("'\(topicTitle)' clicked.")
        
        dropper.show() { [unowned self] in
//          self.showTransition(targetView: self.postTopicSelectFloatView) {
//            // 여기서 필요시 추가 마무리 작업을 수행한다.
//
//            // 주제 선택 화면이 떠 있을때 백그라운드 화면 아무데나 클릭하면 주제선택창이 사라져야 한다. 이를 위한 Recognizer 부착
//            self.dropDownView.addGestureRecognizer(self.dropDownViewTapGestureRecognizer)
//            self.tvPost.addGestureRecognizer(self.tvPostTapGestureRecognizer2)
//          }
        }
      }
      
      dropper.closureBtAlarm = { [weak self] in
        guard let `self` = self else { GUARD_PRETTY_FUNCTION(); return }
        print("'Alarm clicked.")
        
        self.hidesBottomBarWhenPushed = true
        self.push(to: SampleViewController.instantiate(from: .Main))
        self.hidesBottomBarWhenPushed = false
      }
      
      dropper.closureBtMyPage = { [weak self] in
        guard let `self` = self else { GUARD_PRETTY_FUNCTION(); return }
        print("'MyPage clicked.")
        
        self.hidesBottomBarWhenPushed = true
        self.push(to: SampleViewController.instantiate(from: .Main))
        self.hidesBottomBarWhenPushed = false
      }
      
      dropper.closureBtFilterPost = { [weak self] in
        guard let `self` = self else { GUARD_PRETTY_FUNCTION(); return }
        print("'Filter clicked.")
        
        DispatchQueue.main.async {
          self.view.endEditing(true)
          // self.postFilterContainerInstantiate().show(animated: true)
        }
      }
      
      return dropper
    }
    
    return BSDropper()
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
      
      /**
       * To control inset for proper inset.
       */
      tvPost.contentInset = dropper.adjustedContentInset
    }
  }
  
  // MARK: - Instance Variables Methods -
  private var isDidLayoutFinish: Bool = false
  
  // MARK: - ViewController LifeCycle Delegate Methods -
  override func viewDidLoad() {
    super.viewDidLoad()

    /**
     * add the dropper on top to get ready
     */
    self.view.addSubview(self.dropper)
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
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if isDidLayoutFinish {
      /**
       * observe scrollView
       */
      dropper.observe(scrollView)
    }
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    /**
     * checking offSet
     */
    dropper.check(offsetY: scrollView.contentOffset.y)
    
//    if self.postTopicSelectFloatView.alpha != 0.0 {
//      self.hideTransitionView(targetView: self.postTopicSelectFloatView) { /**/ }
//    }
  }
}

// MARK: - UITextFieldDelegate Methods -
extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField.isFirstResponder {
      textField.resignFirstResponder()
    }
    
    /// 키보드상 검색 버튼 클릭시
    if textField.returnKeyType == .search {
      let targetVC = SampleViewController.instantiate(from: .Main)
      let navVC = UINavigationController(rootViewController: targetVC)
      navVC.setNavigationBarHidden(true, animated: false)
      self.present(navVC, animated: true, completion: nil)
    }
    
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    /// 검색 시작
    
//    self.hideTransitionView(targetView: self.searchRecommendKeywordView) {
//      // 여기서 필요시 추가 마무리 작업을 수행한다.
//    }
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
//    self.showTransition(targetView: self.searchRecommendKeywordView) {
//      // 여기서 필요시 추가 마무리 작업을 수행한다.
//
//      // 주제 선택 화면이 떠 있을때 백그라운드 화면 아무데나 클릭하면 주제선택창이 사라져야 한다. 이를 위한 Recognizer 부착
//      self.dropDownView.addGestureRecognizer(self.dropDownViewTapGestureRecognizer)
//      self.tvPost.addGestureRecognizer(self.tvPostTapGestureRecognizer2)
//    }
  }
}
