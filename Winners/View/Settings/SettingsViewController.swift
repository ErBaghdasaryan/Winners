//
//  SettingsViewController.swift
//  Winners
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import UIKit
import WinnersViewModel
import SnapKit
import StoreKit

class SettingsViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let background = UIImageView(image: UIImage(named: "settingsBG"))
    private let header =  UILabel(text: "Project Description",
                                  textColor: UIColor(hex: "#999999")!,
                                  font: UIFont(name: "SFProText-Regular", size: 16))
    private let text =  UILabel(text: "",
                                textColor: UIColor.white,
                                font: UIFont(name: "SFProText-Regular", size: 16))
    private let terms = SettingsButton()
    private let privacy = SettingsButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#151515")
        self.title = "Settings"

        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        self.header.textAlignment = .left
        self.text.textAlignment = .left
        self.text.numberOfLines = 0
        self.text.lineBreakMode = .byWordWrapping

        self.text.text = """
        Discover an endless gallery of stunning desktop wallpapers designed specifically for your phone. Whether you're looking to inspire creativity, boost productivity, or simply add a personal touch."Wallpapers" has everything you need to transform your device into a canvas of beauty. From serene landscapes to futuristic concepts, find the perfect backdrop to match your mood or style. Simplify your customization journey with "Wallpapers" and let your creativity shine!
        """

        self.terms.setTitle("Terms & Conditions", for: .normal)
        self.privacy.setTitle("Privacy Policy", for: .normal)

        self.background.frame = self.view.bounds

        self.view.addSubview(background)
        self.view.addSubview(header)
        self.view.addSubview(text)
        self.view.addSubview(terms)
        self.view.addSubview(privacy)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(122)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(21)
        }

        text.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
        }

        terms.snp.makeConstraints { view in
            view.top.equalTo(text.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }

        privacy.snp.makeConstraints { view in
            view.top.equalTo(terms.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }
    }

}

//MARK: Make buttons actions
extension SettingsViewController {
    
    private func makeButtonsAction() {
        self.terms.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
        self.privacy.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
    }

    @objc func termsTapped() {
        guard let navigationController = self.navigationController else { return }

        SettingsRouter.showTermsViewController(in: navigationController)
    }

    @objc func privacyTapped() {
        guard let navigationController = self.navigationController else { return }

        SettingsRouter.showPrivacyViewController(in: navigationController)
    }

}

extension SettingsViewController: IViewModelableController {
    typealias ViewModel = ISettingsViewModel
}

//MARK: Preview
import SwiftUI

struct SettingsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let settingsViewController = SettingsViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) -> SettingsViewController {
            return settingsViewController
        }

        func updateUIViewController(_ uiViewController: SettingsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) {
        }
    }
}
