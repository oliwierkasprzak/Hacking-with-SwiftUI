//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Oliwier Kasprzak on 28/03/2023.
//

import CodeScanner
import UserNotifications
import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortType {
        case name, date
    }
    
    var filter: FilterType
    @State private var sort = SortType.date
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingFilter = false
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredPeople: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
        
    }
    
    var sortedPeople: [Prospect] {
        switch sort {
        case .name:
            return filteredPeople.sorted { $0.name < $1.name }
        case .date:
            return filteredPeople
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sortedPeople) { prospect in
                    HStack {
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        
                        Text(prospect.emailAddress)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            }
                        Spacer()
                        if prospect.isContacted {
                            Image(systemName: "person.fill.checkmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.green)
                        }
                    }
                   .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggleContacted(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage:  "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggleContacted(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage:  "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                        }
                        
                        Button {
                            addNotification(for: prospect)
                        } label: {
                            Label("Remind Me", systemImage: "bell")
                        }
                        .tint(.orange)
                    }
                }
                .confirmationDialog("Filter", isPresented: $isShowingFilter, titleVisibility: .visible) {
                    
                    Button("Name") {
                        sort = .name
                    }
                    
                    Button("Recent") {
                        sort = .date
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button {
                   isShowingScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
                
                Button {
                    isShowingFilter = true
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Oliwier Kasprzak\noliwier.kasprzak@icloud.com", completion: handleScanner)
            }
        }
    }
    
    func handleScanner(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
       
        switch result {
        case .success(let success):
            let details = success.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.add(person)
            
        case .failure(let failure):
            print("Scanning failed: \(failure.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = .default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
        }
        
        center.getNotificationSettings { setting in
            if setting.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("No authorization")
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
