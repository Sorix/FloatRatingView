Pod::Spec.new do |spec|
    spec.name                   = 'RatingControl'
    spec.version                = '4.0'
    spec.summary                = 'Whole, half or floating point ratings control written in Swift.'
    spec.homepage               = 'https://github.com/Sorix/RatingControl'
    spec.license                = 'MIT'
    spec.author                 = { 'Sorix' => 'email@in-readme.com', 'Glen Yi' => 'glenyi81@gmail.com' }
    spec.source                 = { :git => 'https://github.com/Sorix/RatingControl.git', :tag => "#{spec.version}" }
    spec.source_files           = 'Source/**/*.swift'
    spec.platform               = :ios, '10.0'
    spec.requires_arc           = true
    spec.swift_version          = '4.2'
end
