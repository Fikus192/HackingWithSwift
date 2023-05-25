//
//  ContentView.swift
//  ChallengeDay_5
//
//  Created by Mateusz Ratajczak on 20/05/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var cachedUsers: FetchedResults<CachedUser>
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cachedUsers) { cachedUser in
                    NavigationLink {
                        DetailView(cachedUser: cachedUser)
                    } label: {
                        HStack {
                            Circle()
                                .fill(cachedUser.isActive ? .green : .red)
                                .frame(width: 20)
                            Text(cachedUser.wrappedName)
                                .font(.headline)
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        do {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            async let userItems = try await URLSession.shared.decode([User].self, from: url, dateDecodingStrategy: .iso8601)
            users = try await userItems
            
            await MainActor.run {
                for user in users {
                    let cachedUser = CachedUser(context: moc)
                    
                    cachedUser.id =         user.id
                    cachedUser.isActive =   user.isActive
                    cachedUser.name =       user.name
                    cachedUser.age =        Int16(user.age)
                    cachedUser.company =    user.company
                    cachedUser.email =      user.email
                    cachedUser.address =    user.address
                    cachedUser.about =      user.about
                    cachedUser.registered = user.registered
                    cachedUser.tags =       user.tags.joined(separator: ",")
                    
                    for friend in user.friends {
                        let cachedFriend = CachedFriend(context: moc)
                        
                        cachedFriend.id =   friend.id
                        cachedFriend.name = friend.name
                        cachedUser.addToFriend(cachedFriend)
                    }
                    
                    try? moc.save()
                }
            }
            
        } catch {
            print("Failed to load data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
