import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "tortoise"
    let icons = ["tortoise", "briefcase","car"]
     
    var body: some View {
        ZStack(alignment: .bottom) {
            // Main content area
            Group {
                switch selectedTab {
                case "tortoise":
                    FetchView(show: Constants.bbName)
                case "briefcase":
                    FetchView(show: Constants.bcsName)
                case "car":
                    FetchView(show: Constants.ecName)
                default:
                    Text("Unknown")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)

            // Custom Tab Bar
            HStack {
                ForEach(icons, id: \.self) { icon in
                    Spacer()
                    Button {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                            selectedTab = icon
                        }
                    } label: {
                        Image(systemName: icon)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(selectedTab == icon ? .white : .gray)
                            .padding()
                            .background(
                                Circle()
                                    .fill(selectedTab == icon ? Color.blue : Color.clear)
                                    .scaleEffect(selectedTab == icon ? 1.2 : 1.0)
                            )
                            .shadow(color: selectedTab == icon ? Color.blue.opacity(0.3) : .clear, radius: 10, x: 0, y: 5)
                    }
                    Spacer()
                }
            }
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white)
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: -2)
            )
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}
