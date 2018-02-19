--======================================================================
--Hamza BOUKRAICHI
--Programme de test du paquetage d'arbre naire
--======================================================================

with ada.text_io;
use ada.text_io;
with ada.integer_text_io;
use ada.integer_text_io;
With p_arbre_n;

--======================================================================
Procedure test_arbre_n is

----------------------Procedure d'affichage-----------------------------
	procedure affiche_ent ( Fn : in integer) is
		Begin
		put(Fn,0);
	End affiche_ent;
------------------------------------------------------------------------

Package p_arbre_n_ent is new p_arbre_n (integer,affiche_ent);
use p_arbre_n_ent;

--======================================================================

-------------Fonctions de tests + traite exception----------------------
--réecriture des fonctions/procedure nécessitant un traite exception
--afin de ne pas interrompre les tests à chaque fois
-- qu'une exception est levée
------------------------------------------------------------------------
--======================================================================
 
 function t_An_Valeur (Fa : in arbre_n ) return integer is
	val : integer; --valeur de la racine
	Begin
		Begin
		val	:=An_Valeur(Fa);
		Exception
		When arbre_vide => 
			put("arbre vide");
			New_Line;
		End;
		return val;
	End t_An_Valeur;
	
--======================================================================

function t_An_Est_Feuille (Fa : in arbre_n) return boolean is
	bool : boolean; -- le booleen résultant 
	Begin
		Begin
		bool := An_Est_Feuille(Fa);
		Exception
		When arbre_vide =>
			put("arbre vide");
			New_Line;
		End;
		return bool;
	End t_An_Est_Feuille;
--======================================================================

function t_An_Frere (Fa : in arbre_n; Fn : in integer ) return arbre_n is
	res: arbre_n; --Resultat de la fonction
	begin
		begin
		res := An_Frere(Fa,Fn);
		Exception
		when frere_introuvable =>
			 put("frere introuvable");
			 New_Line;
		End;
		return res;
	End t_An_Frere;
			 
--======================================================================

function t_An_Fils (Fa : in arbre_n; Fn : in integer ) return arbre_n is
	res: arbre_n; --Resultat de la fonction
	begin
		begin
		res := An_Fils(Fa,Fn);
		Exception
		when fils_introuvable =>
			 put("fils introuvable");
			 New_Line;
		End;
		return res;
	End t_An_Fils;	
--======================================================================
 procedure t_An_Afficher ( Fa : in arbre_n ) is
	Begin
		Begin
		An_Afficher(Fa);
		Exception
 		When arbre_vide => 
			put("arbre vide");
			New_Line;
		End;
	End t_An_Afficher;
	
--======================================================================

procedure t_An_Inserer_Fils (Fa : in out arbre_n; Fa_ins :in arbre_n) is
	Begin
		Begin
		An_Inserer_Fils(Fa,Fa_ins);
		Exception
		When insert_non_autorisee => 
			put("insertion non autorisée");
			New_Line;
		End;
	End t_An_Inserer_Fils;
	
--======================================================================


procedure t_An_Inserer_Frere (Fa : in out arbre_n;Fa_ins : in arbre_n) is

	Begin
		Begin
		An_Inserer_Frere(Fa,Fa_ins);
		Exception
		When insert_non_autorisee => 
			put("insertion non autorisée");
			New_Line;
		When insert_racine => 
			put("l'arbre est une racine");
			New_Line;
		End;
	End t_An_Inserer_Frere;
	

--======================================================================


procedure t_An_Supprimer_frere (Fa :in out arbre_n; Fn :in integer ) is

	Begin
		Begin
		An_Supprimer_frere(Fa,Fn);
		Exception
		When frere_introuvable => 
			put("frere introuvable");
			New_Line;
		When n_zero =>
			put("Suppression impossible");
			New_line;
		End;
	End t_An_Supprimer_frere;
	

--======================================================================


procedure t_An_Supprimer_fils ( Fa : in out arbre_n; Fn : in integer) is
	
	Begin
		Begin
		An_Supprimer_fils (Fa,Fn);
		Exception
		When fils_introuvable => 
			put("fils introuvable");
			New_Line;
		End;
	End t_An_Supprimer_fils;
	
--======================================================================

-------------------------Variables--------------------------------------
arbre_test1 : arbre_n; -- 1er arbre de test
arbre_test2 : arbre_n; -- 2ieme arbre de test
arbre_test3 : arbre_n; -- 3ieme arbre de test
arbre_aux : arbre_n; -- 4ieme arbre de test
nombre_noeuds : integer; -- pour compter les nombres de noeuds
bool_test : boolean; -- Booleen de test
valeur : integer; --valeur des noeuds
feuille1 : arbre_n; -- feuille de test 1
feuille2 : arbre_n; -- feuille de test 2
feuille3 : arbre_n; -- feuille de test 3
feuille4 : arbre_n; -- feuille de test 4
------------------------------------------------------------------------

Begin
	
	--Creation des arbres pour les tests
		--Préconditions vérifiées
	arbre_test1 := An_creer_vide;
	arbre_test2 := An_Creer_Feuille(2);
	arbre_test3 := An_Creer_Feuille(3);
	An_Inserer_Fils(arbre_test2,arbre_test3);
	
	
	
	--Test de An_vide et de An_Creer_Vide
	put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Vide et de An_Creer_Vide");
	New_Line;
	
		--Test 1
	Put("Test 1 : ");
	New_Line;
	Put("Resultat attendu est : TRUE");
	New_Line;
	Put("Resultat obtenu est  : ");
		--Préconditions vérifiées
	bool_test := An_Vide(arbre_test1);
	Put(boolean'image(bool_test));
	New_Line;
	
		--Test 2
	Put("Test 2");
	New_Line;
	Put("Resultat attendu est : FALSE");
	New_Line;
	Put("Resultat obtenu est  : ");
		--Préconditions vérifiées
	bool_test := An_Vide(arbre_test2);
	Put(boolean'image(bool_test));
	New_Line;
	
		--Test 3
	Put("Test 3");
	New_Line;
	Put("Resultat attendu est : FALSE");
	New_Line;
	Put("Resultat obtenu est  : ");
		--Préconditions vérifiées
	bool_test := An_Vide(arbre_test3);
	Put(boolean'image(bool_test));
	New_Line;
	
	put("------------------------------------------------------------");
	New_Line;
	
	--Test de An_Valeur
	put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Valeur");
	New_Line;
	
		--Test 1
	put("Test 1");
	New_Line;
	Put("Valeur attendue : arbre vide");
	New_Line;
	Put("Valeur obtenue  : ");
		--Préconditions vérifiées
	valeur:=t_An_Valeur(arbre_test1);
	
		--Test 2
	put("Test 2");
	New_Line;
	put("Valeur attendue : 2");
	New_line;
		--Préconditions vérifiées
	valeur := t_An_Valeur(arbre_test2);
	put("Valeur obtenue  : ");
	put(valeur,0);
	New_Line;
	
		--Test 3
	put("Test 3");
	New_Line;
	put("Valeur attendue : 3");
	New_line;
		--Préconditions vérifiées
	valeur := t_An_Valeur(arbre_test3);
	put("Valeur obtenue  : ");
	put(valeur,0);
	New_Line;
	
	put("------------------------------------------------------------");
	New_Line;
	
	--Test de An_Est_Feuille
	put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Est_Feuille");
	New_Line;
	
		--Test 1
	put("Test 1");
	New_Line;
	Put("Resultat attendu : arbre vide");
	New_Line;
	Put("Resultat obtenu  : ");
		--Préconditions vérifiées
	bool_test:=t_An_Est_Feuille(arbre_test1);
	New_Line;
	
	--Test 2
	put("Test 2");
	New_Line;
	Put("Resultat attendu : FALSE");
	New_Line;
	Put("Resultat obtenu  : ");
		--Préconditions vérifiées
	bool_test:=t_An_Est_Feuille(arbre_test2);
	Put(Boolean'image(bool_test));
	New_Line;
	
	--Test 3
	put("Test 3");
	New_Line;
	Put("Resultat attendu : TRUE");
	New_Line;
	Put("Resultat obtenu  : ");
		--Préconditions vérifiées
	bool_test:=t_An_Est_Feuille(arbre_test3);
	Put(Boolean'image(bool_test));
	New_Line;
	
	put("------------------------------------------------------------");
	New_Line;
	
	--Test de An_Creer_Feuille
	put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Creer_Feuille");
	New_Line;
	
		--Test 1
	put("Test 1");
	New_Line;
	Put("Resultat attendu :  Feuille : 1");
	New_Line;
	Put("Resultat obtenu  : ");
	feuille1 := An_Creer_Feuille(1);
    t_An_Afficher(feuille1);
    
    
    	--Test 2
	put("Test 2");
	New_Line;
	Put("Resultat attendu :  Feuille : 2");
	New_Line;
	Put("Resultat obtenu  : ");
	feuille2 := An_Creer_Feuille(2);
    t_An_Afficher(feuille2);
    
    put("Les 2 arbres affichés sont bien des feuilles");
    New_Line;
    
    put("------------------------------------------------------------");
	New_Line;
    
    --Test de An_pere
    put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Pere");
	New_Line;
		
		--Test 1
     put("Test 1");
     New_Line;
     Put(" les préconditions ne sont pas vérifiées");
     New_Line;
     
		--Test 2
	put("Test 2");
	New_Line;
	Put("Resultat attendu : arbre vide");
	New_Line;
	Put("Resultat obtenu  : ");
	arbre_aux := An_Pere(arbre_test2);
	t_An_Afficher(arbre_aux);
	
		--Test 3
	put("Test 3");
	New_Line;
	Put("Resultat attendu : ");
	New_Line;
	t_An_Afficher(arbre_test2);
	Put("Resultat obtenu  : ");
	New_Line;
	arbre_aux := An_Pere(arbre_test3);
	t_An_Afficher(arbre_aux);
	
	put("------------------------------------------------------------");
	New_Line;
	
		--Test de An_Frere
	 put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Frere");
	New_Line;
	
		--Test 1
	put("Test 1");
	New_line;
	put("Préconditions non vérifiées");
	New_Line;
	
		--Test 2
	put("Test 2");
	New_Line;
	put("Resultat attendu : frere introuvable ");
	new_line;
	put("Resultat obtenu  : ");
	arbre_aux := t_An_Frere(arbre_test2,1);
	New_Line;
		
		--Test 3
	put("Test 3");
	New_Line;
	put("ajout d'un frere à arbre_test3 (uniquement pour ce test) ");
	New_Line;
	feuille1 := An_Creer_Feuille(4);
	t_An_Inserer_Frere(arbre_test3,feuille1);
	put("Resultat attendu :  Feuille : 4 ");
	new_line;
	put("Resultat obtenu  : ");
	arbre_aux := t_An_Frere(arbre_test3,-1);
	t_An_Afficher(arbre_aux);
	New_Line;
	
		--Remise aux valeurs d'origine
	feuille1 := An_Creer_Feuille(1);
	t_An_Afficher(arbre_test2);
	t_An_Supprimer_Frere(arbre_test3,-1);
	t_An_Afficher(arbre_test2);
   
	
	put("------------------------------------------------------------");
	New_Line;
	
		--Test de An_Fils
	put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Fils");
	New_Line;
	
		--Test 1
	put("Test 1");
	New_line;
	put("Préconditions non vérifiées");
	New_Line;
	
		--Test 2
	put("Test 2");
	New_Line;
	put("Resultat attendu :  Feuille : 3 ");
	new_line;
	put("Resultat obtenu  : ");
	arbre_aux := t_An_Fils(arbre_test2,1);
	t_An_Afficher(arbre_aux);
	New_Line;
	
		--Test 3
	put("Test 3");
	New_Line;
	put("Resultat attendu ; fils introuvable ");
	new_line;
	put("Resultat obtenu  : ");
	arbre_aux := t_An_Fils(arbre_test3,1);
	New_Line;
	
	put("------------------------------------------------------------");
	New_Line;
	
		--Test de An_Afficher
	 put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Afficher");
	New_Line;
	put("Voir ficher test_affichage");
	New_line;
	
	put("------------------------------------------------------------");
	New_Line;

	--Test An_Nombre_Noeuds
	put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Nombre_Noeuds");
	New_Line;
	
		--Test 1
	put("Test 1");
	New_Line;
	Put("Préconditions non vérifiées");
	New_Line;
	
	--Test 2
	put("Test 2");
	New_Line;
	Put("Valeur attendue : 2");
	New_Line;
	Put("Valeur obtenue  : ");
	nombre_noeuds := An_Nombre_Noeuds(arbre_test2);
	Put(nombre_noeuds,0);
	New_Line;
	
	--Test 1
	put("Test 3");
	New_Line;
	Put("Valeur attendue : 1");
	New_Line;
	Put("Valeur obtenue  : ");
	nombre_noeuds := An_Nombre_Noeuds(arbre_test3);
	Put(nombre_noeuds,0);
	New_Line;
	
	put("------------------------------------------------------------");
	New_Line;
	
	--Test An_Rechercher
	put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Rechercher");
	New_Line;
	
		--Test 1
	put("Test 1");
	New_Line;
	Put("Recherche de la valeur 0 dans l'arbre de test 2");
	New_Line;
	Put("Resultat attendu : arbre vide");
	New_Line;
	Put("Resultat obtenu  : ");
	arbre_aux := An_Rechercher (arbre_test2,0);
	t_An_Afficher(arbre_aux);
		
		--Test 2
	put("Test 2");
	New_Line;
	Put("Recherche de la valeur 3 dans l'arbre de test 2");
	New_Line;
	Put("Resultat attendu : ");
	New_Line;
	t_An_Afficher(arbre_test3);
	Put("Resultat obtenu  : ");
	New_Line;
	arbre_aux := An_Rechercher (arbre_test2,3);
	t_An_Afficher(arbre_aux);
	
		--Test 3
	put("Test 3");
	New_Line;
	Put("Recherche de la valeur 2 dans l'arbre de test 2");
	New_Line;
	Put("Resultat attendu : ");
	New_Line;
	t_An_Afficher(arbre_test2);
	Put("Resultat obtenu  : ");
	New_Line;
	arbre_aux := An_Rechercher (arbre_test2,2);
	t_An_Afficher(arbre_aux);
	
	put("------------------------------------------------------------");
	New_Line;
	
	--Test An_Nombre_Noeuds_Valeur
	put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Nombre_Noeuds_Valeur");
	New_Line;
	
		--Test 1
	put("Test 1");
	New_Line;
	Put("Nombre de noeuds contenant la valeur 3 dans l'arbre de test 2");
	New_Line;
	Put("Valeur attendue : 1");
	New_Line;
	Put("Valeur obtenue  : ");
	nombre_noeuds := An_Nombre_Noeuds_Valeur(arbre_test2,2);
	Put(nombre_noeuds,0);
	New_Line;
	
		--Test 2
	put("Test 2");
	New_Line;
	Put("Nombre de noeuds contenant la valeur 4 dans l'arbre de test 2");
	New_Line;
	Put("Valeur attendue : 0");
	New_Line;
	Put("Valeur obtenue  : ");
	nombre_noeuds := An_Nombre_Noeuds_Valeur(arbre_test2,4);
	Put(nombre_noeuds,0);
	New_Line;
	
		--Test 3
	put("Test 3");
	New_Line;
	Put("Nombre de noeuds contenant la valeur 2 dans l'arbre de test 2");
	New_Line;
	Put("Valeur attendue : 1");
	New_Line;
	Put("Valeur obtenue  : ");
	nombre_noeuds := An_Nombre_Noeuds_Valeur(arbre_test2,2);
	Put(nombre_noeuds,0);
	New_Line;
	
	put("------------------------------------------------------------");
	New_Line;
	
	--Test de An_Est_Racine
	put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Est_Racine");
	New_Line;
	
		--Test 1
	put("Test 1");
	New_Line;
	put("Préconditions non vérifiées");
	New_Line;
	
		--Test 2
	put("Test 2");
	New_line;
	put("Resultat attendu : TRUE");
	New_Line;
	bool_test:=An_Est_Racine(arbre_test2);
	put("Resultat obtenu  : ");
	put(boolean'image(bool_test));
	New_line;
	
		--Test 3
	put("Test 3");
	New_line;
	put("Resultat attendu : FALSE");
	New_Line;
	bool_test:=An_Est_Racine(arbre_test3);
	put("Resultat obtenu  : ");
	put(boolean'image(bool_test));
	New_line;
	
	put("------------------------------------------------------------");
	New_Line;	
	
	--Test de An_Changer_Valeur
	put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Changer_Valeur");
	New_Line;
	
		--Test 1
	put("Test 1");
	New_line;
	put("Changement de la valeur de feuille1 en 5");
	New_line;
	arbre_aux := feuille1;
	An_Changer_Valeur(arbre_aux,5);
	put("affichage de la feuille");
	New_line;
	put("Resultat attendu :  Feuille : 5");
	new_line;
	put("Resultat obtenu  : ");
	t_An_Afficher(arbre_aux);
	
	
		--Test 2
	put("Test 2");
	New_line;
	put("Changement de la valeur du premier fils de arbre_test2 en 10");
	New_line;
	put("affichage des arbres avant/apres");
	New_Line;	
	put("Arbre_test2 avant  : ");
	New_Line;
	t_An_Afficher(arbre_test2);
	An_Changer_Valeur(arbre_test3,10);	
	put("arbre_test2 apres : ");
	New_Line;
	t_An_Afficher(arbre_test2);
	
		--Remise aux valeurs d'origines
	An_Changer_Valeur(arbre_test3,3);
	An_Changer_Valeur(feuille1,1);
	
	put("------------------------------------------------------------");
	New_Line;
	
		--Test de An_Inserer_Fils
	 put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Inserer_Fils");
	New_Line;
	
		--Test 1
	put("Test 1");
	new_line;
	put("Insertion de arbre_test3 comme fils de feuille2");
	New_line;
	Put("Resultat attendu : insertion non autorisée ");
	New_line;
	Put("Resultat obtenu  : ");
	--t_An_Inserer_Fils(feuille2,arbre_test3);
	
		--Test 2
	put("Test 2");
	new_line;
	put("insertion de feuille2 comme fils de arbre_test3");
	new_line;
	put("affichage de arbre_test2 avant/apres");
	New_line;
	put("l'arbre avant : ");
	New_line;
	t_An_Afficher(arbre_test2);
	put("l'arbre apres : ");
	New_Line;
	t_An_Inserer_Fils(arbre_test3,feuille2);
	t_An_Afficher(arbre_test2);
	
		--Test 3
	put("Test 3");
	new_line;
	put("insertion de feuille1 comme fils de arbre_test3");
	new_line;
	put("affichage de arbre_test2 avant/apres");
	New_line;
	put("l'arbre avant : ");
	New_line;
	t_An_Afficher(arbre_test2);
	put("l'arbre apres : ");
	New_Line;
	t_An_Inserer_Fils(arbre_test3,feuille1);
	t_An_Afficher(arbre_test2);
	
	put("------------------------------------------------------------");
	New_Line;	
		
		
		--Test de An_Inserer_Frere
	 put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Inserer_Frere");
	New_Line;
		
		--Test 1
	put("Test 1");
	new_line;
	put("Insertion de feuille1 comme frere de feuille2");
	New_line;
	Put("Resultat attendu : insertion non autorisée ");
	New_line;
	Put("Resultat obtenu  : ");
	t_An_Inserer_Frere(feuille2,feuille1);
	
		--Test 2
	put("Test 2");
	new_line;
	put("insertion de (Feuille : 10) comme frere de arbre_test3");
	new_line;
	put("affichage de arbre_test2 avant/apres");
	New_line;
	put("l'arbre avant : ");
	New_line;
	t_An_Afficher(arbre_test2);
	put("l'arbre apres : ");
	New_Line;
	feuille3 := An_Creer_Feuille(10);
	
	t_An_Inserer_Frere(arbre_test3,feuille3);
	t_An_Afficher(arbre_test2);
	
		--Test 3
	put("Test 3");
	new_line;
	put("insertion de (Feuille : 20) comme frere de arbre_test3");
	new_line;
	put("affichage de arbre_test2 avant/apres");
	New_line;
	put("l'arbre avant : ");
	New_line;
	t_An_Afficher(arbre_test2);
	put("l'arbre apres : ");
	New_Line;
	feuille4 := An_Creer_Feuille(20);
	t_An_Inserer_Frere(arbre_test3,feuille4);
	t_An_Afficher(arbre_test2);
	
	put("------------------------------------------------------------");
	New_Line;		
		
		--Test de An_Supprimer_Frere
	 put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Supprimer_Frere");
	New_Line;

	put("Test 1");
	new_line;
	put("Suppression du 3ieme frere à la gauche de arbre_test3");
	New_line;
	Put("Resultat attendu : frere introuvable ");
	New_line;
	Put("Resultat obtenu  : ");
	t_An_Supprimer_Frere(arbre_test3,-3);

	
		--Test 2
	put("Test 2");
	new_line;
	put("Suppression du 1er frere à la gauche de arbre_test3");
	new_line;
	put("affichage de arbre_test2 avant/apres");
	New_line;
	put("l'arbre avant : ");
	New_line;
	t_An_Afficher(arbre_test2);
	put("l'arbre apres : ");
	New_Line;
	t_An_Supprimer_Frere(arbre_test3,-2);
	t_An_Afficher(arbre_test2);
	
		--Test 3
	put("Test 3");
	new_line;
	put("Suppression du frere restant à la gauche de arbre_test3");
	new_line;
	put("affichage de arbre_test2 avant/apres");
	New_line;
	put("l'arbre avant : ");
	New_line;
	t_An_Afficher(arbre_test2);
	put("l'arbre apres : ");
	New_Line;
	t_An_Supprimer_Frere(arbre_test3,-1);
	t_An_Afficher(arbre_test2);
	
	put("------------------------------------------------------------");
	New_Line;	
		
		
		--Test de An_Supprimer_Fils
	 put("------------------------------------------------------------");
	New_Line;
	put("Test de An_Supprimer_Fils");
    New_Line;
	
		--Test 1
	put("Test 1");
	new_line;
	put("Suppression du 3ieme fils de arbretest3");
	New_line;
	Put("Resultat attendu : fils introuvable ");
	New_line;
	Put("Resultat obtenu  : ");
	t_An_Supprimer_Fils(arbre_test3,3);
	
		--Test 2
	put("Test 2");
	new_line;
	put("Suppression du 2ieme fils de arbretest3");
	new_line;
	put("affichage de arbre_test2 avant/apres");
	New_line;
	put("l'arbre avant : ");
	New_line;
	t_An_Afficher(arbre_test2);
	put("l'arbre apres : ");
	New_Line;
	t_An_Supprimer_Fils(arbre_test3,2);
	t_An_Afficher(arbre_test2);
	
		--Test 3
	put("Test 3");
	new_line;
	put("Suppression du 1er fils de arbretest3");
	new_line;
	put("affichage de arbre_test2 avant/apres");
	New_line;
	put("l'arbre avant : ");
	New_line;
	t_An_Afficher(arbre_test2);
	put("l'arbre apres : ");
	New_Line;
	t_An_Supprimer_Fils(arbre_test3,1);
	t_An_Afficher(arbre_test2);
	
	
	put("------------------------------------------------------------");
	New_Line;		
	
End test_arbre_n;


	
