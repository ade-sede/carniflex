(load "~/.sbcl/quicklisp/setup.lisp")
(ql:quickload "lispbuilder-sdl")

(load "variables.lisp")
(load "sdl.lisp")
(load "game.lisp")

(defun main (argv)(
	let ()
	;; SDL stuff
	(sdl:with-init ()
	(sdl:window width height :title-caption "Carniflex")
	(sdl:update-display)

  (sdl:with-events ()
		(:quit-event () t)
		(:key-down-event (:key key) (handle-key key))
		(:idle ()
			(sdl:clear-display sdl:*black*)
			(game 0)
			(sdl:update-display)
			(sleep 1)
		)
	))
))

(sb-int:with-float-traps-masked (:invalid :inexact :overflow)
(main *posix-argv*))
