(load "sdl.lisp")
(load "variables.lisp")

(defun get_sum (y x) (
					  let ((sum 0))
					   (loop for j from (- y 1) to (+ y 1) ; Iterate over lines
						  do (loop for i from (- x 1) to (+ x 1) ; Iterate over columns
								 do (if (and
										  (not (and (= j y) (= i x))) ; Not on the current cell
										  (= (ignore-errors (aref current_grid j i)) 1) ; && Neighbor is alive
										  ) 
										 (setq sum (+ sum 1)) ; Then Add 1 to alive neighbor count
										 ;; () ; else statement
										 
									 )))
	   (sum)
					   ))

(defun game () (
				;;; For each cell, compute the number of alive
				;;; neighboor and deduce the cell's next state. Redraw the cell, only if its next state is different from the current one
				;;;
				;;; List of combinations:
				;;; Sum is < 2 || > 3 -> Dead next turn
				;;; Sum is 3 -> Alive next turn
				;;; Else -> State unchanged next turn

				let ((sum 0))
				 (loop for y from 0 to N
					do (loop for x from 0 to M
						  do (
							  let ()
							  (setq sum (get_sum (y x))) ; Number of alive neighboor
							  (setq (aref next_grid y x) (cond ; Select new state
										  ((or (< 2 sum) (> 3 sum)) (draw y x DEAD) 0)
										  ((= sum 3) (draw y x ALIVE) 1)
										  (t (aref current_grid y x))
																)
										 )
								   )))
				 )) 



;; (if (and (not (and (= j y) (= i x))) ; Avoid the current cell
;; 		 (and (/= (ignore-errors (aref current_grid i j)) NIL)
;; 			  (= (ignore-errors (aref current_grid i j)) 1)))
;; 	(setq live (+ live 1)))
