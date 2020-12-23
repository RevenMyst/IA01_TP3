;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;BASE DE REGLES;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq bdr '(
            
            ;; ---General : 100 --- ;;
            
            (R100 ((EGAL parole mort))((theme violence))) 
            (R101 ((EGAL parole meurtre))((theme violence))) 
            (R102 ((EGAL parole crime))((theme violence))) 
            (R103 ((EGAL parole politique))((theme engage))) 
            (R104 ((EGAL parole inegalite))((theme engage)))

            ;; ---Rock Metal : 200 --- ;;

            (R200 ((LESSER annee 1950))((nonGenre Rock))) 
            (R201 ((LESSER annee 1980))((nonGenre HeavyMetal))) 
            (R203 ((MEMBER instrument (GuitareElectrique Batterie Basse Clavier)))((type_instruments electrique))) 
            (R204 ((EGAL voix cri)(EGAL type_instruments electrique))((genre HeavyMetal)(nonGenre Rock))) 
            (R205 ((EGAL type_instruments electrique))((genre HeavyMetal)(Genre Rock))) 
            (R206 ((EGAL genre HeavyMetal)(EGAL theme violence))((sousGenre DeathMetal))) 
            (R207 ((EGAL genre HeavyMetal)(CONTAIN ligne_instrumentale melodique))((sousGenre PowerMetal)))

            ;; ---Rap : 300 --- ;; 
            (R301 ((GREATER bpm 105))((nonGenre Rap))) 
            (R302 ((EGAL voix NIL))((nonGenre Rap))) 
            (R303 ((MEMBER instrument (Synthetiseur PlatineDJ Percussions Basse Samples)))((type_instruments electronique))) 
            (R304 ((MEMBER paroles (Politique Inegalites)))((Theme engage))) 
            (R305 ((MEMBER paroles (Drogue Argent Meurtres Police)))((theme sombre))) 
            (R306 ((EGAL type_instruments electronique) (EGAL voix parle)) ((classe Rap))) 
            (R307 ((EGAL genre Rap)(EGAL Theme sombre)((sousGenre GangstaRap)))) 
            (R308 ((EGAL genre Rap)(EGAL Theme engage)((sousGenre RapConscient)))) 
            (R309 ((EGAL genre Rap) (CONTAIN ligne_instrumentale melodique) (EGAL vulgarite NIL)) ((sousGenre RapCommercial)))

            ;; ---Techno : 400 --- ;; 
            ;;meme que R303 
            ;;(setq r303 '(R303 ((MEMBER instrument (Synthetiseur PlatineDJ Percussions Basse Samples)))((type_instruments electronique)))) 
            (R401 ((EGAL type_instruments electronique) (CONTAIN ligne_instrumentale repetitive)) (classe Techno)) 
            (R402 ((EGAL classe Techno) (EGAL voix chant) (EGAL rythme minimal)) (genre House)) 
            (R403 ((EGAL classe Techno) (CONTAIN instruments (synthetiseur_Roland_TB_303))) (genre Acid_house)) 
            (R404 ((EGAL classe Techno) (EGAL effet reverb) (CONTAIN ligne_instrumentale un_peu_melodique)) (genre Trance)) 
           
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

(defun checkMEMBERPrem (prem bdf)
  (let ((res T))
    (if (assoc (getPremName prem) bdf)
        (dolist (x (cadr (assoc (getPremName prem) bdf)) res)
          (if (NOT (member x (getPremValue prem))) 
              (setq res NIL)         
            )
          )
      NIL
      )
    )
  )
(defun checkCONTAINPrem (prem bdf)
  (let ((res NIL))
    (if (assoc (getPremName prem) bdf)
        (dolist (x (cadr (assoc (getPremName prem) bdf)) res)
          (if (EQUAL x (getPremValue prem)) 
              (setq res T)         
            )
          )
      NIL
      )
    )
  )
