// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "hello_world/src/hello_world_impl.h"

#include <sstream>

#include "mojo/public/c/system/types.h"

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

extern "C" {

MojoResult HelloWorldMain(MojoHandle client_handle, const char* service_name)
    __attribute__((visibility("default")));
MojoResult HelloWorldMain(MojoHandle client_handle, const char* service_name) {
  if (strcmp(service_name, hello::world::HelloWorld::Name_) != 0) {
    return MOJO_RESULT_NOT_FOUND;
  }

  mojo::MessagePipeHandle message_pipe_handle(client_handle);
  mojo::ScopedMessagePipeHandle scoped_handle(message_pipe_handle);

  new hello::world::HelloWorldImpl(
      mojo::MakeRequest<hello::world::HelloWorld>(scoped_handle.Pass()));

  return MOJO_RESULT_OK;
}
//
}

}  // namespace world
}  // namespace hello
