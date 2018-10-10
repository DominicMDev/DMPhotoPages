Pod::Spec.new do |s|
    s.name         = 'DMPhotoPages'
    s.version      = '0.1.0'
    s.summary      = 'A photo gallery for iOS with a modern feature set. Similar features as the Facebook photo browser.'
    s.description  = 'See https://github.com/EddyBorja/EBPhotoPages'
    s.authors      = 'Eddy Borja', 'Dominic Miller'
    s.license      = { :type => 'MIT', :file => 'LICENSE.md' }
    s.homepage     = 'https://github.com/DominicMDev/DMPhotoPages'
    s.source       = { :git => 'https://github.com/DominicMDev/DMPhotoPages.git', :tag => s.version }
    s.screenshot   = 'https://github.com/DominicMDev/DMPhotoPages/blob/master/Images/1.png?raw=true'
    s.requires_arc = true
    
    s.platform     = :ios, '10.0'
    
    s.source_files = 'DMPhotoPages/**/*.{h,m}'
    s.frameworks = 'QuartzCore', 'CoreGraphics', 'AVFoundation'
end
