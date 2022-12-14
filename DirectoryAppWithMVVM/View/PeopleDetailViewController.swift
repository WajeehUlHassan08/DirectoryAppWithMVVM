//
//  PeopleDetailViewController.swift
//  DirectoryAppWithMVVM
//
//  Created by Wajeeh Ul Hassan on 11/10/2022.
//

import UIKit

class PeopleDetailViewController: UIViewController {
    var peopleList: Person?
    let peopleVM: PeopleViewModelType
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
        label.isAccessibilityElement = true
        label.accessibilityHint = "Person name"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    lazy var emailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.accessibilityHint = "Person email"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    lazy var jobTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.accessibilityHint = "Job title"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    lazy var favouriteColorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.accessibilityHint = "Favourite color"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    init(vm: PeopleViewModelType, index: IndexPath) {
        self.peopleVM = vm
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        nameLabel.text = "\(vm.getPersonName(for: index.row) ?? "Person name")"
        nameLabel.accessibilityValue = "\(peopleVM.getPersonName(for: index.row) ?? "")"  // For accessibility
        emailLabel.text = "Email: \(vm.getPersonEmail(for: index.row) ?? "Person email")"
        emailLabel.accessibilityValue = "\(peopleVM.getPersonEmail(for: index.row) ?? "")"   // For accessibility
        jobTitle.text = "Designation: \(vm.getPersonDesignation(for: index.row) ?? "Person designation")"
        jobTitle.accessibilityValue = "\(peopleVM.getPersonDesignation(for: index.row) ?? "")"   // For accessibility
        favouriteColorLabel.text = "Favourite Color: \(vm.getPersonFavColor(for: index.row) ?? "Person favourite color")"
        favouriteColorLabel.accessibilityValue = "\(peopleVM.getPersonFavColor(for: index.row) ?? "")"   // For accessibility
        peopleVM.getPersonImage(for: index.row) { imageData in
            guard let imageData = imageData else { return }
            DispatchQueue.main.async {
                self.avatarImage.image = UIImage(data: imageData)
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    private func setUpUI() {
        view.addSubview(avatarImage)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(jobTitle)
        view.addSubview(favouriteColorLabel)
        avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        avatarImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        avatarImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        avatarImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 20).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo: nameLabel.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        emailLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        jobTitle.topAnchor.constraint(equalTo: emailLabel.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        jobTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        favouriteColorLabel.topAnchor.constraint(equalTo: jobTitle.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        favouriteColorLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
}
