(load "sdl.lisp")
(load "variables.lisp")

(defun get_sum (y x) (
	(defvar i 0)
	(defvar live 0)
	(loop
		(defvar j 0)
		(setq i (+ i 1))
			(loop
				(setq j (+ j 1))
				(if (and (not (and (= i y) (= j x)))
					(and (/= (ignore-errors (aref current_grid i j)) NIL)
						(= (ignore-errors (aref current_grid i j)) 1)))
						(setq live (+ live 1)))
	)))
	(return live)
)

(defun game () (
				 ;; For each cell, compute the number of alive
				 ;; neighboor and deduce the cell's next state. Redraw the cell
				 (defvar sum)
				 (loop for y from 0 to N
					do (loop for x from 0 to M
							(setq sum (get_sum (y x))) ; Number of alive neighboor
							(setq (aref next_grid y x) (cond
														 ((or (< 2 sum) (> 3 sum)) (draw y x DEAD) 0)
														 ((= sum 3) (draw y x ALIVE) 1)
														 (t (t) (aref current_grid y x))
														 )))))
	   )
