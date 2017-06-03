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
      let view = UIView(frame: CGRect(x: 0, y: 0, width: 360, height: 800))

      beforeEach {
        let path = Bundle(for: AVPlayerLayerSpec.self).path(forResource: "sample", ofType: "mov")
        let url = URL(string: path!)
        let asset = AVAsset(url: url!)
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: item)
        playerLayer = AVPlayerLayer(player: player)
        view.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
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
        //FIXME: expect(e).toEventually(beTrue())
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
