import SwiftUI
import AcademyUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel(
        announcementUpdatingService: .init(),
        announcementListenerService: .init()
    )
    
    @State var showHelpListView: Bool = false
    @State var showAcademyPeopleView: Bool = false
    @State var showEquipmentList: Bool = false
    @State var showSuggestionsBoxView: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        HStack {
                            Text("Apple Developer Academy")
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
                                            AnnouncementCard(text: announcement.text, username: announcement.fromUser?.name ?? "Binder", time: announcement.createdDate.getFormattedDate(), userImage: Image("andre-memoji"))
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
                        
                        Divider()
                            .background(Color.white)
                        
                        VStack {
                            HStack {
                                VStack {
                                    FeatureCard(title: "pessoas na academy", maxHeight: 120, color: Color.adaPink) {
                                        showAcademyPeopleView = true
                                    }
                                    
                                    FeatureCard(title: "equipamentos", maxHeight: 120, color: Color.adaLightBlue) {
                                        showEquipmentList = true
                                    }
                                }
                                
                                FeatureCard(title: "@ajuda", maxHeight: 252, color: Color.adaGreen) {
                                    showHelpListView = true
                                }
                            }
                            HStack {
                                FeatureCard(title: "learning journey", maxHeight: 120, color: Color.adaYellow) {
                                    
                                }
                                
                                FeatureCard(title: "caixinha de sugestões", maxHeight: 120, color: Color.adaPurple) {
                                    showSuggestionsBoxView = true
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    .padding()
                    
                    Spacer()
                    
                    NavigationLink("", destination: HelpListView(), isActive: $showHelpListView)
                    NavigationLink("", destination: AcademyPeopleView(), isActive: $showAcademyPeopleView)
                    NavigationLink("", destination: EquipmentListView(), isActive: $showEquipmentList)
                    NavigationLink("", destination: SuggestionsBoxView(), isActive: $showSuggestionsBoxView)
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
                .foregroundColor(color.opacity(0.1))
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Text(title)
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
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
        .onTapGesture {
            onTap()
        }
        .frame(maxHeight: maxHeight)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
