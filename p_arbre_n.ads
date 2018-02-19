--======================================================================
--Hamza BOUKRAICHI GROUPE H
--Paquetage arbre naire spec
--======================================================================
-- Paquetage générique arbre n-aire. 
-- La valeur d'un noeud est de type T.
--======================================================================

----------------------Declarations de Types-----------------------------
generic 
 type T is private;
 with procedure afficherT (Fe : in T);
package p_arbre_n is

 type arbre_n is private;
----------------------Exceptions----------------------------------------
arbre_vide : exception;
frere_introuvable : exception;
fils_introuvable : exception;
insert_non_autorisee : exception;
insert_racine : exception;
n_zero : exception;
n_neg : exception;
------------------------------------------------------------------------

--======================================================================
-- Fonction An_Vide
-- Sémantique: Détecter si un arbre n-aire est vide ou non
-- Paramètres: a: arbre_n
-- Type retour: booléen (vaut vrai si a est vide)
-- Préconditions : aucune
-- Postconditions : aucune
-- Exceptions : aucune
 function An_Vide (Fa : in arbre_n) return boolean;

--======================================================================
-- Fonction An_Creer_Vide
-- Sémantique: Créer un arbre n-aire vide
-- Paramètres: /
-- Type retour: arbre_n
-- Préconditions : aucune
-- Postconditions : aucune
-- Exceptions : aucune
 function An_Creer_Vide return arbre_n;

--======================================================================
-- Fonction An_Valeur
-- Sémantique: Retourner la valeur rangée à la racine d'un arbre n-aire
-- Paramètres: a: arbre_n
-- Type retour: T
-- Préconditions : aucune
-- Postconditions : aucune
-- Exceptions : arbre_vide
 
 function An_Valeur (Fa : in arbre_n ) return T;
--======================================================================
-- Fonction An_Est_Feuille
-- Sémantique: Indiquer si un arbre n-aire est une feuille (pas de fils)
-- Paramètres: a: arbre_n
-- Type retour: booléen (vaut vrai si a n'a pas de fils)
-- Préconditions : aucune
-- Postconditions : aucune
-- Exceptions : arbre_vide

 function An_Est_Feuille (Fa : in arbre_n) return boolean;

--======================================================================
-- Fonction An_Creer_Feuille
-- Sémantique: Créer un arbre n-aire avec une valeur mais sans fils,
-- ni frère, ni père
-- Paramètres: nouveau: T
-- Type retour: arbre_n
-- Préconditions : aucune 
-- Postconditions : l'arbre retourné est une feuille
-- Exceptions : aucune

 function An_Creer_Feuille ( Fnouveau : in T) return arbre_n
	with
	POST => An_Est_Feuille (An_Creer_Feuille'RESULT) = True;
	


--======================================================================
-- Fonction An_Pere
-- Sémantique: Retourner l'arbre n-aire père d'un arbre n-aire
-- Paramètres: a: arbre_n
-- Type retour: arbre_n
-- Préconditions : arbre_non vide
-- Postconditions : aucune 
-- Exceptions : aucune

 function An_Pere ( Fa : in arbre_n ) return arbre_n
	with
	PRE => Not An_Vide (Fa);

--======================================================================
-- Fonction An_Frere
-- Sémantique: Retourner le nieme  Frere d'un arbre n-aire
--        le numero 1 est le premier frere droit
--        le numero 0 est l'arbre lui-même. 
--        le numero -1 est le premier frere gauche
-- Paramètres: a: arbre_n,
--             n : entier, le numéro du frère
-- Type retour: arbre_n
-- Préconditions : aucune
-- Postconditions : aucune
-- Exceptions : frere_introuvable

 function An_Frere ( Fa : in arbre_n; Fn : in integer) return arbre_n;

--======================================================================
-- Fonction An_Fils
-- Sémantique: Retourner le nieme fils de a
--   le numero 1 est le premier fils

--   Attention : le 2ème fils est le frère droit, pas le petit-fils
-- Paramètres: a: arbre_n,
--             n : entier, le numéro du fils
-- Type retour: arbre_n
-- Préconditions : aucune
-- Postconditions : aucune
-- Exceptions : fils_introuvable

 function An_Fils ( Fa : in arbre_n; Fn : in integer) return arbre_n;

	
--======================================================================
-- Procédure An_Afficher
-- Sémantique: Afficher le contenu complet d'un arbre n-aire
-- Paramètres: a: arbre_n
-- Préconditions : aucune
-- Postconditions : aucune 
-- Exceptions : arbre_vide

 procedure An_Afficher ( Fa : in arbre_n ) ;
 
--======================================================================
-- Fonction An_Nombre_Noeuds
-- Sémantique : Retourner le nombre total de noeuds d'un arbre n-aire
-- Paramètres : a : arbre_n
-- Type retour : Entier
-- Préconditions : arbre non vide
-- Postconditions : aucune
-- Exceptions : aucune

 function An_Nombre_Noeuds ( Fa : in arbre_n) return integer
	with
	PRE => Not An_Vide (Fa);
	
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

function An_Rechercher ( Fa : in arbre_n ; Fdata : in T) return arbre_n;

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
	return integer
	with
	PRE => Not An_Vide (Fa);

--======================================================================
-- Fonction An_Est_Racine
-- Sémantique: Indiquer si un arbre n-aire est sans père
-- Paramètres: a: arbre_n
-- Type retour: booléen (vaut vrai si a n'a pas de père)
-- Préconditions : arbre non vide
-- Postconditions : aucune
-- Exceptions : aucune

function An_Est_Racine ( Fa : in arbre_n ) return boolean
	with
	PRE => Not An_Vide (Fa);

--======================================================================
-- Procédure An_Changer_Valeur
-- Sémantique: Changer la valeur du noeud d'un arbre n-aire
-- Paramètres: a: arbre_n
--             data: T, la nouvelle valeur
-- Préconditions : arbre non vide
-- Postconditions : la racine de l'arbre vaut data
-- Exceptions : aucune

procedure An_Changer_Valeur (Fa : in out arbre_n; Fdata : in T)
	with
	PRE => Not An_Vide (Fa),	
	POST => An_Valeur(Fa'OLD) = Fdata;
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


procedure An_Inserer_Fils ( Fa : in out arbre_n; Fa_ins :in arbre_n)
	with
	PRE => Not An_Vide(Fa) and Not An_Vide(Fa_ins),
	POST => An_Fils(Fa,1)=Fa_ins;

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


procedure An_Inserer_Frere ( Fa : in out arbre_n; Fa_ins : in arbre_n)
	with
	PRE => Not An_Vide(Fa) and Not An_Vide(Fa_ins),
	POST => An_Fils(An_Pere(Fa),1)=Fa_ins;

--======================================================================

-- Procédure An_Supprimer_frere
-- Sémantique: Supprime le nieme frere d'un arbre n-aire
-- Paramètres: a: arbre_n, 
--             n : entier, le numéro du frère (et tous ses descendants)
-- à supprimer
-- Préconditions : arbre non vide
-- Postconditions : le nombre de noeuds diminue 
-- Exceptions : frere_introuvable
			-- n=0 : n_zero

procedure An_Supprimer_frere (Fa : in out arbre_n; Fn : in integer )
	with
	PRE => Not An_Vide(Fa),
	POST => An_Nombre_Noeuds(Fa) <= An_Nombre_Noeuds(Fa'OLD);
	

--======================================================================

-- Procédure An_Supprimer_fils
-- Sémantique: Supprime le nieme fils d'un arbre n-aire
-- Paramètres: a: arbre_n,
--             n : entier, le numéro du fils (et tous ses descendants) 
--à supprimer
-- Préconditions : arbre non vide
-- Postconditions : le nombre de noeuds diminue
-- Exceptions : fils_introuvable
			-- n_neg : n négatif

procedure An_Supprimer_fils ( Fa : in out arbre_n; Fn : in integer) 
	with
	PRE => Not An_Vide(Fa),
	POST => (If not An_Vide(Fa) then 
				An_Nombre_Noeuds(Fa) <= An_Nombre_Noeuds(Fa'OLD)
			Else
				True);              
--======================================================================


private

	type Noeud;

	type arbre_n is access Noeud;

	type Noeud is record
		val : T;
		p_pere : arbre_n;
		p_gauche : arbre_n;
		p_droit : arbre_n;
		p_fils : arbre_n;
	end record;

--======================================================================

End p_arbre_n;	
