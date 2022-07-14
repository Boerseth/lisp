(load "headers.lsp")

(chapter 4 "SPECIALIZED DATA STRUCTURES") 


(section 4 1 "Arrays")

(setf arr (make-array '(2 3) :initial-element nil))
(aref arr 0 0)
(setf (aref arr 0 0) 'b)
arr
(aref arr 0 0)

(defun arr-mult (a b)
  (let ((c (make-array '(2 2) :initial-element 0)))
    (dolist (i (list 0 1))
      (dolist (j (list 0 1))
        (setf (aref c i j)
              (+ (* (aref a i 0) (aref b 0 j))
                 (* (aref a i 1) (aref b 1 j))))))
    c))

(defun arr-from-list (lst)
  (let ((n (length lst))
        (m (length (car lst))))
    (let ((a (make-array (list n m) :initial-element 0))
          (i 0)
          (j 0))
      (dolist (row lst)
        (setf j 0)
        (dolist (elmt row)
          (setf (aref a i j) elmt)
          (setf j (+ j 1)))
        (setf i (+ i 1)))
      a)))

(setf i (arr-from-list (list (list 1 0) (list 0 1))))
i
(setf a (arr-from-list (list (list 1 2)
                             (list 3 4))))
a
(setf b (arr-from-list (list (list 5 6)
                             (list 7 8))))
b
(setf c (arr-from-list (list (list 5 6 4)
                             (list 7 8 2))))
c

*print-array*
(setf vec (make-array 4 :initial-element nil))
(vector "a" 'b 3)
(svref vec 0)
(svref (vector "zeroth" 1 2) 0)


(section 4 2 "Example: Binary Search")
(defun bin-search (obj vec)
  (let ((len (length vec)))
    (and (not (zerop len))
         (finder obj vec 0 (- len 1)))))

(defun finder (obj vec start end)
  (format t "~A~%" (subseq vec start (+ end 1)))
  (let ((range (- end start)))
    (if (zerop range)
      (if (eql obj (svref vec start))
        start
        nil)
      (let ((mid (+ start (round (/ range 2)))))
        (if (eql obj (svref vec mid))
          mid
          (if (> obj (svref vec mid))
            (finder obj vec (+ mid 1) end)
            (finder obj vec start (- mid 1))))))))

(bin-search 8 (vector 0 1 2 3 4 5 6 7 8 9))
(bin-search 3 (vector 0 1 2 3 4 5 6 7 8 9))


(section 4 3 "Strings and Characters")
;(sort "elbow" #'char<)
(aref "abc" 1)
(char "abc" 1)
(let ((str (copy-seq "Merlin")))
  (setf (char str 3) #\k)
  str)
(equal "fred" "fred")
(equal "fred" "Fred")
(string-equal "fred" "Fred")
(format nil "~A or ~A" "truth" "dare")
(concatenate 'string "not " "to worry")


(section 4 4 "Sequences")
;(mirrorp "abba")
(elt '(a b c) 1)

(defun mirrorp (s)
  (let ((len (length s)))
    (and (evenp len)
         (do ((forward 0 (+ forward 1))
              (back (- len 1) (- back 1)))
           ((or (> forward back)
                (not (eql (elt s forward)
                          (elt s back))))
            (> forward back))))))
(mirrorp "abba")
(mirrorp "abcaba")
(position #\a "fantasia")
(position #\a "fantasia" :start 3 :end 5)
(position #\a "fantasia" :from-end t)
(position 'a '((c d) (a b)) :key #'car)
(position '(c d) '((c d) (a b)))
(position '(c d) '((c d) (a b)) :test #'equal)
(position 3 '(1 0 7 5) :test #'<)
(position 3 '(1 0 7 5) :test #'>)
(defun second-word (str)
  (let ((p1 (position #\  str)))
    (if (null p1)
      nil
      (let ((p2 (position #\  str :start (+ p1 1))))
        (if (null p2)
          (subseq str (+ p1 1))
          (subseq str (+ p1 1) p2))))))
(second-word "Form follows function.")
(second-word "Form")
(find #\a "cat")
(find-if #'characterp "ham")
(setf lst '((complete 2) (incomplete 1)))
(find-if #'(lambda (x)
             (eql (car x) 'complete))
         lst)
(find 'complete lst :key #'car)
(remove-duplicates "abracadabra")
(reduce #'intersection '((b r a d 's) (b a d) (c a t)))


(section 4 5 "Example: Parsing Dates")

(defun tokens (str test start)
  (let ((p1 (position-if test str :start start)))
    (if p1
      (let ((p2 (position-if #'(lambda (c)
                                 (not (funcall test c)))
                             str :start p1)))
        (cons (subseq str p1 p2)
              (if p2
                (tokens str test p2)
                nil)))
      nil)))

(defun constituent (c)
  (and (graphic-char-p c)
       (not (char= c #\  ))))

(tokens "ab12 3cde.f" #'alpha-char-p 0)

(defun parse-date (str)
  (let ((toks (tokens str #'constituent 0)))
    (list (parse-integer (first toks))
          (parse-month (second toks))
          (parse-integer (third toks)))))

(defconstant month-names
             #("jan" "feb" "mar" "apr" "may" "jun"
               "jul" "aug" "sep" "oct" "nov" "dec"))

(defun parse-month (str)
  (let ((p (position str month-names
                     :test #'string-equal)))
    (if p
      (+ p 1)
      nil)))

(parse-date "16 Aug 1980")

(defun my-read-integer (str)
  (if (every #'digit-char-p str)
    (let ((accum 0))
      (dotimes (pos (length str))
        (setf accum (+ (* accum 10)
                       (digit-char-p (char str pos)))))
      accum)
    nil))


(section 4 6 "Structures")
(defun block-height (b) (svref b 0))
