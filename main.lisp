(load "~/.sbcl/quicklisp/setup.lisp")
(ql:quickload "lispbuilder-sdl")
(load "variables.lisp")
(load "sdl.lisp")
(load "game.lisp")


(defparameter *usage-string* "Usage: sbcl --script main.lisp width height

With:	width, non-zero positiv integer, the width of the grid
		height, non-zero positiv integer, the height of the grid

Note: Integers are 'one-indexed'")


(defun parse () (if (or
					  (not *posix-argv*) ; No argv
					  (/= (list-length *posix-argv*) 3) ; Not exactly 2 arguments
					  (not (and ; Arguments are not positiv integers
							(typep (ignore-errors (parse-integer (nth 1 *posix-argv*))) 'integer)
							(typep (ignore-errors (parse-integer (nth 2 *posix-argv*))) 'integer)
							(< 0 (ignore-errors (parse-integer (nth 1 *posix-argv*))))
							(< 0 (ignore-errors (parse-integer (nth 2 *posix-argv*))))
							)))
					 (print *usage-string*) ; Raise error
					 (main *posix-argv*) ; Go on
				 ))

(defun main (argv)(
				   let ()
					;; SDL stuff
					(setq M (parse-integer (nth 1 *posix-argv*)))
					(setq N (parse-integer (nth 2 *posix-argv*)))
					(setq size (/ WIDTH (max N M)))
					(setq csize size)
					(sdl:with-init ()
					  (sdl:window width height :title-caption "Carniflex")
					  (sdl:update-display)
						(setf (sdl:frame-rate) IMAGE_PER_SEC)
					  (sdl:with-events ()
						(:quit-event () t)
						(:key-down-event (:key key) (handle-key key))
						(:idle ()
							   (sdl:clear-display COLOR_BACKGROUND)
							   (game 0)
							   (sdl:update-display)
							)
						))
					))

(sb-int:with-float-traps-masked (:invalid :inexact :overflow)
  (parse))
