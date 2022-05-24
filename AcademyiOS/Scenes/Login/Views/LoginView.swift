import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var backgroundColor = Color(red: 23/255, green: 3/255, blue: 28/255)
    
    var body: some View {
        VStack {
            Spacer()
            Image("academyPocketLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 250)
            
            Spacer()
            
            SignInWithAppleView(loginViewModel: viewModel)
                .frame(maxHeight: 50)
                .frame(maxWidth: 50)
            
            Spacer()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
        .background(backgroundColor)
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
