#
#  BZKIntegrationTestSuite.podspec
#
#  Created by Benoit Sarrazin on 20/08/2014.
#  Copyright (c) 2014 Berzerk Design. All rights reserved.
#

Pod::Spec.new do |s|

  s.name         = "BZKIntegrationTestSuite"
  s.version      = "0.0.3"
  s.summary      = "Because sometimes you need to test integration at runtime."

  s.description  = <<-DESC
                   Because sometimes you need to test integration at runtime.

                   * Allows you to create test cases that can be executed at runtime, with a device or the simulator.
                   DESC

  s.homepage     = "https://github.com/BerzerkerDesign/BZKIntegrationTestSuite"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Benoit Sarrazin" => "bensarz@gmail.com" }
  s.social_media_url   = "http://twitter.com/bensarz"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/BerzerkerDesign/BZKIntegrationTestSuite.git", :tag => "0.0.3" }
  s.source_files  = "BZKIntegrationTestSuite", "BZKIntegrationTestSuite/**/*.{h,m}"
  s.public_header_files = "BZKIntegrationTestSuite/**/*.h"
  s.requires_arc = true

end
