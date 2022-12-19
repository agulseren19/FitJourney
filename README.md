# FitJourney
# To Run
* sudo gem install cocoapods
* cd FitJourney (project's directory)
* pod init
* paste this content to created Podfile:<br>
``` 
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FitJourney' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FitJourney

  pod 'FirebaseAuth'
  
  pod 'GoogleSignIn'
  
  pod 'Firebase/Messaging'

  target 'FitJourneyTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FitJourneyUITests' do
    # Pods for testing
  end

end 
```
* pod install
* open FitJourney.xcworkspace in Xcode, wait loading
* build and run in Xcode
