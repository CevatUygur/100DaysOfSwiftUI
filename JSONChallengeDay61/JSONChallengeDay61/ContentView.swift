//
//  ContentView.swift
//  JSONChallengeDay60
//
//  Created by CEVAT UYGUR on 20.03.2022.
//

import CoreData
import SwiftUI

struct User: Codable, Identifiable {
    let id: String
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var isActive: Bool
    let friends: [Friend]
}

struct Friend: Codable, Identifiable {
    let id: String
    var name: String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var childContext
    @FetchRequest(sortDescriptors: []) var cdUsers: FetchedResults<CDUser>
    //@FetchRequest(sortDescriptors: []) var cdFriends: FetchedResults<CDFriend>
    
    //@State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cdUsers) { user in
                    NavigationLink {
                        ScrollView {
                            VStack(alignment: .leading) {
                                Text("Age: \(user.age)")
                                    .padding(.vertical, 5)

                                Text("Active: \(user.isActive ? "Yes" : "No")")
                                    .padding(.vertical, 5)

//                                Text("Company: \(user.company)")
//                                    .padding(.vertical, 5)
//
//                                Text("E-mail: \(user.email)")
//                                    .padding(.vertical, 5)
//
//                                Text("Address: \(user.address)")
//                                    .padding(.vertical, 5)
//
//                                Text("About: \(user.about)")
//                                    .padding(.vertical, 5)

                                Text("Friends:")
                                    .font(.headline)
                                    .padding(.vertical, 5)

//                                ForEach(user.friends) { friend in
//                                    Text(friend.name)
//                                        .padding(.vertical, 1)
//                                }
                            }
                            .padding(.horizontal)
                        }
                        .navigationTitle(user.name ?? "Unknown")
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.name ?? "Unknown")
                                .font(.headline)
//                            Text("Company: \(user.company)")
//                                .font(.caption)
//                            Text("Age: \(user.age)")
//                                .font(.caption)
//                            Text("Number of Friends: \(user.friends.count)")
//                                .font(.caption)
                        }
                    }
                }

            }
            .navigationTitle("User List")
        }
        .task {
            await loadUserData()
        }
    }
    
    
        
    func loadUserData() async {
        
        // Prepare a URLRequest to send our encoded data as JSON
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        // Run the request nd process the response
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Handle the result here - attempt to unwrap optional data provied by task
            guard let unwrappedData = data else {
                
                // Sjow the error message
                print("No data in response: \(error?.localizedDescription ?? "Unknown Error")")
                
                return
            }
            
            // Now decode from JSON directly into Core Data managed objects
            // Do this on a background thread to avoid concurrency issues
            // SEE: https://stackoverflow.com/questions/49454965/how-to-save-to-managed-object-context-in-a-background-thread-in-core-data
            // SEE: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/Concurrency.html
            let parent = PersistenceController.shared.container.viewContext
            let childContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            childContext.parent = parent
            
            // Set merge policy for this context (so friends that exist on multiple users don't cause conflicts, for example)
            // Set the merge policy for duplicate entries – ensure that duplicate entries get merged into a single unique record
            // "To help resolve this, Core Data gives us constraints: we can make one attribute constrained so that it must always be unique. We can then go ahead and make as many objects as we want, unique or otherwise, but as soon as we ask Core Data to save those objects it will resolve duplicates so that only one piece of data gets written."
            childContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            childContext.performAndWait {
                
                // Decode directly into Core Data objects
                let decoder = JSONDecoder(context: childContext)
                if let decodedData = try? decoder.decode([CDUser].self, from: unwrappedData) {
                    print("There were \(decodedData.count) users placed into Core Data")
                } else {
                    print("Could not decode from JSON into Core Data")
                }
                
                // Required to actually write the changes to Core Data
                do {
                    // Save Core Data objects
                    try childContext.save()
                    
                } catch {
                    fatalError("Failure to save context: \(error)")
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
