//
//  RickAndMortyService.swift
//  simple_parse_JSON
//
//  Created by Kirill Khomytsevych on 15.04.2023.
//

import Foundation

class RickAndMortyService {

    func request(urlString: String, completion: @escaping (RickAndMortyModel?, Error?) -> Void) {

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
                completion(nil,error)
                return
            }
            guard let data = data else { return }

            // Show json
//            guard let jsonString = String(data: data, encoding: .utf8) else { return }
//            print(jsonString)

            do {
                let rickAndMortyModel = try JSONDecoder().decode(RickAndMortyModel.self, from: data)
                completion(rickAndMortyModel,nil)
            } catch {
                print(error)
                completion(nil,error)
            }
        }.resume()
    }

}
