import Quick
import Nimble
import RxSwift
import AVFoundation
@testable import RxAudioVisual

class AVPlayerItemSpec: QuickSpec {

  override func spec() {

    describe("KVO through rx") {

      var asset: AVAsset!
      var item: AVPlayerItem!
      var disposeBag: DisposeBag!

      beforeEach {
        let path = Bundle(for: AVPlayerItemSpec.self).path(forResource: "sample", ofType: "mov")
        let url = URL(string: path!)
        asset = AVAsset(url: url!)
        item = AVPlayerItem(asset: asset)
        disposeBag = DisposeBag()
      }

      it("should load asset") {
        var e: AVAsset?
        item.rx.asset.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(equal(asset))
      }

      it("should load duration") {
        var e: CMTime?
        item.rx.duration.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(kCMTimeZero))
      }

      it("should load presentationSize") {
        var e: CMTime?
        item.rx.presentationSize.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(equal(kCMTimeZero))
      }

      it("should load status") {
        var e: AVPlayerItemStatus?
        item.rx.status.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        // FIXME: WHY???
        //expect(e).toEventually(equal(AVPlayerItemStatus.readyToPlay))
      }

      it("should load tracks") {
        var e: [AVPlayerItemTrack]?
        item.rx.tracks.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(beEmpty())
      }

    }

    describe("Notification through rx") {

      var asset: AVAsset!
      var item: AVPlayerItem!
      var disposeBag: DisposeBag!

      beforeEach {
        let path = Bundle(for: AVPlayerItemSpec.self).path(forResource: "sample", ofType: "mov")
        let url = URL(string: path!)
        asset = AVAsset(url: url!)
        item = AVPlayerItem(asset: asset)
        disposeBag = DisposeBag()
      }

      it("should receive didPlayToEnd") {
        var e: Notification?
        item.rx.didPlayToEnd.subscribe(onNext: { v in
          e = v
        }).addDisposableTo(disposeBag)
        NotificationCenter.default.post(name: .AVPlayerItemDidPlayToEndTime, object: nil)
        expect(e).toEventuallyNot(beNil())
      }

      it("should receive timeJumped") {
        var e: Notification?
        item.rx.didPlayToEnd.subscribe(onNext: { v in
          e = v
        }).addDisposableTo(disposeBag)
        NotificationCenter.default.post(name: .AVPlayerItemTimeJumped, object: nil)
        expect(e).toEventuallyNot(beNil())
      }

      it("should receive failedToPlayToEndTime") {
        var e: Notification?
        item.rx.didPlayToEnd.subscribe(onNext: { v in
          e = v
        }).addDisposableTo(disposeBag)
        NotificationCenter.default.post(name: .AVPlayerItemFailedToPlayToEndTime, object: nil)
        expect(e).toEventuallyNot(beNil())
      }

      it("should receive playbackStalled") {
        var e: Notification?
        item.rx.didPlayToEnd.subscribe(onNext: { v in
          e = v
        }).addDisposableTo(disposeBag)
        NotificationCenter.default.post(name: .AVPlayerItemPlaybackStalled, object: nil)
        expect(e).toEventuallyNot(beNil())
      }

      it("should receive newAccessLogEntry") {
        var e: Notification?
        item.rx.didPlayToEnd.subscribe(onNext: { v in
          e = v
        }).addDisposableTo(disposeBag)
        NotificationCenter.default.post(name: .AVPlayerItemNewAccessLogEntry, object: nil)
        expect(e).toEventuallyNot(beNil())
      }

      it("should receive newErrorLogEntry") {
        var e: Notification?
        item.rx.didPlayToEnd.subscribe(onNext: { v in
          e = v
        }).addDisposableTo(disposeBag)
        NotificationCenter.default.post(name: .AVPlayerItemNewErrorLogEntry, object: nil)
        expect(e).toEventuallyNot(beNil())
      }

    }

  }
}
