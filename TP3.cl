;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;BASE DE REGLES;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(setq r1 '(R1 ((LESSER annee 1950))((nonGenre Rock))))
(setq r2 '(R2 ((LESSER annee 1980))((nonGenre HeavyMetal))))
(setq r3 '(R3 ((MEMBER instrument (GuitareElectrique Batterie Basse Clavier)))((classe rockMetal))))
(setq r4 '(R4 ((EQUAL cri T)(EQUAL classe rockMetal))((genre HeavyMetal)(nonGenre Rock))))
(setq r5 '(R5 ((EQUAL classe rockMetal))((genre HeavyMetal)(Genre Rock))))
(setq r6 '(R6 ((GREATER bpm 105))((nonGenre Rap))))
(setq r7 '(R7 ((EQUAL voix NIL))((nonGenre Rap))))
(setq r8 '(R8 ((MEMBER instrument (Synthetiseur PlatineDJ Percussions Basse Samples)))((genre Rap))))
(setq r9 '(R9 ((EQUAL classe Rap)(member Theme (Inegalites Politique))((classe RapConscient))))
(setq r10 '(R10 ((EQUAL classe Rap)(member Theme (Drogue Argent Meurtres Police))((classe RapGangsta))))

;;; Problème : les "instruments" sont les mêmes en techno qu'en rap
      ;; je propose cette solution pour remplacer la règle R8
      ;; c'est juste un exemple, on pourra choisir d'autres critères pour séparer la techno et le rap
      (setq r8 '(R8 ((MEMBER instrument (Synthetiseur PlatineDJ Percussions Basse Samples)))((type_instruments electronique))))
      ;;J'adore cete nouvelle R8, elle est carrément cool et nous fait une belle profondeur !!! Bravo pour l'edit !
      (setq r11 '(R11 ((EQUAL type_instruments electronique) (NOT (EQUAL voix chant))) (classe Rap)))) 
      (setq r12 '(R12 ((EQUAL type_instruments electronique) (EQUAL ligne_instrumentale_repetitive T)) (classe Techno))))

; règles pour déterminer le sous-genre de techno
(setq r13 '(R13 ((EQUAL classe Techno) (EQUAL voix T) (EQUAL rythme minimanl)) (genre House))))
(setq r14 '(R14 ((EQUAL classe Techno) (MEMBER sythetiseur_Roland_TB_303 instruments)) (genre Acid_house))))
(setq r15 '(R15 ((EQUAL classe Techno) (E


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
