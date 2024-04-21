//
//  SearchView.swift
//  NetflixStyleSwiftUI
//
//  Created by Minho on 4/22/24.
//

import SwiftUI

struct Category: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let count: Int
}

struct SearchView: View {
    
    let item = ["SF", "가족", "스릴러"]
    
    @State private var query: String = ""
    @State private var category = [
        Category(name: "스릴러", count: 1),
        Category(name: "액션", count: 2),
        Category(name: "SF", count: 3),
        Category(name: "로맨스", count: 4),
        Category(name: "애니메이션", count: 5)
    ]
    
    var filterCategory: [Category] {
        return query.isEmpty ? category : category.filter { $0.name.contains(query) }
    }
    
    func setupRows(_ category: Category) -> some View {
        HStack {
            Image(systemName: "person")
            Text("\(category.name), \(category.count)")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filterCategory, id: \.self) { value in
                    NavigationLink {
                        SearchDetailView(category: value)
                    } label: {
                        setupRows(value)
                    }
                }
            }
            .navigationTitle("영화 검색")
            .searchable(text: $query, placement: .navigationBarDrawer, prompt: "영화를 검색해보세요.")
            .onSubmit(of: .search) {
                print("ASDF")
            }
            .toolbar {
                Button {
                    addNewCategory()
                } label: {
                    Text("추가")
                }
            }
        }
    }
    
    func addNewCategory() {
        category.append(Category(name: item.randomElement()!, count: .random(in: 1...100)))
    }
}

struct SearchDetailView: View {
    
    let category: Category
    
    var body: some View {
        Text("\(category.name), \(category.count)")
    }
}

#Preview {
    SearchView()
}
