//
//  PeopleViewModel.swift
//  DirectoryAppWithMVVM
//
//  Created by Wajeeh Ul Hassan on 11/10/2022.
//

import Foundation

protocol PeopleViewModelCore {
    func bind(updateHandler: @escaping () -> Void)
    func getPeople()
}
protocol PeopleViewModelAttributes {
    var count: Int { get }
    func getPersonName(for index: Int) -> String?
    func getPersonEmail(for index: Int) -> String?
    func getPersonDesignation(for index: Int) -> String?
    func getPersonFavColor(for index: Int) -> String?
    func getPersonImage(for index: Int, completion: @escaping (Data?) -> Void)
}
typealias PeopleViewModelType = PeopleViewModelCore & PeopleViewModelAttributes
class PeopleViewModel {
    public var peopleList: [Person] = [] {
        didSet {
            self.updateHandler?()
        }
    }
    private var networkManager: NetworkService
    private var pageCount = 1
    private let cache: ImageCache
    private var updateHandler: (() -> Void)?
    init(networkManager: NetworkService, cache: ImageCache = ImageCache()) {
        self.networkManager = networkManager
        self.cache = cache
    }
}
extension PeopleViewModel: PeopleViewModelCore {
    func bind(updateHandler: @escaping () -> Void) {
        self.updateHandler = updateHandler
    }
    func getPeople() {
        guard let url = URL(string: "\(Constants.baseURL)/people") else { return }
        self.networkManager.getModel(url: url) { (result: Result<[Person], NetworkError>) in
            switch result {
            case .success(let page):
                self.pageCount += 1
                self.peopleList.append(contentsOf: page)
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension PeopleViewModel: PeopleViewModelAttributes {
    var count: Int {
        return self.peopleList.count
    }
    func getPersonName(for index: Int) -> String? {
        guard index < self.count else { return nil }
        let fullName = "\(self.peopleList[index].firstName) \(self.peopleList[index].lastName)"
        return fullName
    }
    func getPersonEmail(for index: Int) -> String? {
        guard index < self.count else { return nil }
        return self.peopleList[index].email
    }
    func getPersonDesignation(for index: Int) -> String? {
        guard index < self.count else { return nil }
        return self.peopleList[index].jobtitle
    }
    func getPersonFavColor(for index: Int) -> String? {
        guard index < self.count else { return nil }
        return self.peopleList[index].favouriteColor
    }
    func getPersonImage(for index: Int, completion: @escaping (Data?) -> Void) {
        guard index < self.count else {
            completion(nil)
            return
        }
        let posterPath = self.peopleList[index].avatar
        // Check ImageCache
        if let imageData = self.cache.getImageData(key: posterPath) {
            completion(imageData)
            return
        }
        guard let url = URL(string: "\(self.peopleList[index].avatar)") else { return }
       // Else call network
       self.networkManager.getRawData(url: url) { result in
            switch result {
            case .success(let imageData):
                self.cache.setImageData(data: imageData, key: posterPath)
                completion(imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
