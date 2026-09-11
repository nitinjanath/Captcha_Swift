//
//  CaptchaApp.swift
//  Captcha
//
//  Created by Nitin Janath on 5/4/26.
//
import SwiftUI

struct ImageCaptchaView: View {
    
    @ObservedObject var model: CaptchaModel
    
    var body: some View {
        VStack(spacing: 24) {
            
            Text("CAPTCHA")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Prove you're human")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            VStack(spacing: 8) {
                Text("Select the image that says:")
                    .font(.headline)
                
                Text(model.correctImageName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
            }
            
            if model.imageAttempts > 0 {
                Text("Wrong! Try again. Attempt \(model.imageAttempts + 1) of 2")
                    .foregroundColor(.red)
                    .font(.subheadline)
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                
                ForEach(model.imageCaptchaOptions, id: \.self) { imageName in
                    
                    Button(action: {
                        model.handleImageGuess(guessedName: imageName)
                    }) {
                        VStack(spacing: 6) {
                            
                            if let path = Bundle.main.path(forResource: imageName, ofType: "png"),
                               let uiImage = UIImage(contentsOfFile: path) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 120)
                                    .cornerRadius(8)
                            } else {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 120)
                                    .cornerRadius(8)
                                    .overlay(
                                        Text("?")
                                            .font(.largeTitle)
                                            .foregroundColor(.gray)
                                    )
                            }
                            
                            Text(imageName)
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .onAppear {
            model.setupImageCaptcha()
        }
    }
}
