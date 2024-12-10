//
//  TodoDetailViewController.swift
//  Appeneure
//
//  Created by Prashant Kumar Soni on 07/12/24.
//

import UIKit

class TodoDetailViewController: UIViewController {

    private let cntnrView = UIView()
    private let titleLabel = UILabel()
    private let messageText = UILabel()
    @objc var detailData = TodoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

}

extension TodoDetailViewController {
    private func setupUI(){
        setupCntnrView()
        addCntnrViewConstraints()
        
        setupTitleLabelView()
        addTitleLabelViewConstraints()
        
        setupMessageTextView()
        addMessageTextViewConstraints()
    }
}

extension TodoDetailViewController {
    private func setupCntnrView(){
        self.view.addSubview(cntnrView)
        self.cntnrView.backgroundColor = UIColor.white
    }
    
    private func addCntnrViewConstraints(){
        cntnrView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension TodoDetailViewController {
    private func setupTitleLabelView(){
        cntnrView.addSubview(titleLabel)
        titleLabel.layer.cornerRadius = 8.0
        titleLabel.text = "Title: " + (detailData.title ?? "")
        titleLabel.textColor = UIColor.black
    }
    
    private func addTitleLabelViewConstraints(){
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16.0)
            make.height.equalTo(50)
            make.top.equalToSuperview().inset(95.0)
        }
    }
}

extension TodoDetailViewController {
    private func setupMessageTextView(){
        cntnrView.addSubview(messageText)
        messageText.layer.cornerRadius = 8.0
        messageText.text = detailData.message
        messageText.textColor = UIColor.black
        messageText.numberOfLines = 0
    }
    
    private func addMessageTextViewConstraints(){
        messageText.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(20.0)
        }
    }
}
