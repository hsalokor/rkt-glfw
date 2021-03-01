#! /usr/bin/env racket
#lang racket/base

(require "glfw.rkt")

(glfwInit)
(define window (glfwCreateWindow 800 600 "Example window" #f #f))


(define image (make-GLFWgammaramp '(2 10) '(4 11) '(5 12) 2))
(ptr-ref (GLFWgammaramp-red image))


(sleep 3)
(glfwDestroyWindow window)
(glfwTerminate)
