Hello World Service
===================

Bundled as a dynamic library and loaded at runtime

How To:
-------

* Check out the repo next to the https://github.com/flutter/engine
  * I placed it in the `src/` directory
* Update the hello_world.mojom
* Build the target either by adding a dependency or directly via the command line
* Fill in the implementation
* Package the dylib in the out/ directory along with your application
* In the `ServiceManifest.json` add the framework name, service name and the framework entry function.
