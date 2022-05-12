import SwiftUI
import AcademyUI

struct HomeView: View {
    @State var showHelpListView: Bool = false
    
    var body: some View {
        NavigationView {
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
                        }
                        
                        // TO DO: Announcement List
                    }
                    .padding(.vertical, 32)
                    
                    Divider()
                        .background(Color.white)
                    
                    VStack {
                        HStack {
                            VStack {
                                FeatureCard(title: "pessoas na academy", maxHeight: 120, color: Color.adaPink) {
                                    
                                }
                                
                                FeatureCard(title: "agenda", maxHeight: 120, color: Color.adaLightBlue) {
                                    
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
                                
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding()
                
                Spacer()
                
                NavigationLink("", destination: HelpListView(), isActive: $showHelpListView)
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
    }
}
