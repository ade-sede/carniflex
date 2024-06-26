(load "~/quicklisp/setup.lisp")
(ql:quickload "lispbuilder-sdl")
(load "variables.lisp")
(load "sdl.lisp")
(load "game.lisp")


(defun parse () (if (or (not *posix-argv*) ; No argv
			(/= (list-length *posix-argv*) 3) ; Not exactly 2 arguments
			(not (and ; Arguments are not positiv integers
			      (typep (ignore-errors (parse-integer (nth 1 *posix-argv*))) 'integer)
			      (typep (ignore-errors (parse-integer (nth 2 *posix-argv*))) 'integer)
			      (< 0 (ignore-errors (parse-integer (nth 1 *posix-argv*))))
			      (< 0 (ignore-errors (parse-integer (nth 2 *posix-argv*))))
			      (> 150 (ignore-errors (parse-integer (nth 1 *posix-argv*))))
			      (> 150 (ignore-errors (parse-integer (nth 2 *posix-argv*)))))))
		    (print *usage-string*) ; Raise error
		    (main *posix-argv*)))

(defun main (argv) (let ()
		   (setf M (parse-integer (nth 1 *posix-argv*)))
		   (setf N (parse-integer (nth 2 *posix-argv*)))

		   (setf dragBuff (list 0 0))

		   (setf current_grid (make-array (list N M)))
		   (setf next_grid (make-array (list N M)))

		   (setf zoom (max N M))
		   (setf size (/ WIDTH zoom))
		   (setf prevDrag -1)
		   (sdl:with-init ()
		     (sdl:window width height :title-caption "Carniflex")
		     (sdl:clear-display COLOR_BACKGROUND)
		     (sdl:enable-key-repeat 30 30)
		     (redraw)
		     (sdl:update-display)
		     (setf (sdl:frame-rate) 40)
		     (setf prev (+ (time-now) time-to-wait))
		     (sdl:with-events ()
		       (:quit-event () t)
		       (:key-down-event (:key key) (handle-key key))
		       (:mouse-button-up-event (:button button :x x :y y) (buttonUp button y x))
		       (:mouse-motion-event (:state state :x x :y y) (mouseMove y x state))
		       (:idle (if (and (not PAUSE) (is-elapsed prev time-to-wait))
			       (let()
				(game)
				(sdl:update-display)
				(setf prev (time-now)))))))))

(sb-int:with-float-traps-masked (:invalid :inexact :overflow)
  (parse))
