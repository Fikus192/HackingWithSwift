//
//  DetailView.swift
//  ChallengeDay_5
//
//  Created by Mateusz Ratajczak on 20/05/2023.
//

import SwiftUI

struct DetailView: View {
    let cachedUser: CachedUser
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .center) {
                    Text(cachedUser.wrappedName)
                        .font(.title)
                        .foregroundColor(.red)
                        .padding(5)
                }
                Divider()
                
                Group {
                    Section {
                        Text(cachedUser.wrappedID)
                            .padding(5)
                    } header: {
                        Text("ID:")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding(5)
                    }
                    
                    Section {
                        Text(cachedUser.isActive ? "Active" : "Non-Active")
                            .padding(5)
                    } header: {
                        Text("Is Active?:")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(5)
                    }
                    
                    Section {
                        Text("\(cachedUser.age) years")
                            .padding(5)
                    } header: {
                        Text("Age:")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(5)
                    }
                    
                    Section {
                        Text(cachedUser.wrappedCompany)
                            .padding(5)
                    } header: {
                        Text("Company:")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(5)
                    }
                    
                    Section {
                        Text(cachedUser.wrappedEmail)
                            .padding(5)
                    } header: {
                        Text("Email:")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(5)
                    }
                }
                
                Group {
                    Section {
                        Text(cachedUser.wrappedAddress)
                            .padding(5)
                    } header: {
                        Text("Address:")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(5)
                    }
                    
                    Section {
                        Text(cachedUser.wrappedAbout)
                            .padding(5)
                    } header: {
                        Text("About:")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(5)
                    }
                    
                    Section {
                        Text(cachedUser.wrappedRegistered.formatted(date: .abbreviated, time: .standard))
                            .padding(5)
                    } header: {
                        Text("Registered:")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(5)
                    }
                    
                    Section {
                        let tags = cachedUser.wrappedTags.components(separatedBy: ",")
                        ForEach(tags, id: \.self) { tag in
                            Text(tag)
                                .padding(5)
                        }
                    } header: {
                        Text("Tags:")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(5)
                    }
                    
                    Section {
                        ForEach(cachedUser.friendArray) { friend in
                            Text(friend.wrappedName)
                                .padding(5)
                        }
                    } header: {
                        Text("Friends:")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(5)
                    }
                }
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
