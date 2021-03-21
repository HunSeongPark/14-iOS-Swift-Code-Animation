//
//  ViewController.swift
//  code_animation
//
//  Created by 박훈성 on 2021/03/21.
//

import UIKit

class ViewController: UIViewController {
  
  var someViewBottomConstraint : NSLayoutConstraint?
  
  override func loadView() {
    super.loadView()
    print("ViewController - loadView() called")
    
    view.backgroundColor = UIColor(named: "MY_GREEN")
    
    let someView = UIView()
    someView.backgroundColor = UIColor(named: "MY_BLUE")
    someView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(someView)
    
    someView.layer.cornerRadius = 8
    NSLayoutConstraint.activate([
      someView.widthAnchor.constraint(equalToConstant: 100),
      someView.heightAnchor.constraint(equalToConstant: 50),
      someView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    
    someViewBottomConstraint = NSLayoutConstraint(item: someView, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0)
    
    someViewBottomConstraint?.isActive = true
    
    let moveViewUpBtn = UIButton(type: .system)
    moveViewUpBtn.translatesAutoresizingMaskIntoConstraints = false
    moveViewUpBtn.backgroundColor = .white
    moveViewUpBtn.setTitle("네모를 올리자", for: .normal)
    moveViewUpBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    moveViewUpBtn.tintColor = .black
    moveViewUpBtn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    moveViewUpBtn.layer.cornerRadius = 8
    moveViewUpBtn.addTarget(self, action: #selector(moveViewUp), for: .touchUpInside)
    self.view.addSubview(moveViewUpBtn)
    moveViewUpBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    moveViewUpBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 150).isActive = true
  }
  
  @objc fileprivate func moveViewUp() {
    print("ViewController - moveViewUp() called")
    someViewBottomConstraint?.constant -= 50
    UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
      self.view.layoutIfNeeded()
    }).startAnimation()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    print("ViewController - viewDidLoad() called")
    // Do any additional setup after loading the view.
  }


}

//MARK: - Preview Line

//전처리기 (컴파일 되기 전에 처리되는 프로그램, 디버깅을 위해)
#if DEBUG

import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
  
  //update
  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
  }
  
  //makeUI
  @available(iOS 13.0,*)
  func makeUIViewController(context: Context) -> UIViewController {
    ViewController()
    
  }
}

struct ViewController_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ViewControllerRepresentable()
        .previewDisplayName("ViewController")
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
  }
  
}

#endif
