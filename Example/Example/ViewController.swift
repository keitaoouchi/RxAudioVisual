import UIKit
import RxAudioVisual
import AVFoundation
import RxSwift

class ViewController: UIViewController {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var videoView: UIView!
  var debugger: AVDebugger!
  var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    searchBar.delegate = self
  }
}

extension ViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    view.endEditing(true)

    guard let text = searchBar.text, let url = URL(string: text) else { return }

    // dispose current subscribed disposables
    self.disposeBag = DisposeBag()

    let asset = AVAsset(url: url)
    let item = AVPlayerItem(asset: asset)
    let player = AVPlayer(playerItem: item)
    let layer = AVPlayerLayer(player: player)

    debugger = AVDebugger()
    debugger.debug(player: player)
    debugger.debug(asset: asset)
    debugger.debug(item: item)
    debugger.debug(layer: layer)

    // asynchronousely wait for .readyToPlay status, then play video
    player.rx.status.filter { $0 == .readyToPlay }.subscribe(onNext: { [weak self] _ in
      guard let `self` = self else { return }

      self.videoView.layer.sublayers?.forEach { subLayer in
        subLayer.removeFromSuperlayer()
      }

      layer.frame = self.videoView.bounds
      self.videoView.layer.addSublayer(layer)
      player.play()
    }).disposed(by: self.disposeBag)

    // infinite video playing
    item.rx.didPlayToEnd.subscribe(onNext: { _ in
      player.seek(to: kCMTimeZero)
      player.play()
    }).disposed(by: self.disposeBag)
  }
}
