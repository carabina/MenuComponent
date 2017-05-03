
Pod::Spec.new do |s|
  s.name             = "MenuComponent"
  s.version          = "1.1"
  s.summary          = "A menu component used on iOS."
  s.homepage         = "https://github.com/dexianyinjiu/MenuComponent"
  s.license          = 'MIT'
  s.author           = { "得闲饮酒" => "1625977078@qq.com" }
  s.source           = { :git => "https://github.com/dexianyinjiu/MenuComponent.git", :tag => s.version.to_s }
  s.platform         = :ios, '7.0'
  s.requires_arc     = true
  s.source_files     = 'MenuComponent/**/*.{h,m}'
  s.resources        = "MenuComponent/Resources/*.png"
  s.frameworks       = 'Foundation', 'UIKit'

end
