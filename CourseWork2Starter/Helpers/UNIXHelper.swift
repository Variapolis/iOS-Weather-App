//
//  UNIXHelper.swift
//  CourseWork2Starter
//
//  Created by Sam on 11/05/2023.
//

import Foundation

func UnixToDateFormat(timestamp: Int, format: String) -> String{
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    
    return dateFormatter.string(from: date)
}
