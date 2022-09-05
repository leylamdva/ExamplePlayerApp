//
//  ContentView.swift
//  ExamplePlayerApp
//
//  Created by Leyla Mammadova on 9/5/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        BookView(bookVM: BookViewModel(book: Book.data))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AudioManager())
    }
}
