Pod::Spec.new do |s|
  s.name         = "ZSNavigationBar-oc"
  s.version      = "1.0.0"
  s.summary      = "ZSNavigationBar uses category to allow you change UINavigationBar appearance dynamically.(supported iOS 11+ and iPhone X)"
  s.homepage     = "https://github.com/ZakariyyaSv/ZSNavigationBar"
  s.license      = "MIT"
  s.author       = { "iCeBlink" => "zakariyyasv@gmail.com" }
  s.source       = { :git => "https://github.com/ZakariyyaSv/ZSNavigationBar.git", :tag => '1.0.0' }
  s.source_files = "ZSNavigationBar/Source-oc/*.{h,m}"
  s.requires_arc = true
  s.platform     = :ios, '8.0'

end