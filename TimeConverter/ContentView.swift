//
//  ContentView.swift
//  TimeConverter
//
//  Created by Bakhtiyorjon Mirzajonov on 10/19/23.
//

import SwiftUI

struct ContentView: View {
  @State private var inputTime = 60
  @State private var inputUnit = "Min"
  @State private var outputUnit = "Hour"
  @FocusState private var amountIsFocused: Bool
  
  let unitsArr = ["Sec", "Min", "Hour", "Day", "Week"]
  let allUnits = ["Nanosecond", "Microsecond", "Millisecond", "Sec", "Min", "Hour", "Day", "Week", "Month", "Calendar year", "Decade", "Century"]

  
  let unitsDict = [
    "Century": 3.154e+9,
    "Decade": 3.154e+8,
    "Calendar year": 3.154e+7,
    "Month": 2.628e+6,
    "Week": 604800.0,
    "Day": 86400.0,
    "Hour": 3600.0,
    "Min": 60.0,
    "Sec": 1.0,
    "Millisecond": 0.001,
    "Microsecond": 1e-6,
    "Nanosecond": 1e-9
  ]
  
  var output: Double? {
    let inputInSecs = unitsDict[inputUnit]! * Double(inputTime)
    let outputTime = inputInSecs / unitsDict[outputUnit]!
    
    guard outputTime > 0.0000009 else { return nil }
    
    return outputTime
  }
  
  var body: some View {
    NavigationStack {
      Form {
        Section("Choose the input unit") {
          Picker("Units", selection: $inputUnit) {
            ForEach(unitsArr, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.segmented)
          
          Picker("More units", selection: $inputUnit) {
            ForEach(allUnits, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.navigationLink)
        }
        
        Section("Enter time amount") {
          TextField("Enter amount", value: $inputTime, format: .number)
            .keyboardType(.decimalPad)
            .focused($amountIsFocused)
        }
        
        Section("Choose the output unit") {
          Picker("Units", selection: $outputUnit) {
            ForEach(unitsArr, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.segmented)
          
          Picker("More units", selection: $outputUnit) {
            ForEach(allUnits, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.navigationLink)
        }
        
        Section("Result") {
          if let outputValue = output {
            Text("\(outputValue)")
          } else {
            Text("The number is too small/big.")
              .foregroundColor(.red)
          }
        }
      }
      .navigationTitle("Time Converter")
      .toolbar {
          if amountIsFocused {
              Button("Done") {
                  amountIsFocused = false
              }
          }
      }
    }
  }
}

#Preview {
    ContentView()
}
