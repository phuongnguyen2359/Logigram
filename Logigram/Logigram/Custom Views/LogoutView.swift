//
//  LogoutView.swift
//  Logigram
//
//  Created by TT on 12/3/22.
//

import UIKit

final class SignOutView: UIView {
    var onSignOut: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
        return button
    }()
    
    func setupUI() {
        layer.cornerRadius = 3
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 6
    }
    
    private func setupLayout() {
        
        addSubview(signOutButton)
        NSLayoutConstraint.activate([
            signOutButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            signOutButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            signOutButton.widthAnchor.constraint(equalToConstant: 80),
            signOutButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func handleSignOut() {
        onSignOut?()
    }
}
