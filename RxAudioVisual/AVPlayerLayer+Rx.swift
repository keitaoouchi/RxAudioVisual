import AVFoundation
import RxSwift
import RxCocoa

// MARK: - KVO
extension Reactive where Base: AVPlayerLayer {

  public var player: Observable<AVPlayer?> {
    return self
      .observe(AVPlayer.self, #keyPath(AVPlayerLayer.player))
  }

  // FIXME: ~ iOS10.0, this videoGravity returns String
  //@available(iOS 11, *)
  //public var videoGravity: Observable<AVLayerVideoGravity> {
  //  return self
  //    .observe(AVLayerVideoGravity.self, #keyPath(AVPlayerLayer.videoGravity))
  //    .map { $0 ?? AVLayerVideoGravity.reizeAspect }
  //}

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
