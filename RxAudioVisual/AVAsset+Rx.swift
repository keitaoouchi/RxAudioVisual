import AVFoundation
import RxSwift

extension Reactive where Base: AVAsset {

  public var duration: Single<CMTime> {
    return self
      .loadAsync(for: "duration")
      .map({ loaded in
        if loaded {
          return self.base.duration
        } else {
            return CMTime.zero
        }
      })
  }

  public var preferredRate: Single<Float> {
    return self
      .loadAsync(for: "preferredRate")
      .map({ loaded in
        if loaded {
          return self.base.preferredRate
        } else {
          return 0.0
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

  public var tracks: Single<[AVAssetTrack]> {
    return self
      .loadAsync(for: "tracks")
      .map({ loaded in
        if loaded {
          return self.base.tracks
        } else {
          return []
        }
      })
  }

}

// MARK: - AVAssetUsability
extension Reactive where Base: AVAsset {

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

  public var exportable: Single<Bool> {
    return self
      .loadAsync(for: "exportable")
      .map({ loaded in
        if loaded {
          return self.base.isExportable
        } else {
          return false
        }
      })
  }

  public var readable: Single<Bool> {
    return self
      .loadAsync(for: "readable")
      .map { loaded in
        if loaded {
          return self.base.isReadable
        } else {
          return false
        }
    }
  }

  public var composable: Single<Bool> {
    return self
      .loadAsync(for: "composable")
      .map({ loaded in
        if loaded {
          return self.base.isComposable
        } else {
          return false
        }
      })
  }

  public var compatibleWithSavedPhotosAlbum: Single<Bool> {
    return self
      .loadAsync(for: "compatibleWithSavedPhotosAlbum")
      .map({ loaded in
        if loaded {
          return self.base.isCompatibleWithSavedPhotosAlbum
        } else {
          return false
        }
      })
  }

  @available(iOS 9.0, *)
  public var compatibleWithAirPlayVideo: Single<Bool> {
    return self
      .loadAsync(for: "compatibleWithAirPlayVideo")
      .map({ loaded in
        if loaded {
          return self.base.isCompatibleWithAirPlayVideo
        } else {
          return false
        }
      })
  }
}
