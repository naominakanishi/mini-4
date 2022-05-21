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
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(2)
                                .frame(width: 170)
                            
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
                        .padding(.vertical, DesignSystem.Spacing.titleToContentPadding)
                        
                        VStack {
                            HStack {
                                Text("Avisos")
                                    .font(.adaFontSubtitle)
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
                                                dateString: announcement.createdDate.getFormattedDate(),
                                                type: (announcement.type ?? .announcement).rawValue
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
                        VStack (alignment: .leading){
                            
                            Text("Utilidades")
                                .font(.adaFontSubtitle)
                                .foregroundColor(Color.white)
                                .padding(DesignSystem.Spacing.subtitlesToContentPadding)
                                
                            HStack {
                                VStack {
                                    NavigationLink(destination: {
                                        AcademyPeopleView()
                                    }, label: {
                                        ShortcutCard(title: "mentores",
                                                     image: Image("people-icon"),
                                                     color: Color.adaRed.opacity(0.6)
                                        )
                                        .padding(.vertical, 4)
                                    })
                                    NavigationLink(destination: {
                                        SuggestionsBoxView()
                                    }, label: {
                                        ShortcutCard(title: "sugestoes",
                                                     image: Image("suggestions-icon"),
                                                     color: Color.adaLightBlue.opacity(0.6)
                                        )
                                        .padding(.vertical, 4)
                                    })
                                    Button {
                                        viewModel.openLearningJourney()
                                    } label: {
                                        ShortcutCard(title: "learning\njourney",
                                                     image: Image("learningJourney-icon"),
                                                     color: Color.adaDarkBlue.opacity(0.6)
                                        )
                                            .padding(.vertical, 4)
                                    }


                                }
                                VStack {
                                    NavigationLink {
                                        HelpListView(currentUser: authService.user)
                                    } label: {
                                        ShortcutCard(title: "@ajuda",
                                                     image: Image("help-icon"),
                                                     color: Color.adaPurple.opacity(0.6),
                                                     imageWidth: 60
                                        )
                                            .aspectRatio(1, contentMode: .fill)
                                            .padding(.vertical, 4)
                                    }

                                    NavigationLink {
                                        EquipmentListView(currentUser: authService.user)
                                    } label: {
                                        ShortcutCard(title: "equipamentos",
                                                     image: Image("equipments-icon"),
                                                     color: Color.adaGreen.opacity(0.6)
                                        )
                                            .padding(.vertical, 4)
                                    }
                                }
                            }
                        }
                        
                    }
                    .padding(.horizontal, DesignSystem.Spacing.generalHPadding)
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
    var imageWidth: CGFloat = 27
    
    var body: some View {
        HStack {
            VStack {
                Spacer()
                Text(title)
                    .font(.system(size: 15.5, weight: .bold, design: .default))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
            VStack {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageWidth)
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
