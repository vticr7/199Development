
//import SwiftUI
//
//struct HomeView: View {
//    @State var showView: Bool = false
//
//    var body: some View {
//        VStack { // Use a VStack to vertically stack the ScrollView and the device info
//            ScrollView(.vertical, showsIndicators: false) {
//                if showView {
//                    
//                    Home()
//                        .transition(.scale.combined(with: .opacity))
//                }
//            }
//            .frame(maxWidth: .infinity)
//            .background {
//                GeometryReader { geometry in
//                    ZStack {
//                        
//                        Circle()
//                            .fill(LinearGradient(gradient: Gradient(colors: [Color("Green").opacity(0.7), Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                            .scaleEffect(0.6)
//                            .offset(x: geometry.size.width * 0.3, y: -geometry.size.height * 0.2)
//                            .blur(radius: 120)
//                            .rotationEffect(Angle(degrees: showView ? 0 : 360)) // Rotating animation
//                        
//                        Circle()
//                            .fill(LinearGradient(gradient: Gradient(colors: [Color("Red").opacity(0.7), Color.clear]), startPoint: .bottomTrailing, endPoint: .topLeading))
//                            .scaleEffect(0.6)
//                            .offset(x: -geometry.size.width * 0.3, y: geometry.size.height * 0.2)
//                            .blur(radius: 120)
//                            .rotationEffect(Angle(degrees: showView ? 360 : 0)) // Rotating animation
//
//                        Rectangle()
//                            .fill(.ultraThinMaterial)
//                    }
//                    .ignoresSafeArea()
//                    .animation(.easeInOut(duration: 1.5), value: showView)
//                }
//            }
//            
//            // Place your device information VStack here, after the ScrollView
//            VStack(alignment: .leading, spacing: 10) {
//                Text("Login Successful : \(UIDevice.current.model)")
//                
//            }
//            .padding()
//            .onAppear {
//                UIDevice.current.isBatteryMonitoringEnabled = true
//            }
//        }
//        .preferredColorScheme(.dark)
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                showView = true
//            }
//        }
//    }
//    
//    func getCameraDetails() -> String {
//        // Your logic to get camera details
//        return "12MP (Wide), f/1.6 aperture"
//    }
//}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
import SwiftUI

// Note model
import UIKit
import Firebase
struct Note: Identifiable, Equatable {
    let id: UUID = UUID()
    var title: String
    var description: String
    var photos: [UIImage] // Store photos as UIImage
}

// ImagePicker.swift
// Assuming the ImagePicker code you provided is already in your project

// HomeView
import SwiftUI

struct HomeView: View {
    @State private var notes = [Note]()
    @State private var showingAddNoteView = false
    @AppStorage("uid") var userID: String = "random" // Example user ID; use your own logic to manage this
    
    var body: some View {
        NavigationView {
            List(notes) { note in
                NavigationLink(destination: DetailsView(note: note)) {
                    NoteRow(note: note)
                }
            }
            .navigationTitle("Notes")
            .navigationBarItems(
                leading: Button(action: signOut) {
                    Text("Sign Out")
                        .foregroundColor(.red) // Customize to fit your app style
                },
                trailing: NavigationLink("Add Note", destination: AddNoteView(notes: $notes))
            )
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            withAnimation {
                userID = "" // Clearing userID on sign out
            }
            // Optionally, handle UI changes or navigation upon successful sign-out
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

struct NoteRow: View {
    var note: Note
    
    var body: some View {
        HStack {
            if let firstPhoto = note.photos.first {
                Image(uiImage: firstPhoto)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
            }
            VStack(alignment: .leading) {
                Text(note.title)
                    .font(.headline)
                Text(note.description)
                    .font(.subheadline)
                    .lineLimit(1)
            }
        }
    }
}

// DetailsView
//
//  AddNoteView.swift
//  Mobilicius
//
//  Created by Vaibhav  Tiwary on 23/03/24.
//

import Foundation
import UIKit
import SwiftUI
struct AddNoteView: View {
    @Binding var notes: [Note]
    @State private var title = ""
    @State private var description = ""
    @State private var images = [UIImage]()
    @State private var showingImagePicker = false
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
                .padding()
            TextField("Description", text: $description)
                .padding()
            
            Button("Add Photo") {
                showingImagePicker = true
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $images.appendingNew())
            }
            
            ForEach(images, id: \.self) { img in
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }
            
            Button("Save Note") {
                let newNote = Note(title: title, description: description, photos: images)
                notes.append(newNote)
            }
        }
        .navigationTitle("Add Note")
    }
}

extension Binding where Value == [UIImage] {
    func appendingNew() -> Binding<UIImage?> {
        .init(
            get: { nil },
            set: { newValue in
                if let newValue = newValue {
                    self.wrappedValue.append(newValue)
                }
            }
        )
    }
}


struct DetailsView: View {
    var note: Note
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                ForEach(note.photos, id: \.self) { photo in
                    Image(uiImage: photo)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                Text(note.title)
                    .font(.title)
                    .padding()
                Text(note.description)
                    .padding()
            }
        }
        .navigationTitle("Note Details")
    }
}// AddNoteView
// Assuming you've already implemented AddNoteView according to the previous instructions

// Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
