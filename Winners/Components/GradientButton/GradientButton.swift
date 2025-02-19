//
//  GradientButton.swift
//  Winners
//
//  Created by Er Baghdasaryan on 19.02.25.
//

import UIKit

class GradientButton: UIButton {

    private let gradientLayer = CAGradientLayer()
    private let iconImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {

        gradientLayer.colors = [UIColor(hex: "#709AFE")!.cgColor, UIColor(hex: "#8868F4")!.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = 12
        layer.insertSublayer(gradientLayer, at: 0)

        setTitle("Download", for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        iconImageView.image = UIImage(systemName: "arrow.down.circle")
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        addSubview(iconImageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds

        let iconSize: CGFloat = 20
        let padding: CGFloat = 8
        iconImageView.frame = CGRect(x: bounds.midX - 50, y: bounds.midY - iconSize / 2, width: iconSize, height: iconSize)

        titleLabel?.frame = CGRect(x: bounds.midX - 20, y: 0, width: bounds.width / 2, height: bounds.height)
    }
}
