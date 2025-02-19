//
//  OnboardingViewController.swift
//  Winners
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import UIKit
import WinnersViewModel
import SnapKit
import StoreKit

class OnboardingViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?
    private let backgroundImage = UIImageView(image: UIImage(named: "onboarding"))
    private let header = UILabel(text: "Welcome to Wallpapers",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let subHeader = UILabel(text: "Simplify your customization journey with 'Wallpapers' and let your creativity shine!",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Regular", size: 16))

    private let nextButton = UIButton(type: .system)
    private let buttonDescription = UILabel(text: "By tapping the “Get Started” you agree to our Privacy Policy and Terms of Use",
                                            textColor: UIColor(hex: "#999999")!,
                                            font: UIFont(name: "SFProText-Regular", size: 12))

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyGradientToButton()
    }

    override func setupUI() {
        super.setupUI()

        self.subHeader.numberOfLines = 2
        self.subHeader.lineBreakMode = .byWordWrapping

        self.buttonDescription.numberOfLines = 2
        self.buttonDescription.lineBreakMode = .byWordWrapping

        self.backgroundImage.frame = self.view.bounds

        self.nextButton.setTitle("Get Started", for: .normal)
        self.nextButton.setTitleColor(.white, for: .normal)
        self.nextButton.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 16)
        self.nextButton.layer.masksToBounds = true
        self.nextButton.layer.cornerRadius = 14
        applyGradientToButton()

        self.view.addSubview(backgroundImage)
        self.view.addSubview(header)
        self.view.addSubview(subHeader)
        self.view.addSubview(nextButton)
        self.view.addSubview(buttonDescription)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        self.header.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(188)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(28)
        }

        self.subHeader.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(42)
        }

        self.nextButton.snp.makeConstraints { view in
            view.top.equalTo(subHeader.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }

        self.buttonDescription.snp.makeConstraints { view in
            view.top.equalTo(nextButton.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(72)
            view.trailing.equalToSuperview().inset(72)
            view.height.equalTo(30)
        }
    }

}

//MARK: Make buttons actions
extension OnboardingViewController {
    
    private func makeButtonsAction() {
        nextButton.addTarget(self, action: #selector(nextButtonTaped), for: .touchUpInside)
    }

    @objc func nextButtonTaped() {
        guard let navigationController = self.navigationController else { return }

        OnboardingRouter.showTabBarViewController(in: navigationController)
    }

    private func applyGradientToButton() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: "#709AFE")!.cgColor, UIColor(hex: "#8868F4")!.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = nextButton.bounds
        gradientLayer.cornerRadius = nextButton.layer.cornerRadius

        nextButton.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension OnboardingViewController: IViewModelableController {
    typealias ViewModel = IOnboardingViewModel
}

//MARK: Preview
import SwiftUI

struct OnboardingViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let onboardingViewController = OnboardingViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) -> OnboardingViewController {
            return onboardingViewController
        }

        func updateUIViewController(_ uiViewController: OnboardingViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) {
        }
    }
}
