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
            (R206 ((EGAL genre HeavyMetal)(EGAL theme violence))((sousGenre (HeavyMetal DeathMetal)))) 
            (R207 ((EGAL genre HeavyMetal)(CONTAIN ligne_instrumentale melodique))((sousGenre (HeavyMetal PowerMetal))))

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
            (R402 ((EGAL genre Techno) (EGAL voix chant) (EGAL rythme minimal)) ((sousGenre (Techno House)))) 
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

(defun checkEGALPrem (prem bdf)
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

(defun checkMEMBREPrem (prem bdf)
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
;; appelle le bon checker pour une premisse donnée
(defun checkPrem (prem bdf)
  (cond
   ((equal (getPremType prem) 'EGAL) (checkEGALPrem prem bdf))
   ((equal (getPremType prem) 'LESSER) (checkLESSERPrem prem bdf))
   ((equal (getPremType prem) 'GREATER) (checkGREATERPrem prem bdf))
   ((equal (getPremType prem) 'MEMBRE) (checkMEMBREPrem prem bdf))
   ((equal (getPremType prem) 'CONTAIN) (checkCONTAINPrem prem bdf))
   )
  )
   
 ;; verifie que toute les premisses d'une regles sont vraies   
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

(defun algo (bdf bdr)
  (let ((usedRule NIL))
    (loop
      ;; on boucle tant que la bdf varie en parcourant les regles
      (if (EQUAL bdf
                 (dolist (x bdr bdf)
                   ;; si la regle na pas deja été appliquée et que ses premisses sont verifiées
                   ;; on ajoute la conclusion a la bdf
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
  )

(defun main (bdf bdr)
  (let ((newBdf NIL)
        (resGenre NIL)
        (resSousGenre NIL)
        (genresNonDiscr '(Rock HeavyMetal Techno Rap))
        )
    ;; on rempli la bdf en faisant tourner l'algo
    (setq newBdf (algo bdf bdr))
    ;;on recupere les genres et sous genres deduit par le moteur
    (dolist (x newBdf)
      (if (equal (car x) 'genre)
          (push (cadr x) resGenre)
        )
      (if (equal (car x) 'sousGenre)
          (push (cadr x) resSousGenre)
        )

      )
    ;; on retire les genres impossibles
    (dolist (x newBdf)
      (if (equal (car x) 'nonGenre)
          (progn 
            ;; on retire le genre
            (setq resGenres (delete (cadr x) resGenre))
            (setq genresNonDiscr (delete (cadr x) genresNonDiscr))
            ;; on retire les sous genres
            (dolist (y resSousGenre)
              (if (equal (car y) (cadr x))
                  (setq resSousGenre (delete y resSousGenre))
                )
              )
            ;; NB : delete est sensé modifier la list mais cela ne semble pas toujours fonctionner
            ;; d'ou le setq en plus
            )
        
        )
      )

    (format t "Genres possibles : ~s ~%Genres probables : ~s ~%Sous genres probables ~s " genresNonDiscr resGenre resSousGenre)


    )
  )

(setq prem '(CONTAIN ligne_instrumentale melodique))
(setq bdf '((instruments (guitareElectrique)) (voix cri)(parole mort))) 