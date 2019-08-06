# Jobsity

Jobsity is a swift app that show the Series.

## Requirements
- Xcode 10.2
- Swift 5.0
- Cocoapods

## Installation

Clone the project 

```
run pod install
```
open TestJobsity.xcworkspace

## Pods
  # CoreData
  - Use core data to store favorite series, it only stores the id, name, image, and rating because the on the detail we only
    need the id to request further information on the serie and in the preview we just need the rating, image and name properties.
    
  # SVProgressHUD
  - Show some hud while the user waits, api responds quickly so did not use this much. 
  - When there are errors on the request or something unexpected happened we also use SVProgressHUD to let the user know what happening in the Application.

  # Alamofire
  - I used this to perfom all the request needed in the app.

  # AlamofireImage: 
  - This is a helper pod to avoid loading the images from the URL manually, it intruduces some helper functions such as af_setImage that takes as parameter an URL and we can also display a placeholder while the download takes place

