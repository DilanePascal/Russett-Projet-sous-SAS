

PROC IMPORT DATAFILE="C:\Users\Emmaüs Connect\Documents\Projet sous SAS\Tables\russett.txt"
	DBMS=TAB REPLACE 
	OUT=WORK.Russett;
	GETNAMES=YES;
RUN;



PROC GPLOT data=russett;
	plot gini*pays;
	title  "Inegalité agricole (GINI) par pays";
RUN;
PROC UNIVARIATE DATA=russett;
	VAR gini;
	ID pays;
	title  "Inegalité agricole (GINI) par pays";
RUN;


data russett2;
	set russett;
	if demo = "dictature" then regime = 1;
						  else regime = 0;
run;
PROC UNIVARIATE DATA=russett2;
	VAR farm;
	ID demo;
	title  "Relation entre l'accès à la propriété (farm) des terres et le type de régime (demo)";
	HISTOGRAM / NORMAL;
RUN;


PROC MEANS data=russett MEAN STD MIN MAX MAXDEC=2;
	Class continent;
	VAR gini gnpr inst;
RUN;
PROC SGPLOT data=russettsanscanada;
	vbox gini / category=demo;
	title  "Inegalités agricoles (GINI) par régime";
RUN;



PROC SGPLOT data=russett;
	hbar demo;
	title "Répartition des types de régime politique";
RUN;



proc means data=russett mean n std min max;
	Class continent;
	VAR gnpr;
RUN;

proc sort data=russett;
by gnpr;
run;
proc sort data=russett;
by continent;
run;
PROC boxPLOT data=russett;
	plot  gnpr*continent/
		CAXIS=black CTEXT=black
		CBOXES=black
		BOXSTYLE=schematic
		IDCOLOR=black IDSYMBOL=dot;

		INSET MIN MEAN MAX STDDEV /  
		HEADER='Overall Statistics' 
		POSITION=TM;

		INSETGROUP N min max NHIGH NLOW NOUT / 
		HEADER='Extremes par groupe';
	title  "repartition des richesses (gnpr) par continent";

RUN;

proc means data=russett mean n std min max;
	class demo;
	var gnpr;
run;


proc sort data=russett;
by gnpr;
run;
proc sort data=russett;
by demo;
run;
proc boxplot data=russett;
	plot gnpr*demo / 
		CAXIS=black CTEXT=black
		CBOXES=black
		BOXSTYLE=schematic
		IDCOLOR=black IDSYMBOL=dot;

		INSET MIN MEAN MAX STDDEV /  
		HEADER='Overall Statistics' 
		POSITION=TM;

		INSETGROUP N min max NHIGH NLOW NOUT / 
		HEADER='Extremes par groupe';

	title "Niveau de developpement industriel par catégorie de régime politique";
run;





proc corr data=russett PLOTS=matrix(Histogram);
	var inst ecks death;
	title "Corrélation entre l'instabilité de l'éxécutif et les violences politiques";
run;


proc means data=russett mean n std max min;
	var inst ecks death;
	class demo;
run;



proc corr data=russett PLOTS=matrix(Histogram);
	var gnpr gini;
	title "Corrélation entre inégalités agricoles et développement industriel";
run;
proc gplot data=russett;
	plot gini*gnpr;
	title "Corrélation entre inégalités agricoles et développement industriel";
run;


proc means data=russett2 mean std n;
	class regime;
	var gini;
run;
proc means data=russett2 mean std n;
	class regime;
	var gnpr;
run;

PROC UNIVARIATE DATA=russett2;
	VAR gnpr;
	ID demo;
	HISTOGRAM / NORMAL;
	title "Evaluation de la significativité de la différence entre le developpement et le regime";
RUN;
PROC UNIVARIATE DATA=russett2;
	VAR gini;
	ID demo;
	HISTOGRAM / NORMAL;
	title "Evaluation de la significativité de la différence entre les inégalités et le regime";
RUN;
PROC SGPLOT data=russett;
hbar demo;
title "Répartition des types de régime politique";
RUN;

proc sql;
	select continent,pays,gini,gnpr,demo
	from russett
	having gini>avg(gini) and gnpr<avg(gnpr);
	title "Les pays qui vérifient l'hypothèse formulée"; 
run;
