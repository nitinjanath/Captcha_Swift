//
//  CaptchaApp.swift
//  Captcha
//
//  Created by Nitin Janath on 5/4/26.
//

import SwiftUI

struct AudioCaptchaView: View {
    
    @ObservedObject var model: CaptchaModel
    
    var body: some View {
        VStack(spacing: 24) {
            
            Text("Audio CAPTCHA")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Almost there!")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            VStack(spacing: 12) {
                Text("Press play, then select the text you heard:")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    model.playAudio()
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "speaker.wave.2.fill")
                            .font(.title2)
                        Text("Play Audio")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 14)
                    .background(Color.green)
                    .cornerRadius(30)
                }
            }
            
            if model.audioAttempts > 0 {
                Text("Wrong! Try again. Attempt \(model.audioAttempts + 1) of 2")
                    .foregroundColor(.red)
                    .font(.subheadline)
            }
            
            VStack(spacing: 12) {
                ForEach(model.audioCaptchaOptions, id: \.self) { audioName in
                    
                    Button(action: {
                        model.handleAudioGuess(guessedName: audioName)
                    }) {
                        Text(audioName)
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
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
            model.setupAudioCaptcha()
        }
    }
}
