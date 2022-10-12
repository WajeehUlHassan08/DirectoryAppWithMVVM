//
//  PeopleViewController.swift
//  DirectoryAppWithMVVM
//
//  Created by Wajeeh Ul Hassan on 11/10/2022.
//

import UIKit

class PeopleViewController: UIViewController {
    private var peopleList: [Person] = [Person]()
    lazy var peopleTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(PeopleTableViewCell.self, forCellReuseIdentifier: PeopleTableViewCell.reuseId)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    let peopleVM: PeopleViewModelType
    init(vm: PeopleViewModelType) {
        self.peopleVM = vm
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "People".localized()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        setUpUI()
        self.peopleVM.bind {
            DispatchQueue.main.async {
                self.peopleTableView.reloadData()
            }
        }
        self.peopleVM.getPeople()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        peopleTableView.frame = view.bounds
    }
    private func setUpUI() {
        view.addSubview(peopleTableView)
    }
}
extension PeopleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peopleVM.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PeopleTableViewCell.reuseId, for: indexPath) as? PeopleTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(peopleVM: self.peopleVM, index: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = PeopleDetailViewController(vm: self.peopleVM, index: indexPath)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
