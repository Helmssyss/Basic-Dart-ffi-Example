import 'dart:ffi' as ffi;
import 'dart:io' show Platform;
import 'package:ffi/ffi.dart' as pkg_ffi;

// C: const char* hello(void);
typedef _hello_native_t = ffi.Pointer<pkg_ffi.Utf8> Function();
typedef _hello_dart_t = ffi.Pointer<pkg_ffi.Utf8> Function();

class HelloFFI {
  late final ffi.DynamicLibrary _lib;
  late final _hello_dart_t _hello;

  HelloFFI() {
    if (Platform.isAndroid) {
      _lib = ffi.DynamicLibrary.open('libhello.so');
    } else if (Platform.isIOS || Platform.isMacOS) {
      _lib = ffi.DynamicLibrary.process();
    }

    _hello = _lib
        .lookup<ffi.NativeFunction<_hello_native_t>>('hello')
        .asFunction<_hello_dart_t>();
  }

  String sayHello() {
    final ffi.Pointer<pkg_ffi.Utf8> ptrFunc = _hello();
    return ptrFunc.toDartString();
  }
}
