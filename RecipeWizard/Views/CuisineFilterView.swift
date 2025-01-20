//
//  CuisineFilter.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

import SwiftUI
struct CuisineFilterView: View {
    @Binding var homeVM: HomeViewModel

    var body: some View {
        Menu(Constants.cuisineType) {
            Picker(selection: $homeVM.filter, label: Text(Constants.cuisineType)) {
                ForEach(Array(homeVM.cuisines).sorted(), id: \.self){ cuisine in
                    Text(cuisine).tag(cuisine)
                }
            }
        }
    }
}


#Preview {
    @Previewable @State var homeVM = HomeViewModel()
    
    CuisineFilterView(homeVM: $homeVM)
}
