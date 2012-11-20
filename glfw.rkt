(module glfw/unsafe racket/base
  (require ffi/unsafe
           ffi/unsafe/define
           ffi/unsafe/alloc)

  (provide (except-out (all-defined-out)
                       check))

  (define GL_FALSE              0)
  (define GL_TRUE               1)

  ; Key and button state/action definitions
  (define GLFW_RELEASE          0)
  (define GLFW_PRESS            1)

  ; Keyboard key definitions
  (define GLFW_KEY_UNKNOWN      -1)
  (define GLFW_KEY_SPACE        32)
  (define GLFW_KEY_SPECIAL      256)
  (define GLFW_KEY_ESC          (+ GLFW_KEY_SPECIAL 1))
  (define GLFW_KEY_F1           (+ GLFW_KEY_SPECIAL 2))
  (define GLFW_KEY_F2           (+ GLFW_KEY_SPECIAL 3))
  (define GLFW_KEY_F3           (+ GLFW_KEY_SPECIAL 4))
  (define GLFW_KEY_F4           (+ GLFW_KEY_SPECIAL 5))
  (define GLFW_KEY_F5           (+ GLFW_KEY_SPECIAL 6))
  (define GLFW_KEY_F6           (+ GLFW_KEY_SPECIAL 7))
  (define GLFW_KEY_F7           (+ GLFW_KEY_SPECIAL 8))
  (define GLFW_KEY_F8           (+ GLFW_KEY_SPECIAL 9))
  (define GLFW_KEY_F9           (+ GLFW_KEY_SPECIAL 10))
  (define GLFW_KEY_F10          (+ GLFW_KEY_SPECIAL 11))
  (define GLFW_KEY_F11          (+ GLFW_KEY_SPECIAL 12))
  (define GLFW_KEY_F12          (+ GLFW_KEY_SPECIAL 13))
  (define GLFW_KEY_F13          (+ GLFW_KEY_SPECIAL 14))
  (define GLFW_KEY_F14          (+ GLFW_KEY_SPECIAL 15))
  (define GLFW_KEY_F15          (+ GLFW_KEY_SPECIAL 16))
  (define GLFW_KEY_F16          (+ GLFW_KEY_SPECIAL 17))
  (define GLFW_KEY_F17          (+ GLFW_KEY_SPECIAL 18))
  (define GLFW_KEY_F18          (+ GLFW_KEY_SPECIAL 19))
  (define GLFW_KEY_F19          (+ GLFW_KEY_SPECIAL 20))
  (define GLFW_KEY_F20          (+ GLFW_KEY_SPECIAL 21))
  (define GLFW_KEY_F21          (+ GLFW_KEY_SPECIAL 22))
  (define GLFW_KEY_F22          (+ GLFW_KEY_SPECIAL 23))
  (define GLFW_KEY_F23          (+ GLFW_KEY_SPECIAL 24))
  (define GLFW_KEY_F24          (+ GLFW_KEY_SPECIAL 25))
  (define GLFW_KEY_F25          (+ GLFW_KEY_SPECIAL 26))
  (define GLFW_KEY_UP           (+ GLFW_KEY_SPECIAL 27))
  (define GLFW_KEY_DOWN         (+ GLFW_KEY_SPECIAL 28))
  (define GLFW_KEY_LEFT         (+ GLFW_KEY_SPECIAL 29))
  (define GLFW_KEY_RIGHT        (+ GLFW_KEY_SPECIAL 30))
  (define GLFW_KEY_LSHIFT       (+ GLFW_KEY_SPECIAL 31))
  (define GLFW_KEY_RSHIFT       (+ GLFW_KEY_SPECIAL 32))
  (define GLFW_KEY_LCTRL        (+ GLFW_KEY_SPECIAL 33))
  (define GLFW_KEY_RCTRL        (+ GLFW_KEY_SPECIAL 34))
  (define GLFW_KEY_LALT         (+ GLFW_KEY_SPECIAL 35))
  (define GLFW_KEY_RALT         (+ GLFW_KEY_SPECIAL 36))
  (define GLFW_KEY_TAB          (+ GLFW_KEY_SPECIAL 37))
  (define GLFW_KEY_ENTER        (+ GLFW_KEY_SPECIAL 38))
  (define GLFW_KEY_BACKSPACE    (+ GLFW_KEY_SPECIAL 39))
  (define GLFW_KEY_INSERT       (+ GLFW_KEY_SPECIAL 40))
  (define GLFW_KEY_DEL          (+ GLFW_KEY_SPECIAL 41))
  (define GLFW_KEY_PAGEUP       (+ GLFW_KEY_SPECIAL 42))
  (define GLFW_KEY_PAGEDOWN     (+ GLFW_KEY_SPECIAL 43))
  (define GLFW_KEY_HOME         (+ GLFW_KEY_SPECIAL 44))
  (define GLFW_KEY_END          (+ GLFW_KEY_SPECIAL 45))
  (define GLFW_KEY_KP_0         (+ GLFW_KEY_SPECIAL 46))
  (define GLFW_KEY_KP_1         (+ GLFW_KEY_SPECIAL 47))
  (define GLFW_KEY_KP_2         (+ GLFW_KEY_SPECIAL 48))
  (define GLFW_KEY_KP_3         (+ GLFW_KEY_SPECIAL 49))
  (define GLFW_KEY_KP_4         (+ GLFW_KEY_SPECIAL 50))
  (define GLFW_KEY_KP_5         (+ GLFW_KEY_SPECIAL 51))
  (define GLFW_KEY_KP_6         (+ GLFW_KEY_SPECIAL 52))
  (define GLFW_KEY_KP_7         (+ GLFW_KEY_SPECIAL 53))
  (define GLFW_KEY_KP_8         (+ GLFW_KEY_SPECIAL 54))
  (define GLFW_KEY_KP_9         (+ GLFW_KEY_SPECIAL 55))
  (define GLFW_KEY_KP_DIVIDE    (+ GLFW_KEY_SPECIAL 56))
  (define GLFW_KEY_KP_MULTIPLY  (+ GLFW_KEY_SPECIAL 57))
  (define GLFW_KEY_KP_SUBTRACT  (+ GLFW_KEY_SPECIAL 58))
  (define GLFW_KEY_KP_ADD       (+ GLFW_KEY_SPECIAL 59))
  (define GLFW_KEY_KP_DECIMAL   (+ GLFW_KEY_SPECIAL 60))
  (define GLFW_KEY_KP_EQUAL     (+ GLFW_KEY_SPECIAL 61))
  (define GLFW_KEY_KP_ENTER     (+ GLFW_KEY_SPECIAL 62))
  (define GLFW_KEY_KP_NUM_LOCK  (+ GLFW_KEY_SPECIAL 63))
  (define GLFW_KEY_CAPS_LOCK    (+ GLFW_KEY_SPECIAL 64))
  (define GLFW_KEY_SCROLL_LOCK  (+ GLFW_KEY_SPECIAL 65))
  (define GLFW_KEY_PAUSE        (+ GLFW_KEY_SPECIAL 66))
  (define GLFW_KEY_LSUPER       (+ GLFW_KEY_SPECIAL 67))
  (define GLFW_KEY_RSUPER       (+ GLFW_KEY_SPECIAL 68))
  (define GLFW_KEY_MENU         (+ GLFW_KEY_SPECIAL 69))
  (define GLFW_KEY_LAST         GLFW_KEY_MENU)

  ; Mouse button definitions
  (define GLFW_MOUSE_BUTTON_1      0)
  (define GLFW_MOUSE_BUTTON_2      1)
  (define GLFW_MOUSE_BUTTON_3      2)
  (define GLFW_MOUSE_BUTTON_4      3)
  (define GLFW_MOUSE_BUTTON_5      4)
  (define GLFW_MOUSE_BUTTON_6      5)
  (define GLFW_MOUSE_BUTTON_7      6)
  (define GLFW_MOUSE_BUTTON_8      7)
  (define GLFW_MOUSE_BUTTON_LAST   GLFW_MOUSE_BUTTON_8)

  ; Mouse button aliases
  (define GLFW_MOUSE_BUTTON_LEFT   GLFW_MOUSE_BUTTON_1)
  (define GLFW_MOUSE_BUTTON_RIGHT  GLFW_MOUSE_BUTTON_2)
  (define GLFW_MOUSE_BUTTON_MIDDLE GLFW_MOUSE_BUTTON_3)

  ; Joystick identifiers
  (define GLFW_JOYSTICK_1          0)
  (define GLFW_JOYSTICK_2          1)
  (define GLFW_JOYSTICK_3          2)
  (define GLFW_JOYSTICK_4          3)
  (define GLFW_JOYSTICK_5          4)
  (define GLFW_JOYSTICK_6          5)
  (define GLFW_JOYSTICK_7          6)
  (define GLFW_JOYSTICK_8          7)
  (define GLFW_JOYSTICK_9          8)
  (define GLFW_JOYSTICK_10         9)
  (define GLFW_JOYSTICK_11         10)
  (define GLFW_JOYSTICK_12         11)
  (define GLFW_JOYSTICK_13         12)
  (define GLFW_JOYSTICK_14         13)
  (define GLFW_JOYSTICK_15         14)
  (define GLFW_JOYSTICK_16         15)
  (define GLFW_JOYSTICK_LAST       GLFW_JOYSTICK_16)

  ; glfwOpenWindow modes
  (define GLFW_WINDOW               #x00010001)
  (define GLFW_FULLSCREEN           #x00010002)

  ; glfwGetWindowParam tokens
  (define GLFW_OPENED               #x00020001)
  (define GLFW_ACTIVE               #x00020002)
  (define GLFW_ICONIFIED            #x00020003)
  (define GLFW_ACCELERATED          #x00020004)
  (define GLFW_RED_BITS             #x00020005)
  (define GLFW_GREEN_BITS           #x00020006)
  (define GLFW_BLUE_BITS            #x00020007)
  (define GLFW_ALPHA_BITS           #x00020008)
  (define GLFW_DEPTH_BITS           #x00020009)
  (define GLFW_STENCIL_BITS         #x0002000A)


  ; The following constants are used for both glfwGetWindowParam and glfwOpenWindowHint
  (define GLFW_REFRESH_RATE         #x0002000B)
  (define GLFW_ACCUM_RED_BITS       #x0002000C)
  (define GLFW_ACCUM_GREEN_BITS     #x0002000D)
  (define GLFW_ACCUM_BLUE_BITS      #x0002000E)
  (define GLFW_ACCUM_ALPHA_BITS     #x0002000F)
  (define GLFW_AUX_BUFFERS          #x00020010)
  (define GLFW_STEREO               #x00020011)
  (define GLFW_WINDOW_NO_RESIZE     #x00020012)
  (define GLFW_FSAA_SAMPLES         #x00020013)
  (define GLFW_OPENGL_VERSION_MAJOR #x00020014)
  (define GLFW_OPENGL_VERSION_MINOR #x00020015)
  (define GLFW_OPENGL_FORWARD_COMPAT #x00020016)
  (define GLFW_OPENGL_DEBUG_CONTEXT #x00020017)
  (define GLFW_OPENGL_PROFILE       #x00020018)

  ; GLFW_OPENGL_PROFILE tokens
  (define GLFW_OPENGL_CORE_PROFILE  #x00050001)
  (define GLFW_OPENGL_COMPAT_PROFILE #x00050002)

  ; glfwEnable/glfwDisable tokens
  (define GLFW_MOUSE_CURSOR         #x00030001)
  (define GLFW_STICKY_KEYS          #x00030002)
  (define GLFW_STICKY_MOUSE_BUTTONS #x00030003)
  (define GLFW_SYSTEM_KEYS          #x00030004)
  (define GLFW_KEY_REPEAT           #x00030005)
  (define GLFW_AUTO_POLL_EVENTS     #x00030006)

  ; glfwWaitThread wait modes
  (define GLFW_WAIT                 #x00040001)
  (define GLFW_NOWAIT               #x00040002)

  ; glfwGetJoystickParam tokens
  (define GLFW_PRESENT              #x00050001)
  (define GLFW_AXES                 #x00050002)
  (define GLFW_BUTTONS              #x00050003)

  ; glfwReadImage/glfwLoadTexture2D flags
  (define GLFW_NO_RESCALE_BIT       #x00000001) ; Only for glfwReadImage
  (define GLFW_ORIGIN_UL_BIT        #x00000002)
  (define GLFW_BUILD_MIPMAPS_BIT    #x00000004) ; Only for glfwLoadTexture2D
  (define GLFW_ALPHA_MAP_BIT        #x00000008)

  ; Time spans longer than this (seconds) are considered to be infinity
  (define GLFW_INFINITY 100000.0)

  ; The video mode structure used by glfwGetVideoModes()
  (define-cstruct _GLFWvidmode ([Width _int]
                                [Height _int]
                                [RedBits _int]
                                [BlueBits _int]
                                [GreenBits _int]))

  (define-cstruct _GLFWimage ([Width _int]
                              [Height _int]
                              [Format _int]
                              [BytesPerPixel _int]
                              [Data (_ptr io _byte)]))

  ; Thread ID
  (define _GLFWthread _int)

  ; Mutex object
  (define _GLFWmutex _pointer)

  ; Condition variable object
  (define _GLFWcond _pointer)

  (define (check v who)
    (unless (= GL_TRUE v)
      (error who "failed: ~a" v)))
  
  (define-ffi-definer define-glfw (ffi-lib "libglfw"))

  (define-glfw glfwInit (_fun -> (ret : _int)
                              -> (check ret "glfwInit"))
    #:wrap (deallocator))

  (define-glfw glfwTerminate (_fun -> _void)
    #:wrap (allocator glfwInit))

  (define-glfw glfwGetVersion (_fun (major : (_ptr o _int))
                                    (minor : (_ptr o _int)) 
                                    (rev : (_ptr o _int)) 
                                    -> _void
                                    -> (values major minor rev)))

  (define-glfw glfwOpenWindow (_fun _int _int
                                    _int _int _int _int
                                    _int _int
                                    _int -> _int)
    #:wrap (deallocator))

  (define-glfw glfwOpenWindowHint (_fun _int _int -> _void))

  (define-glfw glfwCloseWindow (_fun -> _void)
    #:wrap (allocator glfwOpenWindow))

  (define-glfw glfwSetWindowTitle (_fun _path -> _void))
  (define-glfw glfwGetWindowSize (_fun (width : (_ptr o _int))
                                       (height : (_ptr o _int))
                                       -> _void
                                       -> (values width height)))
  (define-glfw glfwSetWindowSize (_fun _int _int -> _void)))
