//
//  MenuFetcher.swift
//  Albertos
//
//  Created by Ebubekir Sezer on 20.01.2022.
//

import Foundation
import Combine

class MenuFetcher: MenuFetching {
    
    let networkFetching: NetworkFetching
    let baseURL: URL
    
    init(baseURL: URL = URL(string: "https://raw.githubusercontent.com/mokagio/tddinswift_fake_api/trunk")!,
         networkFetching: NetworkFetching = URLSession.shared) {
        self.baseURL = baseURL
        self.networkFetching = networkFetching
    }
    
    func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
        let request = URLRequest(url: baseURL.appendingPathComponent("menu_response.json"))
        return networkFetching.load(request)
            .decode(type: [MenuItem].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
