//
//  ContentView.swift
//  Dr_jeju
//
//  Created by 문재윤 on 2/18/25.
//

import SwiftUI

struct ContentView: View {
    @State private var question = "" // The text entered by the user
    @State private var response = ""
    @State private var isLoading = false

    var body: some View {
        VStack {
            Text("Ask GPT a Question:")
                .font(.title)
                .padding()

            // TextField to enter a question
            TextField("Enter your question here", text: $question)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(maxWidth: .infinity)

            if isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                Text(response)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            // Button to send the request with the user's input
            Button("Send Request") {
                if !question.isEmpty {
                    fetchAPIResponse()
                } else {
                    response = "Please enter a question."
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }

    func fetchAPIResponse() {
        guard let url = URL(string: "http://34.22.80.135:3389/api/gpt/") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Use the question entered by the user
        let json: [String: Any] = ["prompt": question]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else { return }
        request.httpBody = jsonData

        isLoading = true

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.response = "Error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.response = "No data received"
                    return
                }

                if let decodedResponse = try? JSONDecoder().decode(APIResponse.self, from: data) {
                    self.response = decodedResponse.response
                } else {
                    self.response = "Failed to decode response"
                }
            }
        }.resume()
    }
}

struct APIResponse: Codable {
    let response: String
}


#Preview {
    ContentView()
}
