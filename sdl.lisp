(load "variables.lisp")

(defun zoomIn () (
	let ()
	(setq zoom (+ zoom 0.1))
	(setq csize (* size zoom))
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

(defun handle-click-mouse (button x y) (
	let (
		(bx (truncate (/ x csize)))
		(by (truncate (/ y csize)))
	)
	(format t "x ~d y ~d ~%" bx by)
		(let (
			(sx (+ (* bx csize) margin))
			(sy (+ (* by csize) margin))
		)
			(let (
				(sx2 (- (+ sx csize) margin))
				(sy2 (- (+ sy csize) margin))
			)
			(if (and (and (>= x sx) (<= x sx2)) (and (>= y sy) (<= y sy2)) )
				(progn (setf (aref current_grid by bx) ALIVE) (draw by bx ALIVE) (print "OK") ) ;;in
				(format t "OUT ~%" sx sy) ;;out
			)
		))
))

;;DRAW on screen
(defun draw (y x kind) (
	let (
		(sx (+ (* x csize) margin))
		(sy (+ (* y csize) margin))
	)
	(sdl:draw-box
		(sdl:rectangle-from-edges-* sx sy
			(- (+ sx csize) margin)
			(- (+ sy csize) margin)
		)
		:color (if (= kind DEAD) COLOR_DEAD COLOR_ALIVE)
	)
))
