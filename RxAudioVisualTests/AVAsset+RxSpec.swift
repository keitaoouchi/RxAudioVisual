import Quick
import Nimble
import RxSwift
import AVFoundation
@testable import RxAudioVisual

class AVAssetSpec: QuickSpec {

  override func spec() {

    describe("AVAsynchronousKeyValueLoading through rx") {

      var asset: AVAsset!
      var disposeBag: DisposeBag!

      beforeEach {
        let path = Bundle(for: AVAssetSpec.self).path(forResource: "sample", ofType: "mov")
        let url = URL(string: path!)
        asset = AVAsset(url: url!)
        disposeBag = DisposeBag()
      }

      it("should eventually load duration") {
        var e: CMTime?
        asset.rx.duration.subscribe(onSuccess: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(kCMTimeZero))
      }

      it("should eventually load preferredRate") {
        var e: Float?
        asset.rx.preferredRate.subscribe(onSuccess: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(0))
      }

      it("should eventually load preferredVolume") {
        var e: Float?
        asset.rx.preferredVolume.subscribe(onSuccess: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(0))
      }

      it("should eventually load preferredTransform") {
        var e: CGAffineTransform?
        asset.rx.preferredTransform.subscribe(onSuccess: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(CGAffineTransform.identity))
      }

      it("should eventually load tracks") {
        var e: [AVAssetTrack]?
        asset.rx.tracks.subscribe(onSuccess: { v in e = v; print(v) }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(beEmpty())
      }

      it("should eventually load playable") {
        var e: Bool?
        asset.rx.playable.subscribe(onSuccess: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(false))
      }

      it("should eventually load exportable") {
        var e: Bool?
        asset.rx.exportable.subscribe(onSuccess: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(false))
      }

      it("should eventually load readable") {
        var e: Bool?
        asset.rx.readable.subscribe(onSuccess: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(false))
      }

      it("should eventually load composable") {
        var e: Bool?
        asset.rx.composable.subscribe(onSuccess: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(false))
      }

    }
  }
    
}
