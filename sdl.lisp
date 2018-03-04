(load "variables.lisp")

(defun time-now () (
    get-internal-real-time
))

(defun is-elapsed (prev elapse) (
    if (>= (- (time-now) prev) elapse)
        1
        nil
))

(defun zoomIn () (
				  if (= zoom 1)
					 (format t "reach max zoom ~%")
					 (
					  let ()
					   (format t "zoom! ~%")
					   (setq zoom (- zoom 1))
					   (setq size (/ WIDTH zoom))
					   (redraw)
					   )
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
				   if (<= time-to-wait 100)
					  (format t "can't speed more ~%")
					  (
							let ()
							(setq time-to-wait (- time-to-wait 100))
						)
					  ))

(defun moveUp () (
				  if (= offY (- 0 N))
					 nil
					 (progn
					   (setq offY (- offY 1))
					   (redraw)
					   )
					 ))

(defun moveDown () (
					if (= offY (- N 1))
					   nil
					   (progn
						 (setq offY (+ offY 1))
						 (redraw)
						 )
					   ))

(defun moveLeft () (
					if (= offX (- 0 M))
					   nil
					   (progn
						 (setq offX (- offX 1))
						 (redraw)
						 )
					   ))


(defun moveRight () (
					 if (= offX (- M 1))
						nil
						(progn
						  (setq offX (+ offX 1))
						  (redraw)
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
	(when (SDL:KEY= KEY :SDL-KEY-KP-PLUS) (zoomIn))
  (when (SDL:KEY= KEY :SDL-KEY-left) (moveLeft))
  (when (SDL:KEY= KEY :SDL-KEY-right) (moveRight))
  (when (SDL:KEY= KEY :SDL-KEY-up) (moveUp))
  (when (SDL:KEY= KEY :SDL-KEY-down) (moveDown))
  (when (SDL:KEY= KEY :SDL-KEY-p) (gamePause))
	(when (SDL:KEY= KEY :SDL-KEY-r) (gameRestart))
  (when (SDL:KEY= KEY :SDL-KEY-a) (speedUp))
  ;;check keys here: https://gitlab.com/dto/xelf/blob/master/keys.lisp
  )

(defun handle-click-mouse (button y x) (
										let (
												(bx (+ (truncate (/ x size)) offX) )
												(by (+ (truncate (/ y size)) offY) )
											 )
											 (format t "y: ~D x: ~D ~%" bx by)
										 (if (is-in-rect bx by 0 0 M N)
											 (if (/= prevDrag 0)
												 (setq prevDrag 0)
												 (progn
												 	(setf (aref current_grid by bx) (if (= 1 (aref current_grid by bx)) DEAD ALIVE))
											   	(draw by bx (if (= 1 (aref current_grid by bx)) ALIVE DEAD))
											   	(sdl:update-display)
											   )
											 )
											)
										 ))

;;DRAW on screen
(defun is-in-rect (x y rx1 ry1 rx2 ry2) (
										 if (and (and (>= x rx1) (<= x rx2)) (and (>= y ry1) (<= y ry2)))
											1
											nil
											))

(defun _draw (y x kind) (
						 let (
							  (sx (* (- x offX) size))
							  (sy (* (- y offY) size))
							  )
						  (sdl:draw-box
						   (sdl:rectangle-from-edges-* sx sy
													   (+ sx size)
													   (+ sy size)
													   )
						   :color (if (= kind DEAD) COLOR_DEAD COLOR_ALIVE)
						   )
						  ))

(defun draw (y x kind) (
						if (is-in-rect x y offX offY (+ offX zoom) (+ offY zoom))
							(_draw y x kind)
								nil
							))

(defun redraw () (
				  progn
				   (sdl:clear-display COLOR_BACKGROUND)
				   (loop for y from 0 to (- N 1)
					  do
						(loop for x from 0 to (- M 1)
						   do
							 (if (= (aref current_grid y x) 1)
								 (draw y x ALIVE)
								 (draw y x DEAD)
								 )
							 )
						)
				   (sdl:update-display)
				   ))

(defun buttonUp (button y x) (
							  progn
							   (if (not drag)
								   (handle-click-mouse button y x)
								   )
							   (setf dragBuff (list 0 0))
							   (setf drag nil)
							   ))

(defun dist (a b) (
		- a b
))

(defun repeat (x fn) (
	if (>= x 1) (
		loop for i from 0 to (- x 1) do (funcall fn)
	)
))

(defun times (preva a)
		(/ (abs (dist preva a)) size)
)


(defun mouseMove (y x state) (
	if (= state 1)
	(progn
		(if (= prevDrag 0)
			(progn (setq prevDragX x) (setq prevDragY y) (setq prevDrag (time-now)) )
		)
		(if (is-elapsed prevDrag 50)
			(progn
				(format t "ok ~d || ~d ~d , old: ~d ~d , d: ~d ~d ~%" size y x prevDragX prevDragY (dist prevDragX x) (dist prevDragY y))
				(if (>= (dist prevDragX x) size) (repeat (times prevDragX x) (function moveRight)))
				(if (<= (dist prevDragX x) (- 0 size)) (repeat (times prevDragX x) (function moveLeft)))
				(if (>= (dist prevDragY y) size) (repeat (times prevDragY y) (function moveDown)))
				(if (<= (dist prevDragY y) (- 0 size)) (repeat (times prevDragY y) (function moveUp)))
				(setq prevDragX x)
				(setq prevDragy y)
				(setq prevDrag (time-now))
			)
		)
	)
))
