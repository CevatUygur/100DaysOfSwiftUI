//
//  ProspectsView.swift
//  HotProspects
//
//  Created by CEVAT UYGUR on 7.04.2022.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var prospectsArray = [Prospect]()
    
    @State private var isShowingScanner = false
    @State private var showingConfirmation = false
    @State private var sortedByName = false
    @State private var sortedByEmail = false
    
    let filter: FilterType
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sortedProspects(prospectsArray)) { prospect in
                    VStack(alignment: .leading) {
                        HStack {
                            if prospect.isContacted {
                                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "person.crop.circle.badge.xmark")
                                    .foregroundColor(.blue)
                            }
                            VStack(alignment: .leading){
                                Text(prospect.name)
                                    .font(.headline)
                                Text(prospect.emailAddress)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 5)
                        }
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toogle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toogle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarItems(leading: Button {
                showingConfirmation = true
            } label: {
                Label("Sort", systemImage: "arrow.up.arrow.down.square")
            }, trailing: Button {
                isShowingScanner = true
            } label: {
                Label("Scan", systemImage: "qrcode.viewfinder")
            })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Cevat Uygur\ncevatugur@gmail.com", completion: handleScan)
            }
            .confirmationDialog("Sort", isPresented: $showingConfirmation) {
                Button("Name") { sortedByName = true; sortedByEmail = false }
                Button("Email") { sortedByEmail = true; sortedByName = false }
            } message: {
                Text("Sort by...")
            }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontated people"
        }
    }
    
    var filteredProspects : [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    func sortedProspects(_ array: [Prospect]) -> [Prospect] {
        var array = prospectsArray
        if sortedByName {
            array = filteredProspects.sorted {$0.name < $1.name}
            return array
        } else if sortedByEmail {
            array = filteredProspects.sorted {$0.emailAddress < $1.emailAddress}
            return array
        } else {
            array = filteredProspects
            return array
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.add(person)
        
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            // for testing in simulator comment the above line and uncomment the below line
            // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D ohh!")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
