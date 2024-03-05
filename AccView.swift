import SwiftUI

struct AccView: View {
    @StateObject private var viewModel: AccViewModel = .init()
    @Environment(\.presentationMode) var closeView

    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.profile, .profile2]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            closeView.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()

                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 4)
                            .frame(width: 324, height: 255)
                            .padding()
                            .overlay(
                                ZStack {
                                    if let dataImage = viewModel.image, let uiImage = UIImage(data: dataImage) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 170, height: 170)
                                            .foregroundColor(.white)
                                            .clipShape(Circle())
                                    } else {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .foregroundColor(.black)
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(.white)
                                            .frame(width: 159, height: 162)
                                            .padding(.top, 20)
                                    }
                                }
                            )
                            .onTapGesture {
                                viewModel.checkPermissions()
                            }
                    }

                    Spacer()

                    TextField("Username", text: $viewModel.userName)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding()
                        .frame(width: 297, height: 38)
                        .background(
                            RoundedRectangle(cornerRadius: 0)
                                .strokeBorder(Color.black, lineWidth: 2)
                                .frame(width: 297, height: 38)
                        )
                    
                    HStack{
                        
                        Text ("Age:")
                            .padding(.trailing)
                            .font(.custom("You2013", size: 20))
                            .foregroundColor(.white)

                            
                    }
                    
                    TextField("User age", text: .init(get: { String(viewModel.age) }, set: { viewModel.age = Int($0) ?? 18 }))
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding()
                        .frame(width: 297, height: 38)
                        .background(
                            RoundedRectangle(cornerRadius: 0)
                                .strokeBorder(Color.black, lineWidth: 2)
                                .frame(width: 297, height: 38)
                        )

                    Spacer()

                    HStack {
                        Spacer()
                        Image(systemName: "message")
                            .resizable()
                            .frame(width: 200, height: 100)
                            .overlay(
                                ZStack {
                                    Text(viewModel.greeting)
                                        .frame(width: 180, height: 80)
                                        .font(.custom("You2013", size: 18))
                                        .foregroundColor(.white)
                                }
                            )
                    }

                    HStack {
                        Image("helper1")
                            .resizable()
                            .frame(width: 120, height: 150)
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isPicker) {
            ImagePicker(image: $viewModel.image)
        }
    }
}

#Preview {
    AccView()
}
