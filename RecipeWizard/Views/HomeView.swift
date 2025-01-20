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
        VStack {
            Text(Constants.title)
                .font(.title)
            CuisineFilterView(homeVM: $homeVM)
                .font(.title3)
            
            ZStack {
                List(homeVM.filteredRecipes, id: \.self) { recipe in
                    RecipeView(homeVM: $homeVM,
                               recipe: recipe)
                }
                .animation(.default, value: homeVM.filteredRecipes)
                .refreshable {
                    await homeVM.loadRecipes()
                }
                .background(.clear)

                if homeVM.loadingState == .loading {
                    ProgressView()
                } else if homeVM.loadingState == .doneLoadingEmpty {
                    ErrorView(homeVM: $homeVM,
                              message: Constants.noRecipes)
                } else if homeVM.loadingState == .failure {
                    ErrorView(homeVM: $homeVM,
                              message: Constants.failFetchingRecipes)
                }
            }
        }
        .background(.yellow)
        .task {
            await homeVM.loadRecipes()
        }
    }
}

#Preview {
    HomeView()
}
