//
//  MERESTResponse.h
//  MEREST
//
//  Created by Marc Easen on 31/05/2010.
//  Copyright 2010 Marc Easen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
	MERESTResponseHTTPStatusCodeInvalid = -1,
	
	MERESTResponseHTTPStatusCodeInformationalContinue = 100,
	MERESTResponseHTTPStatusCodeInformationalSwitchingProtocols = 101,
	MERESTResponseHTTPStatusCodeInformationalProcessing = 102,
	
	MERESTResponseHTTPStatusCodeSuccessOK = 200,
	MERESTResponseHTTPStatusCodeSuccessCreated = 201,
	MERESTResponseHTTPStatusCodeSuccessAccepted = 202,
	MERESTResponseHTTPStatusCodeSuccessNonAuthoritativeInformation = 203,
	MERESTResponseHTTPStatusCodeSuccessNoContent = 204,
	MERESTResponseHTTPStatusCodeSuccessResetContent = 205,
	MERESTResponseHTTPStatusCodeSuccessPartialContent = 206,
	MERESTResponseHTTPStatusCodeSuccessMultiStatus = 207,
	
	MERESTResponseHTTPStatusCodeRedirectionMultipleChoices = 300,
	MERESTResponseHTTPStatusCodeRedirectionMovedPermanently = 301,
	MERESTResponseHTTPStatusCodeRedirectionFound = 302,
	MERESTResponseHTTPStatusCodeRedirectionSeeOther = 303,
	MERESTResponseHTTPStatusCodeRedirectionNotModified = 304,
	MERESTResponseHTTPStatusCodeRedirectionUseProxy = 305,
	MERESTResponseHTTPStatusCodeRedirectionSwitchProxy = 306,
	MERESTResponseHTTPStatusCodeRedirectionTemporaryRedirect = 307,
	
	MERESTResponseHTTPStatusCodeClientErrorBadRequest = 400,
	MERESTResponseHTTPStatusCodeClientErrorUnauthorized = 401,
	MERESTResponseHTTPStatusCodeClientErrorPaymentRequired = 402,
	MERESTResponseHTTPStatusCodeClientErrorForbidden = 403,
	MERESTResponseHTTPStatusCodeClientErrorNotFound = 404,
	MERESTResponseHTTPStatusCodeClientErrorMethodNotAllowed = 405,
	MERESTResponseHTTPStatusCodeClientErrorNotAcceptable = 406,
	MERESTResponseHTTPStatusCodeClientErrorProxyAuthenticationRequired = 407,
	MERESTResponseHTTPStatusCodeClientErrorRequestTimeout = 408,
	MERESTResponseHTTPStatusCodeClientErrorConflict = 409,
	MERESTResponseHTTPStatusCodeClientErrorGone = 410,
	MERESTResponseHTTPStatusCodeClientErrorLengthRequired = 411,
	MERESTResponseHTTPStatusCodeClientErrorPreconditionFailed = 412,
	MERESTResponseHTTPStatusCodeClientErrorRequestEntityTooLarge = 413,
	MERESTResponseHTTPStatusCodeClientErrorRequestURITooLong = 414,
	MERESTResponseHTTPStatusCodeClientErrorUnsupportedMediaType = 415,
	MERESTResponseHTTPStatusCodeClientErrorRequestedRangeNotSatisfiable = 416,
	MERESTResponseHTTPStatusCodeClientErrorExpectationFailed = 417,
	MERESTResponseHTTPStatusCodeClientErrorImATeapot = 418,
	MERESTResponseHTTPStatusCodeClientErrorUnprocessableEntity = 422,
	MERESTResponseHTTPStatusCodeClientErrorLocked = 423,
	MERESTResponseHTTPStatusCodeClientErrorFailedDependency = 424,
	MERESTResponseHTTPStatusCodeClientErrorUnorderedCollection = 425,
	MERESTResponseHTTPStatusCodeClientErrorUpgradeRequired = 426,
	MERESTResponseHTTPStatusCodeClientErrorRetryWith = 449,
	MERESTResponseHTTPStatusCodeClientErrorBlockedByWindowsParentalControls = 450,
	MERESTResponseHTTPStatusCodeClientErrorWebLimitAccessError = 455,
	
	MERESTResponseHTTPStatusCodeServerErrorInternalServerError = 500,
	MERESTResponseHTTPStatusCodeServerErrorNotImplemented = 501,
	MERESTResponseHTTPStatusCodeServerErrorBadGateway = 502,
	MERESTResponseHTTPStatusCodeServerErrorServiceUnavailable = 503,
	MERESTResponseHTTPStatusCodeServerErrorGatewayTimeout = 504,
	MERESTResponseHTTPStatusCodeServerErrorHTTPVersionNotSupported = 505,
	MERESTResponseHTTPStatusCodeServerErrorVariantAlsoNegotiates = 506,
	MERESTResponseHTTPStatusCodeServerErrorInsufficientStorage = 507,
	MERESTResponseHTTPStatusCodeServerErrorBandwidthLimitExceeded = 509,
	MERESTResponseHTTPStatusCodeServerErrorNotExtended = 510	
} MERESTResponseHTTPStatusCode;


typedef enum {
    MERESTResponseContentTypeInvalid = -1,
    MERESTResponseContentTypeJSON = 1,
    MERESTResponseContentTypeXML = 2
} MERESTResponseContentType;

@class MERESTRequest;

@interface MERESTResponse : NSObject {
    MERESTRequest *restRequest;
    MERESTResponseHTTPStatusCode statusCode;
    MERESTResponseContentType contentType;
    NSDictionary *headers;
    NSData *data;
}

@property (readonly) MERESTRequest *restRequest;
@property (readonly) MERESTResponseHTTPStatusCode statusCode;
@property (readonly) NSDictionary *headers;
@property (readonly) NSData *data;

- (id) initWithRESTRequest:(MERESTRequest *) restRequest 
               URLResponse:(NSURLResponse *) urlResponse 
                      data:(NSData *)data;
- (id) dataObjectUsingClass:(Class) aClass;

@end
