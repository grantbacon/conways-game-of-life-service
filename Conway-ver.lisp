(in-package "ACL2")
;testing code
(include-book "Conway")
(include-book "doublecheck" :dir :teachpacks)
(include-book "list-utilities" :dir :teachpacks)
(include-book "testing" :dir :teachpacks)

;pretty simple theorem about proving the key is dependent on the x y and width
(defthm avl-key-depend-x-y 
  (implies (and (natp x) (natp y) (natp width))
    (equal (get-avl-key x y width) 
      (+ x (* y width))
      )
    )
  )

(defthm empty-tree-always-nil 
  (implies (and (posp y) (posp width) (posp height) (< y height))
    (equal (build-next-generation width height y (empty-tree) (empty-tree))
      nil
      )
    )
  )

;TODO make another verification theorem