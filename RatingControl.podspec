Pod::Spec.new do |spec|
    spec.name                   = 'RatingControl'
    spec.version                = '3.5'
    spec.summary                = 'Whole, half or floating point ratings control written in Swift.'
    spec.homepage               = 'https://github.com/Sorix/FloatingRatingView'
    spec.license                = 'MIT'
    spec.author                 = { 'Sorix' => 'email@in-readme.com', 'Glen Yi' => 'glenyi81@gmail.com' }
    spec.source                 = { :git => 'https://github.com/Sorix/FloatingRatingView.git', :tag => "#{spec.version}" }
    spec.source_files           = 'Source/**/*.swift'
    spec.platform               = :ios, '9.0'
    spec.requires_arc           = true
    spec.pod_target_xcconfig    = { 'SWIFT_VERSION' => '4.2' }
end
