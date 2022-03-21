//
//  AddView.swift
//  HabitTracking
//
//  Created by CEVAT UYGUR on 14.03.2022.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var habits: Habits
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    @State private var count : Int?
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    TextField("Name: *Required", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        
                    
                    TextField("Description: *Required", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("Count: Default = 1", value: $count, format: .number)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
            }
            
            .navigationTitle("Add New Habit")
            .toolbar {
                Button("Save") {
                    if name.isEmpty && description.isEmpty {
                        showingAlert = true
                        alertMessage = "Please enter 'Habit Name' and 'Habit Description'"
                    } else if name.isEmpty {
                        showingAlert = true
                        alertMessage = "Please enter 'Habit Name'"
                    } else if description.isEmpty {
                        showingAlert = true
                        alertMessage = "Please enter 'Habit Description'"
                    } else {
                        addHabit()
                    }
                }
            }
        }
        .alert("Please fill the required fields.", isPresented: $showingAlert) {
            Button("OK", action: Cancel)
        } message: {
            Text(alertMessage)
        }
    }
    
    func addHabit () {
        let item = Habit(name: name, description: description, count: count ?? 1)
        habits.items.append(item)
        dismiss()
    }
    
    func Cancel () {
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
