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

(defun gamePause () (
	let ()
	(setq PAUSE (not PAUSE))
))


(defun gameRestart ()
	(setq current_grid (make-array (list N M)))
	(redraw)
	(setq PAUSE t)
	(sdl:update-display)
)
;;handle key events
(defun handle-key (key)
	(when (SDL:KEY= KEY :SDL-KEY-ESCAPE) (SDL:PUSH-QUIT-EVENT))
	(when (SDL:KEY= KEY :SDL-KEY-a) (zoomIn))
	(when (SDL:KEY= KEY :SDL-KEY-left) (speedDown))
	(when (SDL:KEY= KEY :SDL-KEY-right) (speedUp))
	(when (SDL:KEY= KEY :SDL-KEY-p) (gamePause))
	(when (SDL:KEY= KEY :SDL-KEY-r) (gameRestart))
	;;check keys here: https://gitlab.com/dto/xelf/blob/master/keys.lisp
)

(defun handle-click-mouse (button y x) (
	let (
		(bx (truncate (/ x csize)))
		(by (truncate (/ y csize)))
	)
	;; (format t "x ~d y ~d ~%" bx by)
		(let (
			(sx (+ (* bx csize) margin))
			(sy (+ (* by csize) margin))
		)
			(let (
				(sx2 (- (+ sx csize) margin))
				(sy2 (- (+ sy csize) margin))
			)
			(if (and (and (>= x sx) (<= x sx2)) (and (>= y sy) (<= y sy2)))
				(progn 
				(setf (aref current_grid by bx) (if (= 1 (aref current_grid by bx)) DEAD ALIVE))
				(draw by bx (if (= 1 (aref current_grid by bx)) ALIVE DEAD))
				(sdl:update-display)
				)
		))
)))

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

(defun redraw () (
	loop for y from 0 to (- N 1)
		do (loop for x from 0 to (- M 1)
			do (if (= (aref current_grid y x) 1)
			(draw y x ALIVE)
			(draw y x DEAD)
		)
)))

(defun buttonUp (button y x) (
  (progn
	(if (not drag)
		(handle-click-mouse button y x)
		)
	(setf dragBuff (list 0 0))
	(setf drag nil)
	)
  ))

(defun mouseMove (y-rel x-rel state) (
									  if (= (state) SDL-PRESSED)
										 (progn
										   (setf drag t)
										   (seft (car dragBuff) (+ (car dragBuff) y-rel)) ; Add y movement
										   (seft (car dragBuff) (+ (cdr dragBuff) x-rel)) ; Add x movement
										   ;; If movement exceeds size of a cell, move 1 in the right direction
										   (cond
											 ((>= size (abs (car dragBuff))) (if (> 0 (car dragBuff))	; Up or down ?
																				 (moveUp)				; Up
																				 (moveDown)				; Down
																				 ))
											 ((>= size (abs (cdr dragBuff))) (if (> 0 (cdr dragbuff))	; Left or right ?
																				 (moveRight)			; Right
																				 (moveLeft)				; Left
																			  ))
											 )
										   )
					 ))
