//
//  ProfileViewController.swift
//  Winners
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import UIKit
import WinnersViewModel
import SnapKit
import StoreKit

class ProfileViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .cyan


        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        
    }

}

//MARK: Make buttons actions
extension ProfileViewController {
    
    private func makeButtonsAction() {
    }

}

extension ProfileViewController: IViewModelableController {
    typealias ViewModel = IProfileViewModel
}

//MARK: Preview
import SwiftUI

struct ProfileViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let profileViewController = ProfileViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProfileViewControllerProvider.ContainerView>) -> ProfileViewController {
            return profileViewController
        }

        func updateUIViewController(_ uiViewController: ProfileViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProfileViewControllerProvider.ContainerView>) {
        }
    }
}
