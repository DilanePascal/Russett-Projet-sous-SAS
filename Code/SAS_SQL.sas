******************************;
*  		PROCEDURE SQL
******************************;

**Requête simple ***;

PROC SQL;
create table test as
 SELECT *
   FROM toto.Clients;
QUIT;


***Limitation des résultats ***;
PROC SQL outobs=5;
  SELECT *
    FROM toto.Clients;
QUIT;

****Tri des résultats ****;

*par le nom de la variable;
PROC SQL;
  SELECT * 
    FROM toto.Clients
ORDER BY Nomcli;
QUIT;

PROC SQL;
  SELECT * 
    FROM toto.Clients
ORDER BY sexe, villecli, nomcli;
QUIT;

*par la position de la variable;
PROC SQL;
  SELECT * 
    FROM toto.Clients
ORDER BY 3;
QUIT;

* Tri decroissant;
PROC SQL;
SELECT * 
    FROM toto.CLIENTS
    ORDER BY NomCli DESC;
QUIT;

PROC SQL;
SELECT * 
    FROM toto.CLIENTS
    ORDER BY NomCli DESC, prenomcli ;
QUIT;

**Trier selon deux variables;
PROC SQL;
SELECT * 
    FROM toto.CLIENTS 
ORDER BY nomcli,preNomcli;
QUIT;

**Tri croissant et decroissant à la fois;
PROC SQL;
  SELECT * 
    FROM toto.CLIENTS
ORDER BY nomcli DESC,prenomcli;
QUIT;

***Restriction: clause where, and, or et opérateurs classiques;
PROC SQL;
  SELECT * 
    FROM toto.CLIENTS
   WHERE cpcli EQ 57500;
QUIT;

**
= : EQ
<> : NE
< : LT
> : GT
<= : LE
>= : GE
;
PROC SQL;
  SELECT * 
    FROM toto.CLIENTS
   WHERE cpcli NE 57500;
QUIT;

data devoir;
set toto.CLIENTS;
if cpcli ^= 57500;
run;

PROC SQL;
  SELECT * 
    FROM toto.Clients
   WHERE villecli= "Saint-Avold"
     AND sexe= "H"
     AND age < 23;
QUIT;

data devoir_b;
set toto.CLIENTS (where=(villecli= "Saint-Avold" AND sexe= "H" AND age < 23));
*if villecli= "Saint-Avold" AND sexe= "H" AND age < 23;
run;

**Restriction : where, upper, lower, between, is null;

*ForbaCH
FORbach
forbach
ForBaCh;

PROC SQL;
  SELECT * 
    FROM toto.Clients
   WHERE UPPER(Villecli)="FORBACH"; 
QUIT;

PROC SQL;
  SELECT * 
    FROM toto.Clients
   WHERE lower(Villecli)="forbach"; 
QUIT;

PROC SQL;
  SELECT * 
    FROM toto.Clients
   WHERE Villecli IS NULL;
QUIT;

PROC SQL;
  SELECT * 
    FROM toto.Clients
   WHERE Age BETWEEN 18 AND 21;
QUIT;

data devoir;
set toto.Clients (where=(Age BETWEEN 18 AND 21));
run;

data devoir;
set toto.Clients ;
if 18<=Age <= 21;
run;

**Restriction : where, in, like;
PROC SQL;
  SELECT * 
    FROM toto.Clients
   WHERE sexe IN ('H','F');
QUIT;

data devoir;
set toto.Clients (where=(sexe in ('H','F')));
run;

data devoir;
set toto.Clients;
if sexe in ('H','F');
run;

PROC SQL;
  SELECT * 
    FROM toto.Clients
   WHERE sexe IN ('H');
QUIT;

PROC SQL;
  SELECT * 
    FROM toto.Clients
   WHERE Age IN (18,19,20,22);
QUIT;

PROC SQL;
  SELECT * 
    FROM toto.Clients
   WHERE Nomcli LIKE 'L%';
QUIT;

PROC SQL;
  SELECT * 
    FROM toto.Clients
   WHERE villecli LIKE 'For%';
QUIT;

data devoir;
set toto.Clients (where=(Nomcli LIKE 'L%'));
run;

data devoir;
set toto.Clients ;
where Nomcli LIKE 'L%';
run;

PROC SQL;
  SELECT * 
    FROM toto.Clients
   WHERE upper(Nomcli) LIKE '%L%';
QUIT;


PROC SQL;
  SELECT * 
    FROM toto.Clients
   WHERE NomCli LIKE '_____';
QUIT;

***Projection : Une projection est une sélection de colonnes d'un tableau;
PROC SQL;
SELECT Nomcli, 
       Prenomcli 
 FROM toto.Clients;
QUIT;

PROC SQL;
SELECT Nomcli, 
       Prenomcli,
       age, /*commentaire*/
       villecli
  FROM toto.clients
 WHERE Age IN (18,22,20);
QUIT;

*** Gestion des doublons: Distinct;
PROC SQL;
SELECT Villecli
  FROM toto.clients;
QUIT;

PROC SQL;
SELECT DISTINCT Villecli
  FROM toto.Clients;
QUIT;

PROC SORT data=toto.Clients OUT=tester (keep=Villecli) nodupkey;
	By Villecli;
RUN;

PROC SORT data=toto.Clients OUT=tester (keep=Villecli sexe rename=(Villecli=ville)) nodupkey;
	By Villecli sexe;
RUN;

PROC SQL;
SELECT DISTINCT Villecli as ville,
                sexe
 FROM toto.clients; 
QUIT;

***Renommer une variable: AS;
PROC SQL;
SELECT Nomcli AS Nouveau_Nom 
  FROM toto.clients; 
QUIT;

*** Les jointures: INNER JOIN - LEFT JOIN;
proc sort data=toto.Clients;
by codecli;
run;
proc sort data=toto.Locations;
by codecli;
run;

data nouv;
merge toto.Clients (in=A) toto.Locations (in=B);
by codecli;
if A and B;
run;

PROC SQL;
    SELECT cl.codecli,
           codefilm,
           prenomcli,
           nomcli,
           ruecli,
           cpcli,
           villecli,
           Sexe,
           Age,
           datedebut,
           durée
      FROM toto.Clients AS cl
INNER JOIN toto.Locations AS Lo
        ON cl.codecli=lo.codecli; 
QUIT;

PROC SQL;
    SELECT cl.codecli,
           codefilm,
           prenomcli,
           nomcli,
           ruecli,
           cpcli,
           villecli,
           Sexe,
           Age,
           datedebut,
           durée
      FROM toto.Clients cl
INNER JOIN toto.Locations Lo
        ON cl.codecli=lo.codecli; 
QUIT;

PROC SQL;
    SELECT cl.codecli,
           codefilm,
           prenomcli,
           nomcli,
           ruecli,
           cpcli,
           villecli,
           Sexe,
           Age,
           datedebut,
           durée
      FROM toto.Clients cl
INNER JOIN toto.Locations Lo
        ON cl.codecli=lo.codecli
     WHERE cl.cpcli=57800; 
QUIT;

*****Left join***;
proc sort data=toto.Films;
by codefilm;
run;
proc sort data=toto.Locations;
by codefilm;
run;

data nouv;
merge toto.Locations (in=A) toto.Films (in=B);
by codefilm;
if A ;
run;

PROC SQL;
    SELECT *
      FROM toto.Locations lo
 LEFT JOIN toto.Films fi
        ON lo.codefilm=fi.codefilm; 
QUIT;

PROC SQL;
    SELECT codecli,
           lo.codefilm,
           datedebut,
           durée,
           nomfilm
      FROM toto.Locations lo
 LEFT JOIN toto.Films fi
        ON lo.codefilm=fi.codefilm; 
QUIT;


data nouv;
merge dmaisoN.Locations (in=A) dmaisoN.Films (in=B);
by codefilm;
if B ;
run;

PROC SQL;
    SELECT codecli,
           fi.codefilm,
           datedebut,
           durée,
           nomfilm
      FROM toto.Films fi
 LEFT JOIN toto.Locations lo
        ON fi.codefilm=lo.codefilm; 
QUIT;

PROC SQL;
    SELECT codecli,
           lo.codefilm,
           datedebut,
           durée,
           nomfilm
      FROM toto.Locations Lo
 LEFT JOIN toto.Films fi
        ON lo.codefilm=fi.codefilm
     WHERE fi.codefilm IN (1,5,7); 
QUIT;

PROC SQL;
    SELECT cl.codecli,
           lo.codefilm,
           prenomcli,
           nomcli,
           ruecli,
           cpcli,
           villecli,
           Sexe,
           Age,
           nomfilm,
           datedebut,
           durée		
      FROM toto.Clients cl
INNER JOIN toto.Locations Lo
        ON cl.codecli=lo.codecli
INNER JOIN toto.Films fi
        ON lo.codefilm =fi.codefilm
        WHERE cl.cpcli=57800; 
QUIT;

PROC SQL;
    SELECT *
      FROM dmaisoN.Clients cl
INNER JOIN dmaisoN.Locations Lo
        ON cl.codecli=lo.codecli
INNER JOIN dmaisoN.Films fi
        ON lo.codefilm =fi.codefilm
     WHERE cl.cpcli=57800; 
QUIT;

proc sort data=toto.Clients;
by codecli;
run;
proc sort data=toto.Locations;
by codecli;
run;
Data merge_clients_location;
merge toto.Clients (in=A) toto.Locations (in=B);
by codecli;
if A and B;
run;
proc sort data=merge_clients_location;
by codefilm;
run;
proc sort data= toto.Films;
by codefilm;
run;
Data films_clients_location (where=(cpcli=57800));
merge merge_clients_location (in=A) toto.Films (in=B);
by codefilm;
if A and B;
;
run;

PROC SQL;
    SELECT cl.codecli,
           lo.codefilm,
           prenomcli,
           nomcli,
           ruecli,
           cpcli,
           villecli,
           Sexe,
           Age,
           nomfilm,
           datedebut,
           durée	
      FROM toto.Clients cl
 LEFT JOIN toto.Locations Lo
        ON cl.codecli=lo.codecli
 LEFT JOIN toto.Films fi
        ON lo.codefilm =fi.codefilm
        order by nomcli; 
QUIT;

PROC SQL;
    SELECT *
      FROM dmaisoN.Clients cl
 LEFT JOIN dmaisoN.Locations Lo
        ON cl.codecli=lo.codecli
 LEFT JOIN dmaisoN.Films fi
        ON lo.codefilm =fi.codefilm
     WHERE cl.cpcli=57800; 
QUIT;


PROC SQL;
    SELECT *
      FROM dmaisoN.Clients cl
 LEFT JOIN dmaisoN.Locations Lo
        ON cl.codecli=lo.codecli
INNER JOIN dmaisoN.Films fi
        ON lo.codefilm =fi.codefilm; 
QUIT;

proc sort data=dmaisoN.Clients;
by codecli;
run;
proc sort data=dmaisoN.Locations;
by codecli;
run;
Data merge_clients_location;
merge dmaisoN.Clients (in=A) dmaisoN.Locations (in=B);
by codecli;
if A ;
run;
proc sort data=merge_clients_location;
by codefilm;
run;
proc sort data= dmaisoN.Films;
by codefilm;
run;
Data films_clients_location ;
merge merge_clients_location (in=A) dmaisoN.Films (in=B);
by codefilm;
if A and B;
;
run;

PROC SQL;
    SELECT *
      FROM dmaisoN.Clients cl
INNER JOIN dmaisoN.Locations Lo
        ON cl.codecli=lo.codecli
LEFT JOIN dmaisoN.Films fi
        ON lo.codefilm =fi.codefilm
     WHERE cl.cpcli=57800; 
QUIT;

****************************************;
* Manipulation de la table des produits ;
****************************************;
proc print data = toto.produits;
run;
**Combiner AND et OR ;
PROC SQL;
    SELECT *
      FROM toto.produits
     WHERE (CodeCateg=1 AND PrixUnit  >  50)
        OR (CodeCateg=3 AND PrixUnit  <  90);
QUIT;

data devoir;
set toto.produits (where=((CodeCateg=1 AND PrixUnit  >  50) or (CodeCateg=3 AND PrixUnit  <  90) ));
run;
***Requêtes et calculs arithmétiques;
PROC SQL;
 SELECT *, 
      UnitesStock + UnitesCom 
 FROM toto.produits;
QUIT;

PROC SQL;
 SELECT  
      (UnitesStock + UnitesCom) as addition 
 FROM toto.produits;
QUIT;

PROC SQL;
SELECT RefProd, 
       (UnitesStock + UnitesCom) as addition 
  FROM toto.produits;
QUIT;

PROC SQL;
SELECT RefProd AS Reference, 
       (UnitesStock + UnitesCom) AS Available_units /*Unités_disponibles*/
  FROM dmaisoN.produits; 
QUIT;

PROC SQL;
SELECT RefProd, 
       (PrixUnit * UnitesStock) AS  Amount_in_stock /*Quantité_en_stock*/
 FROM  dmaisoN.produits; 
QUIT;

PROC SQL;
SELECT RefProd, 
       (PrixUnit * UnitesStock) AS Amount_in_stock_unavailable
 FROM  dmaisoN.produits
WHERE  Indisponible=1; 
QUIT;

PROC SQL outobs=5;
SELECT RefProd, 
       (PrixUnit * UnitesStock) AS Amount_in_stock
  FROM dmaisoN.produits
 WHERE Indisponible=1
ORDER BY 2 DESC; 
QUIT;   

PROC SQL;
SELECT RefProd, UnitesStock,
       PrixUnit *(UnitesStock-5) as soustraction
  FROM dmaisoN.produits
 WHERE UnitesStock >= 5; 
QUIT;

data devoir;
set  dmaisoN.produits (where=( UnitesStock >= 5));
soustraction=PrixUnit *(UnitesStock-5) ;
keep  RefProd soustraction UnitesStock;
run;

PROC SQL;
SELECT RefProd, 
       ROUND(PrixUnit *1.5,.01) AS Nouveau_prix
  FROM dmaisoN.produits; 
QUIT;

***Traitement conditionnel: CASE WHEN;

**ex avec la table clients;
PROC SQL;
SELECT codecli,Nomcli,prenomcli,Sexe,
  CASE Sexe
      WHEN "H" THEN "Homme" 
      WHEN "F" THEN "Femme"  
      ELSE Sexe 
  END AS Titre
 FROM dmaisoN.Clients ;
QUIT;

**********************************************
			******SUITE************
**********************************************;
PROC SQL;
SELECT Refprod, Nomprod, NiveauReap,
 CASE NiveauReap
      WHEN 0 THEN "Pas de niveau minimum" 
      ELSE "Réapprovisionnement à partir de "||NiveauReap||" unités restantes" 
  END AS reapprovisionnement
 FROM dmaisoN.Produits ;
QUIT;

/*
DATA dmaisoN.Produits;
set dmaisoN.Produits;
drop NiveauReap2 Text_to_num CharReapnouveau NiveauReapnouveau test;
RUN;*/


DATA dmaisoN.Produits;
set dmaisoN.Produits;
format NiveauReap2 $32.;
NiveauReap2=input(NiveauReap,$32.);
Text_to_num=input(NiveauReap2, best8.);
Rename NiveauReap2=CharReapnouveau Text_to_num=NiveauReapnouveau;
RUN;

PROC SQL;
SELECT Refprod, Nomprod, CharReapnouveau,
 CASE CharReapnouveau
      WHEN '0' THEN "Pas de niveau minimum" 
      ELSE "Réapprovisionnement à partir de "||CharReapnouveau||" unités restantes" 
  END AS reapprovisionnement
 FROM dmaisoN.Produits ;
QUIT;

PROC SQL;
SELECT Refprod, Nomprod, PrixUnit,
 CASE
      WHEN PrixUnit<=50 THEN "Bas prix" 
      WHEN 50 < PrixUnit <=90 THEN "Prix moyens" 
      ELSE "Produits de luxe" 
  END AS Gamme
 FROM dmaisoN.Produits ;
QUIT;

data devoir;
format Gamme $24.;
set dmaisoN.Produits;
if PrixUnit<=50 THEN Gamme="Bas prix";
else if 50 < PrixUnit <=90 THEN Gamme="Prix moyens";
else Gamme="Produits de luxe";
keep  Refprod Nomprod PrixUnit Gamme;
run;

PROC SQL;
SELECT Refprod, UnitesStock, UnitesCom, NiveauReap,
 CASE
      WHEN UnitesCom > 40 THEN "Déjà commandé" 
      WHEN UnitesCom < NiveauReap THEN "A Commander " 
      WHEN UnitesCom = 0 THEN "N'est plus en stock "
      ELSE " Disponible " 
  END AS Informations
 FROM dmaisoN.Produits ;
QUIT;

data devoir;
format Informations $24.;
set dmaisoN.Produits;
if UnitesCom > 40 THEN Informations="Déjà commandé";
else if UnitesCom < NiveauReap THEN Informations="A Commander " ;
else if UnitesCom = 0 THEN Informations="N'est plus en stock ";
else Informations=" Disponible ";
keep  Refprod UnitesStock UnitesCom NiveauReap Informations;
run;
***Agrégation;
PROC SQL;
SELECT COUNT(*) as nb
  FROM dmaisoN.clients; 
QUIT;

PROC SQL;
SELECT COUNT(codecli) as nb_de_lignes
  FROM dmaisoN.clients; 
QUIT;

PROC SQL;
SELECT COUNT(DISTINCT CodeCateg)  as nb_codecateg_distinct
  FROM dmaisoN.produits;
QUIT;

PROC SQL;
SELECT DISTINCT CodeCateg
  FROM dmaisoN.produits;
QUIT;

**Restriction dans le dénombrement ;
PROC SQL;
SELECT COUNT(*) as nb_Indisponible
  FROM dmaisoN.produits
 WHERE Indisponible=1; 
QUIT;

***Calculs statistiques simples;
PROC SQL;
SELECT SUM(UnitesStock) as la_som
  FROM dmaisoN.produits;
 WHERE CodeCateg=1;
QUIT;

PROC SQL;
  SELECT AVG(PrixUnit) as moyenne
    FROM dmaisoN.produits;
QUIT;

PROC SQL;
SELECT ROUND(AVG(PrixUnit),.001) as moyenne
  FROM dmaisoN.produits; 
QUIT;

PROC SQL;
SELECT MIN(PrixUnit) as mini,
		AVG(PrixUnit) as moy,
       MAX(PrixUnit) as maxi 
  FROM dmaisoN.produits; 
QUIT;

***Agrégats par attribut;
PROC SQL;
SELECT CodeCateg, 
	   COUNT(*) as nb
  FROM dmaisoN.produits
  group by CodeCateg;
QUIT;

PROC SQL;
SELECT Indisponible, 
       COUNT(*) as nb
  FROM dmaisoN.produits 
GROUP BY Indisponible; 
QUIT;

PROC SQL;
  SELECT Indisponible,
         COUNT(*) AS Nombre_de_clients 
    FROM dmaisoN.produits  
GROUP BY Indisponible
ORDER BY 2 DESC; 
QUIT;

PROC SQL;
SELECT NoFour,
       COUNT(*) AS Nombre_de_produits,  
       ROUND(AVG(PrixUnit),.001) AS PrixMoyen, 
       MIN(PrixUnit) AS PrixMinimum,
       MAX(PrixUnit) AS PrixMaximum
  FROM dmaisoN.produits 
GROUP BY NoFour
ORDER BY NoFour;
QUIT;


PROC MEANS data=dmaisoN.produits n mean min max ;
	Var PrixUnit;
	Class NoFour;
Run;

PROC MEANS DATA=dmaisoN.produits n mean min max maxdec=2;
var PrixUnit;
Class Nofour;
output out = test (drop = _FREQ_ _TYPE_)
N = Nombre_de_produits
mean = PrixMoyen
min = PrixMinimum
max = PrixMaximum;
run;

proc print data =test;
run;

PROC SQL;
SELECT NoFour,
       CodeCateg,
       COUNT(*) 
  FROM dmaisoN.produits  
GROUP BY NoFour, CodeCateg; 
QUIT;

PROC SQL;
SELECT NoFour,
       COUNT(*) AS Nombre_de_produits,  
       ROUND(AVG(PrixUnit)) AS PrixMoyen, 
       MIN(PrixUnit) AS PrixMinimum,
       MAX(PrixUnit) AS PrixMaximum
  FROM dmaisoN.produits
 GROUP BY NoFour
 HAVING Nombre_de_produits < 2
ORDER BY NoFour; 
QUIT;

PROC MEANS DATA=dmaisoN.produits n mean min max maxdec=2;
var PrixUnit;
Class Nofour;
output out = test (drop =_FREQ_ _TYPE_)
N = Nombre_de_produits
mean = PrixMoyen
min = PrixMinimum
max = PrixMaximum;
run;

data test2 ;
set test(where=(Nombre_de_produits <2));
run;

************************************;
* 	CREATION D'UNE TABLE AVEC SQL
************************************;

PROC SQL;
CREATE TABLE DMAISON.MA_NOUV_TABLE AS
 SELECT *
   FROM DMAISON.Clients;
QUIT;


PROC SQL;
CREATE TABLE DMAISON.MA_TABLE AS
SELECT NoFour,
       COUNT(*) AS Nombre_de_produits,  
       ROUND(AVG(PrixUnit)) AS PrixMoyen, 
       MIN(PrixUnit) AS PrixMinimum,
       MAX(PrixUnit) AS PrixMaximum
  FROM dmaisoN.produits
 GROUP BY NoFour
 HAVING Nombre_de_produits < 2
ORDER BY NoFour; 
QUIT;


***********************************************************************************
SELECTION DE VARIABLES DANS DIFFERENTES TABLES ET STOCKAGE DANS UNE NOUVELLE TABLE
***********************************************************************************;

PROC SQL;
CREATE TABLE DMAISON.MA_TABLE_2 AS
    SELECT cl.codecli,
           cl.nomcli, 
           cl.prenomcli, 
           cl.ruecli, 
           cl.villecli, 
           cl.cpcli, 
           lo.codecli as nouv_nom,
           lo.codefilm,
           lo.datedebut,
           lo.duree
      FROM dmaisoN.Clients cl
INNER JOIN dmaisoN.Locations Lo
        ON cl.codecli=lo.codecli; 
QUIT;

PROC SQL;
CREATE TABLE DMAISON.MA_TABLE_3 AS
    SELECT cl.codecli,
           cl.nomcli, 
           cl.prenomcli, 
           cl.ruecli, 
           cl.villecli, 
           cl.cpcli, 
           lo.codefilm,
           lo.datedebut,
           lo.duree,
           fi.nomfilm
      FROM dmaisoN.Clients cl
 LEFT JOIN dmaisoN.Locations Lo
        ON cl.codecli=lo.codecli
 LEFT JOIN dmaisoN.Films fi
        ON lo.codefilm =fi.codefilm; 
QUIT;











































