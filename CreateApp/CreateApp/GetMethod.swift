//
//  GetMethod.swift
//  CreateApp
//
//  Created by Sonnv on 2/12/19.
//  Copyright © 2019 Sonnv. All rights reserved.
//

import Foundation

func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else { return }
        do {
            let json = try JSONDecoder().decode(T.self, from: data)
            guard let t = T
        } catch {}
        }.resume()
}
