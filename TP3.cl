;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;BASE DE REGLES;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq bdr '(
            
            ;; ---Liste des éléments demandÃ©s Ã  l'utilisateur + caractÃ©risation--- ;;
                ;ELEMENT Parole
                    ;mort, meurtre, crime, politique, inegalite, police, meurtres, crime, argent, drogue,
                    ;amour, philosophique, pacifiste, humoristique, dejante, patriote

                ;ELEMENT Annee
                    ;Entier

                ;ELEMENT voix
                    ;cri, NIL, chante, parle
            
                ;ELEMENT rimes
                    ; pauvres, riches
            
                ;ELEMENT vulgarite
                    ; T NIL

                ;LISTE Instruments
                    ;guitareElectrique, batterie, basse, clavier, synthetiseur, platinedj, percussions,
                    ;sample, saxophone, trompette, clarinette
                    ;piano, clarinette, clavecin, orgue, viole de gambe, violoncelle, flute

                ;LISTE Ligne instrumentale
                    ;melodique, un_peu_melodique, non melodique, repetitive, contrepoint
            
                ;ELEMENT formation_instrumentale
                    ;orchestre 
            
                ;ELEMENT type_instruments
                    ;accoustique, electrique, electronique

                ;ELEMENT Langue
                    ;japonais, coreen, latin 

                ;ELEMENT Effet
                    ;reverb,

                ;ELEMENT Usage
                    ;film, ecoute, religieux, autre 

                ;ELEMENT Rythme
                    ;minimal, marque

                ;ELEMENT Synthetiseur
                    ;Roland_tb_303

            ;; ---General : 100 --- ;;
            
                ;; ---Themes--- ;;

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
            (R110 ((EGAL parole amour))((theme amour)))
            (R111 ((EGAL parole amour))((theme poetique)))
            (R112 ((EGAL parole philosophique))((theme poetique)))
            (R113 ((EGAL parole pacifiste))((theme poetique)))
            (R114 ((EGAL parole humoristique))((theme troll)))
            (R115 ((EGAL parole dejante))((theme troll)))

                ;; ---n---;;



            ;; ---Rock Metal : 200 --- ;;

            (R200 ((LESSER annee 1950))((nonGenre Rock))) 
            (R201 ((LESSER annee 1980))((nonGenre HeavyMetal))) 
            (R203 ((MEMBRE instruments (GuitareElectrique Batterie Basse Clavier)))((type_instruments electrique))) 
            (R204 ((EGAL voix cri))((nonGenre Rock))) 
            (R205 ((EGAL type_instruments electrique))((Genre Rock))) 
            (R206 ((EGAL type_instruments electrique)(EGAL voix cri))((Genre HeavyMetal))) 
            (R207 ((EGAL genre HeavyMetal)(EGAL theme violence))((sousGenre (HeavyMetal DeathMetal)))) 
            (R208 ((EGAL genre HeavyMetal)(CONTAIN ligne_instrumentale melodique))((sousGenre (HeavyMetal PowerMetal))))

            ;; ---Rap : 300 --- ;;

            (R302 ((EGAL voix NIL))((nonGenre Rap))) 
            (R303 ((MEMBRE instruments (synthetiseur platineDJ percussions basse samples)))((type_instruments electronique)))
            (R306 ((EGAL type_instruments electronique) (EGAL voix parle)) ((genre Rap))) 
            (R307 ((EGAL genre Rap)(EGAL theme sombre)((sousGenre (Rap GangstaRap))))) 
            (R308 ((EGAL genre Rap)(EGAL theme engage)((sousGenre (Rap RapConscient)))))
            (R309 ((EGAL genre Rap) (CONTAIN ligne_instrumentale melodique) (EGAL vulgarite NIL)) ((sousGenre (Rap RapCommercial))))
            (R310 ((EGAL genre Rap)(EGAL theme poetique)((sousGenre (Rap RapPoetique)))))
            (R311 ((EGAL genre Rap)(EGAL parole egocentree)(EGAL rimes pauvres)((sousGenre (Rap RapEgotrip)))))
            (R312 ((EGAL genre Rap)(EGAL theme troll)((sousGenre (Rap RapTroll)))))
            (R312 ((EGAL genre Rap)(EGAL tempo lent)(EGAL rythme marque)((sousGenre (Rap RapTrap)))))
			(R313 ((MEMBRE instruments (piano clarinette clavecin orgue viole de gambe violoncelle flute guitareElectrique)))((nonGenre Rap)))
			(R314 ((EGAL voix chante))((nonGenre Rap)))
			(R315 ((EGAL langue latin))((nonGenre Rap)))
			(R316 ((EGAL usage religion))((nonGenre Rap)))
			

            ;; ---Techno : 400 --- ;;

            (R402 ((EGAL voix parle)) ((nonGenre Techno)))
            (R401 ((EGAL type_instruments electronique) (CONTAIN ligne_instrumentale repetitive)) ((genre Techno))) 
            (R402 ((EGAL genre Techno) (EGAL voix chant) (EGAL rythme minimal)) ((sousGenre (Techno House)))) 
            (R403 ((EGAL genre Techno) (CONTAIN instruments (synthetiseur_Roland_TB_303))) ((sousGenre (Techno Acid_house))))
            (R404 ((EGAL genre Techno) (EGAL effet reverb) (CONTAIN ligne_instrumentale un_peu_melodique)) ((sousGenre (Techno Trance)))) 
            
            ;; --- Pop : 500 --- ;;

            (R501 ((EGAL voix cri))((nonGenre POP))) 
            (R502 ((EGAL theme amour)(EGAL type_instruments electrique))((genre POP)(nonGenre Rock)))
            (R503 ((EGAL genre POP)(EGAL langue Japonais))((sousGenre (POP J-POP))))
            (R503 ((EGAL genre POP)(EGAL langue Coreen))((sousGenre (POP K-POP))))
            
            ;; --- Jazz : 600 --- ;;

            (R601 ((MEMBRE instruments (saxophone trompette clarinette)))((genre Jazz)))

            ;; --- Cinéma : 700 --- ;;

            (R701 ((EGAL usage film))((genre Cinema)))
            (R702 ((EGAL theme amour))((sousGenre CinemaRomantique)))

            ;; --- Hymne : 800 --- ;;

            (R800 ((EGAL voix NIL))((nonGenre Hymne)))
            (R801 ((EGAL parole patriote))((genre Hymne)))

            ;; --- Fonctionnel : 900 --- ;;

            (R900 ((EGAL usage autre))((genre Fonctionnel)))
			(R901 ((EGAL usage film))((genre Fonctionnel)))
            
            ;; --- Musique classique : 1000 --- ;;

            (R1001 ((MEMBRE instruments (orgue clavecin piano clarinette violon contrebasse violoncelle flute))) ((genre MusiqueClassique)))
            (R1002 ((EGAL genre MusiqueClassique) (MEMBRE instruments (clavecin orgue violeDeGambe) (EGAL ligne_instrumentale contrepoint)) (sousGenre (MusiqueClassique MusiqueClassiqueBaroque)))) 
            (R1003 ((EGAL genre MusiqueClassique) (MEMBRE instruments (clarinette piano)) (EGAL formation_instrumentale orchestre)) ((sousGenre (MusiqueClassique MusiqueClassiqueClassique)))) 
            (R1004 ((EGAL genre MusiqueClassique) (GREATER annee 1900) (LESSER annee 1950)) ((sousGenre (MusiqueClassique MusiqueClassiqueModerne))))
            (R1005 ((EGAL genre MusiqueClassique) (GREATER annee 1950)) ((sousGenre (MusiqueClassique MusiqueClassiqueContemporaine)))) 
       
            ;; --- Chants grÃ©goriens : 1100 --- ;; 
                   
            (R1100 ((LESSER annee 1600) (EGAL usage religieux) (EGAL langue latin)) ((genre ChantGregorien))) 
            (R1101 ((EGAL voix nil)) ((nonGenre ChantGregorien))) 

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
;; appelle le bon checker pour une premisse donnÃ©e
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
                   ;; si la regle na pas deja été appliquée et que ses prémisses sont verifiées
                   ;; on ajoute la conclusion a la bdf
                   (if (AND (NOT (member (getRuleName x) usedRule)) (checkAllPrem x bdf))
                       (progn 
                         ;; -- debug (print x)
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
        (genresNonDiscr '(Rock HeavyMetal Techno Rap Jazz Pop ChantGregorien Cinema Fonctionnel musiqueClassique))
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
    ;; -- debug (print newBdf)
    ;; on retire les genres impossibles
    (dolist (x newBdf)
      (if (equal (car x) 'nonGenre)
          (progn 
            ;; on retire le genre
            (setq resGenre (delete (cadr x) resGenre))
            (setq genresNonDiscr (delete (cadr x) genresNonDiscr))
            ;; on retire les sous genres
            (dolist (y resSousGenre)
              (if (equal (car y) (cadr x))
                  (setq resSousGenre (delete y resSousGenre))
                )
              )
            ;; NB : delete est sensÃ© modifier la list mais cela ne semble pas toujours fonctionner
            ;; d'ou le setq en plus
            )
        
        )
      )

    (format t "Genres possibles : ~s ~%Genres probables : ~s ~%Sous genres probables ~s " genresNonDiscr resGenre resSousGenre)


    )
  )


(setq bdf '((instruments (guitareElectrique basse batterie)) (parole meurtre)(voix cri))) 
(setq bdf '((instruments (percussions synthetiseur))(voix parle)(vulgarite NIL)(ligne_instrumentale (melodique))))
(setq bdf '((instruments (guitareElectrique)) (theme Amour)(langue Japonais))) 

