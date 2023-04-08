//
//  ContentView.swift
//  ChallengeDay_1
//
//  Created by Mateusz Ratajczak on 24/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var numberUnit: Double = 0.0
    @State private var inputUnit = "Meters"
    @State private var outputUnit = "Kilometers"
    
    @FocusState private var isFocused: Bool
    
    let lengthUnits = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
//  1 Metr = 0.001 Kilometra
//  1 Metr = 3.2808399 Stopy
//  1 Metr = 1.0936133 Jarda
//  1 Metr = 0.000621371192 Mili
    
    var inputUnitConverted: Double {
        
        let finalInput: Double = numberUnit
        
        switch inputUnit {
        case "Meters":
            return finalInput
        case "Kilometers":
            return finalInput / 0.001
        case "Feet":
            return finalInput / 3.2808399
        case "Yards":
            return finalInput / 1.0936133
        case "Miles":
            return finalInput / 0.000621371192
        default:
            return finalInput
        }
    }
    
    var outputUnitConverted: Double {
        
        let finalOutput: Double = inputUnitConverted
        
        switch outputUnit {
        case "Meters":
            return finalOutput
        case "Kilometers":
            return finalOutput * 0.001
        case "Feet":
            return finalOutput * 3.2808399
        case "Yards":
            return finalOutput * 1.0936133
        case "Miles":
            return finalOutput * 0.00621371192
        default:
            return finalOutput
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Convert lenght", value: $numberUnit, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                } header: {
                    Text("Enter your value")
                }
                
                Section {
                    Picker("Type of Conversion - Input", selection: $inputUnit) {
                        ForEach(lengthUnits, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select Input")
                }
                
                Section {
                    Picker("Type of Conversion - Output", selection: $outputUnit) {
                        ForEach(lengthUnits, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select Output")
                }
                
                Section {
                    Text(outputUnitConverted, format: .number)
                } header: {
                    Text("Result of Conversion")
                }
            }
            .navigationTitle("Length Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
