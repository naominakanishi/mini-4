import SwiftUI
import AcademyUI
import Academy

struct HomeView: View {
    @StateObject
    var viewModel: HomeViewModel = .init()
    
    @State var showHelpListView: Bool = false
    @State var showAcademyPeopleView: Bool = false
    @State var showEquipmentList: Bool = false
    @State var showSuggestionsBoxView: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(2)
                            .frame(width: 170)
                        
                        Spacer()
                        
                        NavigationLink {
                            ProfileView(viewModel: .init())
                        } label: {
                            ProfilePictureView(imageUrl: $viewModel.userImageUrl, size: 60)
                        }
                    }
                    .padding(.vertical, DesignSystem.Spacing.titleToContentPadding)
                    
                    announcementsView
                    eventListView
                    shortcutsView
                    
                }
                .padding(.horizontal, DesignSystem.Spacing.generalHPadding)
                Spacer()
            }
            .background(Color.adaBackground)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("")
        }
    }
    
    
    @ViewBuilder
    private var announcementsView: some View {
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
                                text: announcement.headline ?? announcement.text.prefix(100) + "...",
                                user: announcement.fromUser,
                                dateString: announcement.createdDate.getFormattedDate(),
                                type: (announcement.type ?? .announcement).rawValue)
                            
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
    }
    
    @ViewBuilder
    private var eventListView: some View {
        MonthView(month: viewModel.todayEvents) {
            NavigationLink("ver mais") {
                CalendarEventListView()
            }
        }
    }
    
    @ViewBuilder
    private var shortcutsView: some View {
        VStack (alignment: .leading) {
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
                        HelpListView()
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
                        EquipmentListView()
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
