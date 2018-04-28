Pod::Spec.new do |s|
  s.name          = "RxAudioVisual"
  s.version       = "1.2.0"
  s.summary       = "A reactive wrapper built around AVFoundation."
  s.homepage      = "https://github.com/keitaoouchi/RxAudioVisual"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "keitaoouchi" => "keita.oouchi@gmail.com" }
  s.source        = { :git => "https://github.com/keitaoouchi/RxAudioVisual.git", :tag => "#{s.version}" }
  s.source_files  = "RxAudioVisual/*.{swift,h}"
  s.frameworks    = "AVFoundation"
  s.ios.deployment_target = "10.0"
  s.pod_target_xcconfig = { "SWIFT_VERSION" => "4.0" }
  s.dependency 'RxSwift', '~> 4.0'
  s.dependency 'RxCocoa', '~> 4.0'
end
