;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;BASE DE REGLES;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(setq r1 '(R1 ((LESSER annee 1950))((nonGenre Rock))))
(setq r2 '(R2 ((LESSER annee 1980))((nonGenre HeavyMetal))))
(setq r3 '(R3 ((MEMBER instrument (GuitareElectrique Batterie Basse Clavier)))((classe rockMetal))))
(setq r4 '(R4 ((EQUAL cri T)(EQUAL classe rockMetal))((genre HeavyMetal)(nonGenre Rock))))
(setq r5 '(R5 ((EQUAL classe rockMetal))((genre HeavyMetal)(Genre Rock))))


(setq bdr (list r1 r2 r3 r4 r5))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;GETTERs;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun getRuleName (rule)
  (car rule)
  )

(defun getPremisse (rule)
  (cadr rule)
  )

(defun getCcl (rule)
  (caddr rule)
  )
(defun getPremName (prem)
  (cadr prem)
  )
(defun getPremValue (prem)
  (caddr prem)
  )

(defun checkEQUALPrem (prem bdf)
  (let ((res nil))
    (dolist (x bdf res)
      (if (and (equal (car x) (getPremName prem))(equal (cadr x)(getPremValue prem)))
          (setq res T)
        )
      )
    )
  )
(setq prem1 '(EQUAL cri T))
(setq bdf '((cri carotte)))