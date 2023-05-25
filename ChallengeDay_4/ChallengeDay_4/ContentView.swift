//
//  ContentView.swift
//  ChallengeDay_4
//
//  Habbit-Tracking
//
//  Created by Mateusz Ratajczak on 03/05/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    @State private var showingAddActivity: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { item in
                    NavigationLink {
                        ActivityView(activities: activities)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text("\(item.time) min")
                                .foregroundColor(.yellow)
                        }
                    }
                }
                .onDelete(perform: removeItems)
                
            }
            .navigationTitle("Habbit-Tracking")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddActivity.toggle()
                    } label: {
                        Label("Add Activity", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(activities: activities)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
