import SwiftUI
import Academy

final class LoadingViewModel: ObservableObject {
    
    private let authService = AuthService.shared
    
    @Published
    private(set) var authState: AuthState = .undefined
    
    init() {}
    
    func onAppear() {
        authService
            .authStatePublisher
            .assign(to: &$authState)
    }
}

struct LoadingView: View {
    @StateObject
    var viewModel = LoadingViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.authState {
            case .undefined:
                Loader()
            case .signedIn:
                HomeView(viewModel: .init())
            case .signedOut:
                LoginView()
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}
