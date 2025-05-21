import Foundation
import CoreLocation

class AreaCodeService {
    static let shared = AreaCodeService()
    private let geocoder = CLGeocoder()
    
    // Dictionary of area codes to approximate locations
    private let areaCodeLocations: [String: (latitude: Double, longitude: Double)] = [
        "212": (40.7128, -74.0060),  // New York
        "213": (34.0522, -118.2437), // Los Angeles
        "312": (41.8781, -87.6298),  // Chicago
        "415": (37.7749, -122.4194), // San Francisco
        "305": (25.7617, -80.1918),  // Miami
        "404": (33.7490, -84.3880),  // Atlanta
        "617": (42.3601, -71.0589),  // Boston
        "214": (32.7767, -96.7970),  // Dallas
        "206": (47.6062, -122.3321), // Seattle
        "702": (36.1699, -115.1398), // Las Vegas
        "803": (34.0007, -81.0348),  // Columbia, SC
        "843": (32.7765, -79.9311),  // Charleston, SC
        "864": (34.8526, -82.3940),  // Greenville, SC
        "854": (32.7765, -79.9311),  // Charleston overlay
        "839": (34.0007, -81.0348),  // Columbia overlay
        // Add more area codes as needed
    ]
    
    func getLocationForAreaCode(_ areaCode: String) -> CLLocationCoordinate2D? {
        if let coordinates = areaCodeLocations[areaCode] {
            return CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        }
        return nil
    }
    
    func extractAreaCode(from phoneNumber: String) -> String? {
        // Remove any non-digit characters
        let digits = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // Check if the number starts with 1 (country code)
        if digits.hasPrefix("1") && digits.count >= 10 {
            // Extract the area code (3 digits after the country code)
            let startIndex = digits.index(digits.startIndex, offsetBy: 1)
            let endIndex = digits.index(startIndex, offsetBy: 3)
            return String(digits[startIndex..<endIndex])
        } else if digits.count >= 10 {
            // Extract the area code (first 3 digits)
            let endIndex = digits.index(digits.startIndex, offsetBy: 3)
            return String(digits[..<endIndex])
        }
        
        return nil
    }
} 