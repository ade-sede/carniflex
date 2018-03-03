(load "variables.lisp")

(defun zoomIn () (
	let ()
	(setq zoom (+ zoom 0.1))
	(setq size (* size zoom))
))

(defun speedDown () (
	if (= IMAGE_PER_SEC 1)
		(format t "can't speed less ~%")
		(
		let ()
		(setq IMAGE_PER_SEC (- IMAGE_PER_SEC 1))
		(setf (sdl:frame-rate) IMAGE_PER_SEC)
		)
))

(defun speedUp () (
	if (= IMAGE_PER_SEC 50)
		(format t "can't speed more ~%")
		(
		let ()
		(setq IMAGE_PER_SEC (+ IMAGE_PER_SEC 1))
		(setf (sdl:frame-rate) IMAGE_PER_SEC)
		)
))

;;handle key events
(defun handle-key (key)
	(when (SDL:KEY= KEY :SDL-KEY-ESCAPE) (SDL:PUSH-QUIT-EVENT))
	(when (SDL:KEY= KEY :SDL-KEY-a) (zoomIn))
	(when (SDL:KEY= KEY :SDL-KEY-left) (speedDown))
	(when (SDL:KEY= KEY :SDL-KEY-right) (speedUp))
	;;check keys here: https://gitlab.com/dto/xelf/blob/master/keys.lisp
)

;;DRAW on screen
(defun draw (y x kind) (
	let (
		(sx (+ (* zoom (* x size)) margin))
		(sy (+ (* zoom (* y size)) margin))
	)
	(sdl:draw-box
		(sdl:rectangle-from-edges-* sx sy
			(- (+ sx size) margin)
			(- (+ sy size) margin)
		)
		:color (if (= kind DEAD) COLOR_DEAD COLOR_ALIVE)
	)
))
