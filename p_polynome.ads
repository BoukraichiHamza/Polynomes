--======================================================================
--Hamza BOUKRAICHI GROUPE H
--Paquetage polynome spec
--======================================================================
 with p_arbre_n;
----------------------Declarations de Types-----------------------------
package p_polynome is 
   type polynome is private;
   
   TailleMax : integer := 200;
	
	type str is record
		chaine : string(1..TailleMax);
		longueur : integer;
	end record;
------------------------------------------------------------------------
--------------------------Exceptions------------------------------------
longueur_maximum : exception;
polynome_vide : exception;
------------------------------------------------------------------------
--======================================================================
--Fonction encoder
--Semantique : créer l'arbre représentant le polynome
--Parametres : Fpoly_str : str
--Type retour : polynome (représentant le polynome)
--Préconditions : aucune
--Postconditions : aucune
--Exceptions : aucune

function encoder (Fpoly_string : in str) return polynome;

--======================================================================
--======================================================================
--Procedure decoder
--Semantique : Affiche un polynome sous forme de chaine de caractères
--Parametres : Fpoly : Donnee : polynome; 
--Préconditions : aucune
--Postconditions : aucune
--Exceptions : aucune

procedure decoder (Fpoly : in polynome);

--======================================================================
--======================================================================
--Fonction addition
--Semantique : effectue la somme de deux polynomes
--Parametres :-- Fp1 : polynome; premier polynome à sommer
			  -- Fp2 : polynome; deuxieme polynome à sommer
--Type retour : polynome : le polynome représentant la somme
--Préconditions : aucune 
--Postconditions : aucune
--Exceptions : aucune

function addition (Fp1 : in polynome; Fp2 : in polynome) return polynome;
 
--======================================================================
--======================================================================
--Fonction saisir
--Semantique : lit le polynome saisi par l'utilisateur et retourne
--le polynome sous forme d'arbre 
--Parametres : aucun
--Type retour :polynome
--Préconditions : aucune 
--Postconditions : aucune 
--Exceptions : aucune

function saisir return str;

--======================================================================
--======================================================================
--procedure afficher_poly
--procedure qui affiche un polynome sous forme d'arbre_n
--Parametres : Fp : Donnée polynome; le polynome à afficher
--Préconditions : aucune
--Postconditions : aucune
--Exceptions : polynome_vide

Procedure afficher_poly ( Fp : in polynome);
--======================================================================
------------------------------------------------------------------------

----------------------------Private-------------------------------------
private
   
   type p_var is access character;
   type p_ent is access integer;
   
   type Noeud_Poly is record
      puissance : p_ent;
      variable : p_var;
      coef : p_ent;
   end record;
 
--======================================================================
--Procedure affiche_noeud_poly
--Semantique : affiche le noeud d'un polynome
--Parametres : Fnoeud : Donnée : Noeud_Poly
--Préconditions : aucune
--Postconditions : aucune
--Exceptions : aucune

procedure affiche_noeud_poly (Fnoeud : in Noeud_Poly);
--======================================================================
	

   package p_arbre_poly is new p_arbre_n(Noeud_Poly,affiche_noeud_poly);
   use p_arbre_poly;
   type polynome is new arbre_n;
------------------------------------------------------------------------
end p_polynome;
