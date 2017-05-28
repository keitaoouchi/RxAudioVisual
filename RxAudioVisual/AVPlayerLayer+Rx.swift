import AVFoundation
import RxSwift
import RxCocoa

// MARK: - KVO
extension Reactive where Base: AVPlayerLayer {

  public var player: Observable<AVPlayer?> {
    return self
      .observe(AVPlayer.self, #keyPath(AVPlayerLayer.player))
  }

  public var videoGravity: Observable<String> {
    return self
      .observe(String.self, #keyPath(AVPlayerLayer.videoGravity))
      .map { $0 ?? AVLayerVideoGravityResizeAspect }
  }

  public var readyForDisplay: Observable<Bool> {
    return self
      .observe(Bool.self, #keyPath(AVPlayerLayer.readyForDisplay))
      .map { $0 ?? false }
  }

  public var videoRect: Observable<CGRect> {
    return self
      .observe(CGRect.self, #keyPath(AVPlayerLayer.videoRect))
      .map { $0 ?? CGRect.zero }
  }

}
