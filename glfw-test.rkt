#lang racket/base
(require (planet schematics/schemeunit:3:4))
(require (planet schematics/schemeunit:3:4/text-ui))
(require "glfw.rkt")

(run-tests
   (test-suite "Initialization and metadata"
      #:before (lambda () (glfwInit))
      #:after (lambda () (glfwTerminate)) 

   (test-case "glfwGetVersion returns valid version information"
              (let-values ([(major minor rev) (glfwGetVersion)]) 
                (check-not-eq? major 0)
                (check-not-eq? minor 0)
                (check-not-eq? rev 0)))))
