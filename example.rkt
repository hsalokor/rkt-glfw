#! /usr/bin/env racket
#lang racket/base

(require "glfw.rkt")

(glfwInit)
(define window (glfwCreateWindow 800 600 "Example window" #f #f))


(define image (make-GLFWgammaramp 10 10 10 5))
(GLFWgammaramp-red image)


(sleep 3)
(glfwDestroyWindow window)
(glfwTerminate)
