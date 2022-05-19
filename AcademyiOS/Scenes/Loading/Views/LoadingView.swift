import SwiftUI
import Academy

struct LoadingView: View {
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        VStack {
            switch authService.authState {
            case .undefined:
                Loader()
            case .signedIn:
                HomeView()
            case .signedOut:
                LoginView()
            }
        }
        .onAppear {
            authService.initialize()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
