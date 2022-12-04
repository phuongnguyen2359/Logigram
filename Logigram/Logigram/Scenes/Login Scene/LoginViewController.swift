//
//  LoginViewController.swift
//  Logigram
//
//  Created by TT on 12/2/22.
//

import UIKit

protocol LoginViewControllerDelegate: ViewControllerDelegate {
    func presentHomeVC(_ sender: LoginViewController)
}

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: LogigramSecureTextField!
    
    weak var delegate: LoginViewControllerDelegate?
    var viewModel: LoginViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
        bindViewModel()
    }
    
    override func willDeinit() {
        delegate?.viewControllerWillDeinit()
    }
    
    private func setupUI() {
        emailTextField.becomeFirstResponder()
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onDismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func bindViewModel() {
        viewModel.loginStateRelay.subscribe(onNext: { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .completed:
                self.delegate?.presentHomeVC(self)
            case let .loginError(error):
                self.showErrorMsg(error)
            case .idle, .loading:
                break
            }
        }).disposed(by: disposeBag)
    }
}

//MARK: - Handle Actions
extension LoginViewController {
    @IBAction func onSignIn() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        guard checkInputsValid(email: email, password: password) else { return }
        viewModel.signIn(email: email, password: password)
    }
    
    @IBAction func onBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Convenient methods
extension LoginViewController {
    @objc func onDismissKeyboard() {
        view.endEditing(true)
    }
    
    /// Check Email-Password valid
    /// - Parameters:
    ///   - email: String
    ///   - password: String
    /// - Returns: Bool
    private func checkInputsValid(email: String, password: String) -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    /// Show SignIn error message
    /// - Parameter error: LoginError
    private func showErrorMsg(_ error: LoginError) {
        let alertVC = UIAlertController(title: "SignIn Error!", message: error.errorMsg, preferredStyle: .alert)
        alertVC.modalPresentationStyle = .currentContext
        alertVC.addAction(UIAlertAction(title: "Ok!", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
