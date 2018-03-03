(defparameter *usage-string* "Usage: sbcl --script main.lisp width height

With:	width, non-zero positiv integer, the width of the grid
		height, non-zero positiv integer, the height of the grid

Note: Integers are 'one-indexed'")
(if (or
	 (not *posix-argv*)
	 (/= (list-length *posix-argv*) 3)
	 (not (and
		   (typep (ignore-errors (parse-integer (nth 1 *posix-argv*))) 'integer)
		   (typep (ignore-errors (parse-integer (nth 2 *posix-argv*))) 'integer)
		   (< 0 (ignore-errors (parse-integer (nth 1 *posix-argv*))))
		   (< 0 (ignore-errors (parse-integer (nth 2 *posix-argv*))))
		   )))
	(print *usage-string*) ; Then statement
	(print "Everything is ok") ; Else statement
	)
