//
//  ContentView.swift
//  NetflixStyleSwiftUI
//
//  Created by Minho on 4/22/24.
//

import SwiftUI

struct ContentView: View {
    
    let sections: [String] = ["첫번째 섹션", "두번째 섹션", "세번째 섹션", "네번째 섹선"]
    let items: [String] = (0...10).map { String($0) }
    let url = URL(string: "https://picsum.photos/300/500")
    
    @State private var path: [String] = []
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical) {
                
                ForEach(sections, id: \.self) { section in
                    VStack(alignment: .leading) {
                        Text(section)
                            .font(.title2)
                        
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem(.flexible())], content: {
                                ForEach(items, id: \.self) { item in
                                    AsyncImage(url: url) { data in
                                        switch data {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 80, height: 120)
                                        case .success(let image):
                                            NavigationLink(destination: detailView(text: section, image: image)) {
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 80, height: 120)
                                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                            }
                                        case .failure(let error):
                                            Image(systemName: "xmark")
                                        @unknown default:
                                            Image(systemName: "xmark")
                                        }
                                    }
                                    
                                }
                            })
                        }
                    }
                    .padding()
                }
                
                
            }
            .navigationTitle("My Random Image")
        }
        
        
    }
}

struct detailView: View {
    
    @State var text: String
    @State var image: Image
    
    var body: some View {
        image
            .resizable()
            .frame(width: 250, height: 350)
        Text(text)
    }
}

#Preview {
    ContentView()
}
