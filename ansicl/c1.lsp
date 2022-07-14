(load "headers.lsp")


(chapter 1 "INTRODUCTION")

(section 1 1 "New Tools")

(defun sum (n)
 (let ((s 0))
   (dotimes (i n s)
     (incf s i))))

(sum 5)

(defun addn (n)
 #'(lambda (x)
     (+ x n)))


(section 1 2 "New Techniques")


(section 1 3 "A New Approach")
