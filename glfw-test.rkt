#lang racket/base

(module+ test
  (require "glfw.rkt"
           racket/function
           rackunit
           rackunit/text-ui)

  (define (check-not-= x y) (check-false (= x y)))

  (define-test-suite initialization
    #:before glfwInit
    #:after glfwTerminate

    (test-case "Version query succeeds with non-zero values"
               (let-values ([(major minor rev) (glfwGetVersion)])
                 (check-not-= major 0)
                 (check-not-= minor 0)
                 (check-not-= rev 0)))

    (test-case "Opening window in windowed mode succeeds"
               (let ([window (glfwCreateWindow 400 300 "Main window" #f #f)])
                 (glfwDestroyWindow window)))

    (test-case "Opening window in fullscreen mode succeeds"
               (let ([window (glfwCreateWindow 400 300 "Main window" (glfwGetPrimaryMonitor) #f)])
                 (glfwDestroyWindow window))))

  (define window #f)
  (define-test-suite window-functions
    #:before (thunk
               (glfwInit)
               (set! window
                 (glfwCreateWindow 400 300 "Main window" #f #f)))
    #:after (thunk
              (glfwDestroyWindow window)
              (glfwTerminate))

    (test-case "Setting and getting window size succeeds"
               (glfwSetWindowSize window 350 250)
               (sleep 1) ; There is a slight delay before the size is actually set
               (let-values ([(x y) (glfwGetWindowSize window)])
                 (check-equal? x 350)
                 (check-equal? y 250)))

    (test-case "Setting window position succeeds"
               (glfwSetWindowPos window 10 10))

    (test-case "Setting window title succeeds"
               (glfwSetWindowTitle window "Test title"))

    (test-case "Window iconify and restore succeeds"
               (glfwIconifyWindow window)
               (glfwRestoreWindow window)))

  (run-tests initialization)
  (run-tests window-functions))
