//
//  CaptchaApp.swift
//  Captcha
//
//  Created by Nitin Janath on 5/4/26.
//
import SwiftUI


struct ContentView: View {
    
    @StateObject var model = CaptchaModel()
    
    var body: some View {
        switch model.currentScreen {
            
        case .imageCaptcha:
            ImageCaptchaView(model: model)
            
        case .audioCaptcha:
            AudioCaptchaView(model: model)
            
        case .botScreen:
            BotScreen(model: model)
            
        case .humanScreen:
            HumanScreen(model: model)
        }
    }
}
