;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;BASE DE REGLES;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(setq r1 '(R1 ((LESSER annee 1950))((nonGenre Rock))))
(setq r2 '(R2 ((LESSER annee 1980))((nonGenre HeavyMetal))))
(setq r3 '(R3 ((MEMBER instrument (GuitareElectrique Batterie Basse Clavier)))((type_instruments electrique))))
(setq r4 '(R4 ((EQUAL voix cri)(EQUAL type_instruments electrique))((genre HeavyMetal)(nonGenre Rock))))
(setq r5 '(R5 ((EQUAL type_instruments electrique))((genre HeavyMetal)(Genre Rock))))
(setq r6 '(R6 ((GREATER bpm 105))((nonGenre Rap))))
(setq r7 '(R7 ((EQUAL voix NIL))((nonGenre Rap))))
(setq r8 '(R8 ((MEMBER instrument (Synthetiseur PlatineDJ Percussions Basse Samples)))((type_instruments electronique))))
(setq r9 '(R9 ((MEMBER paroles (Politique Inegalites)))((Theme engage))))
(setq r10 '(R10 ((MEMBER paroles (Drogue Argent Meurtres Police)))((theme sombre))))
(setq r11 '(R11 ((EQUAL type_instruments electronique) (EQUAL voix parle)) ((classe Rap))))
(setq r12 '(R12 ((EQUAL classe Rap)(EQUAL Theme sombre)((genre GangstaRap)))))
(setq r13 '(R13 ((EQUAL classe Rap)(EQUAL Theme engage)((genre RapConscient)))))
(setq r14 '(R14 ((EQUAL classe Rap) (CONTAIN ligne_instrumentale melodique) (EQUAL vulgarite NIL)) ((genre RapCommercial))))


(setq r30 '(R30 ((MEMBER instrument (Synthetiseur PlatineDJ Percussions Basse Samples)))((type_instruments electronique))))
(setq r31 '(R31 ((EQUAL type_instruments electronique) (CONTAIN ligne_instrumentale repetitive)) (classe Techno))))
(setq r32 '(R32 ((EQUAL classe Techno) (EQUAL voix chant) (EQUAL rythme minimal)) (genre House))))
(setq r33 '(R33 ((EQUAL classe Techno) (CONTAIN instruments (synthetiseur_Roland_TB_303))) (genre Acid_house)))
(setq r34 '(R34 ((EQUAL classe Techno) (EQUAL effet reverb) (CONTAIN ligne_instrumentale un_peu_melodique)) (genre Trance))))


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

