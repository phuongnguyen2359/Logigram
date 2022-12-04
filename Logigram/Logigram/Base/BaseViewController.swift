//
//  BaseViewController.swift
//  Logigram
//
//  Created by TT on 12/3/22.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

    var disposeBag = DisposeBag()
    private weak var previousParent: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if previousParent != nil && parent == nil {
            willDeinit()
        }
        previousParent = parent
    }
    
    func willDeinit() {
        preconditionFailure("You should implement this function in your class to detach coordinator.")
    }
    
    deinit {}
}
