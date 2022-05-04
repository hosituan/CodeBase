//
//  Logging.swift
//  CodeBase
//
//  Created by Ho Si Tuan on 04/05/2022.
//


import UIKit
import CocoaLumberjack

fileprivate let fileLogger: DDFileLogger = DDFileLogger()

public func LoggerSetup() {
    
    //DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
    fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7
    DDLog.add(fileLogger)
    
    #if PROD
    
    #else
    
    #endif
    
}

public func LoggerAllLogFiles() -> [String] {
    return fileLogger.logFileManager.sortedLogFilePaths
}

public func LogDebug(_ message: @autoclosure () -> String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: UInt = #line, userInfo: [String: Any] = [:]) {
    DDLogDebug(message, file: fileName, function: functionName, line: lineNumber)
}
public func LogVerbose(_ message: @autoclosure () -> String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: UInt = #line, userInfo: [String: Any] = [:]) {
    DDLogVerbose(message, file: fileName, function: functionName, line: lineNumber)
}
public func LogInfo(_ message: @autoclosure () -> String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: UInt = #line, userInfo: [String: Any] = [:]) {
    DDLogInfo(message, file: fileName, function: functionName, line: lineNumber)
}
public func LogWarn(_ message: @autoclosure () -> String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: UInt = #line, userInfo: [String: Any] = [:]) {
    DDLogWarn(message, file: fileName, function: functionName, line: lineNumber)
}
public func LogError(_ message: @autoclosure () -> String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: UInt = #line, userInfo: [String: Any] = [:]) {
    DDLogError(message, file: fileName, function: functionName, line: lineNumber)
}
