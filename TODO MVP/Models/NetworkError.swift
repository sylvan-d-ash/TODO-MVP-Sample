//
//  NetworkError.swift
//  TODO MVP
//
//  Created by Sylvan Ash on 01/08/2018.
//  Copyright © 2018 Sylvan Ash. All rights reserved.
//
// @see
// https://github.com/Swinject/SwinjectMVVMExample/blob/master/ExampleModel/NetworkError.swift

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    
    /// unknown or not supported error
    case Unknown
    /// not connected to the internet
    case NotConnectedToInternet
    /// international data roaming turned oof
    case InternationalRoamingOff
    /// cannot reach the server
    case NotReachedServer
    /// connection to server lost
    case ConnectionLost
    /// incorrect data returned from the server
    case IncorrectDataReturned
    
    internal init(error: NSError) {
        if error.domain == NSURLErrorDomain {
            switch error.code {
            case NSURLErrorNetworkConnectionLost:
                self = .ConnectionLost
            case NSURLErrorNotConnectedToInternet:
                self = .NotConnectedToInternet
            case NSURLErrorInternationalRoamingOff:
                self = .InternationalRoamingOff
            case NSURLErrorUnknown:
                self = .Unknown
            case NSURLErrorCancelled:
                self = .Unknown
            case NSURLErrorHTTPTooManyRedirects:
                self = .Unknown
            case NSURLErrorUserCancelledAuthentication, NSURLErrorUserAuthenticationRequired:
                self = .Unknown
            case NSURLErrorCallIsActive, NSURLErrorDataNotAllowed, NSURLErrorRequestBodyStreamExhausted:
                self = .Unknown
            case NSURLErrorTimedOut:
                self = .NotReachedServer
            case NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
                self = .NotReachedServer
            case NSURLErrorDNSLookupFailed:
                self = .NotReachedServer
            case NSURLErrorBadURL:
                self = .IncorrectDataReturned
            case NSURLErrorUnsupportedURL:
                self = .IncorrectDataReturned
            case NSURLErrorDataLengthExceedsMaximum:
                self = .IncorrectDataReturned
            case NSURLErrorResourceUnavailable:
                self = .IncorrectDataReturned
            case NSURLErrorRedirectToNonExistentLocation, NSURLErrorBadServerResponse:
                self = .IncorrectDataReturned
            case NSURLErrorZeroByteResource, NSURLErrorCannotDecodeRawData, NSURLErrorCannotDecodeContentData:
                self = .IncorrectDataReturned
            case NSURLErrorCannotParseResponse:
                self = .IncorrectDataReturned
            case NSURLErrorFileDoesNotExist, NSURLErrorFileIsDirectory:
                self = .IncorrectDataReturned
            case
            NSURLErrorNoPermissionsToReadFile,
            NSURLErrorSecureConnectionFailed,
            NSURLErrorServerCertificateHasBadDate,
            NSURLErrorServerCertificateUntrusted,
            NSURLErrorServerCertificateHasUnknownRoot,
            NSURLErrorServerCertificateNotYetValid,
            NSURLErrorClientCertificateRejected,
            NSURLErrorClientCertificateRequired,
            NSURLErrorCannotLoadFromNetwork,
            NSURLErrorCannotCreateFile,
            NSURLErrorCannotOpenFile,
            NSURLErrorCannotCloseFile,
            NSURLErrorCannotWriteToFile,
            NSURLErrorCannotRemoveFile,
            NSURLErrorCannotMoveFile,
            NSURLErrorDownloadDecodingFailedMidStream,
            NSURLErrorDownloadDecodingFailedToComplete:
                self = .Unknown
            default:
                self = .Unknown
            }
            
        } else {
            self = .Unknown
        }
    }
    
    
    var description: String {
        let text: String
        switch self {
        case .Unknown:
            text = NSLocalizedString("NetworkError_Unknown", comment: "Error description")
        case .NotConnectedToInternet:
            text = NSLocalizedString("NetworkError_NotConnectedToInternet", comment: "Error description")
        case .InternationalRoamingOff:
            text = NSLocalizedString("NetworkError_InternationalRoaminOff", comment: "Error description")
        case .NotReachedServer:
            text = NSLocalizedString("NetworkError_NotReachedServer", comment: "Error description")
        case .ConnectionLost:
            text = NSLocalizedString("NetworkError_ConnectionLost", comment: "Error description")
        case .IncorrectDataReturned:
            text = NSLocalizedString("NetworkError_IncorrectDataReturned", comment: "Error description")
        }
        
        return text
    }
    
}
