--======================================================================
--Hamza BOUKRAICHI
--Programme de test du paquetage de polynome
--======================================================================

with ada.text_io;
use ada.text_io;
with ada.integer_text_io;
use ada.integer_text_io;
With p_polynome;
use p_polynome;
--======================================================================
Procedure test_polynome is

------------------------Variables---------------------------------------
poly_string1 : str; --Polynome à encoder de test1
poly_string2 : str; --polynome à encoder de test2
poly_string3 : str; --Polynome à encoder de test3
poly1 : polynome; --Polynome de test1
poly2 : polynome; --Polynome de test2
poly3 : polynome; --Polynome de test3
------------------------------------------------------------------------

Begin

--Test de Encoder
put("----------------------------------------------------------------");
New_line;
put("Test de Encoder");
New_Line;

--Test1
put("Test 1");
New_line;

put("Encodage du monome +4X1Y2Z0");
New_line;
poly_string1.longueur :=8;
poly_string1.chaine(1..8) :="+4X1Y2Z0";
poly1:=encoder(poly_string1);
Afficher_poly(poly1);

--Test2
put("Test 2");
New_line;

put("Encodage du polynome +1X2Y0Z0+1X1Y1Z1");
New_line;
poly_string2.longueur :=16;
poly_string2.chaine(1..16) :="+1X2Y0Z0+1X1Y1Z1";
poly2:=encoder(poly_string2);
Afficher_poly(poly2);


--Test3
put("Test 3");
New_line;

put("Encodage du polynome : +3X0Y0Z0+1X0Y0Z3+4X1Y2Z0+1X2Y0Z0+1X1Y1Z1");
New_line;
poly_string3.longueur :=40;
poly_string3.chaine(1..40) :="+3X0Y0Z0+1X0Y0Z3+4X1Y2Z3+1X2Y0Z0+1X1Y1Z1";
poly3:=encoder(poly_string3);
Afficher_poly(poly3);


put("----------------------------------------------------------------");
New_line;

--Test de Décoder
put("----------------------------------------------------------------");
New_line;
put("Test de Décoder");
New_Line;

--Test1
put("Test 1");
New_line;

put("Decodage du premier polynome encoder");
New_line;
decoder(poly1);

--Test2
put("Test 2");
New_line;

put("Decodage du deuxieme polynome encoder");
New_line;
decoder(poly2);

--Test3
put("Test 3");
New_line;

put("Decodage du troisieme polynome encoder");
New_line;
decoder(poly3);


put("----------------------------------------------------------------");
New_line;

--Test d'Addition
put("----------------------------------------------------------------");
New_line;
put("Test d'Addition");
New_Line;

--Test1
put("Test 1");
New_line;

put("Addition de +3X0Y0Z2 et -3X0Y0Z1");
New_line;

poly_string1.longueur :=8;
poly_string1.chaine(1..8) :="+3X0Y0Z2";
poly1:=encoder(poly_string1);

poly_string2.longueur :=8;
poly_string2.chaine(1..8) :="-3X0Y0Z1";
poly2:=encoder(poly_string2);

poly3 := addition(poly1,poly2);
afficher_poly(poly3);

--Test2
put("Test 2");
New_line;

put("Addition de +3X0Y0Z1+4X2Y1Z1 et -3X0Y0Z1");
New_line;

poly_string1.longueur :=16;
poly_string1.chaine(1..16) :="+3X0Y0Z1+4X2Y1Z1";
poly1:=encoder(poly_string1);

poly_string2.longueur :=8;
poly_string2.chaine(1..8) :="-3X0Y0Z1";
poly2:=encoder(poly_string2);

poly3 := addition(poly1,poly2);
afficher_poly(poly3);

--Test3
put("Test 3");
New_line;

put("Addition de +3X0Y0Z0+1X0Y0Z3 et +4X1Y2Z0+1X2Y0Z0+1X1Y1Z1");
New_line;

poly_string1.longueur :=16;
poly_string1.chaine(1..16) :="+3X0Y0Z0+1X0Y0Z3";
poly1:=encoder(poly_string1);

poly_string2.longueur :=24;
poly_string2.chaine(1..24) :="+4X1Y2Z0+1X2Y0Z0+1X1Y1Z1";
poly2:=encoder(poly_string2);

poly3 := addition(poly1,poly2);
afficher_poly(poly3);


put("----------------------------------------------------------------");
New_line;

--Test de Saisir
put("----------------------------------------------------------------");
New_line;
put("Test de Saisir");
New_Line;

--Test1
put("Test 1");
New_line;

put("Le polynome +5X1Y2Z2 sera saisi encoder puis decoder ");
New_line;
poly_string1 := saisir;
poly1:=encoder(poly_string1);
Put("le polynome encodé");
New_line;
Afficher_poly(poly1);
decoder(poly1);

--Test2
put("Test 2");
New_line;

put("Le polynome +30X0Y1Z4-10X1Y2Z0 sera saisi, encodé puis decodé ");
New_line;
poly_string2 := saisir;
poly2:=encoder(poly_string2);
Put("le polynome encodé");
New_line;
Afficher_poly(poly2);
decoder(poly2);

--Test3
put("Test 3");
New_line;

put("Le polynome +2X1Y0Z0-2X1Y0Z0+3X2Y1Z0 sera saisi, encodé puis decodé ");
New_line;
poly_string3 := saisir;
poly3:=encoder(poly_string3);
Put("le polynome encodé");
New_line;
Afficher_poly(poly3);
decoder(poly3);


put("----------------------------------------------------------------");
New_line;

End test_polynome;
