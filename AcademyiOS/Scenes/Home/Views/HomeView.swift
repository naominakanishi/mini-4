import SwiftUI
import AcademyUI
import Academy

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel(
        announcementUpdatingService: .init(),
        announcementListenerService: .init()
    )
    
    @EnvironmentObject var authService: AuthService
    
    @State var showHelpListView: Bool = false
    @State var showAcademyPeopleView: Bool = false
    @State var showEquipmentList: Bool = false
    @State var showSuggestionsBoxView: Bool = false
    
    func logout() {
        authService.signOut { result in
            // TO DO
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        HStack {
                            Text("Academy Pocket")
                                .font(.system(size: 30, weight: .bold, design: .default))
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            ZStack {
                                Circle()
                                    .foregroundColor(Color.adaLightBlue)
                                Image("andre-memoji")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(2)
                            }
                            .frame(maxWidth: 60, maxHeight: 60)
                            .onTapGesture {
                                logout()
                            }
                        }
                        
                        VStack {
                            HStack {
                                Text("Avisos")
                                    .font(.system(size: 24, weight: .bold, design: .default))
                                    .foregroundColor(Color.white)
                                
                                Spacer()
                                
                                NavigationLink {
                                    AnnouncementListView(viewModel: .init(listener: .init()))
                                } label: {
                                    Text("ver mais")
                                }

                            }
                            
                            if viewModel.activeAnnouncements.count > 0 {
                                TabView {
                                    ForEach(viewModel.activeAnnouncements) { announcement in
                                        VStack {
                                            AnnouncementCard(
                                                text: announcement.text,
                                                user: announcement.fromUser,
                                                dateString: announcement.createdDate.getFormattedDate()
                                            )
                                            Spacer()
                                                .frame(height: 40)
                                        }
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.95, height: 130)
                                .tabViewStyle(.page)
//
                            } else {
                                VStack {
                                    Text("Nenhum aviso importante hoje... 😴")
                                        .padding()
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                }
                                .frame(maxWidth: .infinity)
                                .background(Color.adaDarkGray)
                                .cornerRadius(8)
                            }
                        }
//                        .padding(.vertical, 32)
                        
                        HStack {
                            VStack {
                                ShortcutCard(title: "mentores", image: Image("people-icon"), color: Color.adaGreen.opacity(0.6))
                                    .padding(.vertical, 4)
                                ShortcutCard(title: "sugestoes", image: Image("suggestions-icon"), color: Color.adaPurple.opacity(0.6))
                                    .padding(.vertical, 4)
                                ShortcutCard(title: "learning\njourney", image: Image("learningJourney-icon"), color: Color.adaPink.opacity(0.6))
                                    .padding(.vertical, 4)
                            }
                            VStack {
                                ShortcutCard(title: "@ajuda", image: Image("help-icon"), color: Color.adaLightBlue.opacity(0.6))
                                    .scaledToFill()
                                    .padding(.vertical, 4)
                                ShortcutCard(title: "equipamentos", image: Image("equipments-icon"), color: Color.adaPurple.opacity(0.6))
                                    .padding(.vertical, 4)
                            }
                        }
                    }
                    .padding()
                    Spacer()
                    
                }
            }
           
            .background(Color.adaBackground)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("")
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}

extension Color {
    var homeCardGradient: LinearGradient {
        .init(colors: .init(repeating: self, count: 1) + [.clear],
              startPoint: .topLeading,
              endPoint: .bottomTrailing)
    }
}

extension Color {
    var strokeHomeCardGradient: LinearGradient {
        .init(colors: .init(repeating: self, count: 1) + [.clear],
              startPoint: .topLeading,
              endPoint: .bottomTrailing)
    }
}

struct ShortcutCard: View {
    let title: String
    let image: Image
    let color: Color
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 27)
            }
            Spacer()
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 32)
                Spacer()
            }
        }
        .padding()
        .background(color.adaGradient(repeatCount: 1))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color.reversedAdaGradient(repeatCount: 3), lineWidth: 1)
        )
    }
}
