//
//  AddActivityView.swift
//  ChallengeDay_4
//
//  Created by Mateusz Ratajczak on 03/05/2023.
//

import SwiftUI

struct AddActivityView: View {
    @ObservedObject var activities: Activities
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var type: String = "Aerobic"
    @State private var time: Int = 0
    
    let types = ["Aerobic", "Strengthening", "Flexibility", "Balance"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Time", value: $time, format: .number)
                    .keyboardType(.decimalPad)
            }
            .background(.darkBackground)
            .navigationTitle("Add new Activity")
            .toolbar {
                Button("Save") {
                    let item = ActivityItem(name: name, type: type, time: time)
                    activities.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
