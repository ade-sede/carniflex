(load "sdl.lisp")
(load "variables.lisp")

(defun get_sum (y x) (
					  let ((sum 0))
					   (loop for j from (- y 1) to (+ y 1) ; Iterate over lines
						  do (loop for i from (- x 1) to (+ x 1) ; Iterate over columns
								do (
									if (and
										(not (and (= j y) (= i x))) ; Not on the current cell
										(< -1 j)					; Out of bounds check
										(< -1 i)
										(< j N)
										(< i M)
										(= (ignore-errors (aref current_grid j i)) 1) ; && Neighbor is alive
										)
									   (setq sum (+ sum 1)) ; Then Add 1 to alive neighbor count
									   ;; () ; else statement
									   )))
					   sum
					   ))

(defun my_debug (sum y x) (
						   format t "~% Cell ~D ~D has a sum of ~D" x y sum
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

				;; (format t "~% Current grid when entering the game ~% -------------------- ~% ~A" current_grid)
				;; (format t "~D ~%" (aref current_grid 0 0))

				 (loop for y from 0 to (- N 1)
					do (loop for x from 0 to (- M 1)
						  do (
							  let ()
							   (setq sum (get_sum y x)) ; Number of alive neighboor
							   (my_debug sum y x)
							   (setf (aref next_grid y x) (cond ; Select new state
															((or (> 2 sum) (< 3 sum)) 0)
															((= sum 3)  1)
															(t (aref current_grid y x))
															)
									 )
									 (redraw)
							   )))

				 ;; (format t "~% Next grid when exiting the game ~% -------------------- ~% ~A" next_grid)
				 
				(loop for y from 0 to (- N 1)
					do (loop for x from 0 to (- M 1)
						do (
							setf (aref current_grid y x) (aref next_grid y x)
					)))
				 ))
