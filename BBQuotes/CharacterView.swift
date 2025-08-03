import SwiftUI

struct CharacterView: View {

    let character: Char
    let show: String

    var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ZStack(alignment: .top) {

                    // Background image
                    Image(show.removeCaseAndSpaces())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .ignoresSafeArea()
                        .blur(radius: 10)
                        .overlay(Color.black.opacity(0.5))
                        .ignoresSafeArea()

                    // Foreground content
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 30) {

                            // Character image carousel
                            TabView {
                                ForEach(character.images, id: \.self) { charUrl in
                                    AsyncImage(url: charUrl) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: geo.size.width / 1.2, height: geo.size.height / 1.8)
                                            .cornerRadius(30)
                                            .shadow(radius: 10)
                                            .padding()
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: geo.size.width / 1.2, height: geo.size.height / 1.8)
                                    }
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                            .frame(width: geo.size.width, height: geo.size.height / 1.8)
                            .padding(.top, 60)

                            // Info Section
                            VStack(alignment: .leading, spacing: 12) {
                                Text(character.name)
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.white)

                                Text("Portrayed By: \(character.portrayedBy)")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.85))

                                Divider().background(Color.white.opacity(0.3))

                                Text("\(character.name) Character Info")
                                    .font(.title2.bold())
                                    .foregroundColor(.white)

                                Text("Born: \(character.birthday)")
                                    .foregroundColor(.white)

                                Divider().background(Color.white.opacity(0.3))

                                Text("Occupations:")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)

                                ForEach(character.occupations, id: \.self) { occ in
                                    Text("• \(occ)")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.85))
                                }

                                Divider().background(Color.white.opacity(0.3))

                                Text("Nicknames:")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)

                                if character.aliases.isEmpty {
                                    Text("None")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.7))
                                } else {
                                    ForEach(character.aliases, id: \.self) { alias in
                                        Text("• \(alias)")
                                            .font(.subheadline)
                                            .foregroundColor(.white.opacity(0.85))
                                    }
                                }

                                Divider().background(Color.white.opacity(0.3))

                                // Death Details
                                DisclosureGroup("Status (spoiler alert!)") {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(character.status)
                                            .font(.title3.bold())
                                            .foregroundColor(.white)

                                        if let death = character.death {
                                            AsyncImage(url: death.image) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .clipShape(.rect(cornerRadius: 30))
                                                    .shadow(radius: 6)
                                                    .padding(.top, 10)
                                                    .onAppear {
                                                        withAnimation {
                                                            proxy.scrollTo(1, anchor: .bottom)
                                                        }
                                                    }
                                            } placeholder: {
                                                ProgressView()
                                            }

                                            Text("How: \(death.details)")
                                                .foregroundColor(.white.opacity(0.9))

                                            Text("Last Words: \"\(death.lastWords)\"")
                                                .italic()
                                                .foregroundColor(.white.opacity(0.8))
                                        }
                                    }
                                }
                                .tint(.white)
                                .font(.headline)
                            }
                            .padding()
                            .background(.ultraThinMaterial.opacity(0.7))
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .padding(.horizontal)
                            .id(1)
                            .padding(.bottom, 80)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: Constants.bbName)
        .preferredColorScheme(.dark)
}
