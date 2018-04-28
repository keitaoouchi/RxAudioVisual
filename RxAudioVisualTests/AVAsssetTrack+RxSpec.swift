import Quick
import Nimble
import RxSwift
import AVFoundation
@testable import RxAudioVisual

class AVAssetTrackSpec: QuickSpec {

  override func spec() {

    describe("AVAsynchronousKeyValueLoading through rx") {

      var asset: AVAsset!
      var track: AVAssetTrack?
      var disposeBag: DisposeBag!

      let waitForTrack = {
        if track == nil {
          asset.rx.tracks.subscribe(onSuccess: { tracks in track = tracks.first }).disposed(by: disposeBag)
          expect(track).toEventuallyNot(beNil())
        }
      }

      beforeEach {
        asset = AVAsset(url: TestHelper.sampleURL)
        disposeBag = DisposeBag()
      }

      it("should eventually load playable") {
        waitForTrack()

        var e: Bool?
        track?.rx.playable.subscribe(onSuccess: { v in e = v }).disposed(by: disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(beFalse())
      }

      it("should eventually load enabled") {
        waitForTrack()

        var e: Bool?
        track?.rx.enabled.subscribe(onSuccess: { v in e = v }).disposed(by: disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(beTrue())
      }

      it("should eventually load selfContained") {
        waitForTrack()

        var e: Bool?
        track?.rx.selfContained.subscribe(onSuccess: { v in e = v }).disposed(by: disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(beFalse())
      }

      it("should eventually load totalSampleDataLength") {
        waitForTrack()

        var e: Int64?
        track?.rx.totalSampleDataLength.subscribe(onSuccess: { v in e = v }).disposed(by: disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(0))
      }

      it("should eventually load timeRange") {
        waitForTrack()

        var e: CMTimeRange?
        track?.rx.timeRange.subscribe(onSuccess: { v in e = v }).disposed(by: disposeBag)
        expect(e).toEventuallyNot(beNil())
      }

      it("should eventually load naturalTimeScale") {
        waitForTrack()

        var e: CMTimeScale?
        track?.rx.naturalTimeScale.subscribe(onSuccess: { v in e = v }).disposed(by: disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(0))
      }

      it("should eventually load estimatedDataRate") {
        waitForTrack()

        var e: Float?
        track?.rx.estimatedDataRate.subscribe(onSuccess: { v in e = v }).disposed(by: disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(0.0))
      }

      it("should eventually load naturalSize") {
        waitForTrack()

        var e: CGSize?
        track?.rx.naturalSize.subscribe(onSuccess: { v in e = v }).disposed(by: disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(CGSize.zero))
      }

      it("should eventually load preferredTransform") {
        waitForTrack()

        var e: CGAffineTransform?
        track?.rx.preferredTransform.subscribe(onSuccess: { v in e = v }).disposed(by: disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(equal(.identity))
      }

      it("should eventually load preferredVolume") {
        waitForTrack()

        var e: Float?
        track?.rx.preferredVolume.subscribe(onSuccess: { v in e = v }).disposed(by: disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(0.0))
      }

      it("should eventually load nominalFrameRate") {
        waitForTrack()

        var e: Float?
        track?.rx.nominalFrameRate.subscribe(onSuccess: { v in e = v }).disposed(by: disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(0.0))
      }

    }
  }

}
