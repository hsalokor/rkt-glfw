#lang racket/base

(provide (except-out (all-defined-out)
                     racket->cblock
                     racket->array
                     make-GLFWgammaramp
                     make-GLFWgammaramp-aux
                     make-GLFWgamepadstate
                     make-GLFWgamepadstate-aux
                     make-GLFWimage
                     make-GLFWimage-aux)
         (rename-out [make-GLFWgammaramp-aux make-GLFWgammaramp]
                     [make-GLFWgamepadstate-aux make-GLFWgamepadstate]
                     [make-GLFWimage-aux make-GLFWimage]))

(require ffi/unsafe ffi/unsafe/define syntax/parse/define vulkan/unsafe)


(define-simple-macro (defines (name:id value:expr) ...)
  (begin (define name value) ...))

(defines

  ;-------------------------------------------------------------
  ;-------------------------- VALUES ---------------------------
  ;-------------------------------------------------------------

  ;initialization, version and error
  (GLFW_TRUE                      1)
  (GLFW_FALSE                     0)

  ;joystick hat states
  (GLFW_HAT_CENTERED                0)
  (GLFW_HAT_UP                      1)
  (GLFW_HAT_RIGHT                   2)
  (GLFW_HAT_DOWN                    4)
  (GLFW_HAT_LEFT                    8)
  (GLFW_HAT_RIGHT_UP                (bitwise-ior GLFW_HAT_RIGHT GLFW_HAT_UP))
  (GLFW_HAT_RIGHT_DOWN              (bitwise-ior GLFW_HAT_RIGHT GLFW_HAT_DOWN))
  (GLFW_HAT_LEFT_UP                 (bitwise-ior GLFW_HAT_LEFT GLFW_HAT_UP))
  (GLFW_HAT_LEFT_DOWN               (bitwise-ior GLFW_HAT_LEFT GLFW_HAT_DOWN))

  ;keyboard keys
  (GLFW_KEY_UNKNOWN               -1)
  (GLFW_KEY_SPACE                 32)
  (GLFW_KEY_APOSTROPHE            39)
  (GLFW_KEY_COMMA                 44)
  (GLFW_KEY_MINUS                 45)
  (GLFW_KEY_PERIOD                46)
  (GLFW_KEY_SLASH                 47)
  (GLFW_KEY_0                     48)
  (GLFW_KEY_1                     49)
  (GLFW_KEY_2                     50)
  (GLFW_KEY_3                     51)
  (GLFW_KEY_4                     52)
  (GLFW_KEY_5                     53)
  (GLFW_KEY_6                     54)
  (GLFW_KEY_7                     55)
  (GLFW_KEY_8                     56)
  (GLFW_KEY_9                     57)
  (GLFW_KEY_SEMICOLON             59)
  (GLFW_KEY_EQUAL                 61)
  (GLFW_KEY_A                     65)
  (GLFW_KEY_B                     66)
  (GLFW_KEY_C                     67)
  (GLFW_KEY_D                     68)
  (GLFW_KEY_E                     69)
  (GLFW_KEY_F                     70)
  (GLFW_KEY_G                     71)
  (GLFW_KEY_H                     72)
  (GLFW_KEY_I                     73)
  (GLFW_KEY_J                     74)
  (GLFW_KEY_K                     75)
  (GLFW_KEY_L                     76)
  (GLFW_KEY_M                     77)
  (GLFW_KEY_N                     78)
  (GLFW_KEY_O                     79)
  (GLFW_KEY_P                     80)
  (GLFW_KEY_Q                     81)
  (GLFW_KEY_R                     82)
  (GLFW_KEY_S                     83)
  (GLFW_KEY_T                     84)
  (GLFW_KEY_U                     85)
  (GLFW_KEY_V                     86)
  (GLFW_KEY_W                     87)
  (GLFW_KEY_X                     88)
  (GLFW_KEY_Y                     89)
  (GLFW_KEY_Z                     90)
  (GLFW_KEY_LEFT_BRACKET          91)
  (GLFW_KEY_BACKSLASH             92)
  (GLFW_KEY_RIGHT_BRACKET         93)
  (GLFW_KEY_GRAVE_ACCENT          96)
  (GLFW_KEY_WORLD_1               161)
  (GLFW_KEY_WORLD_2               162)
  (GLFW_KEY_ESCAPE                256)
  (GLFW_KEY_ENTER                 257)
  (GLFW_KEY_TAB                   258)
  (GLFW_KEY_BACKSPACE             259)
  (GLFW_KEY_INSERT                260)
  (GLFW_KEY_DELETE                261)
  (GLFW_KEY_RIGHT                 262)
  (GLFW_KEY_LEFT                  263)
  (GLFW_KEY_DOWN                  264)
  (GLFW_KEY_UP                    265)
  (GLFW_KEY_PAGE_UP               266)
  (GLFW_KEY_PAGE_DOWN             267)
  (GLFW_KEY_HOME                  268)
  (GLFW_KEY_END                   269)
  (GLFW_KEY_CAPS_LOCK             280)
  (GLFW_KEY_SCROLL_LOCK           281)
  (GLFW_KEY_NUM_LOCK              282)
  (GLFW_KEY_PRINT_SCREEN          283)
  (GLFW_KEY_PAUSE                 284)
  (GLFW_KEY_F1                    290)
  (GLFW_KEY_F2                    291)
  (GLFW_KEY_F3                    292)
  (GLFW_KEY_F4                    293)
  (GLFW_KEY_F5                    294)
  (GLFW_KEY_F6                    295)
  (GLFW_KEY_F7                    296)
  (GLFW_KEY_F8                    297)
  (GLFW_KEY_F9                    298)
  (GLFW_KEY_F10                   299)
  (GLFW_KEY_F11                   300)
  (GLFW_KEY_F12                   301)
  (GLFW_KEY_F13                   302)
  (GLFW_KEY_F14                   303)
  (GLFW_KEY_F15                   304)
  (GLFW_KEY_F16                   305)
  (GLFW_KEY_F17                   306)
  (GLFW_KEY_F18                   307)
  (GLFW_KEY_F19                   308)
  (GLFW_KEY_F20                   309)
  (GLFW_KEY_F21                   310)
  (GLFW_KEY_F22                   311)
  (GLFW_KEY_F23                   312)
  (GLFW_KEY_F24                   313)
  (GLFW_KEY_F25                   314)
  (GLFW_KEY_KP_0                  320)
  (GLFW_KEY_KP_1                  321)
  (GLFW_KEY_KP_2                  322)
  (GLFW_KEY_KP_3                  323)
  (GLFW_KEY_KP_4                  324)
  (GLFW_KEY_KP_5                  325)
  (GLFW_KEY_KP_6                  326)
  (GLFW_KEY_KP_7                  327)
  (GLFW_KEY_KP_8                  328)
  (GLFW_KEY_KP_9                  329)
  (GLFW_KEY_KP_DECIMAL            330)
  (GLFW_KEY_KP_DIVIDE             331)
  (GLFW_KEY_KP_MULTIPLY           332)
  (GLFW_KEY_KP_SUBTRACT           333)
  (GLFW_KEY_KP_ADD                334)
  (GLFW_KEY_KP_ENTER              335)
  (GLFW_KEY_KP_EQUAL              336)
  (GLFW_KEY_LEFT_SHIFT            340)
  (GLFW_KEY_LEFT_CONTROL          341)
  (GLFW_KEY_LEFT_ALT              342)
  (GLFW_KEY_LEFT_SUPER            343)
  (GLFW_KEY_RIGHT_SHIFT           344)
  (GLFW_KEY_RIGHT_CONTROL         345)
  (GLFW_KEY_RIGHT_ALT             346)
  (GLFW_KEY_RIGHT_SUPER           347)
  (GLFW_KEY_MENU                  348)
  (GLFW_KEY_LAST                  GLFW_KEY_MENU)
  
  ;modifier key flags
  (GLFW_MOD_SHIFT                 #x0001)
  (GLFW_MOD_CONTROL               #x0002)
  (GLFW_MOD_ALT                   #x0004)
  (GLFW_MOD_SUPER                 #x0008)
  (GLFW_MOD_CAPS_LOCK             #x0010)
  (GLFW_MOD_NUM_LOCK              #x0020)
  
  ;mouse buttons
  (GLFW_MOUSE_BUTTON_1            0)
  (GLFW_MOUSE_BUTTON_2            1)
  (GLFW_MOUSE_BUTTON_3            2)
  (GLFW_MOUSE_BUTTON_4            3)
  (GLFW_MOUSE_BUTTON_5            4)
  (GLFW_MOUSE_BUTTON_6            5)
  (GLFW_MOUSE_BUTTON_7            6)
  (GLFW_MOUSE_BUTTON_8            7)
  (GLFW_MOUSE_BUTTON_LAST         GLFW_MOUSE_BUTTON_8)
  (GLFW_MOUSE_BUTTON_LEFT         GLFW_MOUSE_BUTTON_1)
  (GLFW_MOUSE_BUTTON_RIGHT        GLFW_MOUSE_BUTTON_2)
  (GLFW_MOUSE_BUTTON_MIDDLE       GLFW_MOUSE_BUTTON_3)
  
  ;joysticks
  (GLFW_JOYSTICK_1                0)
  (GLFW_JOYSTICK_2                1)
  (GLFW_JOYSTICK_3                2)
  (GLFW_JOYSTICK_4                3)
  (GLFW_JOYSTICK_5                4)
  (GLFW_JOYSTICK_6                5)
  (GLFW_JOYSTICK_7                6)
  (GLFW_JOYSTICK_8                7)
  (GLFW_JOYSTICK_9                8)
  (GLFW_JOYSTICK_10               9)
  (GLFW_JOYSTICK_11               10)
  (GLFW_JOYSTICK_12               11)
  (GLFW_JOYSTICK_13               12)
  (GLFW_JOYSTICK_14               13)
  (GLFW_JOYSTICK_15               14)
  (GLFW_JOYSTICK_16               15)
  (GLFW_JOYSTICK_LAST             GLFW_JOYSTICK_16)
  
  ;gamepad buttons
  (GLFW_GAMEPAD_BUTTON_A          0)
  (GLFW_GAMEPAD_BUTTON_B          1)
  (GLFW_GAMEPAD_BUTTON_X          2)
  (GLFW_GAMEPAD_BUTTON_Y          3)
  (GLFW_GAMEPAD_BUTTON_LEFT_BUMPER 4)
  (GLFW_GAMEPAD_BUTTON_RIGHT_BUMPER 5)            
  (GLFW_GAMEPAD_BUTTON_BACK         6)
  (GLFW_GAMEPAD_BUTTON_START        7)
  (GLFW_GAMEPAD_BUTTON_GUIDE        8)
  (GLFW_GAMEPAD_BUTTON_LEFT_THUMB   9)
  (GLFW_GAMEPAD_BUTTON_RIGHT_THUMB  10)
  (GLFW_GAMEPAD_BUTTON_DPAD_UP      11)
  (GLFW_GAMEPAD_BUTTON_DPAD_RIGHT   12)
  (GLFW_GAMEPAD_BUTTON_DPAD_DOWN    13)
  (GLFW_GAMEPAD_BUTTON_DPAD_LEFT    14)
  (GLFW_GAMEPAD_BUTTON_LAST         GLFW_GAMEPAD_BUTTON_DPAD_LEFT)
  (GLFW_GAMEPAD_BUTTON_CROSS        GLFW_GAMEPAD_BUTTON_A)
  (GLFW_GAMEPAD_BUTTON_CIRCLE       GLFW_GAMEPAD_BUTTON_B)
  (GLFW_GAMEPAD_BUTTON_SQUARE       GLFW_GAMEPAD_BUTTON_X)
  (GLFW_GAMEPAD_BUTTON_TRIANGLE     GLFW_GAMEPAD_BUTTON_Y)
  
  ;gamepad axes
  (GLFW_GAMEPAD_AXIS_LEFT_X       0)
  (GLFW_GAMEPAD_AXIS_LEFT_Y       1)
  (GLFW_GAMEPAD_AXIS_RIGHT_X      2)
  (GLFW_GAMEPAD_AXIS_RIGHT_Y      3)
  (GLFW_GAMEPAD_AXIS_LEFT_TRIGGER 4)
  (GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER 5)                       
  (GLFW_GAMEPAD_AXIS_LAST         GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER)
  
  ;error codes
  (GLFW_NO_ERROR 0)
  (GLFW_NOT_INITIALIZED           #x00010001)
  (GLFW_NO_CURRENT_CONTEXT        #x00010002)
  (GLFW_INVALID_ENUM              #x00010003)
  (GLFW_INVALID_VALUE             #x00010004)
  (GLFW_OUT_OF_MEMORY             #x00010005)
  (GLFW_API_UNAVAILABLE           #x00010006)
  (GLFW_VERSION_UNAVAILABLE       #x00010007)
  (GLFW_PLATFORM_ERROR            #x00010008)
  (GLFW_FORMAT_UNAVAILABLE        #x00010009)
  (GLFW_NO_WINDOW_CONTEXT         #x0001000A)
  
  ;window
  (GLFW_FOCUSED                   #x00020001)
  (GLFW_ICONIFIED                 #x00020002)
  (GLFW_RESIZABLE                 #x00020003)
  (GLFW_VISIBLE                   #x00020004)
  (GLFW_DECORATED                 #x00020005)
  (GLFW_AUTO_ICONIFY              #x00020006)
  (GLFW_FLOATING                  #x00020007)
  (GLFW_MAXIMIZED                 #x00020008)
  (GLFW_CENTER_CURSOR             #x00020009)
  (GLFW_TRANSPARENT_FRAMEBUFFER   #x0002000A)
  (GLFW_HOVERED                   #x0002000B)
  (GLFW_FOCUS_ON_SHOW             #x0002000C)
  (GLFW_RED_BITS                  #x00021001)
  (GLFW_GREEN_BITS                #x00021002)
  (GLFW_BLUE_BITS                 #x00021003)
  (GLFW_ALPHA_BITS                #x00021004)
  (GLFW_DEPTH_BITS                #x00021005)
  (GLFW_STENCIL_BITS              #x00021006)
  (GLFW_ACCUM_RED_BITS            #x00021007)
  (GLFW_ACCUM_GREEN_BITS          #x00021008)
  (GLFW_ACCUM_BLUE_BITS           #x00021009)
  (GLFW_ACCUM_ALPHA_BITS          #x0002100A)
  (GLFW_AUX_BUFFERS               #x0002100B)
  (GLFW_STEREO                    #x0002100C)
  (GLFW_SAMPLES                   #x0002100D)
  (GLFW_SRGB_CAPABLE              #x0002100E)
  (GLFW_REFRESH_RATE              #x0002100F)
  (GLFW_DOUBLEBUFFER              #x00021010)
  (GLFW_CLIENT_API                #x00022001)
  (GLFW_CONTEXT_VERSION_MAJOR     #x00022002)
  (GLFW_CONTEXT_VERSION_MINOR     #x00022003)
  (GLFW_CONTEXT_REVISION          #x00022004)
  (GLFW_CONTEXT_ROBUSTNESS        #x00022005)
  (GLFW_OPENGL_FORWARD_COMPAT     #x00022006)
  (GLFW_OPENGL_DEBUG_CONTEXT      #x00022007)
  (GLFW_OPENGL_PROFILE            #x00022008)
  (GLFW_CONTEXT_RELEASE_BEHAVIOR  #x00022009)
  (GLFW_CONTEXT_NO_ERROR          #x0002200A)
  (GLFW_CONTEXT_CREATION_API      #x0002200B)
  (GLFW_SCALE_TO_MONITOR          #x0002200C)
  (GLFW_COCOA_RETINA_FRAMEBUFFER  #x00023001)
  (GLFW_COCOA_FRAME_NAME          #x00023002)
  (GLFW_COCOA_GRAPHICS_SWITCHING  #x00023003)
  (GLFW_X11_CLASS_NAME            #x00024001)
  (GLFW_X11_INSTANCE_NAME         #x00024002)

  ;glfw
  (GLFW_NO_API                    0)
  (GLFW_OPENGL_API                #x00030001)
  (GLFW_OPENGL_ES_API             #x00030002)
  (GLFW_NO_ROBUSTNESS             0)
  (GLFW_NO_RESET_NOTIFICATION     #x00031001)
  (GLFW_LOSE_CONTEXT_ON_RESET     #x00031002)
  (GLFW_OPENGL_ANY_PROFILE        0)
  (GLFW_OPENGL_CORE_PROFILE       #x00032001)
  (GLFW_OPENGL_COMPAT_PROFILE     #x00032002)
  (GLFW_CURSOR                    #x00033001)
  (GLFW_STICKY_KEYS               #x00033002)
  (GLFW_STICKY_MOUSE_BUTTONS      #x00033003)
  (GLFW_LOCK_KEY_MODS             #x00033004)
  (GLFW_RAW_MOUSE_MOTION          #x00033005)
  (GLFW_CURSOR_NORMAL             #x00034001)
  (GLFW_CURSOR_HIDDEN             #x00034002)
  (GLFW_CURSOR_DISABLED           #x00034003)
  (GLFW_ANY_RELEASE_BEHAVIOR      0)
  (GLFW_RELEASE_BEHAVIOR_FLUSH    #x00035001)
  (GLFW_RELEASE_BEHAVIOR_NONE     #x00035002)
  (GLFW_NATIVE_CONTEXT_API        #x00036001)
  (GLFW_EGL_CONTEXT_API           #x00036002)
  (GLFW_OSMESA_CONTEXT_API        #x00036003)

  ;standard cursor shapes
  (GLFW_ARROW_CURSOR              #x00036001)
  (GLFW_IBEAM_CURSOR              #x00036002)
  (GLFW_CROSSHAIR_CURSOR          #x00036003)
  (GLFW_HAND_CURSOR               #x00036004)
  (GLFW_HRESIZE_CURSOR            #x00036005)
  (GLFW_VRESIZE_CURSOR            #x00036006)
  
  ;glfw
  (GLFW_CONNECTED                 #x00040001)
  (GLFW_DISCONNECTED              #x00040002)

  ;initialization, version and error
  (GLFW_JOYSTICK_HAT_BUTTONS      #x00050001)
  (GLFW_COCOA_CHDIR_RESOURCES     #x00051001)
  (GLFW_COCOA_MENUBAR             #x00051002)

  ;glfw
  (GLFW_DONT_CARE                 -1)

  ;initialization, version and error
  (GLFW_VERSION_MAJOR             3)
  (GLFW_VERSION_MINOR             3)
  (GLFW_VERSION_REVISION          3)

  ;input
  (GLFW_RELEASE                   0)
  (GLFW_PRESS                     1)
  (GLFW_REPEAT                    2)


  ;-------------------------------------------------------------
  ;---------------------- FUNCTION TYPES -----------------------
  ;-------------------------------------------------------------
  
  ;context
  (GLFWglproc                     (_fun -> _void))
  
  ;vulkan support
  (GLFWvkproc                     (_fun -> _void))

  ;initialization, version and error
  (GLFWerrorfun                   (_fun _int _string/utf-8 -> _void))

  ;window
  (GLFWwindowposfun               (_fun _pointer _int _int -> _void))
  (GLFWwindowsizefun              (_fun _pointer _int _int -> _void))
  (GLFWwindowclosefun             (_fun _pointer -> _void))
  (GLFWwindowrefreshfun           (_fun _pointer -> _void))
  (GLFWwindowfocusfun             (_fun _pointer _int -> _void))
  (GLFWwindowiconifyfun           (_fun _pointer _int -> _void))
  (GLFWwindowmaximizefun          (_fun _pointer _int -> _void))
  (GLFWframebuffersizefun         (_fun _pointer _int _int -> _void))
  (GLFWwindowcontentscalefun      (_fun _pointer _float _float -> _void))

  ;input
  (GLFWmousebuttonfun             (_fun _pointer _int _int _int -> _void))
  (GLFWcursorposfun               (_fun _pointer _double _double -> _void))
  (GLFWcursorenterfun             (_fun _pointer _int -> _void))
  (GLFWscrollfun                  (_fun _pointer _double _double -> _void))
  (GLFWkeyfun                     (_fun _pointer _int _int _int _int -> _void))
  (GLFWcharfun                    (_fun _pointer _uint -> _void))
  (GLFWcharmodsfun                (_fun _pointer _uint _int -> _void))
  (GLFWdropfun                    (_fun _pointer _int _pointer -> _void))
  
  ;monitor
  (GLFWmonitorfun                 (_fun _pointer _int -> _void))
  
  ;input
  (GLFWjoystickfun                (_fun _int _int -> _void)))


;-------------------------------------------------------------
;-------------------------- STRUCTS --------------------------
;-------------------------------------------------------------

;racket->cblock :: Converts a list or a vector to a cblock and
;                  returns the pointer to the first element
(define (racket->cblock container type)
  (cond
    [(list? container) (list->cblock container type)]
    [(vector? container) (vector->cblock container type)]
    [else (error 'racket->cblock "Expected list or vector.")]))

;racket->array :: Converts a list or a vector to an array
(define (racket->array container type)
  (cond
    [(list? container) (cast container (_array/list type (length container)))]
    [(vector? container) (cast container (_array/vector type (vector-length container)))]
    [else (error 'racket->array "Expected list or vector.")]))


;monitor
(define-cstruct _GLFWvidmode
  ([width _int]
   [height _int]
   [redBits _int]
   [greenBits _int]
   [blueBits _int]
   [refreshRate _int]))

(define-cstruct _GLFWgammaramp
  ([red _pointer]
   [green _pointer]
   [blue _pointer]
   [size _int]))

;Interface for the constructor of _GLFWgammaramp
(define (make-GLFWgammaramp-aux red green blue size)
  (make-GLFWgammaramp (racket->cblock red _ushort)
                      (racket->cblock green _ushort)
                      (racket->cblock blue _ushort)
                      size))
  

;input
(define-cstruct _GLFWgamepadstate
  ([buttons (_array _wchar 15)]
   [axes (_array _float 6)]))

;Interface for the constructor of _GLFWgamepadstate
(define (make-GLFWgamepadstate-aux buttons axes)
  (make-GLFWgamepadstate (racket->array buttons _wchar)
                         (racket->array axes _float)))

;window
(define-cstruct _GLFWimage
  ([width _int]
   [height _int]
   [pixels _pointer]))

;Interface for the constructor of _GLFWimage
(define (make-GLFWimage-aux width height pixels)
  (make-GLFWimage width height (racket->cblock pixels _wchar)))


;-------------------------------------------------------------
;------------------------- FUNCTIONS -------------------------
;-------------------------------------------------------------

(define-simple-macro (define-ffi-functions lib:expr (name:id (ctype:expr ...)) ...)
  (begin (define-ffi-definer lib-definer lib) (lib-definer name (_fun ctype ...)) ...))

(define-ffi-functions (ffi-lib "glfw3")

  ;initialization, version and error
  (glfwInit                           (-> _int))
  (glfwTerminate                      (-> _void))
  (glfwInitHint                       ((hint : _int) (value : _int) -> _void))
  (glfwGetVersion                     ((major : (_ptr o _int)) (minor : (_ptr o _int)) (rev : (_ptr o _int)) -> _void -> (values major minor rev)))
  (glfwGetVersionString               (-> _string/utf-8))
  (glfwGetError                       ((description : (_ptr o _string/utf-8)) -> (err-code : _int) -> (values err-code description)))
  (glfwSetErrorCallback               (GLFWerrorfun -> GLFWerrorfun))

  ;monitor
  (glfwGetMonitors                    ((count : (_ptr o _int)) -> (monitors : _pointer) -> (values monitors count)))
  (glfwGetPrimaryMonitor              (-> _pointer))
  (glfwGetMonitorPos                  ((monitor : _pointer) (xpos : (_ptr o _int)) (ypos : (_ptr o _int)) -> _void -> (values xpos ypos)))
  (glfwGetMonitorWorkarea             ((monitor : _pointer) (xpos : (_ptr o _int)) (ypos : (_ptr o _int)) (width : (_ptr o _int)) (height : (_ptr o _int)) -> _void -> (values xpos ypos width height)))
  (glfwGetMonitorPhysicalSize         ((monitor : _pointer) (widthMM : (_ptr o _int)) (heightMM : (_ptr o _int)) -> _void -> (values widthMM heightMM)))
  (glfwGetMonitorContentScale         ((monitor : _pointer) (xscale : (_ptr o _float)) (yscale : (_ptr o _float)) -> _void -> (values xscale yscale)))
  (glfwGetMonitorName                 ((monitor : _pointer) -> _string/utf-8))
  (glfwSetMonitorUserPointer          ((monitor : _pointer) -> (pointer : _pointer) -> _void))
  (glfwGetMonitorUserPointer          ((monitor : _pointer) -> _pointer))
  (glfwSetMonitorCallback             ((callback : GLFWmonitorfun) -> GLFWmonitorfun))
  (glfwGetVideoModes                  ((monitor : _pointer) (count : (_ptr o _int)) -> (modes : _GLFWvidmode-pointer) -> (values modes count)))
  (glfwGetVideoMode                   ((monitor : _pointer) -> _GLFWvidmode-pointer))
  (glfwSetGamma                       ((monitor : _pointer) (gamma : _float) -> _void))
  (glfwGetGammaRamp                   ((monitor : _pointer) -> _GLFWgammaramp-pointer))
  (glfwSetGammaRamp                   ((monitor : _pointer) _GLFWgammaramp-pointer -> _void))

  ;window
  (glfwDefaultWindowHints             (-> _void))
  (glfwWindowHint                     ((hint : _int) (value : _int) -> _void))
  (glfwWindowHintString               ((hint : _int) (value : _string/utf-8) -> _void))
  (glfwCreateWindow                   ((width : _int) (height : _int) (title : _string/utf-8) (monitor : _pointer) (share : _pointer) -> _pointer))
  (glfwDestroyWindow                  ((window : _pointer) -> _void))
  (glfwWindowShouldClose              ((window : _pointer) -> _int))
  (glfwSetWindowShouldClose           ((window : _pointer) (value : _int) -> _void))
  (glfwSetWindowTitle                 ((window : _pointer) (title : _string/utf-8) -> _void))
  (glfwSetWindowIcon                  ((window : _pointer) (count : _int) (images : _pointer) -> _void))
  (glfwGetWindowPos                   ((window : _pointer) (xpos : (_ptr o _int)) (ypos : (_ptr o _int)) -> _void -> (values xpos ypos)))
  (glfwSetWindowPos                   ((window : _pointer) (xpos : _int) (ypos : _int) -> _void))
  (glfwGetWindowSize                  ((window : _pointer) (width : (_ptr o _int)) (height : (_ptr o _int)) -> _void -> (values width height)))
  (glfwSetWindowSizeLimits            ((window : _pointer) (minwidth : _int) (minheight : _int) (maxwidth : _int) (maxheight : _int) -> _void))
  (glfwSetWindowAspectRatio           ((window : _pointer) (numer : _int) (denom : _int) -> _void))
  (glfwSetWindowSize                  ((window : _pointer) (width : _int) (height : _int) -> _void))
  (glfwGetFramebufferSize             ((window : _pointer) (width : (_ptr o _int)) (height : (_ptr o _int)) -> _void -> (values width height)))
  (glfwGetWindowFrameSize             ((window : _pointer) (left : (_ptr o _int)) (top : (_ptr o _int)) (right : (_ptr o _int)) (bottom : (_ptr o _int)) -> _void -> (values left top right bottom)))
  (glfwGetWindowContentScale          ((window : _pointer) (xscale : (_ptr o _float)) (yscale : (_ptr o _float)) -> _void))
  (glfwGetWindowOpacity               ((window : _pointer) -> _float))
  (glfwSetWindowOpacity               ((window : _pointer) (opacity : _float) -> _void))
  (glfwIconifyWindow                  ((window : _pointer) -> _void))
  (glfwRestoreWindow                  ((window : _pointer) -> _void))
  (glfwMaximizeWindow                 ((window : _pointer) -> _void))
  (glfwShowWindow                     ((window : _pointer) -> _void))
  (glfwHideWindow                     ((window : _pointer) -> _void))
  (glfwFocusWindow                    ((window : _pointer) -> _void))
  (glfwRequestWindowAttention         ((window : _pointer) -> _void))
  (glfwGetWindowMonitor               ((window : _pointer) -> _pointer))
  (glfwSetWindowMonitor               ((window : _pointer) (monitor : _pointer) (xpos : _int) (ypos : _int) (width : _int) (height : _int) (refreshRate : _int) -> _void))
  (glfwGetWindowAttrib                ((window : _pointer) (attrib : _int) -> _int))
  (glfwSetWindowAttrib                ((window : _pointer) (attrib : _int) (value : _int) -> _void))
  (glfwSetWindowUserPointer           ((window : _pointer) (pointer : _pointer) -> _void))
  (glfwGetWindowUserPointer           ((window : _pointer) -> _pointer))
  (glfwSetWindowPosCallback           ((window : _pointer) (callback : GLFWwindowposfun) -> GLFWwindowposfun))
  (glfwSetWindowSizeCallback          ((window : _pointer) (callback : GLFWwindowsizefun) -> GLFWwindowsizefun))
  (glfwSetWindowCloseCallback         ((window : _pointer) (callback : GLFWwindowclosefun) -> GLFWwindowclosefun))
  (glfwSetWindowRefreshCallback       ((window : _pointer) (callback : GLFWwindowrefreshfun) -> GLFWwindowrefreshfun))
  (glfwSetWindowFocusCallback         ((window : _pointer) (callback : GLFWwindowfocusfun) -> GLFWwindowfocusfun))
  (glfwSetWindowIconifyCallback       ((window : _pointer) (callback : GLFWwindowiconifyfun) -> GLFWwindowiconifyfun))
  (glfwSetWindowMaximizeCallback      ((window : _pointer) (callback : GLFWwindowmaximizefun) -> GLFWwindowmaximizefun))
  (glfwSetFramebufferSizeCallback     ((window : _pointer) (callback : GLFWframebuffersizefun) -> GLFWframebuffersizefun))
  (glfwSetWindowContentScaleCallback  ((window : _pointer) (callback : GLFWwindowcontentscalefun) -> GLFWwindowcontentscalefun))
  (glfwPollEvents                     (-> _void))
  (glfwWaitEvents                     (-> _void))
  (glfwWaitEventsTimeout              ((timeout : _double) -> _void))
  (glfwPostEmptyEvent                 (-> _void))

  ;input
  (glfwGetInputMode                   ((window : _pointer) (mode : _int) -> _int))
  (glfwSetInputMode                   ((window : _pointer) (mode : _int) (value : _int) -> _void))
  (glfwRawMouseMotionSupported        (-> _int))
  (glfwGetKeyName                     ((key : _int) (scancode : _int) -> _string/utf-8))
  (glfwGetKeyScancode                 ((key : _int) -> _int))
  (glfwGetKey                         ((window : _pointer) (key : _int) -> _int))
  (glfwGetMouseButton                 ((window : _pointer) (button : _int) -> _int))
  (glfwGetCursorPos                   ((window : _pointer) (xpos : (_ptr o _double)) (ypos : (_ptr o _double)) -> _void -> (values xpos ypos)))
  (glfwSetCursorPos                   ((window : _pointer) (xpos : _double) (ypos : _double) -> _void))
  (glfwCreateCursor                   ((image : _GLFWimage-pointer) (xhot : _int) (yhot : _int) -> _pointer))
  (glfwCreateStandardCursor           ((shape : _int) -> _pointer))
  (glfwDestroyCursor                  ((cursor : _pointer) -> _void))
  (glfwSetCursor                      ((window : _pointer) (cursor : _pointer) -> _void))
  (glfwSetKeyCallback                 ((window : _pointer) (callback : GLFWkeyfun) -> GLFWkeyfun))
  (glfwSetCharCallback                ((window : _pointer) (callback : GLFWcharfun) -> GLFWcharfun))
  (glfwSetCharModsCallback            ((window : _pointer) (callback : GLFWcharmodsfun) -> GLFWcharmodsfun))
  (glfwSetMouseButtonCallback         ((window : _pointer) (callback : GLFWmousebuttonfun) -> GLFWmousebuttonfun))
  (glfwSetCursorPosCallback           ((window : _pointer) (callback : GLFWcursorposfun) -> GLFWcursorposfun))
  (glfwSetCursorEnterCallback         ((window : _pointer) (callback : GLFWcursorenterfun) -> GLFWcursorenterfun))
  (glfwSetScrollCallback              ((window : _pointer) (callback : GLFWscrollfun) -> GLFWscrollfun))
  (glfwSetDropCallback                ((window : _pointer) (callback : GLFWdropfun) -> GLFWdropfun))
  (glfwJoystickPresent                ((jid : _int) -> _int))
  (glfwGetJoystickAxes                ((jid : _int) (count : (_ptr o _int)) -> (axis : _pointer) -> (values axis count)))
  (glfwGetJoystickButtons             ((jid : _int) (count : (_ptr o _int)) -> (buttons : _pointer) -> (values buttons count)))
  (glfwGetJoystickHats                ((jid : _int) (count : (_ptr o _int)) -> (hats : _pointer) -> (values hats count)))
  (glfwGetJoystickName                ((jid : _int) -> _string/utf-8))
  (glfwGetJoystickGUID                ((jid : _int) -> _string/utf-8))
  (glfwSetJoystickUserPointer         ((jid : _int) (pointer : _pointer) -> _void))
  (glfwGetJoystickUserPointer         ((jid : _int) -> _pointer))
  (glfwJoystickIsGamepad              ((jid : _int) -> _int))
  (glfwSetJoystickCallback            ((callback : GLFWjoystickfun) -> GLFWjoystickfun))
  (glfwUpdateGamepadMappings          ((string : _string/utf-8) -> _int))
  (glfwGetGamepadName                 ((jid : _int) -> _string/utf-8))
  (glfwGetGamepadState                ((jid : _int) (state : (_ptr o _GLFWgamepadstate)) -> (connected : _int) -> (values connected state)))
  (glfwSetClipboardString             ((window : _pointer) (string : _string/utf-8) -> _void))
  (glfwGetClipboardString             ((window : _pointer) -> _string/utf-8))
  (glfwGetTime                        (-> _double))
  (glfwSetTime                        ((time : _double) -> _void))
  (glfwGetTimerValue                  (-> _uint64))
  (glfwGetTimerFrequency              (-> _uint64))
  
  ;context
  (glfwMakeContextCurrent             ((window : _pointer) -> _void))
  (glfwGetCurrentContext              (-> _pointer))

  ;window
  (glfwSwapBuffers                    ((window : _pointer) -> _void))

  ;context
  (glfwSwapInterval                   ((interval : _int) -> _void))
  (glfwExtensionSupported             ((extension : _string/utf-8) -> _int))
  (glfwGetProcAddress                 ((procname : _string/utf-8) -> GLFWglproc))

  ;vulkan support
  (glfwGetInstanceProcAddress                   ((instance : _VkInstance) (procname : _string/utf-8) -> GLFWvkproc))
  (glfwGetPhysicalDevicePresentationSupport     ((instance : _VkInstance) (device : _VkPhysicalDevice) (queuefamily : _uint32) -> _int))
  (glfwCreateWindowSurface                      ((instance : _VkInstance) (window : _pointer) (allocator : _VkAllocationCallbacks-pointer) (surface : (_ptr o _VkSurfaceKHR)) -> (result : _VkResult) -> (values result surface))))
