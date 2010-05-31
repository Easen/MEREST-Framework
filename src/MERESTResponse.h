//
//  MERESTResponse.h
//  MEREST
//
//  Created by Marc Easen on 31/05/2010.
//  Copyright 2010 Marc Easen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
	MERESTRequestHTTPStatusCodeInvalid = -1,
	
	MERESTRequestHTTPStatusCodeInformationalContinue = 100,
	MERESTRequestHTTPStatusCodeInformationalSwitchingProtocols = 101,
	MERESTRequestHTTPStatusCodeInformationalProcessing = 102,
	
	MERESTRequestHTTPStatusCodeSuccessOK = 200,
	MERESTRequestHTTPStatusCodeSuccessCreated = 201,
	MERESTRequestHTTPStatusCodeSuccessAccepted = 202,
	MERESTRequestHTTPStatusCodeSuccessNonAuthoritativeInformation = 203,
	MERESTRequestHTTPStatusCodeSuccessNoContent = 204,
	MERESTRequestHTTPStatusCodeSuccessResetContent = 205,
	MERESTRequestHTTPStatusCodeSuccessPartialContent = 206,
	MERESTRequestHTTPStatusCodeSuccessMultiStatus = 207,
	
	MERESTRequestHTTPStatusCodeRedirectionMultipleChoices = 300,
	MERESTRequestHTTPStatusCodeRedirectionMovedPermanently = 301,
	MERESTRequestHTTPStatusCodeRedirectionFound = 302,
	MERESTRequestHTTPStatusCodeRedirectionSeeOther = 303,
	MERESTRequestHTTPStatusCodeRedirectionNotModified = 304,
	MERESTRequestHTTPStatusCodeRedirectionUseProxy = 305,
	MERESTRequestHTTPStatusCodeRedirectionSwitchProxy = 306,
	MERESTRequestHTTPStatusCodeRedirectionTemporaryRedirect = 307,
	
	MERESTRequestHTTPStatusCodeClientErrorBadRequest = 400,
	MERESTRequestHTTPStatusCodeClientErrorUnauthorized = 401,
	MERESTRequestHTTPStatusCodeClientErrorPaymentRequired = 402,
	MERESTRequestHTTPStatusCodeClientErrorForbidden = 403,
	MERESTRequestHTTPStatusCodeClientErrorNotFound = 404,
	MERESTRequestHTTPStatusCodeClientErrorMethodNotAllowed = 405,
	MERESTRequestHTTPStatusCodeClientErrorNotAcceptable = 406,
	MERESTRequestHTTPStatusCodeClientErrorProxyAuthenticationRequired = 407,
	MERESTRequestHTTPStatusCodeClientErrorRequestTimeout = 408,
	MERESTRequestHTTPStatusCodeClientErrorConflict = 409,
	MERESTRequestHTTPStatusCodeClientErrorGone = 410,
	MERESTRequestHTTPStatusCodeClientErrorLengthRequired = 411,
	MERESTRequestHTTPStatusCodeClientErrorPreconditionFailed = 412,
	MERESTRequestHTTPStatusCodeClientErrorRequestEntityTooLarge = 413,
	MERESTRequestHTTPStatusCodeClientErrorRequestURITooLong = 414,
	MERESTRequestHTTPStatusCodeClientErrorUnsupportedMediaType = 415,
	MERESTRequestHTTPStatusCodeClientErrorRequestedRangeNotSatisfiable = 416,
	MERESTRequestHTTPStatusCodeClientErrorExpectationFailed = 417,
	MERESTRequestHTTPStatusCodeClientErrorImATeapot = 418,
	MERESTRequestHTTPStatusCodeClientErrorUnprocessableEntity = 422,
	MERESTRequestHTTPStatusCodeClientErrorLocked = 423,
	MERESTRequestHTTPStatusCodeClientErrorFailedDependency = 424,
	MERESTRequestHTTPStatusCodeClientErrorUnorderedCollection = 425,
	MERESTRequestHTTPStatusCodeClientErrorUpgradeRequired = 426,
	MERESTRequestHTTPStatusCodeClientErrorRetryWith = 449,
	MERESTRequestHTTPStatusCodeClientErrorBlockedByWindowsParentalControls = 450,
	MERESTRequestHTTPStatusCodeClientErrorWebLimitAccessError = 455,
	
	MERESTRequestHTTPStatusCodeServerErrorInternalServerError = 500,
	MERESTRequestHTTPStatusCodeServerErrorNotImplemented = 501,
	MERESTRequestHTTPStatusCodeServerErrorBadGateway = 502,
	MERESTRequestHTTPStatusCodeServerErrorServiceUnavailable = 503,
	MERESTRequestHTTPStatusCodeServerErrorGatewayTimeout = 504,
	MERESTRequestHTTPStatusCodeServerErrorHTTPVersionNotSupported = 505,
	MERESTRequestHTTPStatusCodeServerErrorVariantAlsoNegotiates = 506,
	MERESTRequestHTTPStatusCodeServerErrorInsufficientStorage = 507,
	MERESTRequestHTTPStatusCodeServerErrorBandwidthLimitExceeded = 509,
	MERESTRequestHTTPStatusCodeServerErrorNotExtended = 510	
} MERESTRequestHTTPStatusCode;

@class MERESTRequest;

@interface MERESTResponse : NSObject {
    MERESTRequest *restRequest;
    MERESTRequestHTTPStatusCode statusCode;
    NSDictionary *headers;
    NSData *data;
}

@property (readonly) MERESTRequest *restRequest;
@property (readonly) MERESTRequestHTTPStatusCode statusCode;
@property (readonly) NSDictionary *headers;
@property (readonly) NSData *data;

- (id) initWithRESTRequest:(MERESTRequest *) restRequest 
               URLResponse:(NSURLResponse *) urlResponse 
                      data:(NSData *)data;
- (id) dataObjectUsingClass:(Class) aClass;

@end
