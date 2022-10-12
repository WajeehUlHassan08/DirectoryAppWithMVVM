//
//  RoomsViewController.swift
//  DirectoryAppWithMVVM
//
//  Created by Wajeeh Ul Hassan on 11/10/2022.
//

import UIKit

class RoomsViewController: UIViewController {
    private var roomList: [Room] = [Room]()
    lazy var roomsTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(RoomTableViewCell.self, forCellReuseIdentifier: RoomTableViewCell.reuseId)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    let roomVM: RoomsViewModelType
    init(vm: RoomsViewModelType) {
        self.roomVM = vm
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        title = "Rooms".localized()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        setUpUI()
        self.roomVM.bind {
            DispatchQueue.main.async {
                self.roomsTableView.reloadData()
            }
        }
        self.roomVM.getRooms()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roomsTableView.frame = view.bounds
    }
    private func setUpUI() {
        view.addSubview(roomsTableView)
    }
}
extension RoomsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.roomVM.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCell.reuseId, for: indexPath) as? RoomTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(roomVM: self.roomVM, index: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
