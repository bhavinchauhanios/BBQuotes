import SwiftUI

struct EpisodeView: View {

    let episode: Episode
    @State private var imageLoaded = false

    var body: some View {
        ZStack {
            // Optional: blurred background layer
            Color.black.opacity(0.6)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                // Episode title
                Text(episode.title)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                Text(episode.seasonEpisode)
                    .font(.title3)
                    .foregroundStyle(.white.opacity(0.85))

                // Image with fade animation
                AsyncImage(url: episode.image) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 10)
                            .transition(.opacity.combined(with: .scale))
                            .onAppear {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    imageLoaded = true
                                }
                            }
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }

                Divider().background(Color.white.opacity(0.2))

                // Synopsis
                Text(episode.synopsis)
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.9))
                    .padding(.top, 4)

                // Metadata
                VStack(alignment: .leading, spacing: 6) {
                    LabeledText(label: "Written By:", value: episode.writtenBy)
                    LabeledText(label: "Directed By:", value: episode.directedBy)
                    LabeledText(label: "Aired:", value: episode.airDate)
                }
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.85))

            }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 6)
            .padding(.horizontal, 20)
            .padding(.vertical, 30)
        }
    }
}

// Helper view for label-value pairs
struct LabeledText: View {
    let label: String
    let value: String

    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .fontWeight(.semibold)
            Text(value)
        }
    }
}

#Preview {
    EpisodeView(episode: ViewModel().episode)
        .preferredColorScheme(.dark)
}
