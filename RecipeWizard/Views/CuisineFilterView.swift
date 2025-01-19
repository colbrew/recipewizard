//
//  CuisineFilter.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

import SwiftUI
struct CuisineFilterView: View {
    @Binding var homeVM: HomeViewModel
    let cuisineTypes = ["All", "British", "Malaysian"]
    var body: some View {
        Menu("Cuisine Type") {
            Picker(selection: $homeVM.filter, label: Text("Cuisine Type")) {
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
