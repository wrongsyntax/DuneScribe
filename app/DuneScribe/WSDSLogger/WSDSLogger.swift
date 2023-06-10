//
//  WSDSLogger.swift
//  DuneScribe
//
//  Created by Uzair Tariq on 2023-06-09.
//

import Foundation
import os

/// Stores the different types of logs and associated details.
///
/// Possible cases are `none`, `debug`, `info`, `success`, `warning`, `error`, and `fault`.
/// Each case has an associated emoji icon and `OSLogType`.
public enum WSDSLogType {
    case none
    case debug
    case info
    case success
    case warning
    case error
    case fault
    
    public var icon: String? {
        switch self {
        case .none:     return nil
        case .debug:    return "🐞"
        case .info:     return "ℹ️"
        case .success:  return "❇️"
        case .warning:  return "⚠️"
        case .error:    return "⛔"
        case .fault:    return "📛"
        }
    }
    
    public var osLogType: OSLogType {
        switch self {
        case .none:     return .default
        case .debug:    return .debug
        case .info:     return .info
        case .success:  return .debug
        case .warning:  return .debug
        case .error:    return .error
        case .fault:    return .fault
        }
    }
}

/// Logger that supports more rich logging than the os.Logger.
public class WSDSLogger {
    private var subsystem: String
    private var category: String
    private var logger: Logger
    
    init(subsystem: String, category: String) {
        self.subsystem = subsystem
        self.category = category
        self.logger = Logger(subsystem: self.subsystem, category: self.category)
    }
    
    public func log(_ message: String) {
        self.log(level: .none, message)
    }
    
    public func debug(_ message: String) {
        self.log(level: .debug, message)
    }
    
    public func info(_ message: String) {
        self.log(level: .info, message)
    }
    
    public func success(_ message: String) {
        self.log(level: .success, message)
    }
    
    public func warning(_ message: String) {
        self.log(level: .warning, message)
    }
    
    public func error(_ message: String) {
        self.log(level: .error, message)
    }
    
    public func fault(_ message: String) {
        self.log(level: .fault, message)
    }
    
    private func log(level: WSDSLogType, _ message: String) {
        let messageWithIcon = message.withIcon(level.icon)
        self.logger.log(level: level.osLogType, "\(messageWithIcon)")
    }
}

extension String {
    /// Prepends the string with `icon` and a single space if `icon` is not `nil`.
    func withIcon(_ icon: String?) -> String {
        return (icon ?? "") + (icon == nil ? "" : " ") + self
    }
}
