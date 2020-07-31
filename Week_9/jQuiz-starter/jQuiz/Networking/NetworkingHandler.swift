//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

typealias ClueResponse<T> = (Result<T, Error>) -> Void

class Networking {
    
    static let sharedInstance = Networking()
    
    private func sendRequest<T: Decodable>(endpoint: String, completion: @escaping ClueResponse<T>) {
        guard let url = URL(string: endpoint) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(response))
            } catch let err {
                completion(.failure(err))
            }
        }.resume()
    }
    
    private func getARandomCategory(completion: @escaping (Clue) -> Void) {
        let url = Endpoints.baseURL.rawValue + Endpoints.getRandomClue.rawValue
        sendRequest(endpoint: url) { (result: Result<[Clue], Error>)  in
            switch result {
            case .success(let response):
                completion(response[0])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getOptions(_ categoryId: Int, completion: @escaping ([String]) -> Void) {
        let url = "\(Endpoints.baseURL.rawValue)\(Endpoints.getOptions.rawValue)\(categoryId)"
        sendRequest(endpoint: url) { (result: Result<[Clue], Error>) in
            switch result {
            case .success(let response):
                let options = self.processOptionsResponse(clues: response)
                completion(options)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func processOptionsResponse(clues: [Clue]) -> [String] {
        var options = [String]()
        for clue in clues where clues.count <= 4 {
            options.append(clue.answer)
        }
        return options
    }
    
    func setupGame(completion: @escaping () -> Void) {
        getARandomCategory(completion: { clue in
            let categoryId = clue.categoryId
            self.getOptions(categoryId) { clues in
            }
        })
    }
    
}
