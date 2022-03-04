//
//  PhotoFocusViewController.swift
//  Assessment
//
//  Created by Arvin Quiliza on 4/3/22.
//

import UIKit

class PhotoFocusViewController: UIViewController {

    var viewModelManager: ViewModelManager?
    var unsplashUrl: URL?
    var photoViewModel: PhotoViewModel? {
        didSet { bindValues() }
    }
    
    // properties
    private lazy var photoImageView: TAImageView = {
        let photoImageView = TAImageView(frame: .zero)
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        return photoImageView
    }()
    
    private lazy var photoAuthorLabel: UILabel = {
        let photoAuthorLabel = UILabel()
        photoAuthorLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        photoAuthorLabel.textColor = .label
        photoAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        return photoAuthorLabel
    }()
    
    private lazy var unsplashButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(Constant.redirect.underlined, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        button.addTarget(self, action: #selector(unsplashButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = doneButton
        
        view.addSubview(photoImageView)
        view.addSubview(photoAuthorLabel)
        view.addSubview(unsplashButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),

            photoAuthorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Space.padding),
            photoAuthorLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: Space.adjacent),
            
            unsplashButton.leadingAnchor.constraint(equalTo: photoAuthorLabel.leadingAnchor),
            unsplashButton.topAnchor.constraint(equalTo: photoAuthorLabel.bottomAnchor, constant: Space.adjacent),
        ])
    }
    
    private func bindValues() {
        photoAuthorLabel.text = "\(Constant.attribution) \(photoViewModel?.author ?? "")"
        photoImageView.downloadImage(from: photoViewModel?.downloadUrl)
        unsplashUrl = URL(string: photoViewModel?.url ?? Network.unsplashBaseUrl)
    }
    
    @objc
    private func dismissViewController() {
        dismiss(animated: true)
    }
    
    @objc
    private func unsplashButtonTapped() {
        guard let unsplashUrl = unsplashUrl else { return }
        presentSafariViewController(with: unsplashUrl)
    }
}
