# OKC
A simple collection view based app.

# Build Details and Requirements
This project was built for iOS 10 using XCode 8.0 and requires XCode 8.0 to run.

# Installation Directions
Pull or download the .zip file of the repo. From the terminal run pod install after navigating to the project directory. Launch XCode and open the OKCTest.xcworkspace workspace file. 

XCode will prompt you to convert to the latest Swift syntax. Ignore this prompt by pressing Later. Navigate to the Pods project file and select the Alamofire target. Navigate to Build Settings and assign the value NO to the key Use Legacy Swift Language Version. Confirm that this value is also specified for the SwiftyJSON target. 

Build and run the project from XCode. 

# Build Notes
You will need to specify a Team to build the project. Go to Targets->OKCTest->General->Signing and specify your development team from the drop down menu. 
