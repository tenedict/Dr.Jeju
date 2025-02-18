//
//  TestView.swift
//  Dr_jeju
//
//  Created by 문재윤 on 2/18/25.
//


import SwiftUI
// TestView
struct TestView: View {
    @State private var question = ""
    @State private var response = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            TextField("질문을 입력하세요", text: $question)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("질문하기") {
                isLoading = true
                gpt(question) { result in
                    response = result
                    isLoading = false
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            if isLoading {
                ProgressView()
                    .padding()
            } else {
                Text(response)
                    .padding()
            }
        }
        .padding()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
