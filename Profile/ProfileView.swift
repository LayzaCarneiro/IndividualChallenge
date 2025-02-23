//
//  ProfileView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("username") var username: String = "Caterpillar 🐛"
    @AppStorage("firstLaunch") var firstLaunch: Bool = true
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showInputAlert = false
    @State private var showResetConfirm = false
    
    var body: some View {
        NavigationView {ZStack {
            Color("offWhite").edgesIgnoringSafeArea(.all)
            ScrollView {
                
                
                VStack {
                    Spacer().frame(maxHeight: 40)
                    
                    VStack {
                        ZStack {
                            Circle()
                                .frame(width: 110, height: 110)
                                .foregroundStyle(.blue)
                            Text(username.prefix(1))
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                    }
                    Text(username)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading) {
                        Section(header: Text("General Info").fontWeight(.semibold).font(.title2)) {
                            GroupBox {
                                HStack {
                                    Text("Username")
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                    
                                    TextField("Name", text: $username)
                                        .frame(maxWidth: 200)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                            .backgroundStyle(.gray.opacity(0.1))
                        }
                        
                        Spacer().frame(minHeight: 40, maxHeight: 50)
                        
                        Section(header: Text("Settings").fontWeight(.semibold).font(.title2)) {
                            GroupBox {
                                HStack {
                                    Text("Show Welcome Screen")
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Button {
                                        dismiss()
                                        firstLaunch = true
                                    } label: {
                                        Text("Show")
                                            .fontWeight(.semibold)
                                    }
                                }
                            }
                            .backgroundStyle(.gray.opacity(0.1))
                            
//                            GroupBox {
//                                HStack {
//                                    Text("Reset All Data")
//                                        .fontWeight(.semibold)
//                                    Spacer()
//                                    Button {
//                                        showResetConfirm.toggle()
//                                    } label: {
//                                        Text("Reset")
//                                            .fontWeight(.bold)
//                                            .foregroundStyle(.red)
//                                    }
//                                }
//                            }
//                            .backgroundStyle(.gray.opacity(0.1))
                        }
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    .alert(isPresented: $showInputAlert) {
                        Alert(title: Text("Invalid Input"), message: Text("Please enter a valid integer value."), dismissButton: .default(Text("OK")))
                    }
                    .alert(isPresented: $showResetConfirm) {
                        Alert(
                            title: Text("Reset Data"),
                            message: Text("Are you sure you want to reset all data? This action cannot be undone."),
                            primaryButton: .destructive(Text("Reset")) {
                                //                                    CoreDataStack.shared.resetAllCoreData()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    doneButton
                }
            }
        }
        }
        
    }
    
    private var doneButton: some View {
        Button("Done") {
            dismiss()
        }
    }
    
}

