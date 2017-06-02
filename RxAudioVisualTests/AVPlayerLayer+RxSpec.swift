import Quick
import Nimble
import RxSwift
import AVFoundation
@testable import RxAudioVisual

class AVPlayerLayerSpec: QuickSpec {

  override func spec() {

    describe("KVO through rx") {

      var player: AVPlayer!
      var playerLayer: AVPlayerLayer!
      var disposeBag: DisposeBag!
      var view = UIView()

      beforeEach {
        let path = Bundle(for: AVPlayerLayerSpec.self).path(forResource: "sample", ofType: "mov")
        let url = URL(string: path!)
        player = AVPlayer(url: url!)
        playerLayer = AVPlayerLayer(player: player)
        view.layer.addSublayer(playerLayer)
        disposeBag = DisposeBag()
      }

      it("should load player") {
        var e: AVPlayer?
        playerLayer.rx.player.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(equal(player))
      }

      it("should load videoGravity") {
        var e: String?
        playerLayer.rx.videoGravity.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventually(equal(AVLayerVideoGravityResizeAspect))
      }

      it("should load readyForDisplay") {
        var e: Bool?
        playerLayer.rx.readyForDisplay.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        // FIXME: ???
        //expect(e).toEventually(beTrue())
      }

      it("should load videoRect") {
        var e: CGRect?
        playerLayer.rx.videoRect.subscribe(onNext: { v in e = v }).addDisposableTo(disposeBag)
        expect(e).toEventuallyNot(beNil())
        expect(e).toEventuallyNot(equal(CGRect.zero))
      }

    }
  }

}
