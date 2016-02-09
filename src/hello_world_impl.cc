// Copyright 2016 the Flutter project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "hello_world/src/hello_world_impl.h"

#include <sstream>

#include "mojo/public/c/system/types.h"
#include "sky/services/dynamic/dynamic_service_dylib.h"

namespace hello {
namespace world {

HelloWorldImpl::HelloWorldImpl(mojo::InterfaceRequest<HelloWorld> request)
    : binding_(this, request.Pass()) {}

HelloWorldImpl::~HelloWorldImpl() {}

void HelloWorldImpl::SayHello(const mojo::String& name,
                              const SayHelloCallback& callback) {
  std::stringstream stream;
  stream << "Hello, " << name.data() << "!";
  callback.Run(stream.str());
}

}  // namespace world
}  // namespace hello

void FlutterServicePerform(mojo::ScopedMessagePipeHandle client_handle,
                           const mojo::String& service_name) {
  if (service_name == hello::world::HelloWorld::Name_) {
    new hello::world::HelloWorldImpl(
        mojo::MakeRequest<hello::world::HelloWorld>(client_handle.Pass()));
    return;
  }
}
