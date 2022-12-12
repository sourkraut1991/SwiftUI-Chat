//
//  ProfileView.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/10/22.
//

import SwiftUI

struct CreateProfileView: View {
    
    @Binding var currentStep: OnboardingStep
    
    @State var firstName = ""
    @State var lastName = ""
    
    //For Image Selector
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    
    @State var isSourceMenuShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    @State var isSaveButtonDisabled = false
    
    
    var body: some View {
        VStack {
            
            Text("Setup your profile")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Just a few more details to get started")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            Spacer()
            
            // MARK: Profile Pic
            
            // Profile image Button
            Button {
                
                // Show action sheet
                isSourceMenuShowing = true
                
            } label: {
                
                ZStack {
                    
                //Shows Image once selected
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                        
                    }
                    else {
                        
                        Circle()
                        .foregroundColor(.white)
                        
                        Image(systemName: "camera.fill")
                        .tint(Color("icons-input"))
                        }
                Circle()
                    .stroke(Color("create-profile-boarder"), lineWidth: 2)
            }
            .frame(width: 134, height: 134)
        }
        Spacer()
        
            // First name
            TextField("Given Name", text: $firstName)
                .textFieldStyle(CreateProfileTextfieldStyle())
                  
            // Last name
            TextField("Last Name", text: $lastName)
                .textFieldStyle(CreateProfileTextfieldStyle())
        
        Spacer()
        
        Button {
            // Prevent double taps
            isSaveButtonDisabled = true
            // Save the data
            DatabaseService().setUserProfile(firstName: firstName,
                                             lastName: lastName,
                                             image: selectedImage) { isSuccess in
                if isSuccess {
                    currentStep = .contacts
                }
                else {
                    // TODO: Show error message to the user
                }
                isSaveButtonDisabled = true
            }
            
        } label: {
            Text(isSaveButtonDisabled ? "Uploading" : "Save")
        }
        .buttonStyle(OnboardingButtonStyle())
        .disabled(isSaveButtonDisabled)
        .padding(.bottom, 82)
    }
        .padding(.horizontal)
        .confirmationDialog("From where?", isPresented: $isSourceMenuShowing, actions: {
            Button {
                // Set the source to photo library
                self.source = .photoLibrary
                
                // Show the image picker
                isPickerShowing = true
                
            } label: {
                Text("Photo Library")
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                Button {
                    // Set the source to camera
                    self.source = .camera
                    
                    // Show the image picker
                    isPickerShowing = true
                } label: {
                    Text("Take Photo")
                }
            }
        })
        .sheet(isPresented: $isPickerShowing) {
            
            // Show the image picker
            ImagePicker(selectedImage: $selectedImage,
                        isPickerShowing: $isPickerShowing, source: self.source)
        }
}
}

