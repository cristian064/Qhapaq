//
//  LoginViewController.swift
//  Qhapaq
//
//  Created by cristian ayala on 5/01/22.
//

import UIKit

class LoginViewController: UIViewController {

    let appleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login Apple Id", for: .normal)
        button.addTarget(self, action: #selector(appleLoginButtonTapped), for: .touchUpInside)
        button.backgroundColor = .lightGray
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setupView()
        
    }
    
    func setupView() {
        self.view.addSubview(appleLoginButton)
        
        appleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        appleLoginButton.centerInSuperview()
        NSLayoutConstraint.activate([
            appleLoginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            appleLoginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50)
        ])
        
    }
    
    @objc func appleLoginButtonTapped() {
        print("tapped")
    }
    
}
