//
//  BookViewModel.swift
//  ExamplePlayerApp
//
//  Created by Leyla Mammadova on 9/5/22.
//

import Foundation

final class BookViewModel : ObservableObject {
    private(set) var book : Book
    
    init(book: Book){
        self.book = book
    }
}

struct Book {
    let id = UUID()
    let title: String
    let description : String
    let duration : TimeInterval
    let track : String
    let image : String
    
    static let data = Book(title: "Example Audiobook", description: "Pretend this is a description of this great audiobook that you have to listen to", duration: 70, track: "Monkeys-Spinning-Monkeys", image: "book-image")
}
