//
//  RoomsViewModel.swift
//  DirectoryAppWithMVVM
//
//  Created by Wajeeh Ul Hassan on 12/10/2022.
//

import Foundation

protocol RoomsViewModelCore {
    func bind(updateHandler: @escaping () -> Void)
    func getRooms()
}
protocol RoomsViewModelAttributes {
    var count: Int { get }
    func isRoomOccupied(for index: Int) -> Bool?
    func maxOccupancy(for index: Int) -> Int?
    func getRoomId(for index: Int) -> String?
}
typealias RoomsViewModelType = RoomsViewModelCore & RoomsViewModelAttributes
class RoomViewModel {
    private var roomsList: [Room] = [] {
        didSet {
            self.updateHandler?()
        }
    }
    private var networkManager: NetworkService
    private var pageCount = 1
    private var updateHandler: (() -> Void)?
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
}
extension RoomViewModel: RoomsViewModelCore {
    func bind(updateHandler: @escaping () -> Void) {
        self.updateHandler = updateHandler
    }
    func getRooms() {
        guard let url = URL(string: "\(Constants.baseURL)/rooms") else { return }
        self.networkManager.getModel(url: url) { (result: Result<[Room], NetworkError>) in
            switch result {
            case .success(let page):
                self.pageCount += 1
                print("Test: 4")
                self.roomsList.append(contentsOf: page)
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension RoomViewModel: RoomsViewModelAttributes {
    var count: Int {
        return self.roomsList.count
    }
    func isRoomOccupied(for index: Int) -> Bool? {
        guard index < self.count else { return nil }
        return self.roomsList[index].isOccupied
    }
    func maxOccupancy(for index: Int) -> Int? {
        guard index < self.count else { return nil }
        return self.roomsList[index].maxOccupancy
    }
    func getRoomId(for index: Int) -> String? {
        guard index < self.count else { return nil }
        return self.roomsList[index].id
    }
}
