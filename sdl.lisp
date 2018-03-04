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
					 (format t "Reached max zoom ~%")
					 (
					  let ()
					   (format t "zoom! ~%")
					   (setq zoom (- zoom 1))
					   ;; (setq offX (+ offX 1))
					   ;; (setq offY (+ offY 1))
					   (setq size (/ WIDTH zoom))
					   (redraw)
					   )
					 ))

(defun zoomOut () (
				  if (= zoom (+ (greater N M) 3))
					 (format t "Reached max zoom ~%")
					 (
					  let ()
					   (format t "zoom-out! ~%")
					   (setq zoom (+ zoom 1))
					   (setq size (/ WIDTH zoom))
					   (redraw)
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

(defun speedDown () (
				   if (>= time-to-wait 5000)
					  (format t "can't speed more ~%")
					  (
							let ()
							(setq time-to-wait (+ time-to-wait 100))
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
	(when (SDL:KEY= KEY :SDL-KEY-KP-MINUS) (zoomOut))
  (when (SDL:KEY= KEY :SDL-KEY-left) (moveLeft))
  (when (SDL:KEY= KEY :SDL-KEY-right) (moveRight))
  (when (SDL:KEY= KEY :SDL-KEY-up) (moveUp))
  (when (SDL:KEY= KEY :SDL-KEY-down) (moveDown))
  (when (SDL:KEY= KEY :SDL-KEY-p) (gamePause))
	(when (SDL:KEY= KEY :SDL-KEY-r) (gameRestart))
  (when (SDL:KEY= KEY :SDL-KEY-a) (speedUp))
  (when (SDL:KEY= KEY :SDL-KEY-s) (speedDown))
  ;;check keys here: https://gitlab.com/dto/xelf/blob/master/keys.lisp
  )

(defun handle-click-mouse (button y x) (
										let (
												(bx (+ (truncate (/ x size)) offX) )
												(by (+ (truncate (/ y size)) offY) )
											 )
											 (format t "y: ~D x: ~D ~%" bx by)
										 (if (is-in-rect bx by 0 0 M N)
											 (progn
											   (setf (aref current_grid by bx) (if (= 1 (aref current_grid by bx)) DEAD ALIVE))
											   (draw by bx (if (= 1 (aref current_grid by bx)) ALIVE DEAD))
											   (sdl:update-display)
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

(defun mouseMove (y-rel x-rel state) (
										let (
												(nsize (* -1 size))
											)
									   (if (or (= 0 prevDrag) (is-elapsed prevDrag 100))
										   (
if (= state 1)
										 (progn
										   (setf drag t)
										   (setf (nth 0 dragBuff) (+ (nth 0 dragBuff) y-rel)) ; Add y movement
										   (setf (nth 1 dragBuff) (+ (nth 1 dragBuff) x-rel)) ; Add x movement
										   ;; If movement exceeds size of a cell, move 1 in the right direction

										   ;; (format t "y: ~D x: ~D ~%" y-rel x-rel)

											 

										   (cond
											 ((>= nsize (nth 1 dragBuff) )(progn			;Left
																		  (moveLeft)
																		  (setf (nth 1 dragBuff) (+ (nth 1 dragBuff) size))
																		  ))
										   ((>= size (nth 1 dragBuff)) (progn				;Right
																	   (moveRight)
																	   (setf (nth 1 dragBuff) (- (nth 1 dragBuff) size))
																	   ))
											 ((>= nsize (nth 0 dragBuff) )(progn			;Up
																		  (moveUp)
																		  (setf (nth 0 dragBuff) (+ (nth 0 dragBuff) size))
																		  ))
										   ((>= size (nth 0 dragBuff)) (progn				;Down
																	   (moveDown)
																	   (setf (nth 0 dragBuff) (- (nth 0 dragBuff) size))
																	   ))
										  )
										   (setq prevDrag (time-now))
										 )
											)
										   )
									  
))
