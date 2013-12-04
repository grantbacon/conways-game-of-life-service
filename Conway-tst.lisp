(in-package "ACL2")
;testing code
(include-book "Conway")
(include-book "doublecheck" :dir :teachpacks)
(include-book "list-utilities" :dir :teachpacks)
(include-book "testing" :dir :teachpacks)
;tests for chr->cod
(check-expect (chr->cod #\a) 65)
(check-expect (chr->cod 5) nil)
(check-expect (chr->cod #\SPACE) 0)
(check-expect (chr->cod '(3)) nil)


;tests for get-avl-key
(check-expect (get-avl-key 1 1 3) 4)
(check-expect (get-avl-key 0 0 5) 0)
(check-expect (get-avl-key 5 5 5) 30)
(check-expect (get-avl-key 3 2 20) 43)

;tests for input-lines->avl-tree

;tests for num-live-neighbors

;tests for strings->char-lists

;tests for 