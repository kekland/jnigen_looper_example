# jnigen_looper_example

Example of a crash when hot-restarting with `Looper.loop()` active.

To build bindings, build the example app and run `dart run jnigen --config jnigen.yaml`.

`package:jni` and `package:jnigen` are from the Git repository at `82c3dc56a5203d03cd0cf809b1e8fad4e2f2d82e`.

My hunch on how to get the Looper working - before a hot restart is executed, we should quit the looper - `Looper.myLooper().quitSafely()`. This should work, but there's no way to detect when a hot restart is happening, unless doing something at the framework level.

Crash 1 - looper is looping, and then a hot restart is requested:

```
E/Dart    (14799): ../../../flutter/third_party/dart/runtime/vm/dart_api_impl.cc: 1534: error: Dart_EnterIsolate expects there to be no current isolate. Did you forget to call Dart_ExitIsolate?
E/DartVM  (14799): version=3.5.0 (stable) (Tue Jul 30 02:17:59 2024 -0700) on "android_arm64"
E/DartVM  (14799): pid=14799, thread=14820, isolate_group=main(0xb400006f6fc21fc0), isolate=main(0xb400006f6fc1f6d0)
E/DartVM  (14799): os=android, arch=arm64, comp=yes, sim=no
E/DartVM  (14799): isolate_instructions=6e95afe080, vm_instructions=6e95afe080
E/DartVM  (14799): fp=6e9211f730, sp=6e9211e5f0, pc=6e95921a74
E/DartVM  (14799):   pc 0x0000006e95921a74 fp 0x0000006e9211f730 /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so+0x22cca74
E/DartVM  (14799): -- End of DumpStackTrace
E/DartVM  (14799):   pc 0x0000000000000000 fp 0x0000006e92121be8 sp 0x0000000000000000 Cannot find code object
E/DartVM  (14799):   pc 0x0000006ef3013740 fp 0x0000006e92121c28 sp 0x0000006e92121bf8 [Optimized] Looper.init:_loop@22041232.#ffiClosure3
E/DartVM  (14799):   pc 0x0000006ef3013190 fp 0x0000006e92121c70 sp 0x0000006e92121c38 [Unoptimized] Looper.loop
E/DartVM  (14799):   pc 0x0000006ef3012aa0 fp 0x0000006e92121ca0 sp 0x0000006e92121c80 [Unoptimized] _HomePageState@17168617._loopLooper@17168617
E/DartVM  (14799):   pc 0x0000006ef3012900 fp 0x0000006e92121cd8 sp 0x0000006e92121cb0 [Unoptimized] _HomePageState@17168617._loopLooper@17168617
E/DartVM  (14799):   pc 0x0000006ef30cb31c fp 0x0000006e92121d28 sp 0x0000006e92121ce8 [Unoptimized] _InkResponseState@315059085.handleTap
E/DartVM  (14799):   pc 0x0000006ef30cae80 fp 0x0000006e92121d60 sp 0x0000006e92121d38 [Unoptimized] _InkResponseState@315059085.handleTap
E/DartVM  (14799):   pc 0x0000006e7f3701d0 fp 0x0000006e92121e20 sp 0x0000006e92121d70 [Unoptimized] GestureRecognizer.invokeCallback
E/DartVM  (14799):   pc 0x0000006ef30c9b10 fp 0x0000006e92121ea8 sp 0x0000006e92121e30 [Unoptimized] TapGestureRecognizer.handleTapUp
E/DartVM  (14799):   pc 0x0000006ef30997e0 fp 0x0000006e92121ef8 sp 0x0000006e92121eb8 [Unoptimized] BaseTapGestureRecognizer._checkUp@224069716
E/DartVM  (14799):   pc 0x0000006e7f36b570 fp 0x0000006e92121f38 sp 0x0000006e92121f08 [Unoptimized] BaseTapGestureRecognizer.handlePrimaryPointer
E/DartVM  (14799):   pc 0x0000006e7f36a644 fp 0x0000006e92121f90 sp 0x0000006e92121f48 [Unoptimized] PrimaryPointerGestureRecognizer.handleEvent
E/DartVM  (14799):   pc 0x0000006e7f369d78 fp 0x0000006e92121fd0 sp 0x0000006e92121fa0 [Unoptimized] PrimaryPointerGestureRecognizer.handleEvent
E/DartVM  (14799):   pc 0x0000006e7f32e3fc fp 0x0000006e92122040 sp 0x0000006e92121fe0 [Unoptimized] PointerRouter._dispatch@219407777
E/DartVM  (14799):   pc 0x0000006e7f32e0c0 fp 0x0000006e92122090 sp 0x0000006e92122050 [Unoptimized] PointerRouter._dispatchEventToRoutes@219407777.<anonymous closure>
E/DartVM  (14799):   pc 0x0000006e87dec918 fp 0x0000006e92122118 sp 0x0000006e921220a0 [Unoptimized] __Map&_HashVMBase&MapMixin&_HashBase&_OperatorEqualsAndHashCode&_LinkedHashMapMixin@3220832.forEach
E/DartVM  (14799):   pc 0x0000006e7f32df28 fp 0x0000006e92122158 sp 0x0000006e92122128 [Unoptimized] PointerRouter._dispatchEventToRoutes@219407777
E/DartVM  (14799):   pc 0x0000006e7f32dab4 fp 0x0000006e921221b8 sp 0x0000006e92122168 [Unoptimized] PointerRouter.route
E/DartVM  (14799):   pc 0x0000006e7f3696e8 fp 0x0000006e92122200 sp 0x0000006e921221c8 [Unoptimized] _WidgetsFlutterBinding&BindingBase&GestureBinding@598399801.handleEvent
E/DartVM  (14799):   pc 0x0000006e7f32d800 fp 0x0000006e92122280 sp 0x0000006e92122210 [Unoptimized] _WidgetsFlutterBinding&BindingBase&GestureBinding@598399801.dispatchEvent
E/DartVM  (14799):   pc 0x0000006e7f32c324 fp 0x0000006e921222d0 sp 0x0000006e92122290 [Unoptimized] _WidgetsFlutterBinding&BindingBase&GestureBinding&SchedulerBinding&ServicesBinding&PaintingBinding&SemanticsBinding&RendererBinding@598399801.dispatchEvent
E/DartVM  (14799):   pc 0x0000006e7f32bcac fp 0x0000006e92122320 sp 0x0000006e921222e0 [Unoptimized] _WidgetsFlutterBinding&BindingBase&GestureBinding@598399801._handlePointerEventImmediately@203304576
E/DartVM  (14799):   pc 0x0000006e7f3290b4 fp 0x0000006e92122360 sp 0x0000006e92122330 [Unoptimized] _WidgetsFlutterBinding&BindingBase&GestureBinding@598399801.handlePointerEvent
E/DartVM  (14799):   pc 0x0000006e7f3fc248 fp 0x0000006e921223a0 sp 0x0000006e92122370 [Unoptimized] _WidgetsFlutterBinding&BindingBase&GestureBinding@598399801._flushPointerEventQueue@203304576
E/DartVM  (14799):   pc 0x0000006e7f313840 fp 0x0000006e92122400 sp 0x0000006e921223b0 [Unoptimized] _WidgetsFlutterBinding&BindingBase&GestureBinding@598399801._handlePointerDataPacket@203304576
E/DartVM  (14799):   pc 0x0000006e7f3135e8 fp 0x0000006e92122440 sp 0x0000006e92122410 [Unoptimized] _WidgetsFlutterBinding&BindingBase&GestureBinding@598399801._handlePointerDataPacket@203304576
E/DartVM  (14799):   pc 0x0000006e80936d54 fp 0x0000006e92122490 sp 0x0000006e92122450 [Unoptimized] _invoke1@15065589
E/DartVM  (14799):   pc 0x0000006e7f30c6fc fp 0x0000006e921224e0 sp 0x0000006e921224a0 [Unoptimized] PlatformDispatcher._dispatchPointerDataPacket@15065589
E/DartVM  (14799):   pc 0x0000006e808020b0 fp 0x0000006e92122518 sp 0x0000006e921224f0 [Unoptimized] _dispatchPointerDataPacket@15065589
E/DartVM  (14799):   pc 0x0000006e7f7117e4 fp 0x0000006e92122548 sp 0x0000006e92122528 [Unoptimized] _dispatchPointerDataPacket@15065589
E/DartVM  (14799):   pc 0x0000006e8b683ac0 fp 0x0000006e92122620 sp 0x0000006e92122558 [Stub] InvokeDartCode
F/libc    (14799): Fatal signal 6 (SIGABRT), code -1 (SI_QUEUE) in tid 14820 (1.ui), pid 14799 (_looper_example)
*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Build fingerprint: 'google/sdk_gphone64_arm64/emu64a:14/UE1A.230829.036.A2/11596452:userdebug/dev-keys'
Revision: '0'
ABI: 'arm64'
Timestamp: 2024-08-26 16:38:27.001214856+0600
Process uptime: 9s
Cmdline: com.example.jnigen_looper_example
pid: 14799, tid: 14820, name: 1.ui  >>> com.example.jnigen_looper_example <<<
uid: 10194
tagged_addr_ctrl: 0000000000000001 (PR_TAGGED_ADDR_ENABLE)
pac_enabled_keys: 000000000000000f (PR_PAC_APIAKEY, PR_PAC_APIBKEY, PR_PAC_APDAKEY, PR_PAC_APDBKEY)
signal 6 (SIGABRT), code -1 (SI_QUEUE), fault addr --------
Abort message: '../../../flutter/third_party/dart/runtime/vm/dart_api_impl.cc: 1534: error: Dart_EnterIsolate expects there to be no current isolate. Did you forget to call Dart_ExitIsolate?'
    x0  0000000000000000  x1  00000000000039e4  x2  0000000000000006  x3  0000006e9211f6b0
    x4  2f2f2f772f1f6f65  x5  2f2f2f772f1f6f65  x6  2f2f2f772f1f6f65  x7  7f7f7f7f7f7f7f7f
    x8  00000000000000f0  x9  00000071a5e56090  x10 0000000000000001  x11 00000071a5ea9058
    x12 0000006e9211dd90  x13 000000000000005b  x14 0000006e9211de40  x15 0000072af2479b06
    x16 00000071a5f16d08  x17 00000071a5eeae90  x18 0000006e91af2000  x19 00000000000039cf
    x20 00000000000039e4  x21 00000000ffffffff  x22 b4000070ffc91c10  x23 0000006e92123000
    x24 0000000000000003  x25 b400006f1fc341a8  x26 0000000000000000  x27 00000000ffffffff
    x28 b400006fdfc1dec8  x29 0000006e9211f730
    lr  00000071a5e9a9b8  sp  0000006e9211f690  pc  00000071a5e9a9e4  pst 0000000000001000
41 total frames
backtrace:
      #00 pc 00000000000669e4  /apex/com.android.runtime/lib64/bionic/libc.so (abort+164) (BuildId: a87908b48b368e6282bcc9f34bcfc28c)
      #01 pc 00000000021c03f0  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #02 pc 000000000251bad4  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #03 pc 00000000021adf74  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #04 pc 00000000021b3914  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #05 pc 00000000021b39d8  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #06 pc 0000000002145aec  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #07 pc 000000000214ee80  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #08 pc 0000000002042d08  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #09 pc 0000000002152cc0  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #10 pc 00000000021b63c4  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #11 pc 0000000001d1a7d0  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #12 pc 0000000001d20360  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #13 pc 00000000000102a4  /system/lib64/libutils.so (android::Looper::pollOnce(int, int*, int*, void**)+408) (BuildId: 4ad4af87e8ab16b872cdbdaf84188131)
      #14 pc 0000000000183604  /system/lib64/libandroid_runtime.so (android::android_os_MessageQueue_nativePollOnce(_JNIEnv*, _jobject*, long, int)+44) (BuildId: c741d6d101847b558f8cdb0633f23335)
      #15 pc 0000000000377030  /apex/com.android.art/lib64/libart.so (art_quick_generic_jni_trampoline+144) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #16 pc 00000000003605a4  /apex/com.android.art/lib64/libart.so (art_quick_invoke_stub+612) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #17 pc 00000000004906b4  /apex/com.android.art/lib64/libart.so (bool art::interpreter::DoCall<false>(art::ArtMethod*, art::Thread*, art::ShadowFrame&, art::Instruction const*, unsigned short, bool, art::JValue*)+1248) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #18 pc 000000000050a5d4  /apex/com.android.art/lib64/libart.so (void art::interpreter::ExecuteSwitchImplCpp<false>(art::interpreter::SwitchImplContext*)+2380) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #19 pc 00000000003797d8  /apex/com.android.art/lib64/libart.so (ExecuteSwitchImplAsm+8) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #20 pc 00000000001fce24  /system/framework/framework.jar (android.os.MessageQueue.next+0)
      #21 pc 000000000037cde0  /apex/com.android.art/lib64/libart.so (art::interpreter::Execute(art::Thread*, art::CodeItemDataAccessor const&, art::ShadowFrame&, art::JValue, bool, bool) (.__uniq.112435418011751916792819755956732575238.llvm.1377403774332988508)+356) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #22 pc 000000000049120c  /apex/com.android.art/lib64/libart.so (bool art::interpreter::DoCall<false>(art::ArtMethod*, art::Thread*, art::ShadowFrame&, art::Instruction const*, unsigned short, bool, art::JValue*)+4152) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #23 pc 0000000000509f94  /apex/com.android.art/lib64/libart.so (void art::interpreter::ExecuteSwitchImplCpp<false>(art::interpreter::SwitchImplContext*)+780) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #24 pc 00000000003797d8  /apex/com.android.art/lib64/libart.so (ExecuteSwitchImplAsm+8) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #25 pc 00000000001fbe08  /system/framework/framework.jar (android.os.Looper.loopOnce+0)
      #26 pc 000000000037cde0  /apex/com.android.art/lib64/libart.so (art::interpreter::Execute(art::Thread*, art::CodeItemDataAccessor const&, art::ShadowFrame&, art::JValue, bool, bool) (.__uniq.112435418011751916792819755956732575238.llvm.1377403774332988508)+356) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #27 pc 000000000049120c  /apex/com.android.art/lib64/libart.so (bool art::interpreter::DoCall<false>(art::ArtMethod*, art::Thread*, art::ShadowFrame&, art::Instruction const*, unsigned short, bool, art::JValue*)+4152) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #28 pc 000000000050a2f8  /apex/com.android.art/lib64/libart.so (void art::interpreter::ExecuteSwitchImplCpp<false>(art::interpreter::SwitchImplContext*)+1648) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #29 pc 00000000003797d8  /apex/com.android.art/lib64/libart.so (ExecuteSwitchImplAsm+8) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #30 pc 00000000001fc57c  /system/framework/framework.jar (android.os.Looper.loop+0)
      #31 pc 000000000037cde0  /apex/com.android.art/lib64/libart.so (art::interpreter::Execute(art::Thread*, art::CodeItemDataAccessor const&, art::ShadowFrame&, art::JValue, bool, bool) (.__uniq.112435418011751916792819755956732575238.llvm.1377403774332988508)+356) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #32 pc 000000000037c560  /apex/com.android.art/lib64/libart.so (artQuickToInterpreterBridge+672) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #33 pc 0000000000377168  /apex/com.android.art/lib64/libart.so (art_quick_to_interpreter_bridge+88) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #34 pc 0000000000360880  /apex/com.android.art/lib64/libart.so (art_quick_invoke_static_stub+640) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #35 pc 00000000004944c4  /apex/com.android.art/lib64/libart.so (art::JValue art::InvokeWithVarArgs<_jmethodID*>(art::ScopedObjectAccessAlreadyRunnable const&, _jobject*, _jmethodID*, std::__va_list)+516) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #36 pc 0000000000553528  /apex/com.android.art/lib64/libart.so (art::JNI<true>::CallStaticVoidMethodV(_JNIEnv*, _jclass*, _jmethodID*, std::__va_list)+112) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #37 pc 000000000040d7e4  /apex/com.android.art/lib64/libart.so (art::(anonymous namespace)::CheckJNI::CallMethodV(char const*, _JNIEnv*, _jobject*, _jclass*, _jmethodID*, std::__va_list, art::Primitive::Type, art::InvokeType) (.__uniq.99033978352804627313491551960229047428)+356) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #38 pc 0000000000526d00  /apex/com.android.art/lib64/libart.so (art::(anonymous namespace)::CheckJNI::CallStaticVoidMethodV(_JNIEnv*, _jclass*, _jmethodID*, std::__va_list) (.__uniq.99033978352804627313491551960229047428.llvm.14769753146406819462)+60) (BuildId: b10f5696fea1b32039b162aef3850ed3)
      #39 pc 00000000000114a0  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libdartjni.so (globalEnv_CallStaticVoidMethod+208) (BuildId: 365326811c527872a19dc7f82faed2401ac17657)
      #40 pc 00000000000081d4  [anon:dart-code]
Lost connection to device.
```

Crash 2 - looper is looping, sent a few messages from Handler, `quitSafely` is called (not always for some reason):

```I/flutter (15097): _quitLooper
F/libc    (15097): Fatal signal 11 (SIGSEGV), code 1 (SEGV_MAPERR), fault addr 0x43ced17443b61ede in tid 15120 (1.ui), pid 15097 (_looper_example)
*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Build fingerprint: 'google/sdk_gphone64_arm64/emu64a:14/UE1A.230829.036.A2/11596452:userdebug/dev-keys'
Revision: '0'
ABI: 'arm64'
Timestamp: 2024-08-26 16:41:31.739612527+0600
Process uptime: 7s
Cmdline: com.example.jnigen_looper_example
pid: 15097, tid: 15120, name: 1.ui  >>> com.example.jnigen_looper_example <<<
uid: 10194
tagged_addr_ctrl: 0000000000000001 (PR_TAGGED_ADDR_ENABLE)
pac_enabled_keys: 000000000000000f (PR_PAC_APIAKEY, PR_PAC_APIBKEY, PR_PAC_APDAKEY, PR_PAC_APDBKEY)
signal 11 (SIGSEGV), code 1 (SEGV_MAPERR), fault addr 0x43ced17443b61ede
    x0  0000000000000001  x1  00000071a5f317c4  x2  00000071a5f317c4  x3  0000006e9293e898
    x4  0000000000000010  x5  0000000000000001  x6  0000000000000000  x7  0000000000000000
    x8  8e78226b0d7d5416  x9  8e78226b0d7d5416  x10 0000000000000020  x11 000000000000000b
    x12 000000000000fa42  x13 000000007fffffff  x14 00000000027f720e  x15 0000072bfa861aab
    x16 0000000000000001  x17 00000071a5e853b0  x18 0000006e904d6000  x19 00000000ffffffff
    x20 43ced17443b61ede  x21 0000006e9293f000  x22 b400006fdfc1af50  x23 0000006e9293ea20
    x24 b400006fdfc1b020  x25 b400006fdfc1af68  x26 0000000000000001  x27 00000000fffffffe
    x28 b400006fdfc27d98  x29 0000006e9293eb40
    lr  00000071c38552a8  sp  0000006e9293e9c0  pc  00000071c38552b4  pst 0000000060001000
8 total frames
backtrace:
      #00 pc 00000000000102b4  /system/lib64/libutils.so (android::Looper::pollOnce(int, int*, int*, void**)+424) (BuildId: 4ad4af87e8ab16b872cdbdaf84188131)
      #01 pc 0000000000021de0  /system/lib64/libandroid.so (ALooper_pollOnce+100) (BuildId: ee15305f0ca03707d21e5e9e9ab687bc)
      #02 pc 0000000001d202e8  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #03 pc 0000000001d1a71c  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #04 pc 0000000001d1e520  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #05 pc 0000000001d1e3b8  /data/app/~~cRr7LYSjyr0gB3glonr4jA==/com.example.jnigen_looper_example-aRzVfatx0YtyZlwdnanwPQ==/lib/arm64/libflutter.so (BuildId: 38b2e4789cc37a87ec67647fa65c44ef8b714721)
      #06 pc 00000000000cb6a8  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+208) (BuildId: a87908b48b368e6282bcc9f34bcfc28c)
      #07 pc 000000000006821c  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: a87908b48b368e6282bcc9f34bcfc28c)
```

Testing on Android emulator API 34, android-arm64.