import AVFoundation
import RxSwift
import RxCocoa

// MARK: - KVO
extension Reactive where Base: AVPlayerItem {

  public var asset: Observable<AVAsset?> {
    return self.observe(
      AVAsset.self, #keyPath(AVPlayerItem.asset)
    )
  }

  public var duration: Observable<CMTime> {
    return self.observe(
      CMTime.self, #keyPath(AVPlayerItem.duration)
    ).map { $0 ?? kCMTimeZero }
  }

  public var error: Observable<NSError?> {
    return self.observe(
      NSError.self, #keyPath(AVPlayerItem.error)
    )
  }

  public var presentationSize: Observable<CMTime> {
    return self.observe(
      CMTime.self, #keyPath(AVPlayerItem.presentationSize)
    ).map { $0 ?? kCMTimeZero }
  }

  public var status: Observable<AVPlayerItemStatus> {
    return self.observe(
      AVPlayerItemStatus.self, #keyPath(AVPlayerItem.status)
    ).map { $0 ?? .unknown }
  }

  public var tracks: Observable<[AVPlayerItemTrack]> {
    return self.observe(
      [AVPlayerItemTrack].self, #keyPath(AVPlayerItem.tracks)
    ).map { $0 ?? [] }
  }

}

// MARK: - Notification
extension Reactive where Base: AVPlayerItem {

  public var didPlayToEnd: Observable<Notification> {
    return NotificationCenter.default.rx.notification(.AVPlayerItemDidPlayToEndTime, object: base)
  }

  public var timeJumped: Observable<Notification> {
    return NotificationCenter.default.rx.notification(.AVPlayerItemTimeJumped, object: base)
  }

  public var failedToPlayToEndTime: Observable<Notification> {
    return NotificationCenter.default.rx.notification(.AVPlayerItemFailedToPlayToEndTime, object: base)
  }

  public var playbackStalled: Observable<Notification> {
    return NotificationCenter.default.rx.notification(.AVPlayerItemPlaybackStalled, object: base)
  }

  public var newAccessLogEntry: Observable<Notification> {
    return NotificationCenter.default.rx.notification(.AVPlayerItemNewAccessLogEntry, object: base)
  }

  public var newErrorLogEntry: Observable<Notification> {
    return NotificationCenter.default.rx.notification(.AVPlayerItemNewErrorLogEntry, object: base)
  }
  
}
