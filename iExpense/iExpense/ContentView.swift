//
//  ContentView.swift
//  iExpense
//
//  Created by CEVAT UYGUR on 6.03.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
                List {
                    ForEach(expenses.items) { item in
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            
                            if item.amount < 10 {
                                Text(item.amount, format: .currency(code: "USD"))
                                    .foregroundColor(Color.red)
                            } else if item.amount < 100 {
                                Text(item.amount, format: .currency(code: "USD"))
                                    .foregroundColor(Color.blue)
                            } else {
                                Text(item.amount, format: .currency(code: "USD"))
                                    .foregroundColor(Color.green)
                            }
                        }
                        
                    }.onDelete(perform: removeItems)
            }
            .navigationTitle("Business")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
        
        NavigationView {
                List {
                    ForEach(expenses.items) { item in
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            
                            if item.amount < 10 {
                                Text(item.amount, format: .currency(code: "USD"))
                                    .foregroundColor(Color.red)
                            } else if item.amount < 100 {
                                Text(item.amount, format: .currency(code: "USD"))
                                    .foregroundColor(Color.blue)
                            } else {
                                Text(item.amount, format: .currency(code: "USD"))
                                    .foregroundColor(Color.green)
                            }
                        }
                    }.onDelete(perform: removeItems)
            }
            .navigationTitle("Personal")
        }
    }

    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
