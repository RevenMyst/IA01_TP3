;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;BASE DE REGLES;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;BONSOIR

(setq r1 '(R1 ((LESSER annee 1950))((nonGenre Rock))))
(setq r2 '(R2 ((LESSER annee 1980))((nonGenre HeavyMetal))))
(setq r3 '(R3 ((MEMBER instrument (GuitareElectrique Batterie Basse Clavier)))((type_instruments electrique))))
(setq r4 '(R4 ((EQUAL voix cri)(EQUAL type_instruments electrique))((genre HeavyMetal)(nonGenre Rock))))
(setq r5 '(R5 ((EQUAL type_instruments electrique))((genre HeavyMetal)(Genre Rock))))
(setq r6 '(R6 ((GREATER bpm 105))((nonGenre Rap))))
(setq r7 '(R7 ((EQUAL voix NIL))((nonGenre Rap))))
(setq r8 '(R8 ((MEMBER instrument (Synthetiseur PlatineDJ Percussions Basse Samples)))((type_instruments electronique))))
(setq r9 '(R9 ((EQUAL type_instruments electronique)(EQUAL Theme engage)((genre RapConscient))))
(setq r10 '(R10 ((EQUAL classe Rap)(member Theme (Drogue Argent Meurtres Police))((genre RapGangsta))))
(setq r11 '(R11 ((EQUAL type_instruments electronique) (EQUAL voix parle)) (classe Rap))))
;;; Problème : les "instruments" sont les mêmes en techno qu'en rap
      ;; je propose cette solution pour remplacer la règle R8
      ;; c'est juste un exemple, on pourra choisir d'autres critères pour séparer la techno et le rap
      (setq r8 '(R8 ((MEMBER instrument (Synthetiseur PlatineDJ Percussions Basse Samples)))((type_instruments electronique))))
      ;;J'adore cete nouvelle R8, elle est carrément cool et nous fait une belle profondeur !!! Bravo pour l'edit !

      (setq r12 '(R12 ((EQUAL type_instruments electronique) (CONTAIN ligne_instrumentale repetitive)) (classe Techno))))

; règles pour déterminer le sous-genre de techno
(setq r13 '(R13 ((EQUAL classe Techno) (EQUAL voix chant) (EQUAL rythme minimal)) (genre House))))
(setq r14 '(R14 ((EQUAL classe Techno) (CONTAIN instruments (synthetiseur_Roland_TB_303))) (genre Acid_house)))
(setq r15 '(R15 ((EQUAL classe Techno) (EQUAL effet reverb) (CONTAIN ligne_instrumentale un_peu_melodique)) (genre Trance))))


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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Checker;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun checkEQUALPrem (prem bdf)
  (let ((res nil))
    (dolist (x bdf res)
      (if (and (equal (car x) (getPremName prem))(equal (cadr x)(getPremValue prem)))
          (setq res T)
        )
      )
    )
  )

