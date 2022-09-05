//
//  PlayerView.swift
//  ExamplePlayerApp
//
//  Created by Leyla Mammadova on 9/5/22.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var audioManager: AudioManager
    var bookVM : BookViewModel
    var isPreview : Bool = false
    @State private var value : Double = 0.0
    @State private var isEditing : Bool = false
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack{
            // Background image
            Image(bookVM.book.image)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            
            // Blur view
            Rectangle()
                .background(.thinMaterial)
                .opacity(0.25)
                .ignoresSafeArea()
            
            VStack(spacing: 32){
                // Dismiss Button
                HStack {
                    Button {
                        audioManager.stop()
                        dismiss()
                    }label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                
                // Title
                Text(bookVM.book.title)
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                // Playback
                if let player = audioManager.player {
                    VStack(spacing: 5){
                        // Playback timeline
                        Slider(value: $value, in: 0...player.duration) { editing in
                            isEditing = editing
                            if !editing {
                                player.currentTime = value
                            }
                        }
                            .accentColor(.white)
                        
                        // Playback time
                        HStack{
                            Text(DateComponentsFormatter.positional.string(from: player.currentTime) ?? "0:00")
                            
                            Spacer()
                            
                            Text(DateComponentsFormatter.positional.string(from: player.duration - player.currentTime) ?? "0:00")
                        }
                        .font(.caption)
                        .foregroundColor(.white)
                        
                        
                        // Playback Control
                        HStack{
                            // Repeat Button
                            let color : Color = audioManager.isLooping ? .teal : .white
                            PlaybackControlButton(systemName: "repeat", color: color){
                                audioManager.toggleLoop()
                            }
                            
                            Spacer()
                            
                            // Backward Button
                            PlaybackControlButton(systemName: "gobackward.10"){
                                player.currentTime -= 10
                            }
                            
                            Spacer()
                            
                            // Play/Pause Button
                            PlaybackControlButton(systemName: audioManager.isPlaying ? "pause.circle.fill" : "play.circle.fill", fontSize: 44){
                                audioManager.playPause()
                            }
                            
                            Spacer()
                            
                            // Forward Button
                            PlaybackControlButton(systemName: "goforward.10"){
                                player.currentTime += 10
                            }
                            
                            Spacer()
                            
                            // Stop Button
                            PlaybackControlButton(systemName: "stop.fill"){
                                audioManager.stop()
                                dismiss()
                            }
                        }
                    }
                }
            }
            .padding(20)
        } // ZStack
        .onAppear {
            audioManager.startPlayer(track: bookVM.book.track, isPreview: isPreview)
        }
        .onReceive(timer) { _ in
            guard let player = audioManager.player, !isEditing else { return }
            value = player.currentTime
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let bookVM = BookViewModel(book: Book.data)
    static var previews: some View {
        PlayerView(bookVM: bookVM, isPreview: true)
            .environmentObject(AudioManager())
    }
}
