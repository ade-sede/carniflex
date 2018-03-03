(load "variables.lisp")

(defun zoomIn () (
	let ()
	(setq zoom (+ zoom 0.1))
	(setq size (* size zoom))
))

;;handle key events
(defun handle-key (key)
	(when (SDL:KEY= KEY :SDL-KEY-ESCAPE) (SDL:PUSH-QUIT-EVENT))
	(when (SDL:KEY= KEY :SDL-KEY-a) (zoomIn))
	;;check keys here: https://gitlab.com/dto/xelf/blob/master/keys.lisp
)

;;DRAW on screen
(defun draw (y x kind) (
	let (
		(sx (* zoom (* x size)))
		(sy (* zoom (* y size)))
	(sdl:draw-box
		(sdl:rectangle-from-edges-* sx sy (+ sx size) (+ sy size))
		:color (if (= kind DEAD) COLOR_DEAD COLOR_ALIVE)
	)
))
