Pod::Spec.new do |spec|
    spec.name                   = 'FloatRatingView'
    spec.version                = '3.0'
    spec.summary                = 'Whole, half or floating point ratings control written in Swift.'
    spec.homepage               = 'https://github.com/Sorix/FloatRatingView'
    spec.license                = 'MIT'
    spec.author                 = { 'Glen Yi' => 'glenyi81@gmail.com' }
    spec.source                 = { :git => 'https://github.com/Sorix/FloatRatingView.git', :tag => "#{spec.version}" }
    spec.source_files           = 'Source/**/*.swift'
    spec.platform               = :ios, '8.0'
    spec.requires_arc           = true
    spec.pod_target_xcconfig    = { 'SWIFT_VERSION' => '4.0' }
end
