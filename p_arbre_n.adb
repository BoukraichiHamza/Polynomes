--======================================================================
--Hamza BOUKRAICHI GROUPE H
--Paquetage arbre naire body
--======================================================================
-- Paquetage générique arbre n-aire. 
-- La valeur d'un noeud est de type T.
--======================================================================

------------------------------------------------------------------------
pragma Assertion_Policy(CHECK);
with ada.text_io;
use ada.text_io;
with ada.integer_text_io;
use ada.integer_text_io;
with Ada.Assertions ;
use Ada.Assertions ;
------------------------------------------------------------------------

Package Body p_arbre_n is

----------------------Fonctions-----------------------------------------
--======================================================================
-- Fonction An_Vide
-- Sémantique: Détecter si un arbre n-aire est vide ou non
-- Paramètres: a: arbre_n
-- Type retour: booléen (vaut vrai si a est vide)
-- Préconditions : aucune
-- Postconditions : aucune
-- Exceptions : aucune

 function An_Vide (Fa : in arbre_n) return boolean is
	Begin
		Return (Fa=Null);
	End An_Vide;

--======================================================================
-- Fonction An_Creer_Vide
-- Sémantique: Créer un arbre n-aire vide
-- Paramètres: /
-- Type retour: arbre_n
-- Préconditions : aucune
-- Postconditions : aucune
-- Exceptions : aucune


 function An_Creer_Vide return arbre_n is
	Begin
		return Null;
	End An_Creer_Vide;

--======================================================================
-- Fonction An_Valeur
-- Sémantique: Retourner la valeur rangée à la racine d'un arbre n-aire
-- Paramètres: a: arbre_n
-- Type retour: T
-- Préconditions : aucune
-- Postconditions : aucune
-- Exceptions : arbre_vide
 
 function An_Valeur (Fa : in arbre_n ) return T is
	Begin
		if Fa = Null then
			raise arbre_vide;
		else
			return Fa.all.val;
		End if;
	End An_Valeur;
	
--======================================================================
-- Fonction An_Est_Feuille
-- Sémantique: Indiquer si un arbre n-aire est une feuille (pas de fils)
-- Paramètres: a: arbre_n
-- Type retour: booléen (vaut vrai si a n'a pas de fils)
-- Préconditions : aucune
-- Postconditions : aucune
-- Exceptions : arbre_vide

 function An_Est_Feuille (Fa : in arbre_n) return boolean is
	bool : boolean; -- le booleen retourné
	Begin
		Begin
		bool := ((not An_Vide(Fa)) and (An_Vide(Fa.all.p_fils)));
		Exception
		When CONSTRAINT_ERROR => raise arbre_vide;
		End;
		return bool;
	End An_Est_Feuille;


--======================================================================
-- Fonction An_Creer_Feuille
-- Sémantique: Créer un arbre n-aire avec une valeur mais sans fils,
-- ni frère, ni père
-- Paramètres: nouveau: T
-- Type retour: arbre_n
-- Préconditions : aucune 
-- Postconditions : l'arbre retourné est une feuille
-- Exceptions : aucune 
	
 function An_Creer_Feuille ( Fnouveau : in T) return arbre_n is
	res : arbre_n;
	Begin
		res := New Noeud;
		res.all.val := Fnouveau;
		res.all.p_fils := Null;
		res.all.p_gauche := Null;
		res.all.p_droit := Null;
		res.all.p_pere := Null;
		return res;
	End An_Creer_Feuille;
	 
--======================================================================
-- Fonction An_Pere
-- Sémantique: Retourner l'arbre n-aire père d'un arbre n-aire
-- Paramètres: a: arbre_n
-- Type retour: arbre_n
-- Préconditions : arbre_non vide
-- Postconditions : aucune 
-- Exceptions : aucune

 function An_Pere ( Fa : in arbre_n ) return arbre_n is
	Begin
			return Fa.all.p_pere;
	End An_Pere;

--======================================================================
-- Fonction An_Frere
-- Sémantique: Retourner le nieme  Frere d'un arbre n-aire
--        le numero 1 est le premier frere droit
--        le numero 0 est l'arbre lui-même. 
--        le numero -1 est le premier frere gauche
-- Paramètres: a: arbre_n,
--             n : entier, le numéro du frère
-- Type retour: arbre_n
-- Préconditions : arbre non vide
-- Postconditions : aucune
-- Exceptions : frere_introuvable

 function An_Frere (Fa : in arbre_n; Fn : in integer ) return arbre_n is
	res: arbre_n;
	Begin
		if Fa=Null then
			raise frere_introuvable;
		else
			if Fn = 0 then
				res:=Fa;
			elsif Fn > 0
				then res:=An_frere(Fa.all.p_droit,Fn-1);
			else 
				res:=An_frere(Fa.all.p_gauche,Fn+1);
			end if;
		end if;
		return res;
	end An_Frere;
	
 
--======================================================================
-- Fonction An_Fils
-- Sémantique: Retourner le nieme fils de a
--   le numero 1 est le premier fils

--   Attention : le 2ème fils est le frère droit, pas le petit-fils
-- Paramètres: a: arbre_n,
--             n : entier, le numéro du fils
-- Type retour: arbre_n
-- Préconditions : arbre non vide
-- Postconditions : aucune
-- Exceptions : fils_introuvable


 function An_Fils ( Fa : in arbre_n; Fn : in integer) return arbre_n is
	res: arbre_n;
	Begin
		if Fa=Null then
				raise fils_introuvable;
		else
			if Fa.all.p_fils = Null or Fn=0 then
				raise fils_introuvable;
			else
				Begin
					res:=An_frere(Fa.all.p_fils,Fn-1);
					Exception
					When frere_introuvable => raise fils_introuvable;
				end;
			End if;
		End if;
				
		return res;	
	End An_Fils;

--======================================================================
-- Procédure An_Afficher
-- Sémantique: Afficher le contenu complet d'un arbre n-aire
-- Paramètres: a: arbre_n
-- Préconditions : aucune
-- Postconditions : aucune
-- Exceptions : aucune

 procedure An_Afficher_aux ( Fa : in arbre_n; Fdec : in integer ) is
	paux : arbre_n; --arbre de parcours des fils
	Begin
		--Indentation pour afficher l'arborescence
		For i in 1..Fdec Loop 
			Put(" ");
		End Loop;
		
		if Fa=Null then
			Null;
			
		elsif An_Est_Feuille(Fa) then
			Put(" Feuille : ");
			AfficherT(Fa.all.val);
			New_Line;
		else
			paux:=Fa.all.p_fils;
			Put(" Pere : ");
			AfficherT(Fa.all.val);
			New_Line;
			
			-- Indentation Pour mettre en valeur la relation Pere -> Fils
			For i in 1..Fdec Loop 
			Put(" ");
			End Loop;
			
			
			Put(" Fils : ( ");			
			New_Line;
			While paux /=Null Loop
			An_Afficher_aux(paux,Fdec+4);	
			paux:=paux.all.p_droit;
			End Loop; --Paux = Null		
			
			For i in 1..Fdec+8 Loop -- 8 = La taille "de Fils : ("
			Put(" ");
			End Loop;
				
			Put( " ) ");
			New_Line;
		End if;
	End An_Afficher_aux;
	
	procedure An_Afficher( Fa : in arbre_n) is
		Begin
			If Fa=Null then
				raise arbre_vide;
			else
				An_Afficher_Aux (Fa,0);
			End if;
		End An_Afficher;
		
--======================================================================
-- Fonction An_Nombre_Noeuds
-- Sémantique : Retourner le nombre total de noeuds d'un arbre n-aire
-- Paramètres : a : arbre_n
-- Type retour : Entier
-- Préconditions : arbre non vide
-- Postconditions : aucune
-- Exceptions : aucune

 function An_Nombre_Noeuds ( Fa : in arbre_n) return integer is
	n : integer; -- Le nombre de noeuds
	paux : arbre_n; -- Arbre pour parcourir l'arbre_n
	Begin
		n :=1;
		paux := Fa.all.p_fils;
		While paux /= Null  Loop
			n:=n+An_Nombre_Noeuds(paux);
			paux:=paux.all.p_droit;
		End Loop; -- paux = Null
		return n;
	End An_Nombre_Noeuds;

--======================================================================
-- Fonction An_Rechercher
-- Sémantique: Rechercher une valeur dans un arbre n-aire et 
-- retourner l'arbre n-aire dont la valeur est racine si elle 
-- est trouvée, un arbre n-aire vide sinon
-- Paramètres: a: arbre_n,
--             data: T, la valeur à rechercher
-- Type retour: arbre_n
-- Préconditions : aucune
-- Postconditions : aucune
-- Exceptions : aucune

 function An_Rechercher ( Fa : in arbre_n ; Fdata : in T) 
return arbre_n is
	res : arbre_n; --L'arbre contenant la valeur
	paux : arbre_n; --arbre de parcours
	Begin
		If Fa=Null then
			res:=Fa;
		Else
			if Fa.all.val = Fdata then
				res:=Fa;
			Else
				res:=Null;
			End if;
			paux:=Fa.all.p_fils;
			While paux /=Null and res=Null Loop
				res:=An_Rechercher(paux,Fdata);
				paux:=paux.all.p_droit;
			End Loop; --paux=Null ou res/=Null			
		End if;
		Return res;
	End An_Rechercher;

	
--======================================================================
-- Fonction An_Nombre_Noeuds_Valeur
-- Sémantique : Retourner le nombre de noeuds d'un arbre n-aire
-- dont la valeur est égale à une valeur donnée.
-- Paramètres : a : arbre_n, 
--              data: T, la valeur à rechercher
-- Type retour : Entier
-- Préconditions : arbre non vide
-- Postconditions : aucune
-- Exceptions : aucune

function An_Nombre_Noeuds_Valeur (Fa : in arbre_n ; Fdata : in T)
	return integer is
		n:integer; -- nombre de noeuds dans la valeur vaut data
		arb_aux : arbre_n; --arbre pour parcourir l'arbre
		Begin
			
			If Fa.all.val = Fdata then 
				n:=1;
			else
				n:=0;
			End if;
			
			arb_aux:=Fa.all.p_fils;
			
			While arb_aux /= Null Loop
				n:=n+An_Nombre_Noeuds_Valeur(arb_aux,Fdata);
				arb_aux:=arb_aux.all.p_droit;
			End loop; --arb_aux = Null
			
			Return n;

		End An_Nombre_Noeuds_Valeur;

--======================================================================

-- Fonction An_Est_Racine
-- Sémantique: Indiquer si un arbre n-aire est sans père
-- Paramètres: a: arbre_n
-- Type retour: booléen (vaut vrai si a n'a pas de père)
-- Préconditions : arbre non vide
-- Postconditions : aucune
-- Exceptions : aucune


function An_Est_Racine ( Fa : in arbre_n ) return boolean is
	aux_pere : arbre_n; -- le pere de l'arbre en question
	Begin
		aux_pere := An_Pere(Fa);
		Return 
			aux_pere=Null;
	End An_Est_Racine;
--======================================================================
-- Procédure An_Changer_Valeur
-- Sémantique: Changer la valeur du noeud d'un arbre n-aire
-- Paramètres: a: arbre_n
--             data: T, la nouvelle valeur
-- Préconditions : arbre non vide
-- Postconditions : la racine de l'arbre vaut data
-- Exceptions : aucune

procedure An_Changer_Valeur (Fa : in out arbre_n; Fdata : in T) is
	Begin
		Fa.all.val := Fdata;
	End  An_Changer_Valeur;

--======================================================================
-- Procédure An_Inserer_Fils
-- Sémantique: Insérer un arbre n-aire sans frère en position de premier 
-- fils d'un arbre n-aire a. L'ancien fils de a devient alors le premier 
-- frère de l'arbre n-aire inséré.
-- Paramètres: Fa: arbre_n, 
--             Fa_ins: arbre_n, l'arbre à insérer
-- Préconditions : ls deux arbres ne sont pas vides
-- Postconditions : Fa_ins est le premier fils de Fa
-- Exceptions : Fa_ins a des freres : insert_non_autorisee

procedure An_Inserer_Fils ( Fa : in out arbre_n; Fa_ins :in arbre_n) is

	Begin
		if Fa_ins.all.p_gauche = Null and Fa_ins.all.p_droit=Null then
			Fa_ins.all.p_droit := Fa.all.p_fils;
			Fa_ins.all.p_pere := Fa;
			if Fa.all.p_fils = Null then
				Null;
			else
				Fa.all.p_fils.all.p_gauche := Fa_ins;
			end if;
			Fa.all.p_fils := Fa_ins;
		else
			raise insert_non_autorisee;
		end if;
	End An_Inserer_Fils;

--======================================================================
-- Procédure An_Inserer_Frere
-- Sémantique: Insérer un arbre n-aire sans frère en position de premier 
-- frère d'un arbre n-aire a
-- Paramètres: Fa: arbre_n,
--             Fa_ins: arbre_n, l'arbre à insérer
-- Préconditions : Les deux arbres sont non vides
-- Postconditions : Fa_ins est le premier frere de Fa
-- Exceptions : Fa est racine : insert_racine
			-- Fa_ins a des freres : insert_non_autorisee

procedure An_Inserer_Frere (Fa : in out arbre_n; Fa_ins : in arbre_n) is
	Begin
		If Fa.all.p_pere=Null then
			Raise insert_racine;
		else
			An_Inserer_Fils(Fa.all.p_pere,Fa_ins);
		End if;	
	End An_Inserer_Frere;


--======================================================================
-- Procédure An_Supprimer_frere
-- Sémantique: Supprime le nieme frere d'un arbre n-aire
-- Paramètres: a: arbre_n, 
--             n : entier, le numéro du frère (et tous ses descendants)
-- à supprimer
-- Préconditions : arbre non vide
-- Postconditions : le nombre de noeuds diminue et le nieme frere de Fa 
				--est différent de l'ancien nieme frere
-- Exceptions : frere_introuvable
			 -- n=0 : n_zero
			 
procedure An_Supprimer_frere (Fa : in out arbre_n; Fn : in integer ) is
    paux : arbre_n; --arbre de parcours des freres
    Begin
        If fn=0 then
            raise n_zero;
        Else
            paux:=An_frere(Fa, Fn);

            if paux.all.p_droit = Null then
                null;
            else
                paux.all.p_droit.all.p_gauche:=paux.all.p_gauche;
            End if;
           
            if paux.all.p_gauche = Null then
                paux.all.p_pere.all.p_fils := paux.all.p_droit;
            else
                paux.all.p_gauche.all.p_droit:=paux.all.p_droit;
            end if;
                   

        End if;
    End An_Supprimer_frere;  
    
--======================================================================
-- Procédure An_Supprimer_fils
-- Sémantique: Supprime le nieme fils d'un arbre n-aire
-- Paramètres: a: arbre_n,
--             n : entier, le numéro du fils (et tous ses descendants) 
--à supprimer
-- Préconditions : arbre non vide
-- Postconditions : le nombre de noeuds diminue et le nieme fils de Fa 
				-- est différent de l'ancien nième fils
-- Exceptions : fils_introuvable
			-- n_neg : n negatif

procedure An_Supprimer_fils ( Fa : in out arbre_n; Fn : in integer) is
	Begin
		If Fn<0 then
			raise n_neg;
		Else
			If Fa.all.p_fils = Null then
				raise fils_introuvable;
			Else
				Begin
					An_supprimer_frere(Fa.all.p_fils,Fn-1);
					Exception
					When frere_introuvable => raise fils_introuvable;
					When n_zero =>
							If Fa.all.p_fils.all.p_droit = Null then
								Fa.all.p_fils := Null;
							Else
								An_Supprimer_frere(Fa.all.p_fils.all.p_droit,Fn-2);
							End if;
				End;
			End if;
		End if;		
	End An_Supprimer_fils;
--======================================================================

--======================================================================
end p_arbre_n;
