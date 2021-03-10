#lang racket/base

(module+ test
  (require "glfw.rkt"
           disposable
           fixture
           racket/function
           rackunit
           rackunit/text-ui)

  (define-test-suite initialization
    #:before glfwInit
    #:after glfwTerminate

    (test-case "Version query succeeds with non-zero values"
      (define-values (major minor rev) (glfwGetVersion))
      (check-not-equal? major 0)
      (check-not-equal? minor 0)
      (check-not-equal? rev 0))

    (test-case "Opening window in windowed mode succeeds"
      (define window (glfwCreateWindow 400 300 "Main window" #f #f))
      (glfwDestroyWindow window))

    (test-case "Opening window in fullscreen mode succeeds"
      (define window (glfwCreateWindow 400 300 "Main window" (glfwGetPrimaryMonitor) #f))
      (glfwDestroyWindow window)))

  (define (create-window)
    (glfwInit)
    (glfwCreateWindow 400 300 "Main window" #f #f))
  (define (destroy-window window)
    (glfwDestroyWindow window)
    (glfwTerminate))

  (define-fixture window (disposable create-window destroy-window))

  (test-case/fixture "window-functions"
    #:fixture window
    (test-case "Setting and getting window size succeeds"
      (glfwSetWindowSize (current-window) 350 250)
      (sleep 1) ; There is a slight delay before the size is actually set
      (define-values (x y) (glfwGetWindowSize (current-window)))
      (check-equal? x 350)
      (check-equal? y 250))

    (test-case "Setting (current-window) position succeeds"
      (glfwSetWindowPos (current-window) 10 10))

    (test-case "Setting (current-window) title succeeds"
      (glfwSetWindowTitle (current-window) "Test title"))

    (test-case "Window iconify and restore succeeds"
      (glfwIconifyWindow (current-window))
      (glfwRestoreWindow (current-window))))

  (run-tests initialization)
  )
