import Foundation

final class TestHelper {
  static var sampleURL: URL {
    let url = Bundle(for: self as AnyClass).url(forResource: "sample", withExtension: "mov")
    return url!
  }
}
