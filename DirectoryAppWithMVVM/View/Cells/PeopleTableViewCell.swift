//
//  PeopleTableViewCell.swift
//  DirectoryAppWithMVVM
//
//  Created by Wajeeh Ul Hassan on 11/10/2022.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {
    static let reuseId = "\(PeopleTableViewCell.self)"
    var peopleListCell: Person?
    lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.isAccessibilityElement = true
        label.accessibilityHint = "Person Name"
        return label
    }()
    lazy var emailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.isAccessibilityElement = true
        label.accessibilityHint = "Person Email"
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpUI() {
        self.contentView.addSubview(self.avatarImage)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.emailLabel)
        avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        avatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        avatarImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 8).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        self.emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        self.emailLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 8).isActive = true
        self.emailLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
    }
    public func configure(peopleVM: PeopleViewModelType, index: IndexPath) {
        nameLabel.text = "\(peopleVM.getPersonName(for: index.row) ?? "Person Name")"
        nameLabel.accessibilityValue = "\(peopleVM.getPersonName(for: index.row) ?? "Person name")"  // For accessibility
        emailLabel.text = "\(peopleVM.getPersonEmail(for: index.row) ?? "Person Email")"
        emailLabel.accessibilityValue = "\(peopleVM.getPersonEmail(for: index.row) ?? "Person email")"  // For accessibility
        peopleVM.getPersonImage(for: index.row) { imageData in
            guard let imageData = imageData else { return }
            DispatchQueue.main.async {
                self.avatarImage.image = UIImage(data: imageData)
            }
        }
    }
}
