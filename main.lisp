(load "~/.sbcl/quicklisp/setup.lisp")
(ql:quickload "lispbuilder-sdl")
(load "variables.lisp")
(load "sdl.lisp")
(load "game.lisp")



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
					;; Update grid dimensions
					(setq M (parse-integer (nth 1 *posix-argv*)))
					(setq N (parse-integer (nth 2 *posix-argv*)))

					;; Init grid
					(setq current_grid (make-array (list N M)))
					(setq next_grid (make-array (list N M)))

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
							   (game)
							   (sdl:update-display)
							   )
						))
					))

(sb-int:with-float-traps-masked (:invalid :inexact :overflow)
  (parse))
