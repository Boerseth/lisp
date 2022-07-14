(defun simulate-read (expression)
  (format t "~A" (concatenate 
                   'string
                   (format nil "~%> ")
                   (format nil "~A" expression))))

(defun simulate-eval (expression)
  (format t "~%~A" (eval expression)))

(defun simulate-repl (expression)
  (progn
    (simulate-read expression)
    (simulate-eval expression)))

(defun run-file-as-if-repl (file)
  (with-open-file (in file)
    (loop
      for expression = (read in nil in)
      until (eq expression in)
      do (simulate-repl expression))))

(loop
  for file in EXT:*ARGS* 
  do (run-file-as-if-repl file))
