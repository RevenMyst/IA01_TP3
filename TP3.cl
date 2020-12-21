;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;BASE DE REGLES;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq bdr '(
            ;; ---General : 100 --- ;;

            (R100 ((EQUAL parole mort))((theme violence)))
            (R101 ((EQUAL parole meurtre))((theme violence)))
            (R102 ((EQUAL parole crime))((theme violence)))
            (R103 ((EQUAL parole politique))((theme engage)))
            (R104 ((EQUAL parole inegalite))((theme engage)))

            ;; ---Rock Metal : 200 --- ;;

            (R200 ((LESSER annee 1950))((nonGenre Rock)))
            (R201 ((LESSER annee 1980))((nonGenre HeavyMetal)))
            (R203 ((MEMBER instrument (GuitareElectrique Batterie Basse Clavier)))((type_instruments electrique)))
            (R204 ((EQUAL voix cri)(EQUAL type_instruments electrique))((genre HeavyMetal)(nonGenre Rock)))
            (R205 ((EQUAL type_instruments electrique))((genre HeavyMetal)(Genre Rock)))
            (R206 ((EQUAL genre HeavyMetal)(EQUAL theme violence))((sousGenre DeathMetal)))
            (R207 ((EQUAL genre HeavyMetal)(CONTAIN ligne_instrumentale melodique))((sousGenre PowerMetal)))

            ;; ---Rap : 300 --- ;;
            (R301 ((GREATER bpm 105))((nonGenre Rap)))
            (R302 ((EQUAL voix NIL))((nonGenre Rap)))
            (R303 ((MEMBER instrument (Synthetiseur PlatineDJ Percussions Basse Samples)))((type_instruments electronique)))
            (R304 ((MEMBER paroles (Politique Inegalites)))((Theme engage)))
            (R305 ((MEMBER paroles (Drogue Argent Meurtres Police)))((theme sombre)))
            (R306 ((EQUAL type_instruments electronique) (EQUAL voix parle)) ((classe Rap)))
            (R307 ((EQUAL genre Rap)(EQUAL Theme sombre)((sousGenre GangstaRap))))
            (R308 ((EQUAL genre Rap)(EQUAL Theme engage)((sousGenre RapConscient))))
            (R309 ((EQUAL genre Rap) (CONTAIN ligne_instrumentale melodique) (EQUAL vulgarite NIL)) ((sousGenre RapCommercial)))

            ;; ---Techno : 400 --- ;;
            ;;meme que R303
            ;;(setq r30 '(R30 ((MEMBER instrument (Synthetiseur PlatineDJ Percussions Basse Samples)))((type_instruments electronique))))
            (R401 ((EQUAL type_instruments electronique) (CONTAIN ligne_instrumentale repetitive)) (genre Techno))
            (R402 ((EQUAL genre Techno) (EQUAL voix chant) (EQUAL rythme minimal)) (sousGenre House))
            (R403 ((EQUAL genre Techno) (CONTAIN instruments (synthetiseur_Roland_TB_303))) (sousGenre Acid_house))
            (R404 ((EQUAL genre Techno) (EQUAL effet reverb) (CONTAIN ligne_instrumentale un_peu_melodique)) (sousGenre Trance))

            )
      )


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
(defun checkGREATERPrem (prem bdf)
  (if (assoc (getPremName prem) bdf)
      (if (> (cadr (assoc (getPremName prem) bdf)) (getPremValue prem))
          T
        NIL
        )
    NIL
    )
  )
(defun checkLESSERPrem (prem bdf)
  (if (assoc (getPremName prem) bdf)
      (if (< (cadr (assoc (getPremName prem) bdf)) (getPremValue prem))
          T
        NIL
        )
    NIL
    )

  )

