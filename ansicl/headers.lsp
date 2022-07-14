(defun chapter (chap name)
  (concatenate
    'string
    (format nil "~%==================================================")
    (format nil "~%    ~A ~A" chap name)
    (format nil "~%==================================================")))

(defun section (chap sec name)
  (concatenate 
    'string
    (format nil "~%    ~A.~A ~A" chap sec name)
    (format nil "~%--------------------------------------------------")))

(defun exercise (num desc) "")
(defun answer (a) "")
(defun done () (format nil "~%"))
(defun ddone () (format nil "~%~%"))
