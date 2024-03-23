////
////  AddNoteView.swift
////  Mobilicius
////
////  Created by Vaibhav  Tiwary on 23/03/24.
////
//
//import Foundation
//import UIKit
//import SwiftUI
//struct AddNoteView: View {
//    @Binding var notes: [Note]
//    @State private var title = ""
//    @State private var description = ""
//    @State private var images = [UIImage]()
//    @State private var showingImagePicker = false
//    
//    var body: some View {
//        Form {
//            TextField("Title", text: $title)
//                .padding()
//            TextField("Description", text: $description)
//                .padding()
//            
//            Button("Add Photo") {
//                showingImagePicker = true
//            }
//            .sheet(isPresented: $showingImagePicker) {
//                ImagePicker(image: $images.appendingNew())
//            }
//            
//            ForEach(images, id: \.self) { img in
//                Image(uiImage: img)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 200)
//            }
//            
//            Button("Save Note") {
//                let newNote = Note(title: title, description: description, photos: images)
//                notes.append(newNote)
//            }
//        }
//        .navigationTitle("Add Note")
//    }
//}
//
//extension Binding where Value == [UIImage] {
//    func appendingNew() -> Binding<UIImage?> {
//        .init(
//            get: { nil },
//            set: { newValue in
//                if let newValue = newValue {
//                    self.wrappedValue.append(newValue)
//                }
//            }
//        )
//    }
//}
