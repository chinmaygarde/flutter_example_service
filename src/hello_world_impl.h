// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef HELLO_WORLD_SRC_HELLO_WORLD_IMPL_H_
#define HELLO_WORLD_SRC_HELLO_WORLD_IMPL_H_

#include "mojo/public/cpp/system/macros.h"
#include "mojo/public/cpp/application/interface_factory.h"
#include "mojo/public/cpp/bindings/strong_binding.h"

#include "hello_world/hello_world.mojom.h"

namespace hello {
namespace world {

class HelloWorldImpl : public HelloWorld {
 public:
  explicit HelloWorldImpl(mojo::InterfaceRequest<HelloWorld> request);

  ~HelloWorldImpl() override;

  void SayHello(const mojo::String& name,
                const SayHelloCallback& callback) override;

 private:
  mojo::StrongBinding<HelloWorld> binding_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(HelloWorldImpl);
};

}  // namespace world
}  // namespace hello

#endif  // HELLO_WORLD_SRC_HELLO_WORLD_IMPL_H_
