import AVFoundation
import RxSwift
import RxCocoa

// MARK: - KVO
extension Reactive where Base: AVPlayer {

  public var status: Observable<AVPlayerStatus> {
    return self
      .observe(AVPlayerStatus.self, #keyPath(AVPlayer.status))
      .map { $0 ?? .unknown }
  }

  public var error: Observable<NSError?> {
    return self
      .observe(NSError.self, #keyPath(AVPlayer.error))
  }

  @available(iOS 10.0, *)
  public var timeControlStatus: Observable<AVPlayerTimeControlStatus> {
    return self
      .observe(AVPlayerTimeControlStatus.self, #keyPath(AVPlayer.timeControlStatus))
      .map { $0 ?? .paused }
  }

  public var rate: Observable<Float> {
    return self
      .observe(Float.self, #keyPath(AVPlayer.rate))
      .map { $0 ?? 0 }
  }

  public var currentItem: Observable<AVPlayerItem?> {
    return self
      .observe(AVPlayerItem.self, #keyPath(AVPlayer.currentItem))
  }

  public var actionAtItemEnd: Observable<AVPlayerActionAtItemEnd> {
    return self
      .observe(AVPlayerActionAtItemEnd.self, #keyPath(AVPlayer.actionAtItemEnd))
      .map { $0 ?? .none }
  }

  // MARK: - AVPlayerMediaControl

  public var volume: Observable<Float> {
    return self
      .observe(Float.self, #keyPath(AVPlayer.volume))
      .map { $0 ?? 0 }
  }

  public var muted: Observable<Bool> {
    return self
      .observe(Bool.self, #keyPath(AVPlayer.isMuted))
      .map { $0 ?? false }
  }

  public var closedCaptionDisplayEnabled: Observable<Bool> {
    return self
      .observe(Bool.self, #keyPath(AVPlayer.closedCaptionDisplayEnabled))
      .map { $0 ?? false }
  }

  // MARK: - AVPlayerExternalPlaybackSupport

  public var allowsExternalPlayback: Observable<Bool> {
    return self
      .observe(Bool.self, #keyPath(AVPlayer.allowsExternalPlayback))
      .map { $0 ?? false }
  }

  public var externalPlaybackActive: Observable<Bool> {
    return self
      .observe(Bool.self, #keyPath(AVPlayer.externalPlaybackActive))
      .map { $0 ?? false }
  }

  public var usesExternalPlaybackWhileExternalScreenIsActive: Observable<Bool> {
    return self
      .observe(Bool.self, #keyPath(AVPlayer.usesExternalPlaybackWhileExternalScreenIsActive))
      .map { $0 ?? false }
  }

}
