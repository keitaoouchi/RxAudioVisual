# RxAudioVisual

[![Build Status](https://www.bitrise.io/app/29c26b2d77b1b3d3/status.svg?token=IGg7cYfCkRh7tXP5_1igJQ&branch=master)](https://www.bitrise.io/app/29c26b2d77b1b3d3)
[![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)](https://swift.org/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/RxAudioVisual.svg?style=flat)](http://cocoapods.org/pods/RxAudioVisual)
[![License](https://img.shields.io/cocoapods/l/RxAudioVisual.svg?style=flat)](http://cocoapods.org/pods/RxAudioVisual)
[![Platform](https://img.shields.io/cocoapods/p/FluxxKit.svg?style=flat)](http://cocoapods.org/pods/FluxxKit)

> RxAudioVisual is a RxSwift wrapper around AVFoundation.

## Requirements

| Target            | Version |
|-------------------|---------|
| iOS               |  => 10.0 |
| Swift             |  ~> 4.0 |
| RxSwift / RxCocoa |  ~> 4.0 |

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

#### AVAsset

| property                                        | ObservableType | Element                   |
|-------------------------------------------------|----------------|---------------------------|
| duration                                        | Single         | CMTime                    |
| preferredRate                                   | Single         | Float                     |
| preferredVolume                                 | Single         | Float                     |
| preferredTransform                              | Single         | CGAffineTransform         |
| tracks                                          | Single         | [AVAssetTrack]            |
| playable                                        | Single         | Bool                      |
| exportable                                      | Single         | Bool                      |
| readable                                        | Single         | Bool                      |
| composable                                      | Single         | Bool                      |
| compatibleWithSavedPhotosAlbum                  | Single         | Bool                      |
| compatibleWithAirPlayVideo                      | Single         | Bool                      |

#### AVAssetTrack

| property                                        | ObservableType | Element                   |
|-------------------------------------------------|----------------|---------------------------|
| playable                                        | Single         | Bool                      |
| enabled                                         | Single         | Bool                      |
| selfContained                                   | Single         | Bool                      |
| totalSampleDataLength                           | Single         | Int64                     |
| timeRange                                       | Single         | CMTimeRange               |
| naturalTimeScale                                | Single         | CMTimeScale               |
| estimatedDataRate                               | Single         | Float                     |
| naturalSize                                     | Single         | CGSize                    |
| preferredTransform                              | Single         | CGAffineTransform         |
| preferredVolume                                 | Single         | Float                     |
| nominalFrameRate                                | Single         | Float                     |

#### AVPlayer

| property                                        | ObservableType | Element                   |
|-------------------------------------------------|----------------|---------------------------|
| status                                          | Observable     | AVPlayerStatus            |
| error                                           | Observable     | NSError?                  |
| timeControlStatus                               | Observable     | AVPlayerTimeControlStatus |
| rate                                            | Observable     | Float                     |
| currentItem                                     | Observable     | AVPlayerItem?             |
| actionAtItemEnd                                 | Observable     | AVPlayerActionAtItemEnd   |
| volume                                          | Observable     | Float                     |
| muted                                           | Observable     | Bool                      |
| closedCaptionDisplayEnabled                     | Observable     | Bool                      |
| allowsExternalPlayback                          | Observable     | Bool                      |
| externalPlaybackActive                          | Observable     | Bool                      |
| usesExternalPlaybackWhileExternalScreenIsActive | Observable     | Bool                      |

#### AVPlayerItem

| property                                        | ObservableType | Element                   |
|-------------------------------------------------|----------------|---------------------------|
| asset                                           | Observable     | AVAsset?                  |
| duration                                        | Observable     | CMTime                    |
| error                                           | Observable     | NSError?                  |
| loadedTimeRanges                                | Observable     | [NSValue]                 |
| presentationSize                                | Observable     | CMTime                    |
| status                                          | Observable     | AVPlayerItemStatus        |
| timebase                                        | Observable     | CMTimebase?               |
| tracks                                          | Observable     | [AVPlayerItemTrack]       |
| seekableTimeRanges                              | Observable     | [NSValue]                 |
| isPlaybackLikelyToKeepUp                        | Observable     | Bool                      |
| isPlaybackBufferEmpty                           | Observable     | Bool                      |
| isPlaybackBufferFull                            | Observable     | Bool                      |
| didPlayToEnd                                    | Observable     | Notification              |
| timeJumped                                      | Observable     | Notification              |
| failedToPlayToEndTime                           | Observable     | Notification              |
| playbackStalled                                 | Observable     | Notification              |
| newAccessLogEntry                               | Observable     | Notification              |
| newErrorLogEntry                                | Observable     | Notification              |

#### AVPlayerLayer

| property                                        | ObservableType | Element                   |
|-------------------------------------------------|----------------|---------------------------|
| player                                          | Observable     | AVPlayer?                 |
| readyForDisplay                                 | Observable     | Bool                      |
| videoRect                                       | Observable     | CGRect                    |

## Author

keita.oouchi, keita.oouchi@gmail.com

## License

RxAudioVisual is available under the MIT license. See the LICENSE file for more info.
