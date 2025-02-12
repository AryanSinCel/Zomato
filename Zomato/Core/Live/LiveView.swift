//
//  LiveView.swift
//  Zomato
//
//  Created by Celestial on 21/01/25.
//

import SwiftUI
import AVKit

//MARK: Live View
struct LiveView: View {
    var body: some View {
        NavigationStack {
            NonBouncingScrollView{
                VStack {
                    // Navigation Bar
                    NavigationView()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .foregroundStyle(Color.white) // Set text color to white
                        .background(Color.black) // Set background to black
                    
                    // Video Loop
                    VideoLoopView(width: UIScreen.main.bounds.width, height: 500)
                        .frame(height: 300)
                        .padding(EdgeInsets(top: -10, leading: 0, bottom: 80, trailing: 0))
                    
                    // Event Text
                    Text("Feast mode on!")
                        .font(.title2)
                        .foregroundStyle(Color.white)
                    Text("Zomaland S5")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                    
                    // Book Now Button
                    
                    Button {
                        // Action for booking
                        
                    } label: {
                        Text("Book Now")
                            .font(.title2)
                            .fontWeight(.heavy)
                        Image(systemName: "chevron.down")
                    }
                    .tint(Color.white)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(Color(.systemGray4))
                    )
                    
                    Spacer()
                }
                .background(Color.black) // Set background color of the VStack to black
            }
            .background(Color.black.edgesIgnoringSafeArea(.top)) // Set safe area color to black
            .toolbarBackground(Color.black, for: .navigationBar) // Set navigation bar background to black
            .toolbarColorScheme(.dark, for: .navigationBar) // Use dark color scheme for navigation bar
        }
    }
}

//MARK: View Player
struct VideoLoopView: UIViewControllerRepresentable {
    var width: CGFloat
    var height: CGFloat
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let player = AVQueuePlayer()
        
        if let url = Bundle.main.url(forResource: "zomato_event", withExtension: "mp4") {
            let item = AVPlayerItem(url: url)
            let looper = AVPlayerLooper(player: player, templateItem: item)
            context.coordinator.looper = looper // Retain looper
        }
        
        player.isMuted = true // Mute the video
        player.play() // Start playback
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill // Adjust video scaling
        playerLayer.frame = CGRect(x: 0, y: 0, width: width, height: height) // Dynamic size
        viewController.view.layer.addSublayer(playerLayer)
        
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let playerLayer = uiViewController.view.layer.sublayers?.first(where: { $0 is AVPlayerLayer }) as? AVPlayerLayer {
            playerLayer.frame = CGRect(x: 0, y: 0, width: width, height: height) // Update size dynamically
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var looper: AVPlayerLooper?
    }
}

#Preview {
    LiveView()
}
