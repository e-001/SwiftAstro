import Foundation

extension SwiftAstro.Time {
    /// Calculates the Local Sidereal Time (LST) for a given observer's longitude.
    ///
    /// - Parameter longitude: The observer's longitude in degrees, where East is positive and West is negative.
    /// - Returns: The Local Sidereal Time in hours, normalized to a range of 0 to 24 hours.
    public func localSiderealTime(longitude: Double) -> Double {
        let jd = self.julianDays
        let jd0 = floor(jd - 0.5) + 0.5 // Julian Day at 0h UT
        let H = (jd - jd0) * 24 // Time in hours since 0h UT
        
        let T = (jd0 - 2451545.0) / 36525.0 // Julian centuries since J2000.0
        let T0 = 6.697374558 + (2400.051336 * T) + (0.000025862 * T * T)
        let T0_normalized = T0.truncatingRemainder(dividingBy: 24) // Ensure T0 is within 0-24 range
        
        let GST = T0_normalized + (H * 1.002737909) // Greenwich Sidereal Time
        let GST_normalized = GST.truncatingRemainder(dividingBy: 24) // Ensure GST is within 0-24 range
        
        let LST = GST_normalized + (longitude / 15) // Local Sidereal Time
        return LST.truncatingRemainder(dividingBy: 24) // Ensure LST is within 0-24 range
    }
}
