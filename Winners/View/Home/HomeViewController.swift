//
//  HomeViewController.swift
//  Winners
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import UIKit
import WinnersViewModel
import SnapKit
import StoreKit

class HomeViewController: BaseViewController {

    var viewModel: ViewModel?

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    var popularCollectionView: UICollectionView!
    var timer: Timer?
    var currentIndex = 0

    var firstHorizontal: UICollectionView!
    var secondHorizontal: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
        startAutoScroll()
    }

    deinit {
        timer?.invalidate()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#151515")

        scrollView.contentInsetAdjustmentBehavior = .never
        self.navigationController?.hidesBarsOnSwipe = true

        //MARK: Popular
        let mylayout = UICollectionViewFlowLayout()
        mylayout.itemSize = sizeForItem()
        mylayout.scrollDirection = .horizontal
        mylayout.minimumLineSpacing = 0
        mylayout.minimumInteritemSpacing = 0

        popularCollectionView = UICollectionView(frame: .zero, collectionViewLayout: mylayout)
        popularCollectionView.showsHorizontalScrollIndicator = false
        popularCollectionView.backgroundColor = .clear

        popularCollectionView.register(PopularCell.self)
        popularCollectionView.backgroundColor = .clear
        popularCollectionView.isScrollEnabled = false

        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self

        //MARK: FirstHorizontal
        let fHlayout = UICollectionViewFlowLayout()
        fHlayout.itemSize = CGSize(width: 168, height: 331)
        fHlayout.scrollDirection = .horizontal
        fHlayout.minimumLineSpacing = 13
        fHlayout.minimumInteritemSpacing = 13

        firstHorizontal = UICollectionView(frame: .zero, collectionViewLayout: fHlayout)
        firstHorizontal.showsHorizontalScrollIndicator = false
        firstHorizontal.backgroundColor = .clear

        firstHorizontal.register(NonPopularCell.self)
        firstHorizontal.backgroundColor = .clear

        firstHorizontal.delegate = self
        firstHorizontal.dataSource = self

        //MARK: SecondHorizontal
        let sHlayout = UICollectionViewFlowLayout()
        sHlayout.itemSize = CGSize(width: 168, height: 331)
        sHlayout.scrollDirection = .horizontal
        sHlayout.minimumLineSpacing = 13
        sHlayout.minimumInteritemSpacing = 13

        secondHorizontal = UICollectionView(frame: .zero, collectionViewLayout: sHlayout)
        secondHorizontal.showsHorizontalScrollIndicator = false
        secondHorizontal.backgroundColor = .clear

        secondHorizontal.register(NonPopularCell.self)
        secondHorizontal.backgroundColor = .clear

        secondHorizontal.delegate = self
        secondHorizontal.dataSource = self

        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear

        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.contentView.addSubview(popularCollectionView)
        self.contentView.addSubview(firstHorizontal)
        self.contentView.addSubview(secondHorizontal)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        viewModel?.loadItems()
        popularCollectionView.reloadData()
        firstHorizontal.reloadData()
        secondHorizontal.reloadData()
    }

    func sizeForItem() -> CGSize {
        let deviceType = UIDevice.currentDeviceType

        switch deviceType {
        case .iPhone:
            let width = self.view.frame.size.width
            let heightt = self.view.frame.size.height - 361
            return CGSize(width: width, height: heightt)
        case .iPad:
            let scaleFactor: CGFloat = 1.5
            let width = 550 * scaleFactor
            let height = 1100 * scaleFactor
            return CGSize(width: width, height: height)
        }
    }

    func setupConstraints() {
        scrollView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.trailing.equalToSuperview()
            view.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }

        contentView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
            view.width.equalToSuperview()
        }

        popularCollectionView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.trailing.equalToSuperview()
            view.height.equalTo(sizeForItem().height)
        }

        firstHorizontal.snp.makeConstraints { view in
            view.top.equalTo(popularCollectionView.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview()
            view.height.equalTo(337)
        }

        secondHorizontal.snp.makeConstraints { view in
            view.top.equalTo(firstHorizontal.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview()
            view.height.equalTo(337)
            view.bottom.equalToSuperview().offset(-20)
        }
    }

}

//MARK: Make buttons actions
extension HomeViewController {
    
    private func makeButtonsAction() {
    }

    private func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }

    @objc private func scrollToNextItem() {
        guard let itemCount = viewModel?.popularItems.count, itemCount > 0 else { return }

        currentIndex = (currentIndex + 1) % itemCount
        let indexPath = IndexPath(item: currentIndex, section: 0)

        popularCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }

}

extension HomeViewController: IViewModelableController {
    typealias ViewModel = IHomeViewModel
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popularCollectionView {
            return self.viewModel?.popularItems.count ?? 0
        } else if collectionView == firstHorizontal {
            return self.viewModel?.firstHorizontalItems.count ?? 0
        } else if collectionView == secondHorizontal {
            return self.viewModel?.secondHorizontalItems.count ?? 0
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == popularCollectionView {
            let cell: PopularCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(image: viewModel?.popularItems[indexPath.row].image ?? "")
            return cell
        } else if collectionView == firstHorizontal {
            let cell: NonPopularCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(image: viewModel?.firstHorizontalItems[indexPath.row].image ?? "")
            return cell
        } else {
            let cell: NonPopularCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(image: viewModel?.secondHorizontalItems[indexPath.row].image ?? "")
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == popularCollectionView {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        } else {
            return CGSize(width: 168, height: 331)
        }
    }
}

//MARK: Preview
import SwiftUI

struct HomeViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let homeViewController = HomeViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<HomeViewControllerProvider.ContainerView>) -> HomeViewController {
            return homeViewController
        }

        func updateUIViewController(_ uiViewController: HomeViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<HomeViewControllerProvider.ContainerView>) {
        }
    }
}
