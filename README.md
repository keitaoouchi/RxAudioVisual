# RxAudioVisual

[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://swift.org/)
[![Version](https://img.shields.io/cocoapods/v/RxAudioVisual.svg?style=flat)](http://cocoapods.org/pods/RxAudioVisual)
[![License](https://img.shields.io/cocoapods/l/RxAudioVisual.svg?style=flat)](http://cocoapods.org/pods/RxAudioVisual)

> RxAudioVisual is a RxSwift wrapper around AVFoundation.

## Requirements

| Target            | Version |
|-------------------|---------|
| iOS               |  ~> 9.0 |
| Swift             |  ~> 3.0 |
| RxSwift / RxCocoa |  ~> 3.4 |

## Installation

RxAudioVisual is available through [CocoaPods](http://cocoapods.org).

### CocoaPods

```ruby
pod "RxAudioVisual"
```

## Getting started

### AVAsynchronousKeyValueLoading

```swift
asset.rx.playable.subscribe(
  onSuccess: { playable in
    // Do something nice.
  }
)
```

### KVO

```swift
player.rx.status.filter { $0 == .readyToPlay }.subscribe(onNext: { _ in
  player.play()
}).addDisposableTo(self.disposeBag)
```

```swift
playerLayer.rx.readyForDisplay.filter { $0 == true }.subscribe(onNext: { [weak self] _ in
  playerLayer.frame = self?.videoView.bounds
  self?.videoView.layer.addSublayer(playerLayer)
}).addDisposableTo(self.disposeBag)
```

### Notification

```swift
item.rx.didPlayToEnd.subscribe(onNext: { _ in
  player.seek(to: kCMTimeZero)
  player.play()
}).addDisposableTo(self.disposeBag)
```

### Overview

| Base          | property                                        | ObservableType | Element                   |
|---------------|-------------------------------------------------|----------------|---------------------------|
| AVAsset       | duration                                        | Single         | CMTime                    |
| AVAsset       | preferredRate                                   | Single         | Float                     |
| AVAsset       | preferredVolume                                 | Single         | Float                     |
| AVAsset       | preferredTransform                              | Single         | CGAffineTransform         |
| AVAsset       | tracks                                          | Single         | [AVAssetTrack]            |
| AVAsset       | playable                                        | Single         | Bool                      |
| AVAsset       | exportable                                      | Single         | Bool                      |
| AVAsset       | readable                                        | Single         | Bool                      |
| AVAsset       | composable                                      | Single         | Bool                      |
| AVAsset       | compatibleWithSavedPhotosAlbum                  | Single         | Bool                      |
| AVAsset       | compatibleWithAirPlayVideo                      | Single         | Bool                      |
| AVAssetTrack  | mediaType                                       | Single         | String?                   |
| AVAssetTrack  | playable                                        | Single         | Bool                      |
| AVAssetTrack  | enabled                                         | Single         | Bool                      |
| AVAssetTrack  | selfContained                                   | Single         | Bool                      |
| AVAssetTrack  | totalSampleDataLength                           | Single         | Int64                     |
| AVAssetTrack  | timeRange                                       | Single         | CMTimeRange               |
| AVAssetTrack  | naturalTimeScale                                | Single         | CMTimeScale               |
| AVAssetTrack  | estimatedDataRate                               | Single         | Float                     |
| AVAssetTrack  | naturalSize                                     | Single         | CGSize                    |
| AVAssetTrack  | preferredTransform                              | Single         | CGAffineTransform         |
| AVAssetTrack  | preferredVolume                                 | Single         | Float                     |
| AVAssetTrack  | nominalFrameRate                                | Single         | Float                     |
| AVPlayer      | status                                          | Observable     | AVPlayerStatus            |
| AVPlayer      | error                                           | Observable     | NSError?                  |
| AVPlayer      | timeControlStatus                               | Observable     | AVPlayerTimeControlStatus |
| AVPlayer      | rate                                            | Observable     | Float                     |
| AVPlayer      | currentItem                                     | Observable     | AVPlayerItem?             |
| AVPlayer      | actionAtItemEnd                                 | Observable     | AVPlayerActionAtItemEnd   |
| AVPlayer      | volume                                          | Observable     | Float                     |
| AVPlayer      | muted                                           | Observable     | Bool                      |
| AVPlayer      | closedCaptionDisplayEnabled                     | Observable     | Bool                      |
| AVPlayer      | allowsExternalPlayback                          | Observable     | Bool                      |
| AVPlayer      | externalPlaybackActive                          | Observable     | Bool                      |
| AVPlayer      | usesExternalPlaybackWhileExternalScreenIsActive | Observable     | Bool                      |
| AVPlayerItem  | didPlayToEnd                                    | Observable     | Notification              |
| AVPlayerItem  | timeJumped                                      | Observable     | Notification              |
| AVPlayerItem  | failedToPlayToEndTime                           | Observable     | Notification              |
| AVPlayerItem  | playbackStalled                                 | Observable     | Notification              |
| AVPlayerItem  | newAccessLogEntry                               | Observable     | Notification              |
| AVPlayerItem  | newErrorLogEntry                                | Observable     | Notification              |
| AVPlayerLayer | player                                          | Observable     | AVPlayer?                 |
| AVPlayerLayer | videoGravity                                    | Observable     | String                    |
| AVPlayerLayer | readyForDisplay                                 | Observable     | Bool                      |
| AVPlayerLayer | videoRect                                       | Observable     | CGRect                    |

## Author

keita.oouchi, keita.oouchi@gmail.com

## License

RxAudioVisual is available under the MIT license. See the LICENSE file for more info.
