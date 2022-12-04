//
//  HomeViewController.swift
//  Logigram
//
//  Created by TT on 12/3/22.
//

import UIKit

protocol HomeViewControllerDelegate: ViewControllerDelegate {
    func presentWellcomeVC(_ sender: HomeViewController)
}

class HomeViewController: BaseViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    
    weak var delegate: HomeViewControllerDelegate?
    private lazy var signOutView: SignOutView = {
        let size = CGSize(width: 140, height: 50)
        let sourceViewOrigin = menuButton.frame.origin
        return SignOutView(frame: .init(origin: .init(x: sourceViewOrigin.x - 90, y: sourceViewOrigin.y + 10), size: size))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
    }
    
    override func willDeinit() {
        delegate?.viewControllerWillDeinit()
    }
    
    private func setupUI() {
        searchView.roundedView()
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onDismissSignOutView))
        self.view.addGestureRecognizer(tapGesture)
    }
}

//MARK: - Handle Actions
extension HomeViewController {
    @objc func onDismissSignOutView() {
        signOutView.removeFromSuperview()
    }
    
    @IBAction func onMenu(_ sender: UIButton) {
        signOutView.onSignOut = { [weak self] in
            guard let self = self else { return }
            self.delegate?.presentWellcomeVC(self)
        }
        self.view.addSubview(signOutView)
    }
}
