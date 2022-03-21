//
//  DetailView.swift
//  HabitTracking
//
//  Created by CEVAT UYGUR on 15.03.2022.
//

import SwiftUI

struct DetailView: View {
    var habits = Habit
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text(habits.name)

                Text("Deneme")
            }
            
        }
        .navigationTitle("Title")
        .font(.headline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(habits: Habits[""])
    }
}
