//
//  func_gpt.swift
//  Dr_jeju
//
//  Created by 문재윤 on 2/18/25.
//

import SwiftUI

func gpt(_ question: String, completion: @escaping (String) -> Void) {
    guard let url = URL(string: "http://34.22.80.135:3389/api/gpt/") else {
        completion("Invalid URL")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let json: [String: Any] = ["prompt": question]
    guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
        completion("Failed to encode JSON")
        return
    }
    request.httpBody = jsonData
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        DispatchQueue.main.async {
            if let error = error {
                completion("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                completion("No data received")
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode(APIResponse.self, from: data) {
                completion(decodedResponse.response)
            } else {
                completion("Failed to decode response")
            }
        }
    }.resume()
}

struct APIResponse: Codable {
    let response: String
}
