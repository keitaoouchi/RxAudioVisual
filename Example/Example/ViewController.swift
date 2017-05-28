import UIKit
import RxAudioVisual
import AVFoundation
import RxSwift

class ViewController: UIViewController {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var videoView: UIView!
  var gomibako = DisposeBag()

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
    self.gomibako = DisposeBag()

    let asset = AVAsset(url: url)
    let item = AVPlayerItem(asset: asset)
    let player = AVPlayer(playerItem: item)
    let layer = AVPlayerLayer(player: player)

    debugVideo(player: player)
    debugVideo(asset: asset)
    debugVideo(item: item)
    debugVideo(layer: layer)

    // asynchronousely wait for .readyToPlay status, then play video
    player.rx.status.filter { $0 == .readyToPlay }.subscribe(onNext: { [weak self] _ in
      guard let `self` = self else { return }

      self.videoView.layer.sublayers?.forEach { subLayer in
        subLayer.removeFromSuperlayer()
      }

      layer.frame = self.videoView.bounds
      self.videoView.layer.addSublayer(layer)
      player.play()
    }).addDisposableTo(self.gomibako)

    // infinite video playing
    item.rx.didPlayToEnd.subscribe(onNext: { _ in
      player.seek(to: kCMTimeZero)
      player.play()
    }).addDisposableTo(self.gomibako)
  }
}

private extension ViewController {

  func debugVideo(player: AVPlayer) {
    player.rx.currentItem.subscribe(onNext: { item in
      logger.debug("[AVPlayer][currentItem]: \(String(describing: item))")
    }).addDisposableTo(self.gomibako)

    player.rx.status.subscribe(onNext: { status in
      logger.debug("[AVPlayer][status]: \(status.rawValue)")
    }).addDisposableTo(self.gomibako)

    player.rx.rate.subscribe(onNext: { rate in
      logger.debug("[AVPlayer][rate]: \(rate)")
    }).addDisposableTo(self.gomibako)

    player.rx.actionAtItemEnd.subscribe(onNext: { action in
      logger.debug("[AVPlayer][actionAtItemEnd]: \(action.rawValue)")
    }).addDisposableTo(self.gomibako)

    player.rx.timeControlStatus.subscribe(onNext: { status in
      logger.debug("[AVPlayer][timeControlStatus]: \(status.rawValue)")
    }).addDisposableTo(self.gomibako)

    player.rx.volume.subscribe(onNext: { volume in
      logger.debug("[AVPlayer][volume]: \(volume)")
    }).addDisposableTo(self.gomibako)

    player.rx.muted.subscribe(onNext: { muted in
      logger.debug("[AVPlayer][muted]: \(muted)")
    }).addDisposableTo(self.gomibako)
  }

  func debugVideo(asset: AVAsset) {
    asset.rx.duration.subscribe(onSuccess: { duration in
      logger.debug("[AVAsset][duration]: \(duration)")
    }).addDisposableTo(self.gomibako)

    asset.rx.preferredRate.subscribe(onSuccess: { rate in
      logger.debug("[AVAsset][preferredRate]: \(rate)")
    }).addDisposableTo(self.gomibako)

    asset.rx.preferredVolume.subscribe(onSuccess: { volume in
      logger.debug("[AVAsset][preferredVolume]: \(volume)")
    }).addDisposableTo(self.gomibako)

    asset.rx.preferredTransform.subscribe(onSuccess: { trans in
      logger.debug("[AVAsset][preferredTransform]: \(trans)")
    }).addDisposableTo(self.gomibako)

    asset.rx.playable.subscribe(onSuccess: { playable in
      logger.debug("[AVAsset][playable]: \(playable)")
    }).addDisposableTo(self.gomibako)

    asset.rx.exportable.subscribe(onSuccess: { exportable in
      logger.debug("[AVAsset][exportable]: \(exportable)")
    }).addDisposableTo(self.gomibako)

    asset.rx.readable.subscribe(onSuccess: { readable in
      logger.debug("[AVAsset][readable]: \(readable)")
    }).addDisposableTo(self.gomibako)

    asset.rx.composable.subscribe(onSuccess: { composable in
      logger.debug("[AVAsset][composable]: \(composable)")
    }).addDisposableTo(self.gomibako)

    asset.rx.compatibleWithSavedPhotosAlbum.subscribe(onSuccess: { compatibleWithSavedPhotosAlbum in
      logger.debug("[AVAsset][compatibleWithSavedPhotosAlbum]: \(compatibleWithSavedPhotosAlbum)")
    }).addDisposableTo(self.gomibako)

    asset.rx.compatibleWithAirPlayVideo.subscribe(onSuccess: { compatibleWithAirPlayVideo in
      logger.debug("[AVAsset][compatibleWithAirPlayVideo]: \(compatibleWithAirPlayVideo)")
    }).addDisposableTo(self.gomibako)

    asset.rx.compatibleWithAirPlayVideo.subscribe(onSuccess: { compatibleWithAirPlayVideo in
      logger.debug("[AVAsset][compatibleWithAirPlayVideo]: \(compatibleWithAirPlayVideo)")
    }).addDisposableTo(self.gomibako)

    asset.rx.tracks.subscribe(onSuccess: { [weak self] tracks in
      logger.debug("[AVAsset][tracks]: \(tracks)")
    }).addDisposableTo(self.gomibako)

  }

  func debugVideo(item: AVPlayerItem) {
    item.rx.asset.subscribe(onNext: { asset in
      logger.debug("[AVPlayerItem][asset]: \(String(describing: asset))")
    }).addDisposableTo(self.gomibako)

    item.rx.duration.subscribe(onNext: { duration in
      logger.debug("[AVPlayerItem][duration]: \(duration)")
    }).addDisposableTo(self.gomibako)

    item.rx.presentationSize.subscribe(onNext: { presentationSize in
      logger.debug("[AVPlayerItem][presentationSize]: \(presentationSize)")
    }).addDisposableTo(self.gomibako)

    item.rx.status.subscribe(onNext: { status in
      logger.debug("[AVPlayerItem][status]: \(status.rawValue)")
    }).addDisposableTo(self.gomibako)

    item.rx.tracks.subscribe(onNext: { [weak self] tracks in
      logger.debug("[AVPlayerItem][tracks]: \(tracks)")
      tracks.forEach { track in self?.debugVideo(track: track.assetTrack) }
    }).addDisposableTo(self.gomibako)

  }

  func debugVideo(layer: AVPlayerLayer) {
    layer.rx.player.subscribe(onNext: { player in
      logger.debug("[AVPlayerLayer][player]: \(String(describing: player))")
    }).addDisposableTo(self.gomibako)

    layer.rx.videoGravity.subscribe(onNext: { videoGravity in
      logger.debug("[AVPlayerLayer][videoGravity]: \(videoGravity)")
    }).addDisposableTo(self.gomibako)

    layer.rx.readyForDisplay.subscribe(onNext: { readyForDisplay in
      logger.debug("[AVPlayerLayer][readyForDisplay]: \(readyForDisplay)")
    }).addDisposableTo(self.gomibako)

    layer.rx.videoRect.subscribe(onNext: { videoRect in
      logger.debug("[AVPlayerLayer][videoRect]: \(videoRect)")
    }).addDisposableTo(self.gomibako)
  }

  func debugVideo(track: AVAssetTrack) {
    track.rx.mediaType.subscribe(onSuccess: { mediaType in
      logger.debug("[AVAssetTrack][mediaType]: \(String(describing: mediaType))")
    }).addDisposableTo(self.gomibako)

    track.rx.playable.subscribe(onSuccess: { playable in
      logger.debug("[AVAssetTrack][playable]: \(playable)")
    }).addDisposableTo(self.gomibako)

    track.rx.enabled.subscribe(onSuccess: { enabled in
      logger.debug("[AVAssetTrack][enabled]: \(enabled)")
    }).addDisposableTo(self.gomibako)

    track.rx.selfContained.subscribe(onSuccess: { selfContained in
      logger.debug("[AVAssetTrack][selfContained]: \(selfContained)")
    }).addDisposableTo(self.gomibako)

    track.rx.totalSampleDataLength.subscribe(onSuccess: { totalSampleDataLength in
      logger.debug("[AVAssetTrack][totalSampleDataLength]: \(totalSampleDataLength)")
    }).addDisposableTo(self.gomibako)

    track.rx.timeRange.subscribe(onSuccess: { timeRange in
      logger.debug("[AVAssetTrack][timeRange]: \(timeRange)")
    }).addDisposableTo(self.gomibako)

    track.rx.naturalTimeScale.subscribe(onSuccess: { naturalTimeScale in
      logger.debug("[AVAssetTrack][naturalTimeScale]: \(naturalTimeScale)")
    }).addDisposableTo(self.gomibako)

    track.rx.estimatedDataRate.subscribe(onSuccess: { estimatedDataRate in
      logger.debug("[AVAssetTrack][estimatedDataRate]: \(estimatedDataRate)")
    }).addDisposableTo(self.gomibako)

    track.rx.naturalSize.subscribe(onSuccess: { naturalSize in
      logger.debug("[AVAssetTrack][naturalSize]: \(naturalSize)")
    }).addDisposableTo(self.gomibako)

    track.rx.preferredTransform.subscribe(onSuccess: { preferredTransform in
      logger.debug("[AVAssetTrack][preferredTransform]: \(preferredTransform)")
    }).addDisposableTo(self.gomibako)

    track.rx.preferredVolume.subscribe(onSuccess: { preferredVolume in
      logger.debug("[AVAssetTrack][preferredVolume]: \(preferredVolume)")
    }).addDisposableTo(self.gomibako)

    track.rx.nominalFrameRate.subscribe(onSuccess: { nominalFrameRate in
      logger.debug("[AVAssetTrack][nominalFrameRate]: \(nominalFrameRate)")
    }).addDisposableTo(self.gomibako)
  }

}

