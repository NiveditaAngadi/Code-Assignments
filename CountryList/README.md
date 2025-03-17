## Project Name
## Country List 
The app is responsible for fetching the countries and populate in the list. 
User can search country/ies, filter countries based on the population range (>1M, >5M, >10M) 

## Tech Stack
Programming Language: Swift 
Framework: SwiftUI and UIKit 
Network: URLSession 
Testing: XCTest 
Deployment Version: iOS 17+ 

## Table Of Contents 
### Installation & Setup 
Prerequisites:
Xcode 15+ (Implemented on Xcode 16.2)
iOS (minimum deployment iOS 17+) 

Steps to Run the project
git clone <repo-url>
cd <project-directory>
open CountryList.xcodeproj

• Select an iOS simulator or physical device. 
• Press Cmd + R to run the app 

## App Features 
• Show the list of countries by fetching data from "https://api.sampleapis.com/countries/countries"
• User can search country 
• Filter countries by population and clear will start displying all countries. 

## Architecture & Design 
• Design pattern used:
  MVVM 
• Folder structure 
  CountryList 
   - CountryListApp
   - ContentView 
   - Assets
   - NetworkManager
   - PreviewContent 
   - Modules
      - List
        - Model
        - View
        - ViewModel
   CountryListTests
    - Mock  
    - CountriesViewModelTests
    - CountryListTests
    - EndPointTests
    - NetworkServicesTests   

## Testing 
 ### Unit Tests 
  • Used XCTest framework 
  • Mocked API responses using MockURLProtocol
  • Response is fetched from mock data json file
  ####  View Model Test
   • CountriesViewModelTests
      • testSuccessfulCountriesFetch
      • testDecodingErrorHandling
      • testRequestFailedHandling
  ### Network Tests 
  • Network Service Tests 
     • testSuccessfulRequest
     • testInvalidURL
     • testInvalidResponse
     • testDecodingError
  ### End Point Tests
   • testValidEndPointURL
   • testInvalidEndpointURL


## Assumptions & Constraints 
• API responses were mocked
• No localisation support (English only) 

## Future enhancements
• Offline storage using Coredata/SwiftData 
• Test Accessibility support 
• Add pagination for list items 

## Demo 
Video Recording attached. 
  
