//
//  PhotoCollectionViewCell.swift
//  Assessment
//
//  Created by Arvin Quiliza on 3/3/22.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "PhotoCollectionViewCell"
    
    private lazy var photoAuthorImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var photoAuthorLabel: UILabel = {
        let photoAuthorLabel = UILabel()
        photoAuthorLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        photoAuthorLabel.textColor = .white
        photoAuthorLabel.layer.shadowOpacity = 0.8
        photoAuthorLabel.layer.shadowRadius = 0.9
        photoAuthorLabel.layer.shadowColor = UIColor.darkGray.cgColor
        photoAuthorLabel.layer.shadowOffset = CGSize(width: 0, height: -0.5)
        photoAuthorLabel.layer.shadowPath = UIBezierPath(rect: photoAuthorLabel.bounds).cgPath
        photoAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        return photoAuthorLabel
    }()
    
    private lazy var photoImageView: TAImageView = {
        let photoImageView = TAImageView(frame: .zero)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        return photoImageView
    }()
    
    var photoCellViewModel: PhotoViewModel? {
        didSet { bindValues() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupView()
        setupConstraint()
    }
    
    private func setupView() {
        addSubview(photoAuthorImageContainer)
        photoAuthorImageContainer.addSubview(photoImageView)
        photoAuthorImageContainer.addSubview(photoAuthorLabel)
        
        // Doing a fade on image view when resource is still loading
        photoImageView.animateLoadView = { [weak self] in
            guard let self = self else { return }
            let isLoading = self.photoImageView.isLoading
            
            DispatchQueue.main.async {
                if isLoading {
                    UIView.animate(withDuration: Animation.duration) {
                        self.photoImageView.alpha = Alpha.weakFade
                    }
                } else {
                    UIView.animate(withDuration: Animation.duration) {
                        self.photoImageView.alpha = Alpha.solid
                    }
                }
            }
        }
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            photoAuthorImageContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoAuthorImageContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoAuthorImageContainer.topAnchor.constraint(equalTo: topAnchor),
            photoAuthorImageContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            photoImageView.leadingAnchor.constraint(equalTo: photoAuthorImageContainer.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: photoAuthorImageContainer.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: photoAuthorImageContainer.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: photoAuthorImageContainer.bottomAnchor),
            
            photoAuthorLabel.leadingAnchor.constraint(equalTo: photoAuthorImageContainer.leadingAnchor, constant: Space.padding),
            photoAuthorLabel.bottomAnchor.constraint(equalTo: photoAuthorImageContainer.bottomAnchor, constant: -Space.padding),
        ])
    }
    
    private func bindValues() {
        photoAuthorLabel.text = "\(Constant.attribution) \(photoCellViewModel?.author ?? "")"
        photoImageView.downloadImage(from: photoCellViewModel?.downloadUrl)
    }
}
