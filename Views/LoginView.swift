import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var shouldNavigateToHome = false
    @State private var shouldNavigateToSignup = false
    @StateObject private var cart = Cart()

    private var homeViewModel: HomeViewModel {
        HomeViewModel(cart: cart)
    }

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                // App logo or title
                Text("Kai")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 50)

                // Email field
                TextField("Email", text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.4), lineWidth: 1))
                    .padding(.horizontal)

                // Password field
                SecureField("Password", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.4), lineWidth: 1))
                    .padding(.horizontal)
                    .padding(.top, 10)

                // Login button
                Button(action: {
                    authenticationViewModel.login(email: email, password: password)
                }) {
                    Text("Login")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                .padding(.horizontal)

                // Error message
                if let errorMessage = authenticationViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                // Sign up navigation
                Button(action: {
                    shouldNavigateToSignup = true
                }) {
                    Text("Don't have an account? Sign up")
                        .foregroundColor(.blue)
                        .padding()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Login")
            .sheet(isPresented: $shouldNavigateToSignup) {
                SignupView()
            }
            .onAppear {
                authenticationViewModel.onLoginSuccess = {
                    self.shouldNavigateToHome = true
                }
            }
            .fullScreenCover(isPresented: $shouldNavigateToHome) {
                HomeView(viewModel: homeViewModel)
            }
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
