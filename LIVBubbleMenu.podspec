Pod::Spec.new do |s|

  s.name         = "LIVBubbleMenu"
  s.version      = "1.1.0"
  s.summary      = "An animated and customisable bubble menu for iOS8."
  s.description  = "An animated bubble menu using the pop animation library (https://github.com/facebook/pop). The menu is fully customizable in terms of radius, number of items, animation speed, bounciness, background, alpha ect."
  s.homepage     = "https://github.com/limitlessvirtual/LIVBubbleMenu-iOS"
  s.license      = "MIT"
  s.author             = { "limitlessvirtual" => "info@limitlessvirtual.com" }
  s.platform     = :ios, "7.1"
  s.source_files  = "LIVBubbleMenu"
  s.source       = { :git => "https://github.com/limitlessvirtual/LIVBubbleMenu-iOS.git", :tag => "v1.1.0" }
  s.dependency 'pop', '~> 1.0.7'
  s.requires_arc = true

end







