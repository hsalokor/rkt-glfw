#lang racket/base

(require "glfw.rkt")

(define window-width 800)
(define window-height 600)

(define (init)
  (begin
    (glfwInit)
    (glfwOpenWindow window-width window-height
                    8 8 8
                    0 0 0
                    GLFW_WINDOW)
    (glfwSetWindowTitle "Lolbal")
    (sleep 4)
    (glfwCloseWindow)
    (glfwTerminate)))
