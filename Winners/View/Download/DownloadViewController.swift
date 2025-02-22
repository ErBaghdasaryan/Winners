//
//  DownloadViewController.swift
//  Winners
//
//  Created by Er Baghdasaryan on 20.02.25.
//

import UIKit
import WinnersViewModel
import SnapKit
import Photos
import Toast

class DownloadViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let downloadButton = GradientButton()
    private let image = UIImageView()
    private var style = ToastStyle()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let name = self.viewModel?.imageName else { return }
        self.image.image = UIImage(named: name)
    }

    override func setupUI() {
        super.setupUI()

        self.title = "Download"

        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        self.downloadButton.setTitle("Download", for: .normal)
        self.downloadButton.setTitleColor(.black, for: .normal)
        self.downloadButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 15)
        self.downloadButton.backgroundColor = UIColor(hex: "#0084FF")
        self.downloadButton.layer.masksToBounds = true
        self.downloadButton.layer.cornerRadius = 12

        self.image.layer.masksToBounds = true
        self.image.layer.cornerRadius = 30
        self.image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.image.frame = self.view.bounds

        self.style.backgroundColor = UIColor.white
        self.style.messageColor = UIColor.black

        self.view.addSubview(image)
        self.view.addSubview(downloadButton)
        setupConstraints()
        setupNavigationItems()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {
        downloadButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(50)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }
    }
}


extension DownloadViewController: IViewModelableController {
    typealias ViewModel = IDownloadViewModel
}

//MARK: Make buttons actions
extension DownloadViewController {
    
    private func makeButtonsAction() {
        self.downloadButton.addTarget(self, action: #selector(downloadImage), for: .touchUpInside)
    }

    @objc func downloadImage() {
        guard let imageToSave = image.image else {
            self.view.makeToast("You do not have a selected image to upload.", duration: 2.0, position: .bottom, style: style)
            return
        }

        PHPhotoLibrary.requestAuthorization { [self] status in
            if status == .authorized {
                UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(self.imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)
            } else {
                self.view.makeToast("There is no permission to save the image.", duration: 2.0, position: .bottom, style: style)
            }
        }
    }

    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.view.makeToast("Saving error.", duration: 2.0, position: .bottom, style: style)
        } else {

            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Success", message: "Image has been saved to your gallery.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }

            guard let name = self.viewModel?.imageName else { return }
            self.viewModel?.addImage(.init(name: name))
        }
    }

    private func setupNavigationItems() {

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "customBack"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftBarButton
        self.navigationController?.navigationBar.tintColor = .white

        let shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: shareButton)
        navigationItem.rightBarButtonItem = rightBarButton
        self.navigationController?.navigationBar.tintColor = .white
    }

    @objc func backButtonTapped() {
        guard let navigationController = self.navigationController else { return }
        HomeRouter.popViewController(in: navigationController)
    }

    @objc func shareTapped() {
        guard let name = self.viewModel?.imageName else { return }
        guard let image = UIImage(named: name) else {
            print("Image not found")
            return
        }

        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)

        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }

        self.present(activityViewController, animated: true, completion: nil)
    }
}

//MARK: Preview
import SwiftUI

struct DownloadViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let downloadViewController = DownloadViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<DownloadViewControllerProvider.ContainerView>) -> DownloadViewController {
            return downloadViewController
        }

        func updateUIViewController(_ uiViewController: DownloadViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<DownloadViewControllerProvider.ContainerView>) {
        }
    }
}
