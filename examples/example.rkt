#! /usr/bin/env racket
#lang racket/base

(require "../main.rkt")

(glfwInit)
(define window (glfwCreateWindow 800 600 "Example window" #f #f))
(sleep 3)
(glfwDestroyWindow window)
(glfwTerminate)
