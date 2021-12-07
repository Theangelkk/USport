//
//  Profile.swift
//  USport
//
//  Created by Raffaele Calcagno on 05/12/21.
//

import SwiftUI
import UIKit
import AssetsLibrary

struct Profile: View {
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    
    @EnvironmentObject var UserAPP : User
    
    @State var dateOfBirth = Date()
    @State var sex = ["Male", "Female", "Unknown"]
    @State var workout = 3
    @State var weight = 0
    @State var height = 0
    @State var sexSelected = 0
    @State var shouldActivateNotifications = false
    
    var body: some View {
        
        GeometryReader
        {
            geometry in
            
            VStack{
                 VStack {
                Button(action: {
                    self.isShowPhotoLibrary = true
                    
                })
                {  //Ricordiamoci di caricare l'immagine!!!
                    Image("profile_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/2.5, height: geometry.size.height/3)
                        .background(Color.white.opacity(0.0))
                } .background(Color.white.opacity(0.0))
                    
                Text("Nickname")
                         .font(.system(size: 30, weight: .bold, design: .serif))
                         .italic()
                    
                }
                Form
                {
                    
                    
                    Section(header: Text(""))
                    {
                        DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                        
                        Picker(selection: $sexSelected, label: Text("Sex"))
                                {
                                    ForEach(0 ..< sex.count)
                                    {
                                        Text(self.sex[$0])
                                    } .foregroundColor(.blue)
                                }
                        Toggle("Notifications", isOn: $shouldActivateNotifications)
                            .toggleStyle(SwitchToggleStyle(tint: .green))
                        HStack
                        {
                            Text("Workout")
                            Spacer()
                            //Workout è impostato a 3 solo per motivi di corretta visualizzazione, il numero reale è derivato da n_workouts di AddWorkout.swift //
                            Text("\(workout)")
                            Spacer()
                        }
                        HStack
                        {
                            Text("Weight")
                            Spacer()
                            //Workout è impostato a 3 solo per motivi di corretta visualizzazione, il numero reale è derivato da n_workouts di AddWorkout.swift //
                            Text("\(weight)Kg")
                            Spacer()
                        }
                        HStack
                        {
                            Text("Height")
                            Spacer()
                            //Workout è impostato a 3 solo per motivi di corretta visualizzazione, il numero reale è derivato da n_workouts di AddWorkout.swift //
                            Text("\(height)cm")
                            Spacer()
                        }
                        
                    } .foregroundColor(.black)
                }
            }
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image) }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
 
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
 
        return imagePicker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
 
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        var parent: ImagePicker
     
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
     
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
                /*
                let imageSaver = ImageSaver()
                   imageSaver.writeToPhotoAlbum(image: image)
                 */
            }
     
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

/*
class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
        
        
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
*/
