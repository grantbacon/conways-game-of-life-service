(include-book "avl-rational-keys" :dir :teachpacks)
(include-book "io-utilities" :dir :teachpacks)
(include-book "io-utilities-ex" :dir :teachpacks)
(set-state-ok t)



;(defun main (state)
;   )
;(defun build-next-generation (width height last-gen next-gen)
;   )
;
;(defun build-next-generation-row (width height y last-gen next-gen)
;   )
;
;(defun build-next-generation-cell (width height x y last-gen next-gen)
;   )

(defun stdin->string (state)
   (mv-let (chli error state)
           (let ((channel *standard-ci*))
              (if (null channel)
                  (mv nil
                      "Error while opening stdin for input"
                      state)
                  (mv-let (chlist chnl state)
                          (read-n-chars 4000000000 '() channel state)
                     (let ((state (close-input-channel chnl state)))
                       (mv chlist nil state)))))
      (mv (reverse (chrs->str chli)) error state)))

(defun string-list->stdout (strli state)
  (let ((channel *standard-co*))
     (if (null channel)
         (mv "Error while opening stdout"
             state)
         (mv-let (channel state)
                 (write-all-strings strli channel state)
            (let ((state (close-output-channel channel state)))
              (mv nil state))))))

(defun stdin->lines (state)
  (mv-let (chnl state) 
		 (mv *standard-ci* state)
     (if (null chnl)
         (mv "Error opening standard input" state)
         (mv-let (c1 state)                       ; get one char ahead
                 (read-char$ chnl state)
            (mv-let (rv-lines state)      ; get line, record backwards
                    (rd-lines 4000000000 c1 nil chnl state)
               (let* ((state (close-input-channel chnl state)))
                     (mv (reverse rv-lines) state))))))); rev, deliver

;added width input
(defun get-avl-key (x y width)
   (+ (* width y) x))

;added x y width input
(defun input-lines->avl-tree (x y width input-lines last-gen)
   (if (and (integerp x)
            (integerp y)
            (integerp width)
            (tree? last-gen)                 
            (consp input-lines))
       (if (null (car input-lines))
           (input-lines->avl-tree 0 (1+ y) width (cdr input-lines) last-gen)
           (input-lines->avl-tree (1+ x) y width (cons (cdar input-lines) (cdr input-lines))
                                  (if (equal (car (car input-lines)) #\x)
                                      (avl-insert last-gen (get-avl-key x y width) 0)
                                      last-gen)))
       last-gen))


;added n counter
(defun num-live-neighbors (n width height x y last-gen)
   (if (= n 9)
       0
       (if (= n 4)
           (+ 0 (num-live-neighbors (1+ n) width height x y last-gen))
           (let* ((i (mod (+ (1- x) (floor n 3)) width))
                  (j (mod (+ (1- y) (mod n 3)) height))
                  (key (get-avl-key i j width))
                  (live (if (null (avl-retrieve last-gen key)) 0 1)))
                 (+ live (num-live-neighbors (1+ n) width height x y last-gen))))))

(defun build-next-generation-cell (width height x y last-gen next-gen)
   (let* ((n (num-live-neighbors 0 width height x y last-gen))
          (result (if (null (avl-retrieve last-gen (get-avl-key x y width)))
                      (if (= n 3) #\x #\space)
                      (if (or (< n 2) (> n 3)) #\space #\x))))
         (avl-insert next-gen ())))
                

;test input
(defun main (state)
   )
(num-live-neighbors 0 4 4 1 1 
                    (input-lines->avl-tree 0 0 4 (list (coerce "x xx" 'list)
                                                       (coerce "xxxx" 'list)
                                                       (coerce "x  x" 'list)
                                                       (coerce "   x" 'list))
                                           (empty-tree)))