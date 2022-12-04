//
//  LogigramSecureTextField.swift
//  Logigram
//
//  Created by TT on 12/3/22.
//

import UIKit

class LogigramSecureTextField: UITextField {

    let rightButton  = UIButton(type: .custom)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        rightButton.setImage(R.image.password_show(), for: .normal)
        rightButton.addTarget(self, action: #selector(onToggle), for: .touchUpInside)
        rightButton.frame = CGRect(x:8, y:8, width:16, height:16)

        rightViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        rightView?.addSubview(rightButton)
        isSecureTextEntry = true
    }

    @objc func onToggle() {
        toggle()
    }

    private func toggle() {
        isSecureTextEntry.toggle()
        let icon = isSecureTextEntry ? R.image.password_show() : R.image.password_hide()
        rightButton.setImage(icon, for: .normal)
    }
}
