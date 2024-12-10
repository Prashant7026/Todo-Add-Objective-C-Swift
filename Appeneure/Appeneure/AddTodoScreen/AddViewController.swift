//
//  AddViewController.swift
//  Appeneure
//
//  Created by Prashant Kumar Soni on 07/12/24.
//

import UIKit
import SnapKit

class AddViewController: UIViewController {
    
    private let cntnrView = UIView()
    private let titleTF = UITextField()
    private let messageView = UITextView()
    private let saveBtn = UIButton()
    private let placeholderLabel = UILabel()
    var todoData = TodoModel()
    @objc weak var delegate: AppeneureProtocols?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

}

extension AddViewController{
    private func setupUI(){
        setupCntnrView()
        addCntnrViewConstraints()
        
        setupTitleTFView()
        addTitleTFViewConstraints()
        
        setupMessageView()
        addMessageViewConstraints()
        setupPlaceholder()
        
        setupSaveBtnView()
        addSaveBtnViewConstraints()
    }
}

extension AddViewController{
    private func setupCntnrView(){
        self.view.addSubview(cntnrView)
        cntnrView.backgroundColor = UIColor.white
    }
    
    private func addCntnrViewConstraints(){
        cntnrView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

extension AddViewController{
    private func setupTitleTFView(){
        cntnrView.addSubview(titleTF)
        titleTF.isUserInteractionEnabled = true
        titleTF.layer.borderWidth = 2.0
        titleTF.layer.cornerRadius = 8.0
        titleTF.attributedPlaceholder = NSAttributedString(string: "Enter Title Here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        titleTF.leftView = paddingView
        titleTF.leftViewMode = .always
        titleTF.textColor = UIColor.black
        titleTF.delegate = self
    }
    
    private func addTitleTFViewConstraints(){
        titleTF.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16.0)
            make.height.equalTo(50)
            make.top.equalToSuperview().inset(95.0)
        }
    }
}

extension AddViewController: UITextViewDelegate {
    private func setupMessageView(){
        cntnrView.addSubview(messageView)
        messageView.backgroundColor = UIColor.white
        messageView.delegate = self
        messageView.layer.borderWidth = 2.0
        messageView.layer.cornerRadius = 8.0
        messageView.textColor = UIColor.black
        messageView.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func addMessageViewConstraints(){
        messageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16.0)
            make.top.equalTo(titleTF.snp.bottom).inset(-20.0)
            make.height.equalTo(200.0)
        }
    }
    
    private func setupPlaceholder() {
        placeholderLabel.text = "Enter your Detail Todo here..."
        placeholderLabel.font = UIFont.systemFont(ofSize: 16)
        placeholderLabel.textColor = .gray
        placeholderLabel.numberOfLines = 0
        placeholderLabel.isUserInteractionEnabled = false
        messageView.addSubview(placeholderLabel)
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(messageView.textContainerInset.top)
            make.left.equalTo(messageView.textContainerInset.left + 5)
        }
        
        togglePlaceholderVisibility()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        togglePlaceholderVisibility()
    }
    
    private func togglePlaceholderVisibility() {
        placeholderLabel.isHidden = messageView.text.count > 0
    }
}

extension AddViewController{
    private func setupSaveBtnView(){
        cntnrView.addSubview(saveBtn)
        saveBtn.setTitle("Add Todo", for: .normal)
        saveBtn.backgroundColor = UIColor.blue
        saveBtn.layer.cornerRadius = 8.0
        saveBtn.addTarget(self, action: #selector(saveBtnTapped), for: .touchUpInside)
    }
    
    private func addSaveBtnViewConstraints(){
        saveBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(messageView.snp.bottom).offset(85.0)
            make.height.equalTo(50.0)
            make.width.equalTo(100.0)
        }
    }
    
    @objc func saveBtnTapped(){
        if titleTF.text?.count ?? 0 >= 1{
            self.todoData.title = titleTF.text
            self.todoData.message = messageView.text
            self.delegate?.AddTodo(self.todoData)
            self.dismissController()
        } else {
            self.showToast(message: "Please Enter Title", font: UIFont.systemFont(ofSize: 12.0))
        }
    }
}

extension AddViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension AddViewController {
    private func dismissController(){
        self.navigationController?.popViewController(animated: true)
    }
}
