import Quick
import Nimble
import RxSwift
import AVFoundation
@testable import RxAudioVisual

class AVPlayerSpec: QuickSpec {

  override func spec() {

    describe("KVO through rx") {

      var player: AVPlayer!
      var disposeBag: DisposeBag!

      beforeEach {
        let path = Bundle(for: AVPlayerSpec.self).path(forResource: "sample", ofType: "mov")
        let url = URL(string: path!)
        player = AVPlayer(url: url!)
        disposeBag = DisposeBag()
      }

      it("should load status") {
        var e: AVPlayerStatus?
        player.rx.status.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(equal(AVPlayerStatus.readyToPlay))
      }

      it("should load timeControlStatus") {
        var e: AVPlayerTimeControlStatus?
        player.rx.timeControlStatus.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(equal(AVPlayerTimeControlStatus.paused))
        player.play()
        expect(e).toEventually(equal(AVPlayerTimeControlStatus.waitingToPlayAtSpecifiedRate))
      }

      it("should load rate") {
        var e: Float?
        player.rx.rate.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(equal(0.0))
        player.rate = 1.0
        expect(e).toEventually(equal(1.0))
      }

      it("should load currentItem") {
        var e: AVPlayerItem?
        player.rx.currentItem.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
      }

      it("should load actionAtItemEnd") {
        var e: AVPlayerActionAtItemEnd?
        player.rx.actionAtItemEnd.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(equal(AVPlayerActionAtItemEnd.pause))
      }

      it("should load volume") {
        var e: Float?
        player.rx.volume.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(equal(1.0))
        player.volume = 0.0
        expect(e).toEventually(equal(0.0))
      }

      it("should load muted") {
        var e: Bool?
        player.rx.muted.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(beFalse())
        player.isMuted = true
        expect(e).toEventually(beTrue())
      }

      it("should load closedCaptionDisplayEnabled") {
        var e: Bool?
        player.rx.closedCaptionDisplayEnabled.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(beFalse())
      }

      it("should load allowsExternalPlayback") {
        var e: Bool?
        player.rx.allowsExternalPlayback.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(beTrue())
      }

      it("should load externalPlaybackActive") {
        var e: Bool?
        player.rx.externalPlaybackActive.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(beFalse())
      }

      it("should load usesExternalPlaybackWhileExternalScreenIsActive") {
        var e: Bool?
        player.rx.usesExternalPlaybackWhileExternalScreenIsActive.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(beFalse())
      }

    }
  }
}
