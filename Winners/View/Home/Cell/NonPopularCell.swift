//
//  NonPopularCell.swift
//  Winners
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import UIKit
import SnapKit

final class NonPopularCell: UICollectionViewCell, IReusableView {

    private var image = UIImageView()
    private var button = GradientButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        self.image.layer.masksToBounds = true
        self.image.layer.cornerRadius = 14
        self.image.contentMode = .scaleAspectFill

        self.addSubview(image)
        self.addSubview(button)
    }

    private func setupConstraints() {
        image.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview().inset(56)
        }

        button.snp.makeConstraints { view in
            view.top.equalTo(image.snp.bottom).offset(10)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }
    }

    public func setup(image: String) {
        self.image.image = UIImage(named: image)
    }
}
