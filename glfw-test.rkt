#lang racket/base
(require (planet schematics/schemeunit:3:4))
(require (planet schematics/schemeunit:3:4/text-ui))
(require "glfw.rkt")

(define-test-suite glfw-init
  #:before (lambda () (glfwInit))
  #:after (lambda () (glfwTerminate)) 

  (test-case "Version query succeeds with non-zero values"
             (let-values ([(major minor rev) (glfwGetVersion)]) 
               (check-not-eq? major 0)
               (check-not-eq? minor 0)
               (check-not-eq? rev 0)))

  (test-case "Opening window in windowed mode succeeds"
             (glfwOpenWindow 400 300
                             8 8 8
                             0 0 0
                             GLFW_WINDOW)
             (glfwCloseWindow))

  (test-case "Opening window in fullscreen mode succeeds"
             (glfwOpenWindow 640 480
                             8 8 8
                             0 0 0
                             GLFW_FULLSCREEN)
             (glfwCloseWindow)))

(define-test-suite glfw-window-functions
  #:before (lambda ()
             (glfwInit)
             (glfwOpenWindow 400 300
                             8 8 8
                             0 0 0
                             GLFW_WINDOW))
  #:after (lambda ()
            (glfwCloseWindow)
            (glfwTerminate))

  (test-case "Setting window title succeeds"
             (glfwSetWindowTitle "Test title"))

  (test-case "Window iconify and restore succeeds"
             (glfwIconifyWindow)
             (glfwRestoreWindow)))

(run-tests glfw-init)
(run-tests glfw-window-functions)
