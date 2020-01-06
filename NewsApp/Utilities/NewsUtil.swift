//
//  NewsUtil.swift
//  NewsApp
//
//  Created by Adi on 1/6/20.
//  Copyright © 2020 Aditya. All rights reserved.
//

import Foundation

class NewsUtil{
    
    class func getTimeDifference(passedDateString: String, passedDateFormat: String) -> String{
        //return "1h ago"
        var timeLeft = String()
        
        let date1 = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = passedDateFormat
        print("passedDateString**\(passedDateString)")
        let date2 = dateFormatter.date(from: passedDateString)!
        
        
        var seconds = Int(date1.timeIntervalSince(date2))
        
        let days = Int(floor(Double(seconds/(3600*24))))
        if days > 1 {
            seconds -= days * 3600 * 24
        }
        
        let hours = Int(floor(Double(seconds / 3600)))
        
        if hours != 0{
            seconds -= hours * 3600
        }
        
        let minutes = Int(floor(Double(seconds / 60)))
        if minutes != 0 {
            seconds -= minutes * 60
        }
        
        if days != 0 {
            let timeformatter = DateFormatter()
            timeformatter.dateFormat = "hh:mm a"
            let requiredTimeString = timeformatter.string(from: date2)
            //timeLeft = "\(Int(days)) Day ago"
            if days > 1 || hours > 24{
                let components = Calendar.current.dateComponents([.day, .month, .year], from: date2)
                let day = components.day
                let month = components.month
                let year = components.year
                if month != 10 && month != 11 && month != 12{
                    timeLeft = "\(String(describing: day!))/0\(String(describing: month!))/\(String(describing: year!)) \(requiredTimeString)"
                }else{
                    timeLeft = "\(String(describing: day!))/\(String(describing: month!))/\(String(describing: year!)) \(requiredTimeString)"
                }
                
                //timeLeft = day + "/" + month + "/" + year
                
            }else{
                
                timeLeft = "Yesterday \(requiredTimeString)"
            }
            return timeLeft
        }else if hours != 0 {
            timeLeft = "\(Int(hours))h ago"
            return timeLeft
        }else if minutes != 0 {
            timeLeft = "\(Int(minutes))m ago"
            return timeLeft
        }else if seconds != 0 {
            timeLeft = "Just now"
            return timeLeft
        }else{
            return timeLeft
        }
    }
    
}
