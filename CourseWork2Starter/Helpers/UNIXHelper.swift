//
//  UNIXHelper.swift
//  CourseWork2Starter
//
//  Created by Variapolis.
//

import Foundation

func UnixToDateFormat(timestamp: Int, format: String) -> String{
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    
    return dateFormatter.string(from: date)
}
