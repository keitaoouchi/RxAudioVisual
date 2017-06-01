import AVFoundation
import RxSwift

internal extension Reactive where Base: AVAsynchronousKeyValueLoading {

  func loadAsync(for key: String) -> Single<Bool> {
    return Single.create { observer in
      self.base.loadValuesAsynchronously(forKeys: [key]) {
        var error: NSError?
        let status = self.base.statusOfValue(forKey: key, error: &error)
        switch status {
        case .loaded:
          observer(.success(true))
        default:
          // TODO: or emit some error
          observer(.success(false))
        }
      }
      return Disposables.create()
    }
  }

}
