# Captcha_Swift — Image & Audio Human Verification

A native iOS CAPTCHA application built with **SwiftUI** that demonstrates a two-stage human verification system using both visual and audio challenges.

The application begins with an **image CAPTCHA**, presenting four randomly selected images and asking the user to identify the correct one. Users have up to two attempts to complete the challenge successfully. A correct answer advances to the second stage, while two incorrect attempts result in the user being classified as a bot.
The second stage is an **audio CAPTCHA**. Users can play a randomly selected audio challenge and choose the corresponding answer from four options. Like the image challenge, users have two attempts before being classified as a bot. Successfully completing both stages results in a human verification screen.

### Features

* Randomized image CAPTCHA with four choices
* Audio CAPTCHA with built-in audio playback
* Randomized challenges on each attempt
* Two-attempt limit for each CAPTCHA stage
* Bot detection after repeated failures
* Human verification after successful completion
* Native SwiftUI interface
* CAPTCHA state management and reset functionality

The application uses **SwiftUI** for its interface and **AVFoundation** for audio playback. Its state is managed through an observable `CaptchaModel`, which controls the CAPTCHA stages, available challenges, correct answers, attempts, and screen transitions.

This project serves as a simple demonstration of how multimodal CAPTCHA challenges can be implemented in a native iOS application.
