//
//  ContentView.swift
//  JSONChallengeDay60
//
//  Created by CEVAT UYGUR on 20.03.2022.
//

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
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        ScrollView {
                            VStack(alignment: .leading) {
                                Text("Age: \(user.age)")
                                    .padding(.vertical, 5)
                                
                                Text("Active: \(user.isActive ? "Yes" : "No")")
                                    .padding(.vertical, 5)
                                
                                Text("Company: \(user.company)")
                                    .padding(.vertical, 5)
                                
                                Text("E-mail: \(user.email)")
                                    .padding(.vertical, 5)
                                
                                Text("Address: \(user.address)")
                                    .padding(.vertical, 5)
                                
                                Text("About: \(user.about)")
                                    .padding(.vertical, 5)
                                
                                Text("Friends:")
                                    .font(.headline)
                                    .padding(.vertical, 5)
                                
                                ForEach(user.friends) { friend in
                                    Text(friend.name)
                                        .padding(.vertical, 1)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .navigationTitle(user.name)
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text("Company: \(user.company)")
                                .font(.caption)
                            Text("Age: \(user.age)")
                                .font(.caption)
                            Text("Number of Friends: \(user.friends.count)")
                                .font(.caption)
                        }
                    }
                }
                
            }
            .navigationTitle("User List")
        }
        .task {
            if users.isEmpty {
                await loadUserData()
            }
        }
    }
        
    func loadUserData() async {
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                print("Invalid URL")
                return
            }

            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let userData = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown Error")")
                    return
                }

                let userDecoder = JSONDecoder()

                userDecoder.dateDecodingStrategy = .iso8601

                do {
                    users = try userDecoder.decode([User].self, from: userData)
                    //friends = try userDecoder.decode([Friend].self, from: userData)
                    return
                } catch {
                    print("Decoding Failed: \(error)")
                }

                print("Fetch Failed: \(error?.localizedDescription ?? "Unknown Error")")

            }.resume()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
