--======================================================================
--Hamza BOUKRAICHI
--Programme de test de l'affichage d'arbre naire
--======================================================================

with ada.text_io;
use ada.text_io;
with ada.integer_text_io;
use ada.integer_text_io;
With p_arbre_n;

--======================================================================
Procedure test_affichage is

----------------------Procedure d'affichage-----------------------------
	procedure affiche_ent ( Fn : in integer) is
		Begin
		put(Fn,2);
	End affiche_ent;
------------------------------------------------------------------------


Package p_arbre_n_ent is new p_arbre_n (integer,affiche_ent);
use p_arbre_n_ent;

--======================================================================
------------------------Traite Exception--------------------------------

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

-------------------------Variables--------------------------------------
a1 : arbre_n;
a2 : arbre_n;
a3 : arbre_n;
a4 : arbre_n;
a5 : arbre_n;
a6 : arbre_n;
a7 : arbre_n;
a8 : arbre_n;
a9 : arbre_n;
a10 : arbre_n;
------------------------------------------------------------------------
Begin
	--Creation de l'arbre vide
	put("------------------------------------------------------------");
	New_Line;
	put("Création de l'arbre vide");
	New_Line;
	a1:=An_Creer_Vide;
	put("affichage de l'arbre vide");
	New_Line;
	t_An_Afficher(a1);
	New_Line;
	put("------------------------------------------------------------");
	New_Line;
	
	--Creation de la feuille
	put("------------------------------------------------------------");
	New_Line;
	put("Création de la feuille");
	New_Line;
	a1:=An_Creer_Feuille(1);
	put("affichage de la feuille");
	New_Line;
	t_An_Afficher(a1);
	New_Line;
	put("------------------------------------------------------------");
	New_Line;

	--Insertion de fils
	put("------------------------------------------------------------");
	New_Line;
	put("Creation des fils");
	New_Line;
	a2:=An_Creer_Feuille(2);
	a3:=An_Creer_Feuille(3);
	a4:=An_Creer_Feuille(4);
	put("affichage des fils");
	New_Line;
	t_An_Afficher(a2);
	New_Line;
	t_An_Afficher(a3);
	New_Line;
	t_An_Afficher(a4);
	New_Line;
	put("insertion des fils");
	New_line;
	t_An_Inserer_Fils(a1,a4);
	t_An_Inserer_Fils(a1,a3);
	t_An_Inserer_Fils(a1,a2);
	Put("Affichage de l'arbre");
	New_Line;
	t_An_Afficher(a1);
	New_Line;	
	put("------------------------------------------------------------");
	New_Line;
	
	--Insertion de petits fils et de frere
	put("------------------------------------------------------------");
	New_Line;
	put("Creation des petits fils");
	New_Line;
	a5:=An_Creer_Feuille(5);
	a6:=An_Creer_Feuille(6);
	a7:=An_Creer_Feuille(7);
	a8:=An_Creer_Feuille(8);
	a9:=An_Creer_Feuille(9);
	a10:=An_Creer_Feuille(10);
	put("affichage des petits fils");
	New_Line;
	t_An_Afficher(a5);
	New_Line;
	t_An_Afficher(a6);
	New_Line;
	t_An_Afficher(a7);
	New_Line;
	t_An_Afficher(a8);
	New_Line;
	t_An_Afficher(a9);
	New_Line;
	t_An_Afficher(a10);
	New_Line;
	put("insertion des petits fils de 2");
	New_line;
	t_An_Inserer_Fils(a2,a6);
	t_An_Inserer_Frere(a6,a5);
	Put("Affichage de l'arbre");
	New_Line;
	t_An_Afficher(a1);
	New_Line;
	put("insertion des petits fils de 3");
	New_line;
	t_An_Inserer_Fils(a3,a8);
	t_An_Inserer_Frere(a8,a7);
	Put("Affichage de l'arbre");
	New_Line;
	t_An_Afficher(a1);
	New_Line;
	put("insertion des petits fils de 4");
	New_line;
	t_An_Inserer_Fils(a4,a10);
	t_An_Inserer_Frere(a10,a9);
	Put("Affichage de l'arbre");
	New_Line;
	t_An_Afficher(a1);
	New_Line;
	put("------------------------------------------------------------");
	New_Line;
	

End test_affichage;
--======================================================================
