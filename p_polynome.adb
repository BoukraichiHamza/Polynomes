--======================================================================
--Hamza BOUKRAICHI GROUPE H
--Paquetage polynome body
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
package body p_polynome is

------------------------------------------------------------------------
----------------------Fonctions/Procedures------------------------------
--======================================================================
-------------------Fonctions/Procedures auxiliaires---------------------
------------------------------------------------------------------------
--Procedure extract_int
--Procedure qui recupere un entier à une certaine position d'une chaine de caractere
--Parametres : -- Fchaine : Donnée : str; la chaine d'où l'entier sera récupéré
			   -- Fposition : Donnée/Resultat integer;
			   -- Fent : Resultat: integer; entier récupéré
--Précondition : aucune
--Postcondition : aucune
--Exceptions : aucune

procedure extract_int ( Fchaine : in str; Fposition : in out integer; Fent : out integer) is
	char_int : integer;
	Begin
		Fent:=0;
		While Fposition <= Fchaine.longueur and 
		then ((Fchaine.chaine(Fposition) >= '0') 
		and (Fchaine.chaine(Fposition)  <= '9'))    loop
			char_int:=integer'value(Fchaine.chaine(Fposition..Fposition));
			Fent:=Fent*10+char_int;
			Fposition := Fposition+1;
	End Loop; -- Fposition > Longueur ou Le caractere n'est pas un chiffre
	End extract_int;

------------------------------------------------------------------------
--Procedure encoder_monome
--Procedure qui encode un monome d'une chaine de caractère lu à partir 
	--d'une certaine position
--Parametres :-- Fpoly : str; Donnée : La chaine de caractere d'ou le monome sera lu
			  -- Fposition : integer; Donnée/Resultat : la position de laquelle la lecture débutera
			  --Fmonome : Resultat :  polynome; representant le monome encodé
--Préconditions : aucune
--Postconditions : aucune
--Exceptions : aucune

procedure encoder_monome (Fpoly : in str; Fposition : in out integer; Fmonome : out polynome) is
	signe_negatif : boolean; --Si le monome est précédé de + ou de -
	variable : character; -- Pour récupérer les variables du monome
	constante : integer; -- pour récupérer les constantes des monomes
	puissance_pere : integer; --puissance du pere
	puissance : integer; -- puissance du fils actuel
	new_noeud : Noeud_Poly; --Le nouveau à insérer
	new_son : polynome; -- le nouveau fils à inserer
	
	
	Begin
		--Récupération du signe
		signe_negatif := Fpoly.chaine(Fposition) = '-';
		Fposition := Fposition+1;
		
		--Recupération de la constante
		extract_int(Fpoly,Fposition,constante);
		
		--Initialisation du monome
		Fmonome:=An_Creer_Vide;
		puissance_pere := 0;
		
		--Lecture des variables et des puissances
		While Fposition <= Fpoly.longueur and then
		((Fpoly.chaine(Fposition) /= '+') and (Fpoly.chaine(Fposition)/='-')) Loop
				
			--Lecture d'une variable
			variable:= Fpoly.chaine(Fposition);
				Fposition:=Fposition+1;
		
			--Lecture de la puissance
			extract_int(Fpoly,Fposition,puissance);

			--Création du nouveau noeuds
			If An_Vide(Fmonome) then
				new_noeud.puissance := Null;
				new_noeud.variable := New character;
				new_noeud.variable.all := variable;
				new_noeud.coef := Null;
			Else
				new_noeud.puissance := New integer;
				new_noeud.puissance.all := puissance_pere;
				new_noeud.variable := New character;
				new_noeud.variable.all := variable;
				new_noeud.coef := Null;
			End if;
		
			--Ajout du nouveau noeuds au monome
			If An_Vide(Fmonome) then
				Fmonome:=An_Creer_Feuille(new_noeud);
			Else
				new_son := An_Creer_Feuille(new_noeud);
				An_Inserer_Fils(Fmonome,new_son);
				
				--Passage au fils
				Fmonome:=An_Fils(Fmonome,1);
				
			End if;
			
			--Passage à la nouvelle puissance
			puissance_pere := puissance;
			
		End Loop;
		--Fposition > longueur ou Caractere = '+' | '-'
		
		--Ajout de la constante
		--Création du noeud de la constante
		new_noeud.puissance:=New integer;
		new_noeud.puissance.all := puissance_pere;
		new_noeud.variable := Null;
		new_noeud.coef := new integer;
		If signe_negatif then
			new_noeud.coef.all := -constante;
		Else
			new_noeud.coef.all := constante;
		End if;
		
		--Ajout du nouveau noeud de la constante
		If An_Vide(Fmonome) then
				Fmonome:=An_Creer_Feuille(new_noeud);
			Else
				new_son := An_Creer_Feuille(new_noeud);
				An_Inserer_Fils(Fmonome,new_son);
			End if;
		
		--Remonter à la racine du monome
		While not An_Est_Racine(Fmonome) loop
			Fmonome := An_Pere(Fmonome);
		End loop; -- Fmonome est racine
		
	End encoder_monome;
	
	
------------------------------------------------------------------------
--Fonction encoder
--Semantique : créer l'arbre représentant le polynome
--Parametres : Fpoly_str : string
--Type retour : polynome (représentant le polynome)
--Préconditions : aucune
--Postconditions : aucune
--Exceptions : aucune

function encoder (Fpoly_string : in str) return polynome is
	res: polynome; -- Le polynome encodé
	position : integer; -- Indice de parcous de la chaine de caractère
	monome : polynome; --Monome encodé
	Begin
		res:= An_Creer_Vide;
		position:=1;
		--Encoder Chaque monome puis l'ajouter au resultat
		While position<= Fpoly_string.longueur Loop
			encoder_monome(Fpoly_string,position,monome);
			
			--Ajout du monome au resultat
			res:=addition(res,monome);
			
		 End loop; -- Position>longueur
		 
		 return res;
	End encoder;
		
--======================================================================
--======================================================================
-------------------Fonctions/procedures auxiliaires---------------------
------------------------------------------------------------------------
--Procedure write_int
--Procedure qui écrit un entier dans une chaine en gerant la longueur
--Parametres :-- ch : Donnée/Résultat : str; la chaine où l"entier sera écrit
			  -- n  : Donnée : integer; l'entier à ecrire
--Préconditions : aucune
--Postconditions : aucune
--Exception : longueur_maximum

procedure write_int ( ch : in out str; n : in integer) is
	n_aux : integer; -- pour calculer la taille
	taille : integer; -- taille de l'entier à insérer
	int_chaine : string(1..50); -- l'entier transformé en chaine de caractere

	Begin
		--Recupération de la taille
		n_aux:=n;
		taille:=1;
		while n_aux >= 10 Loop
			n_aux := n_aux/10;
			taille :=taille+1;
		End Loop;
		
		--Recupération de la chaine
		int_chaine(1..taille) := Integer'Image(n)(2..taille+1);
		
		--Ecriture dans la chaine
		If ch.longueur + taille > TailleMax then
			raise longueur_maximum;
		Else
			ch.chaine((ch.longueur + 1)..(ch.longueur +taille)) := int_chaine(1..taille);
			ch.longueur:=ch.longueur+taille;
		End if;
	End write_int;
	
------------------------------------------------------------------------
--Procedure write_char
--Procedure qui écrit un caractere dans une chaine en gerant la longueur
--Parametres :-- ch : Donnée/Résultat : str; la chaine où le caractere sera écrit
			  -- c  : Donnée : character; caractère à ecrire
--Préconditions : aucune
--Postconditions : aucune
--Exception : longueur_maximum

procedure write_char ( ch : in out str; c : in character) is
	Begin
		If ch.longueur=TailleMax then
			raise longueur_maximum;
		Else
			ch.longueur := ch.longueur + 1;
			ch.chaine(ch.longueur) :=c;
		End if;
	End write_char;
	
------------------------------------------------------------------------
--Procedure write_monome_fathers
--Procedure qui ajoute les puissances et les variables aux constantes correspondantes
--Parametres : -- Ffather : Donnée : polynome; le pere du polynome actuel
			   -- ch : Donnée/Résultats : str; la chaine representant le polynome
			   -- puissance : Donnée : integer; puissance du polynome actuel
			   --pos_constante : Donnée : integer; -- La position de la derniere constante écrite
--Précondition : LE polynome n'est pas constant
--Postcondition : aucune
--Exception : longueur_maximum

procedure write_monome_fathers ( Ffather : in polynome; ch : in out str;
	puissance : in integer; pos_constante : in integer) is 
	puiss_aux : integer; -- pour récupérer la taille
	taille_pv : integer; -- La taille nécessaire à l'ecriture de la puissance et la variable
	new_length : integer; -- la longueur après insertion
	var : character; -- La variable à inserer
	father_aux : polynome; -- polynome pour parcourir les pere
	new_puiss : integer; --nouvelle puissance
	Begin
		--	Récupération de la taille nécessaire à l'ecriture de la puissance et la variable
		
		puiss_aux := puissance;
		taille_pv :=1;
		While puiss_aux >= 10 loop
			puiss_aux:= puiss_aux/10;
			taille_pv := 1 +taille_pv;
		End loop;
		taille_pv := taille_pv+1;
		--Sauvegarde de la nouvelle taille de la chaine
		new_length := ch.longueur + taille_pv;
		
		--Recupération de variable
		var := An_Valeur(Ffather).variable.all;
		
		--Ecriture de la variable et la puissance à la position pos_constante
		
		If new_length > TailleMax then
			raise longueur_maximum;
		Else
			
			--Décalage des caractères après la constante
			For i in 1..(ch.longueur - pos_constante) Loop
			ch.chaine(new_length - i+1 ) := ch.chaine(ch.longueur -i +1);
			End loop;
			
			--Ecriture de la variable et la puissance à la position pos_constante
			ch.longueur := pos_constante;
			write_char(ch,var);
			write_int(ch,puissance);
			
			--Retour à la taille réelle
			ch.longueur:=new_length;
			
		End If;
		
		--Parcours des pères pour récuperer le reste des variables et puissances
		If An_Est_Racine(Ffather) then
			Null;
		Else
			father_aux := An_Pere(Ffather);
			--Récupération de la nouvelle puissance
			new_puiss:=An_Valeur(Ffather).puissance.all;
			--Récupération des nouvelles variables et puissance
			write_monome_fathers(father_aux,ch,new_puiss,pos_constante);
		End if;
		
	End write_monome_fathers;
------------------------------------------------------------------------
--Procedure write_monome
--procedure qui écrit un nouveau monome dans la chaine
--Parametres :-- Fmonome : Donnee polynome; le monome à ecrire
			  -- ch : Donnée/Résultats : str; la chaine où le monome est écrit
--Préconditions : le polynome est constant
--Postconditions : aucune
--Exception : longueur_maximum

procedure write_monome (Fmonome : in polynome; ch : in out str) is
	cons : integer; -- la constante du polynome
	puiss : integer; -- puissance du monome
	father : polynome; -- polynome pour parcourir les peres
	Begin	
		--Récupération de la constante
		cons := An_Valeur(Fmonome).coef.all;
	
		--Ecriture du signe
		If cons >=0 then
			write_char(ch,'+');
		Else
			write_char(ch,'-');
		End if;
	
		--Ecriture de la constante
		cons:=abs(cons);
		write_int(ch,cons);
	
		--Sauvegarde de la puissance
		puiss:=An_Valeur(Fmonome).puissance.all;
	
		--Parcours des peres pour récupérer les variables
		If An_Est_Racine(Fmonome) then
			Null;
		Else
			father:=An_Pere(Fmonome);
			write_monome_fathers(father,ch,puiss,ch.longueur);
		End if;
	End write_monome;

------------------------------------------------------------------------
--procedure decoder_aux
--Procedure qui parcours les constantes du polynome et les ajoutes à la chaine
--Parametres : --  Fpoly :Donnée: polynome; le polynome à décoder
			   -- ch_courante : Donnée/Résultat : str; la chaine courante
--Précondition : Fpoly non vide
--Postcondition : aucune
--Exception : aucune

procedure decoder_aux ( Fpoly : in polynome; ch : in out str) is
	son : polynome; -- polynome pour parcourir les fils
	brother : polynome; -- polynome pour parcourir les freres
	Begin
		If An_Valeur(Fpoly).variable=Null then --constant
			write_monome(Fpoly,ch);
		Else --Recherche des constantes parmi les fils
			Begin
				son := An_Fils(Fpoly,1);
				decoder_aux(son,ch);
				exception
				When fils_introuvable => Null;
			End;
		End if;
		
		--Recherche des constante parmi les freres
		Begin
			brother:=An_Frere(Fpoly,1);
			decoder_aux(brother,ch);
			Exception
			When frere_introuvable => Null;
		End;
	
	End decoder_aux;
------------------------------------------------------------------------
--Procedure decoder
--Semantique : Affiche un polynome sous forme de chaine de caractères
--Parametres : Fpoly : Donnee : polynome; 
--Préconditions : aucune
--Postconditions : aucune
--Exceptions : polynome_vide

procedure decoder (Fpoly : in polynome) is
	poly_str : str; -- La chaine representant le polynome
	Begin
		
		--Initialisation de la taille
		poly_str.longueur := 0;
		
		--Conversion du polynome en chaine
		If An_Vide(Fpoly) then
			raise polynome_vide;
		Else
			decoder_aux(Fpoly,poly_str);
		End if;
		
		--Affichage de la chaine
		put("Le polynome est : ");
		put(poly_str.chaine(1..poly_str.longueur));
		New_Line;
	
	End decoder;
		
--======================================================================
--======================================================================
-------------------Fonctions/procedures auxiliaires---------------------
------------------------------------------------------------------------
--Fonction break_link
--Fonction qui retourne une copie d'un arbre sans liaison avec ses freres
--Parametres : Fp : polynome; le polynome à copier
--Type retour : polynome : le polynome copié sans les freres
--Précondition : aucune
--Postcondition : aucune
--Exception : aucune

function break_link (Fp : in polynome) return polynome is
	noeud_rac : Noeud_Poly; -- Valeur à la racine
	poly_aux : polynome; -- Pour parcourir les fils
	poly_aux_copy : polynome; -- pour récupérer les fils sans leurs freres
	res : polynome; -- Le polynome sans les freres
	Begin
		If An_Vide(Fp) then
			res := An_Creer_Vide;
		Else
			--Recuperation de la valeur à la racine
			noeud_rac := An_Valeur(Fp);
			res := An_Creer_Feuille(noeud_rac);
			
			--Recupération des fils
			Begin
			poly_aux:=An_Fils(Fp,1);
			Exception
			When fils_introuvable => poly_aux :=An_Creer_Vide;
			End;
			
			While not An_Vide(poly_aux) Loop
				poly_aux_copy:=break_link(poly_aux);
				An_Inserer_Fils(res,poly_aux_copy);
					Begin
				poly_aux:=An_Frere(poly_aux,1);
					Exception
				When frere_introuvable => poly_aux :=An_Creer_Vide;
				End;
				
			End Loop; --poly_aux est vide
		End If;
		return res;		
	End break_link;
				
------------------------------------------------------------------------
--Fonction add_cons
--Fonction qui effectue la somme de deux polynomes constants
--Parametres: -- Fp1 : polynome; premier polynome constant
			  -- Fp2 : arebre_n; deuxieme polynome constant
--type retour : polynome : polynome constant representant la somme
--Précondition : Les deux polynomes ne sont pas vides

--Postcondition : aucune
--Exception : aucune 

function add_cons ( Fp1 : in polynome; Fp2 : in polynome) return polynome is
	somme_noeud:Noeud_Poly; -- Le noeud du polynome somme
	cons : integer; -- La somme des constantes
	res : polynome; -- Le polynome representant la somme
	copy_2 : polynome; -- Pour copier le polynome Fp2
	Begin
		If An_Valeur(Fp1).puissance.all = An_Valeur(Fp2).puissance.all then
		
			somme_noeud.puissance := New Integer;
			somme_noeud.puissance.all := An_Valeur(Fp1).puissance.all;
			somme_noeud.variable := Null;
			somme_noeud.coef := New integer;
			cons := An_Valeur(Fp1).coef.all + An_Valeur(Fp2).coef.all;
			somme_noeud.coef.all := cons;
		
			if cons = 0 then -- Les polynomes nuls ne sont pas conservés
				res:=An_Creer_Vide; 
			else
				res:=An_Creer_Feuille(somme_noeud);
			End if;
		Else
			copy_2 := break_link(Fp2);
			res := Fp1;
			An_Inserer_Frere(res,copy_2);
		End if;
		return res;
	End add_cons;
------------------------------------------------------------------------

--Fonction add_puiss0
--Fonction qui ajoute au fils de puissance 0 d'un polynome
-- un autre polynome
--Parametres : -- Fp1 : polynome; le polynome à qui il sera ajouté 
						--le 2ieme polynome
			   -- Fp2 : polynome; le polynome à ajouter
--Type retour : polynome; le polynome representant la somme
--Preconditions :-- Fp1 est non vide a au moins un fils
				 -- Fp2 est non vide
				 -- Les deux polynomes ont la même puissance à la racine
--Postconditions : aucune
--Exceptions : aucune

function add_puiss0 (Fp1 : in polynome; Fp2 : in polynome) return polynome is
	new_noeud : Noeud_Poly; --Le noeud dont la puissance sera 0
	res : polynome; -- le polynome resultant
	somme_fils : polynome; --Le polynome representant la somme du fils et Fp2
	copy2 : polynome; --polynome pour briser les liens de Fp2
	p_aux : polynome; --polynome pour parcourir les fils de Fp1
	position : integer; --Position du fils de puissance 0 de Fp1
	Begin

		--Recuperation de la valeur à la racine 
		--et passage de la puissance a 0
		new_noeud := An_Valeur(Fp2);
		copy2 := break_link(Fp2);
		new_noeud.puissance.all := 0;
		An_Changer_Valeur(copy2,new_noeud);
		
		--Recherche d'un fils de puissance 0 de Fp1
			Begin
		p_aux:=An_Fils(Fp1,1);
			Exception
			When fils_introuvable => p_aux := An_Creer_Vide;
			End;
			
		position:=1;
		While not An_Vide(p_aux) and then An_Valeur(p_aux).puissance.all/=0 loop
				Begin
			p_aux:=An_Frere(p_aux,1);
			position:=position+1;
				Exception
				When frere_introuvable => p_aux := An_Creer_Vide;
				End;
				
			
		End Loop; -- p_aux est vide ou un fils de puissance 0 existe
		
		--Somme de Fp2 avec le fils de puissance 0 si il existe
		--Insertion de Fp2 sinon
		
		If An_Vide(p_aux) then --Fp1 n'a pas de fils de puissance 0
			res :=Fp1;
			An_Inserer_Fils(res,copy2);
			
		Else --P_aux est le fils de puissance 0 de Fp1
			
			--Création du nouveau fils de puissance 0
			somme_fils:=addition(p_aux,copy2);
			
			--Suppression de l'ancien fils de puissance0
			res :=Fp1;
				Begin
			An_Supprimer_Fils(res,position);
				Exception
				When fils_introuvable => Null;
				End;
			
			--Insertion du nouveau fils de puissance
			If An_Vide(somme_fils) then
				Null;
			Else
				If An_Valeur(somme_fils).coef = Null then
				--Valeur nulle, aucun fils à inserer donc
					Null;
				Else If An_Valeur(somme_fils).coef.all = 0 then
					Null;
			
					Else --Valeur non nulle, le nouveau fils est à inserer
						An_Inserer_Fils(res,somme_fils);
					End if;
				End if;
			End if;
		End if;
		
		
	return res;
	End add_puiss0;

------------------------------------------------------------------------
--Fonction add_sons_aux
--Fonction qui effectue la somme des fils de deux polynomes 
--de meme puissance 2 à 2
--Parametres : --Fp1 : polynome; 1er polynome à sommer
			   --Fp2 : polynome; 2ieme polynome à sommer
--Type retour : polynome; l'arbre representant la somme des fils 2 à 2
--Préconditions :-- Fp1 et Fp2 non vide
				 -- Fp1 et Fp2 ont au moins un fils chacun
				 -- Fp1 et Fp2 ont même variable à la racine
--Postconditions : aucune
--Exceptions : aucune

function add_sons_aux (Fp1 : in polynome; Fp2 : in polynome) return polynome is
	res : polynome; --polynome representant la somme
	paux1 : polynome; --polynome de parcours des fils de Fp1
	paux2 : polynome; --polynome de parcours des fils de Fp2
	position : integer; --position du fils de meme puissance
	copy_son1 : polynome; --polynome pour briser les liens des fils de Fp1
	copy_son2 : polynome; --polynome pour briser les liens des fils de Fp2
	somme : polynome; -- polynome representant sur la somme de deux fils


Begin
		--Copie de Fp1 sans les freres
		res:=Fp1;
		
		--Parcours des fils de res et Fp2:
			--Somme en cas de puissance égale
			--Insertion sinon
			
			Begin
		paux2:=An_Fils(Fp2,1);
			Exception
			When fils_introuvable => paux2 := An_Creer_Vide;
			End;
			
		While not An_Vide(paux2) Loop
				
				Begin
			paux1:=An_Fils(res,1);
				Exception
				When fils_introuvable => paux1 := An_Creer_Vide;
				End;
				
			position := 1;
			While not An_Vide(paux1) and then An_Valeur(paux1).puissance.all/=An_Valeur(paux2).puissance.all Loop
				
				Begin
			paux1:=An_Frere(paux1,1);
			position:=position+1;
				Exception
				When frere_introuvable => paux1 := An_Creer_Vide;
				End;
				
			
			End loop;
				
			--paux1 vide ou existence fils de meme puissance
			
			If An_Vide(paux1) then
				--Pas de fils de meme puissance
				--Copie du fils de fp2
				copy_son2 := break_link(paux2);
				--Insertion du nouveau fils de puissance différente
				An_Inserer_Fils(res,copy_son2);
				
			Else
				--paux1 et paux2 sont des fils de meme puissance
				copy_son1:=break_link(paux1);
				copy_son2:=break_link(paux2);
				
				--Creation du nouveau fils
				somme := addition(copy_son1,copy_son2);
				
				--Suppression de l'ancien fils
					Begin
				An_Supprimer_Fils(res,position);
					Exception
				When fils_introuvable => Null;
				End;
				
				--Insertion du nouveau fils

				If  An_Vide(somme)  then
					Null;
				Else
					An_Inserer_Fils(res,somme);
				End if;
			End if;
			
			Begin
		paux2:=An_Frere(paux2,1);
			Exception
			When frere_introuvable => paux2 := An_Creer_Vide;
			End;
		End loop; -- paux2 vide

		
		return res;
	End add_sons_aux;
				
	
------------------------------------------------------------------------
--Fonction add_sons
--Fonction qui effectue la somme des fils de deux polynomes 2 à 2
--Parametres : --Fp1 : polynome; 1er polynome à sommer
			   --Fp2 : polynome; 2ieme polynome à sommer
--Type retour : polynome; l'arbre representant la somme des fils 2 à 2
--Préconditions :-- Fp1 et Fp2 non vide
				 -- Fp1 et Fp2 ont au moins un fils chacun
				 -- Fp1 et Fp2 ont même variable à la racine
--Postconditions : aucune
--Exceptions : aucune

function add_sons (Fp1 : in polynome; Fp2 : in polynome) return polynome is
	res : polynome; -- Le polynome representant la somme
	copy2 : polynome; -- Pour briser les liens de Fp2
	
	Begin
	If An_Valeur(Fp1).puissance=Null and An_Valeur(Fp2).puissance=Null then
		res:=add_sons_aux(Fp1,Fp2);
	Else
		--Le cas ou l'un est racine et l'autre non est impossible selon la construction réalisé
		If An_Valeur(Fp1).puissance.all =An_Valeur(Fp2).puissance.all then
			res:=add_sons_aux(Fp1,Fp2);
		Else
			copy2 := break_link(Fp2);
			res := Fp1;
			An_Inserer_Frere(res,copy2);
		End if;
	End if;
	Return res;
	
	End add_sons;
------------------------------------------------------------------------
--Fonction addition
--Semantique : effectue la somme de deux polynomes
--Parametres :-- Fp1 : polynome; premier polynome à sommer
	      -- Fp2 : polynome; deuxieme polynome à sommer
--Type retour : polynome : le polynome représentant la somme
--Préconditions : aucune 
--Postconditions : aucune
--Exceptions : aucune

function addition (Fp1 : in polynome; Fp2 : in polynome) return polynome is
	poly_somme : polynome; --l'arbre representant la somme
	Begin
	poly_somme := An_Creer_Vide;
	
	If An_Vide(Fp1) then
		--P1 nul
		poly_somme := break_link(Fp2);
	Elsif An_Vide(Fp2) then
		--P2 nul
		poly_somme := break_link(Fp1);
		
	Elsif An_Valeur(Fp1).variable=Null then
		--P1 Constant
		If An_Valeur(Fp2).variable=Null then
			--P2 constant
			poly_somme := add_cons(Fp1,Fp2);
		Else --P2 non constant
			poly_somme := add_puiss0(Fp2,Fp1);
		End if;
	Elsif An_Valeur(Fp2).variable=Null then
		--P2 constant et P1 non constant
		poly_somme := add_puiss0(Fp1,Fp2);

			
	Elsif Character'Pos(An_Valeur(Fp1).variable.all)=Character'Pos(An_Valeur(Fp2).variable.all) then
		--Même variable
		poly_somme := add_sons(Fp1,Fp2);
		
	Elsif Character'Pos(An_Valeur(Fp1).variable.all)>Character'Pos(An_Valeur(Fp2).variable.all) then
		--Variable P1> Variable P2
		poly_somme := add_puiss0(Fp2,Fp1);

	Else
		--Variable P1 < Variable P2
		poly_somme := add_puiss0(Fp1,Fp2);
	
	End if;
	return poly_somme;

	End addition;
 
--======================================================================
--======================================================================
--Fonction saisir
--Semantique : lit le polynome saisi par l'utilisateur 
--et retourne la chaine de caractrere reprensentant le polynome
--Parametres : aucun
--Type retour :str
--Préconditions : aucune 
--Postconditions : aucune 
--Exceptions : aucune

function saisir return str is
	res : str;
	Begin
		Put("Entrer un polynome");
		New_Line;
		get_line(res.chaine,res.longueur);
		return res;
	End saisir;

--======================================================================
--======================================================================
--Procedure affiche_noeud_poly
--Semantique : affiche le noeud d'un polynome
--Parametres : Fnoeud : Donnée : Noeud_Poly
--Préconditions : aucune
--Postconditions : aucune
--Exceptions : aucune

procedure affiche_noeud_poly (Fnoeud : in Noeud_Poly) is
   Begin
	 --Affichage de la puissance si elle existe
	 
      If Fnoeud.puissance /= Null Then
	 put(Fnoeud.puissance.all,0);
	 --La puissance existe
	 --Affichage de la variable et du coefficient si ils existent
	 If Fnoeud.variable/=Null Then
	    put(".");
	    put((Fnoeud.variable.all));
	 --La variable exite   
	 --Affichage du coefficient si il existe
	    If Fnoeud.coef /= Null then
	       put(".");
	       put(Fnoeud.coef.all,0);
	    Else
	       Null;
	    End if;
	    
	  --La variable n'existe pas
	  --Affichage du coefficient si il existe   
	 Else	    
	    If Fnoeud.coef /= Null then
	       put(".");
	       put(Fnoeud.coef.all,0);
	    Else	    
	       Null;
	    End if;
	    
	 End if;
      --La puissance n'existe pas
      --Affichage de la variable et du coefficient si ils existent 
      Else
	 If Fnoeud.variable/=Null Then
	    put((Fnoeud.variable.all));
	     --La variable exite   
	 --Affichage du coefficient si il existe
	    If Fnoeud.coef /= Null then
	       put(".");
	       put(Fnoeud.coef.all,0);
	    Else
	       Null;
	    End if;
	     --La variable n'existe pas
	  --Affichage du coefficient si il existe   
	 Else	    
	    If Fnoeud.coef /= Null then
	       put(Fnoeud.coef.all,0);
	    Else	    
	       Null;
	    End if;
      End if;
    End if;
    End affiche_noeud_poly;
--======================================================================
--======================================================================
--procedure afficher_poly
--procedure qui affiche un polynome sous forme d'arbre_n
--Parametres : Fp : Donnée polynome; le polynome à afficher
--Préconditions : aucune
--Postconditions : aucune
--Exceptions : polynome_vide

Procedure afficher_poly ( Fp : in polynome) is
	Begin
		Begin
			An_Afficher(Fp);
			Exception
			When arbre_vide => raise polynome_vide;
		End;
	End afficher_poly;
--======================================================================
------------------------------------------------------------------------

end p_polynome;
