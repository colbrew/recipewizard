//
//  HomeView.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/17/25.
//

import SwiftUI

struct HomeView: View {
    @State private var homeVM = HomeViewModel()

    var body: some View {
        Text("Recipes Around the World")
            .font(.largeTitle)

        Menu("Cuisine Type") {
            Picker(selection: $homeVM.filter, label: Text("Cuisine Type")) {
                Text("all").tag("all")
                Text("British").tag("British")
                Text("Malaysian").tag("Malaysian")
            }
        }

        ZStack {
            List(homeVM.filteredRecipes, id: \.self) { recipe in
                RecipeView(recipe: recipe)
            }
            .animation(.default, value: homeVM.filteredRecipes)
            .refreshable {
                await homeVM.loadData()
            }

            if homeVM.loadFailure {
                ErrorView()
            }
        }
        .task {
            await homeVM.loadData()
        }
    }
}

#Preview {
    HomeView()
}
