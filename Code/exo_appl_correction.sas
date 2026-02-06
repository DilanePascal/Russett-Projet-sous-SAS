******************************************************
		CORRECTION DES EXERCICES D'APPLICATION
******************************************************;
data Clients;
set toto.clients;
run;
data Films;
set toto.Films;
run;
data Locations;
set toto.Locations;
run;
data Produits;
set toto.Produits;
run;

*************Exercice 1 — Gestion des locations de films***********************

*1.	Lister le prénom, le nom et la ville de tous les clients ayant loué au moins un film.;

Proc sql;
SELECT DISTINCT c.prenomcli, c.nomcli, c.villecli
FROM Clients c
INNER JOIN Locations l ON c.codecli = l.codecli;
Quit;

*2.	Afficher le titre des films loués par le client "Alberto Dubois".;

Proc sql;
SELECT f.nomfilm
FROM Films f
INNER JOIN Locations l ON f.codefilm = l.codefilm
INNER JOIN Clients c ON l.codecli = c.codecli
WHERE c.prenomcli = 'Alberto' AND c.nomcli = 'Dubois';
Quit;

*3.	Lister le prénom, le nom du client et la durée totale de ses locations.;

Proc sql;
SELECT c.prenomcli, c.nomcli, SUM(l.durée) AS duree_totale
FROM Clients c
INNER JOIN Locations l ON c.codecli = l.codecli
GROUP BY c.prenomcli, c.nomcli;
Quit;

*4.	Afficher le nom du film et le nombre de fois où il a été loué.;

Proc sql;
SELECT f.nomfilm, COUNT(l.codefilm) AS nb_locations
FROM Films f
LEFT JOIN Locations l ON f.codefilm = l.codefilm
GROUP BY f.nomfilm
ORDER BY nb_locations DESC;
Quit;

*5.	Afficher le nombre total de locations effectuées par ville.;

Proc sql;
SELECT c.villecli, COUNT(l.codefilm) AS nb_locations
FROM Clients c
INNER JOIN Locations l ON c.codecli = l.codecli
GROUP BY c.villecli
ORDER BY nb_locations DESC;
Quit;



************* Exercice 2 — Analyse des produits ***********************

*Question 1 — Produits disponibles à réapprovisionner.
Afficher les produits disponibles (Indisponible = 0) dont le stock est inférieur ou égal au niveau de réapprovisionnement;

Proc sql;
SELECT Refprod, Nomprod, UnitesStock, NiveauReap
  FROM Produits
WHERE Indisponible = 0
  AND UnitesStock <= NiveauReap;
Quit ;

*Ce qu’on apprend :
•	Utiliser plusieurs conditions avec AND.
•	Identifier les produits à risque de rupture.

--------------------
*Question 2 — Valeur totale du stock par fournisseur
Calculer la valeur totale du stock (PrixUnit × UnitesStock) pour chaque fournisseur;

Proc sql;
SELECT  NoFour, SUM(PrixUnit * UnitesStock) AS ValeurTotaleStock
FROM Produits
GROUP BY NoFour
ORDER BY ValeurTotaleStock DESC;
Quit;

*Ce qu’on apprend :
•	Utiliser GROUP BY pour regrouper les lignes.
•	Faire des calculs agrégés avec SUM.
•	Trier les résultats avec ORDER BY.

--------------------
*Question 3 — Nombre de produits par catégorie.
Afficher le nombre de produits dans chaque catégorie.;

PROC sql;
SELECT  CodeCateg, COUNT(*) AS NbProduits
FROM Produits
GROUP BY CodeCateg
ORDER BY NbProduits DESC;
Quit;

*Ce qu’on apprend :
•	Utiliser COUNT(*) pour compter les lignes.
•	Classer les catégories selon le nombre d’articles.

---------------------
*Question 4 — Moyenne des prix par catégorie
Calculer le prix moyen unitaire des produits pour chaque catégorie.;

Proc sql;
SELECT CodeCateg, ROUND(AVG(PrixUnit), .01) AS PrixMoyen
FROM Produits
GROUP BY CodeCateg
ORDER BY PrixMoyen DESC;
Quit;

*Ce qu’on apprend :
•	Utiliser AVG() pour une moyenne.
•	ROUND() pour arrondir à deux décimales.
•	Comparer les prix moyens par catégorie.

---------------------
*Question 5 — Produits commandés récemment
Afficher les produits pour lesquels le nombre d’unités commandées (UnitesCom) est 
supérieur à 20 et le produit n’est pas indisponible.;

Proc sql;
SELECT Nomprod, UnitesCom, Indisponible
FROM Produits
WHERE UnitesCom > 20
  AND Indisponible = 0
ORDER BY UnitesCom DESC;
Quit;


*Ce qu’on apprend :
•	Filtrage numérique (>, <)
•	Combinaison de conditions logiques.
•	Tri par ordre décroissant.


