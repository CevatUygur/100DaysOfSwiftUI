//
//  ContentView.swift
//  HabitTracking
//
//  Created by CEVAT UYGUR on 14.03.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { item in
                    NavigationLink {
                        DetailView(habits: Habits)
                    } label: {
                        HStack {
                            Text(item.name)
                                .font(.headline)
                            
                            Spacer()
                            
                            Text(item.count, format: .number)
                                .padding(.horizontal, 5)
                        }
                        
                    }
                    
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Habit Tracking App")
            .toolbar {
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddView(habits: habits)
            }

        }
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
