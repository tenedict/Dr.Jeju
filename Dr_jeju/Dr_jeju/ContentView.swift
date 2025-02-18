////
////  ContentView.swift
////  Dr_jeju
////
////  Created by 문재윤 on 2/18/25.
////
//import SwiftUI
////
////struct UserSelectView: View {
////    @State private var startDate = Date()
////    @State private var endDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
////    @State private var selectedOption = 0
////    @State private var isNextViewActive = false
////    
////    let options = ["옵션 1", "옵션 2", "옵션 3", "옵션 4", "옵션 5", "옵션 6", "옵션 7", "옵션 8"]
////
////    var body: some View {
////        VStack(spacing: 20) {
////            VStack {
////                DatePicker("시작 날짜", selection: $startDate, displayedComponents: .date)
////                    .datePickerStyle(.compact)
////                    .padding()
////                    .tint(Color("jejuorange"))
////                
////                DatePicker("종료 날짜", selection: $endDate, in: startDate..., displayedComponents: .date)
////                    .datePickerStyle(.compact)
////                    .padding()
////                    .tint(Color("jejuorange"))
////            }
////            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
////            .padding()
////            Picker("옵션 선택", selection: $selectedOption) {
////                ForEach(0..<options.count, id: \ .self) { index in
////                    Text(self.options[index]).tag(index)
////                }
////            }
////            .pickerStyle(.inline)
////            
////            NavigationLink(destination: UserSelectMoneyView(), isActive: $isNextViewActive) {
////                Button("다음") {
////                    isNextViewActive = true
////                }
////                .padding()
////                .frame(maxWidth: .infinity)
////                .background(Color("jejuorange"))
////                .foregroundColor(.white)
////                .cornerRadius(10)
////            }
////            .padding(.top, 20)
////        }
////        .padding()
////        .navigationTitle("User Select")
////    }
////}
////
////
////struct UserSelectMoneyView: View {
////    @State private var percentage = 50.0
////    @State private var isDragging = false
////    
////    var body: some View {
////        VStack(spacing: 30) {
////            Text("퍼센트 선택")
////                .font(.headline)
////            
////            // Percentage Display
////            Text("\(Int(percentage))%")
////                .font(.system(size: 44, weight: .bold))
////                .foregroundColor(Color("jejuorange"))
////                .frame(minWidth: 100)
////                .animation(.spring(), value: percentage)
////            
////            // Custom Progress Bar
////            GeometryReader { geometry in
////                ZStack(alignment: .leading) {
////                    // Background Track
////                    RoundedRectangle(cornerRadius: 12)
////                        .fill(Color.gray.opacity(0.2))
////                        .frame(height: 5)
////                    
////                    // Filled Track
////                    RoundedRectangle(cornerRadius: 12)
////                        .fill(Color("jejuorange"))
////                        .frame(width: max(0, min(CGFloat(percentage) / 100.0 * geometry.size.width, geometry.size.width)), height: 5)
////                    
////                    // Drag Handle
////                    Circle()
////                        .fill(.white)
////                        .shadow(radius: isDragging ? 8 : 4)
////                        .frame(width: 40, height: 40)
////                        .offset(x: max(0, min(CGFloat(percentage) / 100.0 * geometry.size.width - 20, geometry.size.width - 40)))
////                        .gesture(
////                            DragGesture()
////                                .onChanged { value in
////                                    isDragging = true
////                                    let newPercentage = min(max(0, (value.location.x / geometry.size.width) * 100), 100)
////                                    percentage = Double(Int(newPercentage / 5) * 5) // Snap to 5% intervals
////                                }
////                                .onEnded { _ in
////                                    isDragging = false
////                                }
////                        )
////                }
////            }
////            .frame(height: 10)
////            .padding(.horizontal)
////            
////            // Quick Selection Buttons
//////            HStack(spacing: 20) {
//////                Button("0%") { percentage = 0 }
//////                Button("25%") { percentage = 25 }
//////                Button("50%") { percentage = 50 }
//////                Button("75%") { percentage = 75 }
//////                Button("100%") { percentage = 100 }
//////            }
//////            .buttonStyle(PercentageButtonStyle())
////            
////            Spacer()
////        }
////        .padding()
////        .navigationTitle("Money Select")
////    }
////}
////
////struct PercentageButtonStyle: ButtonStyle {
////    func makeBody(configuration: Configuration) -> some View {
////        configuration.label
////            .padding(.horizontal, 12)
////            .padding(.vertical, 8)
////            .background(
////                RoundedRectangle(cornerRadius: 8)
////                    .fill(configuration.isPressed ? Color.gray.opacity(0.3) : Color.gray.opacity(0.1))
////            )
////            .foregroundColor(Color("jejuorange"))
////            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
////    }
////}
//// UserSelectView
//struct UserSelectView: View {
//    @State private var startDate = Date()
//    @State private var endDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
//    @State private var selectedOption = 0
//    @State private var isNextViewActive = false
//    @State private var gptResponse = ""
//    
//    let options = ["옵션 1", "옵션 2", "옵션 3", "옵션 4", "옵션 5", "옵션 6", "옵션 7", "옵션 8"]
//    
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                VStack {
//                    DatePicker("시작 날짜", selection: $startDate, displayedComponents: .date)
//                        .datePickerStyle(.compact)
//                        .padding()
//                    
//                    DatePicker("종료 날짜", selection: $endDate, in: startDate..., displayedComponents: .date)
//                        .datePickerStyle(.compact)
//                        .padding()
//                }
//                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
//                .padding()
//                
//                Picker("옵션 선택", selection: $selectedOption) {
//                    ForEach(0..<options.count, id: \ .self) { index in
//                        Text(self.options[index]).tag(index)
//                    }
//                }
//                .pickerStyle(.inline)
//                
//                NavigationLink(destination: UserSelectMoneyView(gptResponse: gptResponse), isActive: $isNextViewActive) {
//                    Button("다음") {
//                        let prompt = "시작 날짜: \(startDate), 종료 날짜: \(endDate), 기간: \(Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0)일 이동안 제주도 여행가는데 필요한 경비 알려줘. 대답은 단답으로만 해. 답변 형식은 \"54만원\"이런 느낌으로 해줘"
//                        gpt(prompt) { result in
//                            gptResponse = result
//                            isNextViewActive = true
//                        }
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.orange)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//                }
//                .padding(.top, 20)
//            }
//            .padding()
//            .navigationTitle("User Select")
//        }
//    }
//}
//
//// UserSelectMoneyView
//struct UserSelectMoneyView: View {
//    let gptResponse: String
//    @State private var percentage = 50.0
//    @State private var isDragging = false
//    
//    var body: some View {
//        VStack(spacing: 30) {
//            Text("GPT의 추천 내용")
//                .font(.headline)
//                .padding()
//            
//            Text(gptResponse)
//                .padding()
//                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
//                .padding()
//                
//            Text("퍼센트 선택")
//                .font(.headline)
//            
//            Text("\(Int(percentage))%")
//                .font(.system(size: 44, weight: .bold))
//                .foregroundColor(Color.orange)
//                .frame(minWidth: 100)
//                .animation(.spring(), value: percentage)
//            
//            GeometryReader { geometry in
//                ZStack(alignment: .leading) {
//                    RoundedRectangle(cornerRadius: 12)
//                        .fill(Color.gray.opacity(0.2))
//                        .frame(height: 5)
//                    
//                    RoundedRectangle(cornerRadius: 12)
//                        .fill(Color.orange)
//                        .frame(width: max(0, min(CGFloat(percentage) / 100.0 * geometry.size.width, geometry.size.width)), height: 5)
//                    
//                    Circle()
//                        .fill(.white)
//                        .shadow(radius: isDragging ? 8 : 4)
//                        .frame(width: 40, height: 40)
//                        .offset(x: max(0, min(CGFloat(percentage) / 100.0 * geometry.size.width - 20, geometry.size.width - 40)))
//                        .gesture(
//                            DragGesture()
//                                .onChanged { value in
//                                    isDragging = true
//                                    let newPercentage = min(max(0, (value.location.x / geometry.size.width) * 100), 100)
//                                    percentage = Double(Int(newPercentage / 5) * 5) // Snap to 5% intervals
//                                }
//                                .onEnded { _ in
//                                    isDragging = false
//                                }
//                        )
//                }
//            }
//            .frame(height: 10)
//            .padding(.horizontal)
//            
//            Spacer()
//        }
//        .padding()
//        .navigationTitle("Money Select")
//    }
//}
//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            UserSelectView()
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
//
import SwiftUI

struct UserSelectView: View {
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    @State private var selectedOption = 0
    @State private var isNextViewActive = false
    @State private var gptResponse = ""
    @State private var isLoading = false
    
    let options = ["옵션 1", "옵션 2", "옵션 3", "옵션 4", "옵션 5", "옵션 6", "옵션 7", "옵션 8"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack {
                    DatePicker("시작 날짜", selection: $startDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding()
                    
                    DatePicker("종료 날짜", selection: $endDate, in: startDate..., displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding()
                }
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                .padding()
                
                Picker("옵션 선택", selection: $selectedOption) {
                    ForEach(0..<options.count, id: \ .self) { index in
                        Text(self.options[index]).tag(index)
                    }
                }
                .pickerStyle(.inline)
                
                if isLoading {
                    ProgressView("GPT의 응답을 기다리는 중...")
                        .padding()
                }
                
                Button("다음") {
                    print("되나요되나요")
                    isLoading = true
                    let prompt = "시작 날짜: \(startDate), 종료 날짜: \(endDate), 기간: \(Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0)일 이동안 제주도 여행가는데 항공료 제외한 필요한 경비 알려줘. 대답은 단답으로만 해. 답변 형식은 \"54만원\",\"544만원\" 이런 느낌으로 해줘"
                    print("gg")
                    gpt(prompt) { result in
                        DispatchQueue.main.async {
                            gptResponse = result
                            isLoading = false
                            isNextViewActive = true
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(isLoading)
                
                NavigationLink(destination: UserSelectMoneyView(gptResponse: $gptResponse), isActive: $isNextViewActive) {
                    EmptyView() // EmptyView is used to create the necessary NavigationLink destination behavior
                }
                .padding(.top, 20)
            }
            .padding()
            .navigationTitle("User Select")
        }
    }
}

struct UserSelectMoneyView: View {
    @Binding var gptResponse: String
    @State private var percentage = 50.0
    @State private var isDragging = false
    
    // Extract the numeric value from gptResponse (assuming the format is like "24만원")
    var extractedAmount: Int {
        // Remove non-numeric characters and convert to integer
        let numberString = gptResponse.filter { "0"..."9" ~= $0 }
        return Int(numberString) ?? 0
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Text("GPT의 추천 내용")
                .font(.headline)
                .padding()
            
            Text(gptResponse)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                .padding()
                
            Text("퍼센트 선택")
                .font(.headline)
            
            Text("\(Int(percentage))%")
                .font(.system(size: 44, weight: .bold))
                .foregroundColor(Color.orange)
                .frame(minWidth: 100)
                .animation(.spring(), value: percentage)
            
            Text("Extracted Amount: \(extractedAmount*Int(percentage)/100)만원") // Display the extracted value here
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 5)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.orange)
                        .frame(width: max(0, min(CGFloat(percentage) / 100.0 * geometry.size.width, geometry.size.width)), height: 5)
                    
                    Circle()
                        .fill(.white)
                        .shadow(radius: isDragging ? 8 : 4)
                        .frame(width: 40, height: 40)
                        .offset(x: max(0, min(CGFloat(percentage) / 100.0 * geometry.size.width - 20, geometry.size.width - 40)))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    isDragging = true
                                    let newPercentage = min(max(0, (value.location.x / geometry.size.width) * 100), 100)
                                    percentage = Double(Int(newPercentage / 5) * 5) // Snap to 5% intervals
                                }
                                .onEnded { _ in
                                    isDragging = false
                                }
                        )
                }
            }
            .frame(height: 10)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Money Select")
    }
}



struct ContentView: View {
    var body: some View {
        NavigationView {
            UserSelectView()
        }
    }
}

#Preview {
    ContentView()
}

