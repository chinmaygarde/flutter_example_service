// Copyright 2016 the Flutter project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library hello_world_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;



class _HelloWorldSayHelloParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String name = null;

  _HelloWorldSayHelloParams() : super(kVersions.last.size);

  static _HelloWorldSayHelloParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HelloWorldSayHelloParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HelloWorldSayHelloParams result = new _HelloWorldSayHelloParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.name = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(name, 8, false);
  }

  String toString() {
    return "_HelloWorldSayHelloParams("
           "name: $name" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["name"] = name;
    return map;
  }
}


class HelloWorldSayHelloResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String message = null;

  HelloWorldSayHelloResponseParams() : super(kVersions.last.size);

  static HelloWorldSayHelloResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HelloWorldSayHelloResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HelloWorldSayHelloResponseParams result = new HelloWorldSayHelloResponseParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.message = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(message, 8, false);
  }

  String toString() {
    return "HelloWorldSayHelloResponseParams("
           "message: $message" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["message"] = message;
    return map;
  }
}

const int _HelloWorld_sayHelloName = 0;

abstract class HelloWorld {
  static const String serviceName = "hello::world::HelloWorld";
  dynamic sayHello(String name,[Function responseFactory = null]);
}


class _HelloWorldProxyImpl extends bindings.Proxy {
  _HelloWorldProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HelloWorldProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _HelloWorldProxyImpl.unbound() : super.unbound();

  static _HelloWorldProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _HelloWorldProxyImpl"));
    return new _HelloWorldProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _HelloWorld_sayHelloName:
        var r = HelloWorldSayHelloResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_HelloWorldProxyImpl($superString)";
  }
}


class _HelloWorldProxyCalls implements HelloWorld {
  _HelloWorldProxyImpl _proxyImpl;

  _HelloWorldProxyCalls(this._proxyImpl);
    dynamic sayHello(String name,[Function responseFactory = null]) {
      var params = new _HelloWorldSayHelloParams();
      params.name = name;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _HelloWorld_sayHelloName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class HelloWorldProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  HelloWorld ptr;

  HelloWorldProxy(_HelloWorldProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _HelloWorldProxyCalls(proxyImpl);

  HelloWorldProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _HelloWorldProxyImpl.fromEndpoint(endpoint) {
    ptr = new _HelloWorldProxyCalls(impl);
  }

  HelloWorldProxy.fromHandle(core.MojoHandle handle) :
      impl = new _HelloWorldProxyImpl.fromHandle(handle) {
    ptr = new _HelloWorldProxyCalls(impl);
  }

  HelloWorldProxy.unbound() :
      impl = new _HelloWorldProxyImpl.unbound() {
    ptr = new _HelloWorldProxyCalls(impl);
  }

  factory HelloWorldProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HelloWorldProxy p = new HelloWorldProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static HelloWorldProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HelloWorldProxy"));
    return new HelloWorldProxy.fromEndpoint(endpoint);
  }

  String get serviceName => HelloWorld.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "HelloWorldProxy($impl)";
  }
}


class HelloWorldStub extends bindings.Stub {
  HelloWorld _impl = null;

  HelloWorldStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  HelloWorldStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  HelloWorldStub.unbound() : super.unbound();

  static HelloWorldStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HelloWorldStub"));
    return new HelloWorldStub.fromEndpoint(endpoint);
  }


  HelloWorldSayHelloResponseParams _HelloWorldSayHelloResponseParamsFactory(String message) {
    var mojo_factory_result = new HelloWorldSayHelloResponseParams();
    mojo_factory_result.message = message;
    return mojo_factory_result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _HelloWorld_sayHelloName:
        var params = _HelloWorldSayHelloParams.deserialize(
            message.payload);
        var response = _impl.sayHello(params.name,_HelloWorldSayHelloResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _HelloWorld_sayHelloName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _HelloWorld_sayHelloName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  HelloWorld get impl => _impl;
  set impl(HelloWorld d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "HelloWorldStub($superString)";
  }

  int get version => 0;
}


