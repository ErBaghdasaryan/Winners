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

    private let background = UIImageView(image: UIImage(named: "profileBG"))
    var viewModel: ViewModel?
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.loadRecentlies()
        self.collectionView.reloadData()
    }

    override func setupUI() {
        super.setupUI()

        self.title = "Recent downloads"

        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        //MARK: Screensavers CollectionView's setup
        let numberOfColumns: CGFloat = 2
        let spacing: CGFloat = 12
        let totalSpacing = ((numberOfColumns - 1) * spacing)
        let availableWidth = self.view.frame.width - totalSpacing
        let itemWidth = availableWidth / numberOfColumns

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: 281)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear

        collectionView.register(PopularCell.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true

        collectionView.delegate = self
        collectionView.dataSource = self

        self.view.backgroundColor = UIColor(hex: "#151515")

        self.background.frame = self.view.bounds

        self.view.addSubview(background)
        self.view.addSubview(collectionView)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(118)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }
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

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.recentlies.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PopularCell = collectionView.dequeueReusableCell(for: indexPath)

        cell.setup(image: viewModel?.recentlies[indexPath.row].name ?? "")

        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 14

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let spacing: CGFloat = 12
        let totalSpacing = ((numberOfColumns - 1) * spacing)
        let availableWidth = self.view.frame.width - totalSpacing - 32
        let itemWidth = availableWidth / numberOfColumns

        return CGSize(width: itemWidth, height: 281)
    }
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
