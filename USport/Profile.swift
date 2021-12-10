//
//  Profile.swift
//  USport
//
//  Created by Raffaele Calcagno on 05/12/21.
//

import SwiftUI
import UIKit
import AssetsLibrary

struct Profile: View
{
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var managerUser : ManagerUser
    
    //@State private var isShowPhotoLibrary = false
    //@State private var image = UIImage()
     
    @State var workouts : [Workout] = []
    
    @State var sex = ["Male", "Female"]
    @State var workout : Int = 0
    @State var weight : String = ""
    @State var height : String = ""
    
    @State var sexSelected = 0
    @State var shouldActivateNotifications = false
    
    @State var firstTime : Bool = true
    
    
    var body: some View {
        
        NavigationView
        {
            GeometryReader
            {
                // Mettere un immagine di sfondo
                
                geometry in
                
                VStack
                {
                    /*
                    VStack
                    {
                        Button(action: {
                            self.isShowPhotoLibrary = true
                            
                        })
                        {  //Ricordiamoci di caricare l'immagine!!!
                            Image("profile_icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/2.5, height: geometry.size.height/3)
                                .background(Color.white.opacity(0.0))
                        } .background(Color.white.opacity(0.0)
                    }
                    */
                    Form
                    {
                        Section(header: Text(""))
                        {
                            Picker(selection: $sexSelected, label: Text("Sex"))
                            {
                                    ForEach(0..<sex.count)
                                    {
                                        Text(self.sex[$0])
                                    }
                                    .foregroundColor(.blue)
                            }.onChange(of: self.sexSelected, perform:{ (value) in
                                save_changes()
                            })
                            
                            TextField_Elem_Profile(name_image: "weight", init_text: weight, text: $weight, geometry: geometry).onChange(of: self.weight, perform:{ (value) in
                                save_changes()
                            })
                            
        
                            TextField_Elem_Profile(name_image: "height", init_text: height, text: $height, geometry: geometry).onChange(of: self.height, perform:{ (value) in
                                save_changes()
                            })
                            
                            NavigationLink(destination: AddWorkout_Profile(type_sport: managerUser.UserAPP.workouts[0].Type_of_Sport)
                                            .environmentObject(managerUser))
                            {
                                Text("Workouts")
                            }.onChange(of: self.workouts, perform:{ (value) in
                                save_changes()
                            })
                            
                            Toggle("Notifications", isOn: $shouldActivateNotifications)
                                .toggleStyle(SwitchToggleStyle(tint: .green))
                            
                        }
                        .foregroundColor(.black)
                        .onChange(of: self.shouldActivateNotifications, perform:{ (value) in
                            save_changes()
                        })
                    }
                }
                .navigationBarTitle("Profile", displayMode: .inline)
            }
            .onAppear
            {
                self.load()
            }
        }
    }
    
    
    func save_changes()
    {
        self.saveData()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    
    func load()
    {
        workout = managerUser.UserAPP.workouts.count
        weight = String(managerUser.UserAPP.weight)
        height = String(managerUser.UserAPP.height)
        
        for i in 0..<sex.count
        {
            if managerUser.UserAPP.gender == sex[i]
            {
                sexSelected = i
            }
        }
        
        if self.firstTime
        {
            self.workouts = managerUser.UserAPP.workouts
            self.firstTime = false
        }
            
        managerUser.UserAPP.workouts = self.workouts
        
    }
    
    func saveData()
    {
        let float_weight : Float = Float(self.weight) ?? 0.0
        let int_height : Int = Int(self.height) ?? 0
                
        if(int_height > 0 && int_height < 270 && float_weight > 0.0 && float_weight < 250.0)
        {
            let int_n_workouts : Int = managerUser.UserAPP.workouts.count
                    
            if(int_n_workouts > 0 && int_n_workouts < 8)
            {
                managerUser.UserAPP.set_weight(weight: float_weight)
                managerUser.UserAPP.set_height(height: int_height)
                
                managerUser.UserAPP.set_gender(idx: sexSelected)
                
                managerUser.UserAPP.workouts = self.workouts
        
                //USportApp.UserAPP!.set_type_of_activity(idx: idx_activity)
                
                UserCoreData.save_user_on_CoreData(user: managerUser.UserAPP, delete_old: true)
            }
        }
    }
}

struct TextField_Elem_Profile: View
{
    var name_image : String
    var init_text : String
    @Binding var text : String
    
    var geometry : GeometryProxy
    
    var body: some View
    {
        HStack (alignment: .center, spacing: 15)
        {
            Image_t(Image_name: name_image)
            
            TextField (init_text, text: $text)
                .font(.system(size: 17))
        }
        .padding(.vertical, 5.0)
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View
    {
        Profile()
    }
}

/*
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

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
        
        
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
*/
