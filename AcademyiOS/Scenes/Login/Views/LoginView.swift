import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome, Academer!")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold, design: .default))
                .padding(.bottom)
            
            SignInWithAppleView(loginViewModel: viewModel)
                .frame(maxHeight: 50)
                .frame(maxWidth: 50)
            
            Spacer()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.adaBackground)
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
