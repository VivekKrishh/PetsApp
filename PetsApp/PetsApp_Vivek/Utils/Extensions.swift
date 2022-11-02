//
//  Extensions.swift
//  PetsApp_Vivek
//

import Foundation
import UIKit

//MARK: Storyboard Init
func instantiateVC(storyboardName: String , storyboardId: String) -> UIViewController {
    let storyboard = UIStoryboard(name: String(describing: storyboardName), bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: String(describing: storyboardId))
}

//MARK: - CheckIfTimeLiesBetween
func CheckTimeExist(startTime: Int, endTime: Int) -> Bool {
    
    var timeExist:Bool
    let calendar = Calendar.current
    let startTimeComponent = DateComponents(calendar: calendar, hour:startTime)
    let endTimeComponent   = DateComponents(calendar: calendar, hour: endTime, minute: 00)
    
    let now = Date()
    let startOfToday = calendar.startOfDay(for: now)
    let startTime    = calendar.date(byAdding: startTimeComponent, to:
                                        startOfToday)!
    let endTime      = calendar.date(byAdding: endTimeComponent, to:
                                        startOfToday)!
    
    if startTime <= now && now <= endTime {
        print("between 9 AM and 6:00 PM")
        timeExist = true
    } else {
        print("not between 9 AM and 6:00 PM")
        timeExist = false
    }
    return timeExist
}

//MARK: - Formatter
func getDateTime(timeStamp: String) -> String {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"//"yyyy-MM-dd'T'HH:mm:ss.SSSX"
    df.timeZone = TimeZone(identifier: "UTC")
    let date = df.date(from: timeStamp)
    df.dateStyle = .full
    return df.string(from: date!)
}

//MARK: - String
extension String.StringInterpolation {
    mutating func appendInterpolation<T: CustomStringConvertible>(_ value: T?) {
        appendInterpolation(value ?? "nil" as CustomStringConvertible)
    }
}

//MARK: - Date
extension Date {
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
        
        return localDate
    }
}

//MARK: - UIView
extension UIView {
    
    //Corner Radius
    @IBInspectable var cornerRadius : CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    //Border Width
    @IBInspectable var borderWidth : CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    //Border Color
    @IBInspectable var borderColor : UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    // The color of the shadow. Defaults to opaque black. Colors created from patterns are currently NOT supported. Animatable.
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            layer.masksToBounds = false
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    //The opacity of the shadow. Defaults to 0. Specifying a value outside the [0,1] range will give undefined results. Animatable.
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            layer.masksToBounds = false
            self.layer.shadowOpacity = newValue
        }
    }
    
    //The shadow offset. Defaults to (0, -3). Animatable.
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            layer.masksToBounds = false
            self.layer.shadowOffset = newValue
        }
    }
    
    //The blur radius used to create the shadow. Defaults to 3. Animatable.
    @IBInspectable var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        }
        set {
            layer.masksToBounds = false
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
}


