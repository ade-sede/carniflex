(load "variables.lisp")

;;handle key events
(defun handle-key (key)
	(when (SDL:KEY= KEY :SDL-KEY-ESCAPE) (SDL:PUSH-QUIT-EVENT))
	(when (SDL:KEY= KEY :SDL-KEY-PLUS) (format t "YEAAAAY ~%"))
	;;check keys here: https://gitlab.com/dto/xelf/blob/master/keys.lisp
)

;;DRAW on screen
(defun draw (x y) (
	let ((x1 (* M_size x)) (y1 (* N_size y)))
	(sdl:draw-box
		(sdl:rectangle-from-edges-* x1 y1 (+ x1 M_size) (+ y1 N_size))
		:color COLOR_ALIVE)
))
