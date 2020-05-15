import SwiftUI

struct ContentView: View {
    var body: some View {
        Player().frame(width: nil, height: 200, alignment: .center)
    }
}

private struct Player: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<Player>) -> PlaybackViewController {
        let controller = PlaybackViewController()
        return controller
    }

    func updateUIViewController(_ uiViewController: PlaybackViewController, context: UIViewControllerRepresentableContext<Player>) {}
}

class PlaybackViewController: UIViewController {
    let mediaURL = "rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov"

    var mediaPlayer = VLCMediaPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMediaPLayer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mediaPlayer.play()
    }

    func setupMediaPLayer() {
        mediaPlayer.delegate = self
        mediaPlayer.drawable = view
        mediaPlayer.media = VLCMedia(url: URL(string: mediaURL)!)
    }
}

extension PlaybackViewController: VLCMediaPlayerDelegate {
    func mediaPlayerStateChanged(_ aNotification: Notification!) {
        if mediaPlayer.state == .stopped {
            dismiss(animated: true, completion: nil)
        }
    }
}
