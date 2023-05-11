//
//  UNIXHelper.swift
//  CourseWork2Starter
//
//  Created by Sam on 11/05/2023.
//

import Foundation

func UnixToStringTime(timestamp: Int) -> String{
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    
    return dateFormatter.string(from: date)
}

func UnixToStringDate(timestamp: Int) -> String{
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .full
    dateFormatter.timeStyle = .none
    
    return dateFormatter.string(from: date)
}
