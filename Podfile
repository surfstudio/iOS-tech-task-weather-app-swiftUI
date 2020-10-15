platform :ios, '12.0'

inhibit_all_warnings!

def utils
    pod 'SwiftGen', '~> 6.1.0'
    pod 'SwiftLint', '~> 0.30.1'
    pod 'CSTObfuscator'
end

def common_pods
    utils

    pod 'Firebase/Core'

    pod 'PluggableApplicationDelegate', :git => "https://github.com/surfstudio/PluggableApplicationDelegate.git", :commit=>"b24aabe3f34d51072cee5cac3b576dbb1f4ca9ec"
    pod 'ReactiveDataDisplayManager', :git=>"https://github.com/surfstudio/ReactiveDataDisplayManager", :tag=>"5.0.1"
    pod 'SurfUtils/StringAttributes', :git => "https://github.com/surfstudio/iOS-Utils.git", :tag => "10.0.5"
    pod 'NodeKit', :git => "https://github.com/surfstudio/NodeKit.git", :tag=>"3.2.0"
end


target 'WeatherDebug' do
	use_frameworks!
	common_pods
end


target 'WeatherRelease' do
	use_frameworks!
	common_pods
end
