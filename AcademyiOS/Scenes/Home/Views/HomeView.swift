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
                        
                        VStack {
                            HStack {
                                VStack {
                                    NavigationLink {
                                        AcademyPeopleView()
                                    } label: {
                                        FeatureCard(title: "mentores", maxHeight: 200, color: Color.adaGreen) {
                                        }
                                    }
                                    
                                    NavigationLink {
                                        EquipmentListView(currentUser: authService.user)
                                    } label: {
                                        FeatureCard(title: "equipamentos", maxHeight: 200, color: Color.adaPurple) {
                                        }
                                    }

                                }
                                
                                NavigationLink {
                                    HelpListView(currentUser: authService.user)
                                } label: {
                                    FeatureCard(title: "@ajuda", maxHeight: 412, color: Color.adaLightBlue) {
                                    }
                                }
                                
                                
                            }
                            HStack {
                                
                                FeatureCard(title: "learning journey", maxHeight: 200, color: Color.adaPink) {
                                    
                                }
                                
                                NavigationLink {
                                    SuggestionsBoxView()
                                } label: {
                                    FeatureCard(title: "caixinha de \nsugestões", maxHeight: 200, color: Color.adaPurple) {
                                    }
                                }
                                
                            }
                        }
                        .padding(.vertical)
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

struct FeatureCard: View {
    var title: String
    var maxHeight: CGFloat
    var color: Color
    var onTap: () -> ()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(color.homeCardGradient)
                .opacity(0.6)
            
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Text(title)
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 32)
                    Spacer()
                }
                .padding()
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color, lineWidth: 1)
        )
        .padding(4)
        .frame(maxHeight: maxHeight)
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
