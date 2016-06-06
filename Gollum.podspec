Pod::Spec.new do |s|
  s.name                  = 'Gollum'
  s.version               = '0.1.1'
  s.summary               = 'A Swift A/B Testing framework for iOS'
  s.homepage              = 'https://github.com/eduardoeof/Gollum'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { 'Eduardo Ferreira' => 'eduardoofe@gmail.com' }
  s.source                = { :git => 'https://github.com/eduardoeof/Gollum.git', :tag => '0.1.1' }
  s.social_media_url      = 'https://twitter.com/eduardoeof'
  s.source_files          = 'Gollum/**/*{.swift}'
  s.requires_arc          = true  
  s.ios.deployment_target = '8.0'
end

