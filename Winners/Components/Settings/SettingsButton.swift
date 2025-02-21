//
//  SettingsButton.swift
//  Winners
//
//  Created by Er Baghdasaryan on 21.02.25.
//

import UIKit
import SnapKit

class SettingsButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 16)
        self.contentHorizontalAlignment = .left
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        self.layer.cornerRadius = 13
        self.layer.masksToBounds = true

        let arrowImage = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowImage.tintColor = .white
        self.addSubview(arrowImage)

        arrowImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(18.75)
            make.centerY.equalToSuperview()
            make.width.equalTo(9)
            make.height.equalTo(16.5)
        }
    }
}
