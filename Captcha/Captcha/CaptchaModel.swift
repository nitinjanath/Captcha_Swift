//
//  CaptchaApp.swift
//  Captcha
//
//  Created by Nitin Janath on 5/4/26.
//
import Foundation
import AVFoundation
import Combine

enum AppScreen {
    case imageCaptcha
    case audioCaptcha
    case botScreen
    case humanScreen
}

class CaptchaModel: ObservableObject {
    
    @Published var currentScreen: AppScreen = .imageCaptcha
    
    @Published var imageCaptchaOptions: [String] = []
    @Published var correctImageName: String = ""
    @Published var imageAttempts: Int = 0
    
    @Published var audioCaptchaOptions: [String] = []
    @Published var correctAudioName: String = ""
    @Published var audioAttempts: Int = 0
    
    var audioPlayer: AVAudioPlayer?
    
    func loadImageFileNames() -> [String] {
        let allPaths = Bundle.main.paths(forResourcesOfType: "png", inDirectory: nil)
        
        var names: [String] = []
        for path in allPaths {
            let url = URL(fileURLWithPath: path)
            let nameWithoutExtension = url.deletingPathExtension().lastPathComponent
            names.append(nameWithoutExtension)
        }
        return names
    }
    
    func loadAudioFileNames() -> [String] {
        let allPaths = Bundle.main.paths(forResourcesOfType: "wav", inDirectory: nil)
        
        var names: [String] = []
        for path in allPaths {
            let url = URL(fileURLWithPath: path)
            let nameWithoutExtension = url.deletingPathExtension().lastPathComponent
            names.append(nameWithoutExtension)
        }
        return names
    }
    func setupImageCaptcha() {
        let allImages = loadImageFileNames()
        
        guard allImages.count >= 4 else {
            print("Not enough image files found in bundle!")
            return
        }
        
        let shuffled = allImages.shuffled()
        imageCaptchaOptions = Array(shuffled.prefix(4))
        
        let randomIndex = Int.random(in: 0..<4)
        correctImageName = imageCaptchaOptions[randomIndex]
    }
    
    func handleImageGuess(guessedName: String) {
        if guessedName == correctImageName {
            audioAttempts = 0
            setupAudioCaptcha()
            currentScreen = .audioCaptcha
        } else {
            imageAttempts += 1
            
            if imageAttempts >= 2 {
                currentScreen = .botScreen
            } else {
                setupImageCaptcha()
            }
        }
    }
    
    func setupAudioCaptcha() {
        let allAudio = loadAudioFileNames()
        
        guard allAudio.count >= 4 else {
            print("Not enough audio files found in bundle!")
            return
        }
        
        let shuffled = allAudio.shuffled()
        audioCaptchaOptions = Array(shuffled.prefix(4))
        
        let randomIndex = Int.random(in: 0..<4)
        correctAudioName = audioCaptchaOptions[randomIndex]
    }
    
    func playAudio() {
        guard let path = Bundle.main.path(forResource: correctAudioName, ofType: "wav") else {
            print("Could not find audio file: \(correctAudioName)")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Could not play audio: \(error)")
        }
    }
    
    func handleAudioGuess(guessedName: String) {
        if guessedName == correctAudioName {
            currentScreen = .humanScreen
        } else {
            audioAttempts += 1
            
            if audioAttempts >= 2 {
                currentScreen = .botScreen
            } else {
                // New audio to try
                setupAudioCaptcha()
            }
        }
    }
    
    func resetAll() {
        imageAttempts = 0
        audioAttempts = 0
        setupImageCaptcha()
        currentScreen = .imageCaptcha
    }
}
