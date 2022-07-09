//
//  JsonDecoder.swift
//  Merita
//
//  Created by ahmed rabie on 01/07/2022.
//

import Foundation
func convertFromJson<T: Codable>(data: Data) -> T? {
    let jsonDecoder = JSONDecoder()
    let decodedArray = try? jsonDecoder.decode(T.self, from: data)
    return decodedArray
}
