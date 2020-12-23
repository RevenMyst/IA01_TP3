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
            (R105 ((EGAL parole police))((theme sombre)))
            (R106 ((EGAL parole meurtres))((theme sombre)))
            (R107 ((EGAL parole crime))((theme sombre)))
            (R108 ((EGAL parole argent))((theme sombre)))
            (R109 ((EGAL parole drogue))((theme sombre)))
 

            ;; ---Rock Metal : 200 --- ;;

            (R200 ((LESSER annee 1950))((nonGenre Rock))) 
            (R201 ((LESSER annee 1980))((nonGenre HeavyMetal))) 
            (R203 ((MEMBRE instruments (GuitareElectrique Batterie Basse Clavier)))((type_instruments electrique))) 
            (R204 ((EGAL voix cri)(EGAL type_instruments electrique))((nonGenre Rock))) 
            (R205 ((EGAL type_instruments electrique))((genre HeavyMetal)(Genre Rock))) 
            (R206 ((EGAL genre HeavyMetal)(EGAL theme violence))((sousGenre DeathMetal))) 
            (R207 ((EGAL genre HeavyMetal)(CONTAIN ligne_instrumentale melodique))((sousGenre PowerMetal)))

            ;; ---Rap : 300 --- ;; 
            (R301 ((GREATER bpm 105))((nonGenre Rap))) 
            (R302 ((EGAL voix NIL))((nonGenre Rap))) 
            (R303 ((MEMBRE instruments (Synthetiseur PlatineDJ Percussions Basse Samples)))((type_instruments electronique))) 
 
            (R306 ((EGAL type_instruments electronique) (EGAL voix parle)) ((genre Rap))) 
            (R307 ((EGAL genre Rap)(EGAL Theme sombre)((sousGenre (Rap GangstaRap))))) 
            (R308 ((EGAL genre Rap)(EGAL Theme engage)((sousGenre (Rap RapConscient))))) 
            (R309 ((EGAL genre Rap) (CONTAIN ligne_instrumentale melodique) (EGAL vulgarite NIL)) ((sousGenre (Rap RapCommercial))))

            ;; ---Techno : 400 --- ;; 
            ;;meme que R303 
            ;;(setq r303 '(R303 ((MEMBER instrument (Synthetiseur PlatineDJ Percussions Basse Samples)))((type_instruments electronique)))) 
            (R402 ((EGAL voix parle)) ((nonGenre Techno)))
            (R401 ((EGAL type_instruments electronique) (CONTAIN ligne_instrumentale repetitive)) ((genre Techno))) 
            (R402 ((EGAL genre Techno) (EGAL voix chant) (EGAL rythme minimal)) ((sousGenre House))) 
            (R403 ((EGAL genre Techno) (CONTAIN instruments (synthetiseur_Roland_TB_303))) ((sousGenre (Techno Acid_house))))
            (R404 ((EGAL genre Techno) (EGAL effet reverb) (CONTAIN ligne_instrumentale un_peu_melodique)) ((sousGenre (Techno Trance)))) 
           
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
(defun getPremType (prem)
  (car prem)
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
(defun checkPrem (prem bdf)
  (cond
   ((equal (getPremType prem) 'EGAL) (checkEGALPrem prem bdf))
   ((equal (getPremType prem) 'LESSER) (checkLESSERPrem prem bdf))
   ((equal (getPremType prem) 'GREATER) (checkGREATERPrem prem bdf))
   ((equal (getPremType prem) 'MEMBRE) (checkMEMBREPrem prem bdf))
   ((equal (getPremType prem) 'CONTAIN) (checkCONTAINPrem prem bdf))
   )
  )
   
   
(defun checkAllPrem (rule bdf)
  (let ((res T))
    (dolist (x (getPremisse rule) res)
      (setq res (AND res (checkPrem x bdf)))
      )
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;Algo;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;; parcours tte les regles non utilis?e
;; verifie si true on ajoute dans BDf et ajoute dans usedRule
;; si lors d'un parcours entier BDF ne change pas
;; retourne les genres et sous genres

(defun algo (bdf bdr usedRule)
  (loop
    (if (EQUAL bdf
               (dolist (x bdr bdf)
                 (if (AND (NOT (member (getRuleName x) usedRule)) (checkAllPrem x bdf))
                     (progn 
                       (dolist (y (getCCL x) bdf)
                         (push y bdf)
                         )
                       (push (getRuleName x) usedRule)
                       )
                   )
                 )
               )
            (return bdf)
        )

    )
  )

(defun main (bdf bdr usedRule)
  (let ((newBdf NIL)
        (resGenre NIL)
        (resSousGenre NIL)
        )
    (setq newBdf (algo bdf bdr usedRule))
    (dolist (x newBdf)
      (if (equal (car x) 'genre)
          (push (cadr x) resGenre)
        )
      )
    (dolist (x newBdf)
      (if (equal (car x) 'nonGenre)
          (delete (cadr x) resGenre)
        )
      )
    (dolist (x newBdf)
      (if (equal (car x) 'sousGenre)
          (push (cadr x) resSousGenre)
        )
      )
    (format t "Genres probables : ~s sousGenre probables ~s " resGenre resSousGenre)


    )
  )

(setq prem '(CONTAIN ligne_instrumentale melodique))
(setq bdf '((vulgarite NIL)(annee 1970)(ligne_instrumentale (melodique repetitive))(instruments (synthetiseur percussions))(voix parle))) 