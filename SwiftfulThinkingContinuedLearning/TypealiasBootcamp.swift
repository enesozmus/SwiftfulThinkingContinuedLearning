//
//  TypealiasBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 22.05.2024.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}
// 🟩
typealias TVModel = MovieModel

struct TypealiasBootcamp: View {
    
    //@State var item: MovieModel = MovieModel(title: "Title", director: "Joe", count: 5)
    @State var item: TVModel = TVModel(title: "Title", director: "Joe", count: 5)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

#Preview {
    TypealiasBootcamp()
}

/*
    🔴 Swift Typealias
        → A type alias allows you to provide a new name for an existing data type into your program.
        → After a type alias is declared, the aliased name can be used instead of the existing type throughout the program.
        → Type alias do not create new types. They simply provide a new name to an existing type.
        → The main purpose of typealias is to make our code more readable, and clearer in context for human understanding.

    typealias name = existing type
 */
