//
//  CaptchaApp.swift
//  Captcha
//
//  Created by Nitin Janath on 5/4/26.
//
import SwiftUI

struct BotScreen: View {
    
    @ObservedObject var model: CaptchaModel
    
    var body: some View {
        VStack(spacing: 24) {
            
            Spacer()
            
            Text("You are a robot.")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.red)
        }
        .padding()
    }
}

struct HumanScreen: View {
    
    @ObservedObject var model: CaptchaModel
    
    var body: some View {
        VStack(spacing: 24) {

            Text("You are a human.")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
            
            Spacer()
        }
        .padding()
    }
}
