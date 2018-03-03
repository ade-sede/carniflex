(load "~/.sbcl/quicklisp/setup.lisp")
(ql:quickload "lispbuilder-sdl")

(load "variables.lisp")
(load "sdl.lisp")
(load "game.lisp")

(defun main (argv)(
	let ()
	;; SDL stuff
	;;(setq size (/ (max (N M)) WIDTH))
	(sdl:with-init ()
	(sdl:window WIDTH HEIGHT :title-caption "Carniflex")
	(setf (sdl:frame-rate) IMAGE_PER_SEC)
	(sdl:clear-display COLOR_DEAD)
  (sdl:with-events ()
		(:quit-event () t)
		(:key-down-event (:key key) (handle-key key))
		(:idle ()
			(sdl:clear-display sdl:*black*)
			(format t "ok ~%")
			(game 0)
			(sdl:update-display)
		)
	))
))

(sb-int:with-float-traps-masked (:invalid :inexact :overflow)
(main *posix-argv*))
