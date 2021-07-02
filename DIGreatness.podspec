Pod::Spec.new do |spec|
  spec.name = "DIGreatness"
  spec.version = "0.0.1"
  spec.summary = "DIGreatness"
  spec.homepage = "https://github.com/shsanek/DIGreatness"

  spec.license = { 
    type: 'Apache-2.0 License',
  }

  spec.author = { "Alexander Shipin" => "ssanek212@gmail.com" }
  spec.source = { :git => "https://github.com/shsanek/DIGreatness" }
  
  spec.prefix_header_file = false
  spec.ios.deployment_target = '11.0'
  spec.swift_version = '5.3'
  
  spec.source_files = 'Sources/**/*.{swift}'
end
