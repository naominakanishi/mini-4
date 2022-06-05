import SwiftUI
import Academy
import AcademyUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("🚨 Avisos")
                        .foregroundColor(.black)
                        .font(.title2)
                        .bold()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(viewModel.announcementList, id: \.self) { announcement in
                                AnnouncementCard(
                                    text: announcement.text,
                                    user: announcement.fromUser,
                                    dateString: announcement.createdDate.formatted(),
                                    type: announcement.type?.rawValue ?? "Aviso",
                                    titleFont: .cardTitle,
                                    contentFont: .cardText
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal, 32)
            }
            .frame(maxWidth: UIScreen.main.bounds.width / 3)
            .background(Color.white)
            
            VStack {
                Text("Calendário")
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 2 / 3)
            .frame(height: UIScreen.main.bounds.height)
            .background(Color.black)
            
        }
        .onAppear {
            viewModel.onAppear()
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
