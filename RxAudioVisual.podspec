Pod::Spec.new do |s|
  s.name          = "RxAudioVisual"
  s.version       = "1.0.1"
  s.summary       = "A reactive wrapper built around AVFoundation."
  s.homepage      = "https://github.com/keitaoouchi/RxAudioVisual"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "keitaoouchi" => "keita.oouchi@gmail.com" }
  s.source        = { :git => "https://github.com/keitaoouchi/RxAudioVisual.git", :tag => "#{s.version}" }
  s.source_files  = "RxAudioVisual/*.swift"
  s.frameworks    = "AVFoundation"
  s.ios.deployment_target = "8.0"
  s.pod_target_xcconfig = { "SWIFT_VERSION" => "3.0" }
  s.dependency 'RxSwift', '~> 3.4'
  s.dependency 'RxCocoa', '~> 3.4'
end
