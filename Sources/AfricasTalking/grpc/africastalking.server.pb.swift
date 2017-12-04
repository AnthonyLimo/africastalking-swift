/*
 * DO NOT EDIT.
 *
 * Generated by the protocol buffer compiler.
 * Source: SdkServerService.proto
 *
 */

/*
 * Copyright 2017, gRPC Authors All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import Foundation
import Dispatch
import gRPC
import SwiftProtobuf

/// Type for errors thrown from generated server code.
internal enum Africastalking_SdkServerServiceServerError : Error {
  case endOfStream
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Africastalking_SdkServerServiceProvider {
  func gettoken(request : Africastalking_ClientTokenRequest, session : Africastalking_SdkServerServicegetTokenSession) throws -> Africastalking_ClientTokenResponse
  func getsipcredentials(request : Africastalking_SipCredentialsRequest, session : Africastalking_SdkServerServicegetSipCredentialsSession) throws -> Africastalking_SipCredentialsResponse
}

/// Common properties available in each service session.
internal class Africastalking_SdkServerServiceSession {
  fileprivate var handler : gRPC.Handler
  internal var requestMetadata : Metadata { return handler.requestMetadata }

  internal var statusCode : Int = 0
  internal var statusMessage : String = "OK"
  internal var initialMetadata : Metadata = Metadata()
  internal var trailingMetadata : Metadata = Metadata()

  fileprivate init(handler:gRPC.Handler) {
    self.handler = handler
  }
}

// getToken (Unary)
internal class Africastalking_SdkServerServicegetTokenSession : Africastalking_SdkServerServiceSession {
  private var provider : Africastalking_SdkServerServiceProvider

  /// Create a session.
  fileprivate init(handler:gRPC.Handler, provider: Africastalking_SdkServerServiceProvider) {
    self.provider = provider
    super.init(handler:handler)
  }

  /// Run the session. Internal.
  fileprivate func run(queue:DispatchQueue) throws {
    try handler.receiveMessage(initialMetadata:initialMetadata) {(requestData) in
      if let requestData = requestData {
        let requestMessage = try Africastalking_ClientTokenRequest(serializedData:requestData)
        let replyMessage = try self.provider.gettoken(request:requestMessage, session: self)
        try self.handler.sendResponse(message:replyMessage.serializedData(),
                                      statusCode:self.statusCode,
                                      statusMessage:self.statusMessage,
                                      trailingMetadata:self.trailingMetadata)
      }
    }
  }
}

// getSipCredentials (Unary)
internal class Africastalking_SdkServerServicegetSipCredentialsSession : Africastalking_SdkServerServiceSession {
  private var provider : Africastalking_SdkServerServiceProvider

  /// Create a session.
  fileprivate init(handler:gRPC.Handler, provider: Africastalking_SdkServerServiceProvider) {
    self.provider = provider
    super.init(handler:handler)
  }

  /// Run the session. Internal.
  fileprivate func run(queue:DispatchQueue) throws {
    try handler.receiveMessage(initialMetadata:initialMetadata) {(requestData) in
      if let requestData = requestData {
        let requestMessage = try Africastalking_SipCredentialsRequest(serializedData:requestData)
        let replyMessage = try self.provider.getsipcredentials(request:requestMessage, session: self)
        try self.handler.sendResponse(message:replyMessage.serializedData(),
                                      statusCode:self.statusCode,
                                      statusMessage:self.statusMessage,
                                      trailingMetadata:self.trailingMetadata)
      }
    }
  }
}


/// Main server for generated service
internal class Africastalking_SdkServerServiceServer {
  private var address: String
  private var server: gRPC.Server
  private var provider: Africastalking_SdkServerServiceProvider?

  /// Create a server that accepts insecure connections.
  internal init(address:String,
              provider:Africastalking_SdkServerServiceProvider) {
    gRPC.initialize()
    self.address = address
    self.provider = provider
    self.server = gRPC.Server(address:address)
  }

  /// Create a server that accepts secure connections.
  internal init?(address:String,
               certificateURL:URL,
               keyURL:URL,
               provider:Africastalking_SdkServerServiceProvider) {
    gRPC.initialize()
    self.address = address
    self.provider = provider
    guard
      let certificate = try? String(contentsOf: certificateURL, encoding: .utf8),
      let key = try? String(contentsOf: keyURL, encoding: .utf8)
      else {
        return nil
    }
    self.server = gRPC.Server(address:address, key:key, certs:certificate)
  }

  /// Start the server.
  internal func start(queue:DispatchQueue = DispatchQueue.global()) {
    guard let provider = self.provider else {
      fatalError() // the server requires a provider
    }
    server.run {(handler) in
      print("Server received request to " + handler.host
        + " calling " + handler.method
        + " from " + handler.caller
        + " with " + String(describing:handler.requestMetadata) )

      do {
        switch handler.method {
        case "/africastalking.SdkServerService/getToken":
          try Africastalking_SdkServerServicegetTokenSession(handler:handler, provider:provider).run(queue:queue)
        case "/africastalking.SdkServerService/getSipCredentials":
          try Africastalking_SdkServerServicegetSipCredentialsSession(handler:handler, provider:provider).run(queue:queue)
        default:
          break // handle unknown requests
        }
      } catch (let error) {
        print("Server error: \(error)")
      }
    }
  }
}