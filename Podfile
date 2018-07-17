source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'

use_frameworks!

inhibit_all_warnings!


def common_pods
    pod 'RealmSwift', '3.7.4'
end

target "careem_test" do
    
    common_pods

    #UI components
    pod 'PYSearch', '0.9.0'
    
    #Promise & future
    pod 'PromiseKit'#, '6.0.1'
    
    #Network layer
    pod 'Alamofire', '4.7.3'
    pod 'AlamofireObjectMapper', '5.1.0'
    pod 'AlamofireImage', '3.3.1'
    pod 'SwiftyJSON', '4.1.0'
    pod 'HTTPStatusCodes', '3.2.0'
    
end

target "careem_testTests" do
    common_pods
    pod 'Quick', '1.3.1'
    pod 'Nimble', '7.1.3'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
    
    #"Update debug pod settings to speed up build time"
    Dir.glob(File.join("Pods", "**", "Pods*{debug,Private}.xcconfig")).each do |file|
        File.open(file, 'a') { |f| f.puts "\nDEBUG_INFORMATION_FORMAT = dwarf" }
    end
end

