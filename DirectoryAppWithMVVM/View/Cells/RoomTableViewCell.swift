//
//  RoomTableViewCell.swift
//  DirectoryAppWithMVVM
//
//  Created by Wajeeh Ul Hassan on 11/10/2022.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    static let reuseId = "\(RoomTableViewCell.self)"
    var roomsList: Room?
    lazy var roomNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.font = UIFont.systemFont(ofSize: 25)
        label.accessibilityHint = "Room Number"
        return label
    }()
    lazy var isOcupiedLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.accessibilityHint = "is Room Occupied or Not"
        return label
    }()
    lazy var maxOccupancyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.accessibilityHint = "Max Room Occupancy"
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
        contentView.addSubview(roomNumberLabel)
        contentView.addSubview(isOcupiedLabel)
        contentView.addSubview(maxOccupancyLabel)
        roomNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        roomNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        roomNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        isOcupiedLabel.topAnchor.constraint(equalTo: roomNumberLabel.bottomAnchor, constant: 8).isActive = true
        isOcupiedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        isOcupiedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        maxOccupancyLabel.topAnchor.constraint(equalTo: isOcupiedLabel.bottomAnchor, constant: 8).isActive = true
        maxOccupancyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        maxOccupancyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
    }
    public func configure(roomVM: RoomsViewModelType, index: IndexPath) {
        roomNumberLabel.text = "Room No#".localized() + "\(roomVM.getRoomId(for: index.row) ?? "Room #")"
        roomNumberLabel.accessibilityValue = "\(roomVM.getRoomId(for: index.row) ?? "Room Number")"  // For accessibility
        isOcupiedLabel.text = "\(roomVM.isRoomOccupied(for: index.row) == true ? "Occupied" : "Vaccant")"
        isOcupiedLabel.accessibilityValue = "\(roomVM.isRoomOccupied(for: index.row) == true ? "Occupied" : "Vaccant")"   // For accessibility
        self.maxOccupancyLabel.text = "Max Occupancy: \(roomVM.maxOccupancy(for: index.row) ?? 4)"
        self.maxOccupancyLabel.accessibilityValue = "\(roomVM.maxOccupancy(for: index.row) ?? 4)"   // For accessibility
        if roomVM.isRoomOccupied(for: index.row) == true {
            self.isOcupiedLabel.textColor = .systemRed
        } else {
            self.isOcupiedLabel.textColor = .systemGreen
        }
    }
}
