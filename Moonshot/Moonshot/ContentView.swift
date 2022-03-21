//
//  ContentView.swift
//  Moonshot2
//
//  Created by CEVAT UYGUR on 13.03.2022.
//

import SwiftUI

struct GridLayout: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions){ mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()

                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )

                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct ListLayout: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                ForEach(missions){ mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        HStack{
                            Spacer()
                            
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(.vertical, 5)
                            
                            Spacer()
                            
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                                .frame(width: 100)
                            
                            Spacer()
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                        .background(.lightBackground)
                    }
                }
            }
        }
    }
}


struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid = false

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                Group {
                    if showingGrid {
                        GridLayout()
                        //GridLayout(astronauts: astronauts, missions: missions)
                    } else {
                        ListLayout()
                        //ListLayout(astronauts: astronauts, missions: missions)
                    }
                }
//                LazyVGrid(columns: columns) {
//                    ForEach(missions){ mission in
//                        NavigationLink {
//                            MissionView(mission: mission, astronauts: astronauts)
//                        } label: {
//                            VStack {
//                                Image(mission.image)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 100, height: 100)
//                                    .padding()
//
//                                VStack {
//                                    Text(mission.displayName)
//                                        .font(.headline)
//                                        .foregroundColor(.white)
//                                    Text(mission.formattedLaunchDate)
//                                        .font(.caption)
//                                        .foregroundColor(.white.opacity(0.5))
//                                }
//                                .padding(.vertical)
//                                .frame(maxWidth: .infinity)
//                                .background(.lightBackground)
//                            }
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(.lightBackground)
//                            )
//
//                        }
//                    }
//                }
//                .padding([.horizontal, .bottom])
            }

            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar(){
                Button(showingGrid ? "Tap for List Layout" : "Tap for Grid Layout"){
                    showingGrid.toggle()
                }
                .foregroundColor(.primary)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
