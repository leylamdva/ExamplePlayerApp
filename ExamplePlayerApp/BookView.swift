//
//  PlayerView.swift
//  ExamplePlayerApp
//
//  Created by Leyla Mammadova on 9/5/22.
//

import SwiftUI

struct BookView: View {
    @StateObject var bookVM: BookViewModel
    @State private var showPlayer = false
    
    var body: some View {
        VStack(spacing: 0){
            // Image
            Image(bookVM.book.image)
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height / 3)
            
            // Details
            ZStack{
                // Background
                Color(red: 24 / 255, green: 23 / 255, blue: 22 / 255)
                    .frame(height: UIScreen.main.bounds.height * 2 / 3)
                
                VStack(alignment: .leading, spacing: 24) {
                    // Type and duration
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Music")
                        
                        Text(DateComponentsFormatter.abbreviated.string(from: bookVM.book.duration) ?? bookVM.book.duration.formatted() + "S")
                    }
                    .font(.subheadline)
                    .textCase(.uppercase)
                    .opacity(0.7)
                    
                    // Title
                    Text(bookVM.book.title)
                        .font(.title)
                    
                    
                    // Play button
                    Button{
                        showPlayer = true
                    } label: {
                        Label("Play", systemImage: "play.fill")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(20)
                        
                    }
                    
                    // Description
                    Text(bookVM.book.description)
                    
                    Spacer()
                    
                }
                .foregroundColor(.white)
                .padding(20)
            }
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $showPlayer) {
            PlayerView(bookVM: bookVM)
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static let bookVM = BookViewModel(book: Book.data)
    static var previews: some View {
        BookView(bookVM: bookVM)
            .environmentObject(AudioManager())
    }
}
