//
//  ActivityView.swift
//  ChallengeDay_4
//
//  Created by Mateusz Ratajczak on 03/05/2023.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var activities: Activities
    @State private var description: String = ""
    @State private var rating: Int = 3
    @State private var item = [ActivityItem]()
    
    var body: some View {
        NavigationView {
            List {
                ZStack(alignment: .bottomTrailing) {
//                    Image(item.type ?? "Aerobic")
//                        .resizable()
//                        .scaledToFit()
                    }
                
                Section {
                    TextEditor(text: $description)
                } header: {
                    Text("Add Description")
                }
                
                Section {
                    RatingView(rating: $rating)
                } header: {
                    Text("Rate you activity")
                }
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activities: Activities())
    }
}
