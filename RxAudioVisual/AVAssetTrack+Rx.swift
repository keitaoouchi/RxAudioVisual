import AVFoundation
import RxSwift

extension Reactive where Base: AVAssetTrack {

  // FIXME: ~ iOS10.0, this videoGravity returns String
  //@available(iOS 11, *)
  //public var mediaType: Single<String?> {
  //  return self
  //      .loadAsync(for: "mediaType")
  //      .map({ loaded in
  //        if loaded {
  //          return self.base.mediaType
  //        } else {
  //          return nil
  //        }
  //      })
  //}

  public var playable: Single<Bool> {
    return self
        .loadAsync(for: "playable")
        .map({ loaded in
          if loaded {
            return self.base.isPlayable
          } else {
            return false
          }
        })
  }

  public var enabled: Single<Bool> {
    return self
        .loadAsync(for: "enabled")
        .map({ loaded in
          if loaded {
            return self.base.isEnabled
          } else {
            return false
          }
        })
  }

  public var selfContained: Single<Bool> {
    return self
        .loadAsync(for: "selfContained")
        .map({ loaded in
          if loaded {
            return self.base.isSelfContained
          } else {
            return false
          }
        })
  }

  public var totalSampleDataLength: Single<Int64> {
    return self
        .loadAsync(for: "totalSampleDataLength")
        .map({ loaded in
          if loaded {
            return self.base.totalSampleDataLength
          } else {
            return 0
          }
        })
  }

  // MARK: - AVAssetTrackTemporalProperties

  public var timeRange: Single<CMTimeRange> {
    return self
      .loadAsync(for: "timeRange")
      .map({ loaded in
        if loaded {
          return self.base.timeRange
        } else {
            return CMTimeRange.zero
        }
      })
  }

  public var naturalTimeScale: Single<CMTimeScale> {
    return self
      .loadAsync(for: "naturalTimeScale")
      .map({ loaded in
        if loaded {
          return self.base.naturalTimeScale
        } else {
          return 0
        }
      })
  }

  public var estimatedDataRate: Single<Float> {
    return self
      .loadAsync(for: "estimatedDataRate")
      .map({ loaded in
        if loaded {
          return self.base.estimatedDataRate
        } else {
          return 0.0
        }
      })
  }

  // MARK: - AVAssetTrackTemporalProperties

  public var naturalSize: Single<CGSize> {
    return self
      .loadAsync(for: "naturalSize")
      .map({ loaded in
        if loaded {
          return self.base.naturalSize
        } else {
          return CGSize.zero
        }
      })
  }

  public var preferredTransform: Single<CGAffineTransform> {
    return self
      .loadAsync(for: "preferredTransform")
      .map({ loaded in
        if loaded {
          return self.base.preferredTransform
        } else {
          return CGAffineTransform.identity
        }
      })
  }

  public var preferredVolume: Single<Float> {
    return self
      .loadAsync(for: "preferredVolume")
      .map({ loaded in
        if loaded {
          return self.base.preferredVolume
        } else {
          return 0.0
        }
      })
  }

  public var nominalFrameRate: Single<Float> {
    return self
      .loadAsync(for: "nominalFrameRate")
      .map({ loaded in
        if loaded {
          return self.base.nominalFrameRate
        } else {
          return 0.0
        }
      })
  }

}
