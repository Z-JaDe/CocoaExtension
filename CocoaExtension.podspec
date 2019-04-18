Pod::Spec.new do |s|
    s.name             = "CocoaExtension"
    s.version          = "1.0.0"
    s.summary          = "一些扩展"
    s.description      = <<-DESC
    Cocoa的一些扩展
    DESC
    s.homepage         = "https://github.com/Z-JaDe"
    s.license          = 'MIT'
    s.author           = { "ZJaDe" => "zjade@outlook.com" }
    s.source           = { :git => "git@github.com:Z-JaDe/CocoaExtension.git", :tag => s.version.to_s }
    
    s.requires_arc          = true
    
    s.ios.deployment_target = '9.0'
    s.frameworks            = "Foundation"
    s.swift_version         = "5.0"

    s.public_header_files   = "Sources/**/*.h"
    s.source_files          = "Sources/**/*.{swift,h,m}"

end
