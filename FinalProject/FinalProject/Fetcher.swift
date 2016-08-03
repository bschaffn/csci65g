//
//  Fetcher.swift
//  Lecture10
//
//  Created by tinaun on 7/25/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import Foundation

class Fetcher : NSObject, NSURLSessionTaskDelegate {
    
    func session() -> NSURLSession {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.timeoutIntervalForRequest = 1.0
        
        return NSURLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
    
    //MARK: NSURLSessionTaskDelegate
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        NSLog("\(#function): sent \(totalBytesSent) out of \(totalBytesExpectedToSend)")
    }
    
    typealias RequestHandler = (data: NSData?, message: String?) -> ()
    func request(url: NSURL, completion: RequestHandler) {
        
        let task = session().dataTaskWithURL(url) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
            NSLog("Task Complete.")
            
            let message = self.parseResponse(response, error: error)
            completion(data: data, message: message)
        }
        task.resume()
    }
    
    typealias RequestJSONHandler = (json: AnyObject?, message: String?) -> ()
    func requestJSON(url: NSURL, completion: RequestJSONHandler ) {
        request(url) { (data, message) in
            var json: AnyObject?
            if let data = data {
                json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            }
            completion(json: json, message: message)
        }
    }
    
    typealias RequestRLEHandler = (rle: Pattern?, message: String?) -> ()
    func requestRLE(url: NSURL, completion: RequestRLEHandler) {
        request(url) { (data, message) in
            var rletext: NSString?
            var pattern: Pattern?
            if let data = data {
                rletext = NSString(data: data, encoding: NSUTF8StringEncoding)
                pattern = RLELoader().load(fromString: String(rletext))
            }
            completion(rle: pattern, message: message)
        }
    }
    
    func parseResponse(response: NSURLResponse?, error: NSError?) -> String? {
        if let statusCode = (response as? NSHTTPURLResponse)?.statusCode {
            if statusCode == 200 {
                return nil
            } else {
                return "HTTP Error \(statusCode): \(NSHTTPURLResponse.localizedStringForStatusCode(statusCode))"
            }
        } else {
            if let netError = error {
                return "Network Error: \(netError.localizedDescription)"
            } else {
                return "OS Error: Error Not Identifiable"
            }
        }
    }
}


extension Fetcher: NSURLSessionDelegate {
   
    //MARK: NSURLSessionDelegate
    func URLSession(session: NSURLSession, didBecomeInvalidWithError error: NSError?) {
        NSLog("\(#function): session became invalid: \(error?.localizedDescription)")
    }
    
    func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession) {
        
    }
    
    func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        
    }
}