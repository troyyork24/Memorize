//
//  ContentView.swift
//  Memorize
//
//  Created by Troy York on 6/1/21.
//

import SwiftUI

struct ContentView: View {
    @State var emojiCount = EmojiGroups.car.emojiOriginalCount
    @State var themes: EmojiGroups = .car
    
    
    enum EmojiGroups: CaseIterable {
        case car, picto, activities
        var title: String {
            switch self {
                case .car:
                    return "Cars"
                case .picto:
                    return "Pictographs"
                case .activities:
                    return "Activities"
            }
        }
        var systemName: String {
            switch self {
                case .car:
                    return "car"
                case .picto:
                    return "sun.max"
                case .activities:
                    return "suit.spade"
            }
        }
        var emojis: [String] {
            switch self {
                case .car:
                    return ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🦽", "🦼", "🛴", "🚲", "🛵", "🏍", "🛺", "🚔", "🚍", "🚀"]
                case .picto:
                    return ["☀︎", "☼", "☽", "☾", "☁︎", "☂︎", "☃︎", "☆", "♤", "♕", "♔", "⚛︎"]
                case .activities:
                    return ["🎿", "⛷", "🏂", "🪂", "🏋️‍♀️", "🤼‍♀️", "🤸‍♀️", "⛹️", "🤺", "🤾‍♀️", "🏌️‍♀️", "🏇", "🏄‍♀️", "🏊‍♀️", "🚣‍♀️", "🧗‍♀️", "🚵"]
            }
        }
        var emojiOriginalCount: Int {
            Int.random(in: 4..<emojis.count)
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                        //change car emojis
                        ForEach(themes.emojis[0..<emojiCount], id: \.self) { emoji in
                            CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                        }
                    }
                    .padding(.horizontal, 5)
                }
                .navigationTitle("Memorize!")
                .foregroundColor(.red)
                Spacer()
                HStack {
                    ForEach(EmojiGroups.allCases, id: \.self, content: { theme in
                        Button(action: {
                            self.themes = theme
                            emojiCount = themes.emojiOriginalCount
                        }, label: {
                            VStack {
                                Image(systemName: theme.systemName)
                                Text(theme.title).font(.headline)
                            }
                        })
                    })
                    .padding()
                }
                
            }
        }
    }
    var remove: some View {
        Button {
            if emojiCount > 1 { emojiCount -= 1 } } label: {Image(systemName: "minus.circle")}
    }
    
    
    //Same thing as entering above some view
    var add: some View {
        Button {
            if emojiCount < themes.emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
            
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    let shape = RoundedRectangle(cornerRadius: 20)
    var body: some View {
        ZStack {
            if isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: 3)
                
                Text(content).font(.largeTitle)
                    .font(.largeTitle)
            } else {
                shape
                    .fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
