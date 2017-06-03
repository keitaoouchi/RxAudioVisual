import UIKit
import RxAudioVisual
import AVFoundation
import RxSwift

class ViewController: UIViewController {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var videoView: UIView!
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
    }).addDisposableTo(self.disposeBag)

    // infinite video playing
    item.rx.didPlayToEnd.subscribe(onNext: { _ in
      player.seek(to: kCMTimeZero)
      player.play()
    }).addDisposableTo(self.disposeBag)
  }
}

private extension ViewController {

  func debugVideo(player: AVPlayer) {
    player.rx.currentItem.subscribe(onNext: { item in
      logger.debug("[AVPlayer][currentItem]: \(String(describing: item))")
    }).addDisposableTo(self.disposeBag)

    player.rx.status.subscribe(onNext: { status in
      logger.debug("[AVPlayer][status]: \(status.rawValue)")
    }).addDisposableTo(self.disposeBag)

    player.rx.rate.subscribe(onNext: { rate in
      logger.debug("[AVPlayer][rate]: \(rate)")
    }).addDisposableTo(self.disposeBag)

    player.rx.actionAtItemEnd.subscribe(onNext: { action in
      logger.debug("[AVPlayer][actionAtItemEnd]: \(action.rawValue)")
    }).addDisposableTo(self.disposeBag)

    player.rx.timeControlStatus.subscribe(onNext: { status in
      logger.debug("[AVPlayer][timeControlStatus]: \(status.rawValue)")
    }).addDisposableTo(self.disposeBag)

    player.rx.volume.subscribe(onNext: { volume in
      logger.debug("[AVPlayer][volume]: \(volume)")
    }).addDisposableTo(self.disposeBag)

    player.rx.muted.subscribe(onNext: { muted in
      logger.debug("[AVPlayer][muted]: \(muted)")
    }).addDisposableTo(self.disposeBag)
  }

  func debugVideo(asset: AVAsset) {
    asset.rx.duration.subscribe(onSuccess: { duration in
      logger.debug("[AVAsset][duration]: \(duration)")
    }).addDisposableTo(self.disposeBag)

    asset.rx.preferredRate.subscribe(onSuccess: { rate in
      logger.debug("[AVAsset][preferredRate]: \(rate)")
    }).addDisposableTo(self.disposeBag)

    asset.rx.preferredVolume.subscribe(onSuccess: { volume in
      logger.debug("[AVAsset][preferredVolume]: \(volume)")
    }).addDisposableTo(self.disposeBag)

    asset.rx.preferredTransform.subscribe(onSuccess: { trans in
      logger.debug("[AVAsset][preferredTransform]: \(trans)")
    }).addDisposableTo(self.disposeBag)

    asset.rx.playable.subscribe(onSuccess: { playable in
      logger.debug("[AVAsset][playable]: \(playable)")
    }).addDisposableTo(self.disposeBag)

    asset.rx.exportable.subscribe(onSuccess: { exportable in
      logger.debug("[AVAsset][exportable]: \(exportable)")
    }).addDisposableTo(self.disposeBag)

    asset.rx.readable.subscribe(onSuccess: { readable in
      logger.debug("[AVAsset][readable]: \(readable)")
    }).addDisposableTo(self.disposeBag)

    asset.rx.composable.subscribe(onSuccess: { composable in
      logger.debug("[AVAsset][composable]: \(composable)")
    }).addDisposableTo(self.disposeBag)

    asset.rx.compatibleWithSavedPhotosAlbum.subscribe(onSuccess: { compatibleWithSavedPhotosAlbum in
      logger.debug("[AVAsset][compatibleWithSavedPhotosAlbum]: \(compatibleWithSavedPhotosAlbum)")
    }).addDisposableTo(self.disposeBag)

    asset.rx.compatibleWithAirPlayVideo.subscribe(onSuccess: { compatibleWithAirPlayVideo in
      logger.debug("[AVAsset][compatibleWithAirPlayVideo]: \(compatibleWithAirPlayVideo)")
    }).addDisposableTo(self.disposeBag)

    asset.rx.compatibleWithAirPlayVideo.subscribe(onSuccess: { compatibleWithAirPlayVideo in
      logger.debug("[AVAsset][compatibleWithAirPlayVideo]: \(compatibleWithAirPlayVideo)")
    }).addDisposableTo(self.disposeBag)

    asset.rx.tracks.subscribe(onSuccess: { [weak self] tracks in
      logger.debug("[AVAsset][tracks]: \(tracks)")
    }).addDisposableTo(self.disposeBag)

  }

  func debugVideo(item: AVPlayerItem) {
    item.rx.asset.subscribe(onNext: { asset in
      logger.debug("[AVPlayerItem][asset]: \(String(describing: asset))")
    }).addDisposableTo(self.disposeBag)

    item.rx.duration.subscribe(onNext: { duration in
      logger.debug("[AVPlayerItem][duration]: \(duration)")
    }).addDisposableTo(self.disposeBag)

    item.rx.presentationSize.subscribe(onNext: { presentationSize in
      logger.debug("[AVPlayerItem][presentationSize]: \(presentationSize)")
    }).addDisposableTo(self.disposeBag)

    item.rx.status.subscribe(onNext: { status in
      logger.debug("[AVPlayerItem][status]: \(status.rawValue)")
    }).addDisposableTo(self.disposeBag)

    item.rx.tracks.subscribe(onNext: { [weak self] tracks in
      logger.debug("[AVPlayerItem][tracks]: \(tracks)")
      tracks.forEach { track in self?.debugVideo(track: track.assetTrack) }
    }).addDisposableTo(self.disposeBag)

  }

  func debugVideo(layer: AVPlayerLayer) {
    layer.rx.player.subscribe(onNext: { player in
      logger.debug("[AVPlayerLayer][player]: \(String(describing: player))")
    }).addDisposableTo(self.disposeBag)

    layer.rx.videoGravity.subscribe(onNext: { videoGravity in
      logger.debug("[AVPlayerLayer][videoGravity]: \(videoGravity)")
    }).addDisposableTo(self.disposeBag)

    layer.rx.readyForDisplay.subscribe(onNext: { readyForDisplay in
      logger.debug("[AVPlayerLayer][readyForDisplay]: \(readyForDisplay)")
    }).addDisposableTo(self.disposeBag)

    layer.rx.videoRect.subscribe(onNext: { videoRect in
      logger.debug("[AVPlayerLayer][videoRect]: \(videoRect)")
    }).addDisposableTo(self.disposeBag)
  }

  func debugVideo(track: AVAssetTrack) {
    track.rx.mediaType.subscribe(onSuccess: { mediaType in
      logger.debug("[AVAssetTrack][mediaType]: \(String(describing: mediaType))")
    }).addDisposableTo(self.disposeBag)

    track.rx.playable.subscribe(onSuccess: { playable in
      logger.debug("[AVAssetTrack][playable]: \(playable)")
    }).addDisposableTo(self.disposeBag)

    track.rx.enabled.subscribe(onSuccess: { enabled in
      logger.debug("[AVAssetTrack][enabled]: \(enabled)")
    }).addDisposableTo(self.disposeBag)

    track.rx.selfContained.subscribe(onSuccess: { selfContained in
      logger.debug("[AVAssetTrack][selfContained]: \(selfContained)")
    }).addDisposableTo(self.disposeBag)

    track.rx.totalSampleDataLength.subscribe(onSuccess: { totalSampleDataLength in
      logger.debug("[AVAssetTrack][totalSampleDataLength]: \(totalSampleDataLength)")
    }).addDisposableTo(self.disposeBag)

    track.rx.timeRange.subscribe(onSuccess: { timeRange in
      logger.debug("[AVAssetTrack][timeRange]: \(timeRange)")
    }).addDisposableTo(self.disposeBag)

    track.rx.naturalTimeScale.subscribe(onSuccess: { naturalTimeScale in
      logger.debug("[AVAssetTrack][naturalTimeScale]: \(naturalTimeScale)")
    }).addDisposableTo(self.disposeBag)

    track.rx.estimatedDataRate.subscribe(onSuccess: { estimatedDataRate in
      logger.debug("[AVAssetTrack][estimatedDataRate]: \(estimatedDataRate)")
    }).addDisposableTo(self.disposeBag)

    track.rx.naturalSize.subscribe(onSuccess: { naturalSize in
      logger.debug("[AVAssetTrack][naturalSize]: \(naturalSize)")
    }).addDisposableTo(self.disposeBag)

    track.rx.preferredTransform.subscribe(onSuccess: { preferredTransform in
      logger.debug("[AVAssetTrack][preferredTransform]: \(preferredTransform)")
    }).addDisposableTo(self.disposeBag)

    track.rx.preferredVolume.subscribe(onSuccess: { preferredVolume in
      logger.debug("[AVAssetTrack][preferredVolume]: \(preferredVolume)")
    }).addDisposableTo(self.disposeBag)

    track.rx.nominalFrameRate.subscribe(onSuccess: { nominalFrameRate in
      logger.debug("[AVAssetTrack][nominalFrameRate]: \(nominalFrameRate)")
    }).addDisposableTo(self.disposeBag)
  }

}
