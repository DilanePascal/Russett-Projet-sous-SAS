/******************************************
  Apllication
*******************************************/

/*** Création d'un fichier sas***/
data creation_d_un_fichier_sas;
input nom $ sexe $ age taille poids date_nais:ddmmyy10.;
format date_nais date9.;
cards;
Marine F 21 169 60.0 13/10/1988
Denis M 18 165 45.0 01/11/1998
Antoine M 20 175 63.0 3/12/2008
Sarah F 19 170 50.0 13/08/1999
Mélanie F 22 172 55.0 23/09/1995
Jean M 21 170 56.2 26/06/1998
Pierre M 20 172 63.2 03/05/1994
Anaïs F 18 162 44.6 13/10/1988
;
run;


data creation_d_un_fichier_sas;
INFILE DATALINES DLM=',';
input nom$ sexe$ age taille poids date_nais:ddmmyy10.;
format date_nais date9.;
DATALINES;
Marine, F, 21, 169, 60.0, 13/10/1988
Denis, M, 18, 165, 45.0, 01/11/1998
Antoine, M, 20, 175, 63.0, 3/12/2008
Sarah, F, 19, 170, 50.0, 13/08/1999
Mélanie, F, 22, 172, 55.0, 23/09/1995
Jean, M, 21, 170, 56.2, 26/06/1998
Pierre, M, 20, 172, 63.2, 03/05/1994
Anaïs, F, 18, 162, 44.6, 13/10/1988
;
run;
proc print ;
run;

**************************************************;

data exemple;
input nom $ sexe $1. age taille poids note ville $ groupe $  ;
cards;
Marine-A F 21 169 60.0 16 Lille A
Denis-M M 18 165 45.0 13 Paris A
Antoine M 20 175 63.0 12 Lens B
Sarah-V F 19 170 50.0 8 Lille A
Mélanie F 22 172 55.0 6 Lens C
Jean M 21 170 56.2 13 Paris C
Pierre M 20 172 63.2 19 Paris C
Anaïs F 18 162 44.6 5 Lille B
Chris M 16 170 63.2 12.6 Lille C
Jane F 21 145 56.8 7 Lens C
Tom M 20 155 66.0 11 Paris C
Joe M 19 173 68.2 14 Paris C
Jerry M 18 168 65.0 3 Lille B
Dan M 18 166 68.0 10 Paris B
Jim M 18 180 80.2 11 Lens B
Sid M 16 175 80.2 12 Lens B
Emma F 21 172 77.1 18 Lille B
Jane F 21 170 67.3 6 Lille A
Joe M 20 172 69.6 4 Lille A
Sam M 16 155 50.5 12 Paris B
Elisa F 16 178 77.0 19 Lens B
Amy F 21 170 72.6 13 Lens C
Sihui F 21 169 72.1 13 Lens C 
July F 20 171 78.0 9 Lens B
Chloe F 16 160 66.2 12 Lille A
;
run;


