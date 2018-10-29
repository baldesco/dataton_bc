"Limpia Objetos"
rm(list=ls())
"Cambia La Ruta A Donde Tengo La Data"
setwd("C:/Users/Richard/Documents/Richard/Dataton")
"Importa Las Tablas"
pag<-read.csv("dt_info_pagadores_muestra.csv",
              header=FALSE,
              sep=",")
"Cambia Los Nombres De Las Variables"
names(pag)[1]<-paste("id_cliente")
names(pag)[2]<-paste("seg_str")
names(pag)[3]<-paste("ocupacion")
names(pag)[4]<-paste("tipo_vivienda")
names(pag)[5]<-paste("nivel_academico")
names(pag)[6]<-paste("estado_civil")
names(pag)[7]<-paste("genero")
names(pag)[8]<-paste("edad")
names(pag)[9]<-paste("ingreso_rango")
"Saca Las Frecuencias"
library(plyr)
count(pag,'seg_str')
count(pag,'ocupacion')
count(pag,'tipo_vivienda')
count(pag,'nivel_academico')
count(pag,'estado_civil')
count(pag,'genero')
count(pag,'edad')
count(pag,'ingreso_rango')

"Importa Las Tablas"
trans<-read.csv("dt_trxpse_personas_2016_2018_muestra_adjt.csv",
              header=FALSE,
              sep=",")
names(trans)[1]<-paste("id_trn_ach")
names(trans)[2]<-paste("id_cliente")
names(trans)[3]<-paste("fecha")
names(trans)[4]<-paste("hora")
names(trans)[5]<-paste("valor_trx")
names(trans)[6]<-paste("ref1")
names(trans)[7]<-paste("ref2")
names(trans)[8]<-paste("ref3")
names(trans)[9]<-paste("sector")
names(trans)[10]<-paste("subsector")
names(trans)[11]<-paste("descripcion")
library(plyr)
count(trans,'fecha')

"Crea El Campo Fecha_1 Formato AÑOMES"
library(sqldf)
trans1<-sqldf("SELECT t1.*,substr(t1.fecha,1,6) as fecha_1 FROM trans as t1")
count(trans1,'fecha_1')

"Crea A Nivel Cliente La Transaccionalidad Para 12 Periodos en valores y en numero de Transacciones"
trans2<-sqldf("SELECT t1.id_cliente, 
              sum(case when t1.fecha_1='201610' then valor_trx else 0 end) as valor_menos4,
              sum(case when t1.fecha_1='201611' then valor_trx else 0 end) as valor_menos3,
              sum(case when t1.fecha_1='201612' then valor_trx else 0 end) as valor_menos2,
              sum(case when t1.fecha_1='201701' then valor_trx else 0 end) as valor_menos1,
              sum(case when t1.fecha_1='201702' then valor_trx else 0 end) as valor_t1,
              sum(case when t1.fecha_1='201703' then valor_trx else 0 end) as valor_t2,
              sum(case when t1.fecha_1='201704' then valor_trx else 0 end) as valor_t3,
              sum(case when t1.fecha_1='201705' then valor_trx else 0 end) as valor_t4,
              sum(case when t1.fecha_1='201706' then valor_trx else 0 end) as valor_t5,
              sum(case when t1.fecha_1='201707' then valor_trx else 0 end) as valor_t6,
              sum(case when t1.fecha_1='201708' then valor_trx else 0 end) as valor_t7,
              sum(case when t1.fecha_1='201709' then valor_trx else 0 end) as valor_t8,
              sum(case when t1.fecha_1='201710' then valor_trx else 0 end) as valor_t9,
              sum(case when t1.fecha_1='201711' then valor_trx else 0 end) as valor_t10,
              sum(case when t1.fecha_1='201712' then valor_trx else 0 end) as valor_t11,
              sum(case when t1.fecha_1='201801' then valor_trx else 0 end) as valor_t12,
              sum(case when t1.fecha_1='201610' then 1 else 0 end) as conteo_menos4,
              sum(case when t1.fecha_1='201611' then 1 else 0 end) as conteo_menos3,
              sum(case when t1.fecha_1='201612' then 1 else 0 end) as conteo_menos2,
              sum(case when t1.fecha_1='201701' then 1 else 0 end) as conteo_menos1,
              sum(case when t1.fecha_1='201702' then 1 else 0 end) as conteo_t1,
              sum(case when t1.fecha_1='201703' then 1 else 0 end) as conteo_t2,
              sum(case when t1.fecha_1='201704' then 1 else 0 end) as conteo_t3,
              sum(case when t1.fecha_1='201705' then 1 else 0 end) as conteo_t4,
              sum(case when t1.fecha_1='201706' then 1 else 0 end) as conteo_t5,
              sum(case when t1.fecha_1='201707' then 1 else 0 end) as conteo_t6,
              sum(case when t1.fecha_1='201708' then 1 else 0 end) as conteo_t7,
              sum(case when t1.fecha_1='201709' then 1 else 0 end) as conteo_t8,
              sum(case when t1.fecha_1='201710' then 1 else 0 end) as conteo_t9,
              sum(case when t1.fecha_1='201711' then 1 else 0 end) as conteo_t10,
              sum(case when t1.fecha_1='201712' then 1 else 0 end) as conteo_t11,
              sum(case when t1.fecha_1='201801' then 1 else 0 end) as conteo_t12
              FROM trans1 as t1
              group by t1.id_cliente")
"Saca El Promedio De Transaciones De Los 12 Meses Siguientes en Valor y En Transacciones"
"Crea A Nivel Cliente La Transaccionalidad Para 12 Periodos en valores y en numero de Transacciones"
trans3<-sqldf("SELECT t1.*,(valor_menos1+valor_menos2+valor_menos3+valor_menos4)/4 as utili_ant,(conteo_menos1+conteo_menos2+conteo_menos3+conteo_menos4)/4 utili_ant_num ,(valor_t1+valor_t2+valor_t3+valor_t4+valor_t5+
              valor_t6+valor_t7+valor_t8+valor_t9+valor_t10+valor_t11+valor_t12)/12 as valor_prom_ade,
              (conteo_t1+conteo_t2+conteo_t3+conteo_t4+conteo_t5+
              conteo_t6+conteo_t7+conteo_t8+conteo_t9+conteo_t10+conteo_t11+conteo_t12)/12 as conteo_prom_ade
              FROM trans2 as t1")
"Saca Promedios Para ver El Treshold De Las Variables Binarias"
median(trans3$valor_prom_ade)
median(trans3$conteo_prom_ade)
"Crea Variables Binarias"
trans4<-sqldf("SELECT t1.*,(case when valor_prom_ade>=46003 then 1 else 0 end) as trans_valor_bin_12M,
              (case when conteo_prom_ade>=0.3827646 then 1 else 0 end) as trans_num_bin_12M
              FROM trans3 as t1")

sum(trans4$trans_valor_bin_12M)
"Tasa De Transaccionalidad Valor para discriminar 66983/306891 21% "
sum(trans4$trans_num_bin_12M)
"Tasa De Transaccionalidad Numero para discriminar 67501/306891 22% "

"Exporta La Base"
write.csv(trans4, file = "Transacciones.csv")

"Importa La Base" 
pag_trans<-read.csv("Transacciones.csv",
              header=TRUE,
              sep=",")
"Pega La Base De Variables Dependientes Con La Variable A Pronbosticar "

tabla_1<-sqldf("SELECT cast(t1.id_cliente as numeric) as id_cliente,t1.trans_valor_bin_12m,trans_num_bin_12m,utili_ant,utili_ant_num,t2.seg_str,t2.ocupacion,t2.tipo_vivienda,t2.nivel_academico, 
              t2.estado_civil,t2.genero,t2.edad,t2.ingreso_rango
              FROM trans4 as t1 left join pag as t2 on (t1.id_cliente=t2.id_cliente)") 
"Limpia Los Ids que no eran numericos"
tabla_2<-sqldf("SELECT t1.* from tabla_1 as t1 where id_cliente>0") 
"Saca Score Card Por Variable, para ver que tal discriminan"

str<-sqldf("SELECT t1.[seg_str],sum(trans_valor_bin_12M) as trans_valor_bin_12M, sum(trans_num_bin_12M) as trans_num_bin_12M , count(*)
      FROM tabla_2 as t1 group by t1.[seg_str]") 
write.table(str, "C:/Users/Richard/Documents/Richard/Dataton/str.txt", sep="\t")

str<-sqldf("SELECT t1.[seg_str],sum(trans_valor_bin_12M) as trans_valor_bin_12M, sum(trans_num_bin_12M) as trans_num_bin_12M , count(*)
      FROM tabla_2 as t1 group by t1.[seg_str]") 
write.table(str, "C:/Users/Richard/Documents/Richard/Dataton/str.txt", sep="\t")

ocupacion<-sqldf("SELECT t1.[ocupacion],sum(trans_valor_bin_12M) as trans_valor_bin_12M, sum(trans_num_bin_12M) as trans_num_bin_12M , count(*)
      FROM tabla_2 as t1 group by t1.[ocupacion]") 
write.table(ocupacion, "C:/Users/Richard/Documents/Richard/Dataton/ocupacion.txt", sep=";")

tipo_vivienda<-sqldf("SELECT t1.[tipo_vivienda],sum(trans_valor_bin_12M) as trans_valor_bin_12M, sum(trans_num_bin_12M) as trans_num_bin_12M , count(*)
      FROM tabla_2 as t1 group by t1.[tipo_vivienda]") 
write.table(tipo_vivienda, "C:/Users/Richard/Documents/Richard/Dataton/tipo_vivienda.txt", sep=";")

nivel_academico<-sqldf("SELECT t1.[nivel_academico],sum(trans_valor_bin_12M) as trans_valor_bin_12M, sum(trans_num_bin_12M) as trans_num_bin_12M , count(*)
      FROM tabla_2 as t1 group by t1.[nivel_academico]") 
write.table(nivel_academico, "C:/Users/Richard/Documents/Richard/Dataton/nivel_academico.txt", sep=";")

estado_civil<-sqldf("SELECT t1.[estado_civil],sum(trans_valor_bin_12M) as trans_valor_bin_12M, sum(trans_num_bin_12M) as trans_num_bin_12M , count(*)
      FROM tabla_2 as t1 group by t1.[estado_civil]") 
write.table(estado_civil, "C:/Users/Richard/Documents/Richard/Dataton/estado_civil.txt", sep=";")

genero<-sqldf("SELECT t1.[genero],sum(trans_valor_bin_12M) as trans_valor_bin_12M, sum(trans_num_bin_12M) as trans_num_bin_12M , count(*)
      FROM tabla_2 as t1 group by t1.[genero]") 
write.table(genero, "C:/Users/Richard/Documents/Richard/Dataton/genero.txt", sep=";")

ingreso_rango<-sqldf("SELECT t1.[ingreso_rango],sum(trans_valor_bin_12M) as trans_valor_bin_12M, sum(trans_num_bin_12M) as trans_num_bin_12M , count(*)
      FROM tabla_2 as t1 group by t1.[ingreso_rango]") 
write.table(ingreso_rango, "C:/Users/Richard/Documents/Richard/Dataton/ingreso_rango.txt", sep=";")

r_edad<-sqldf("SELECT (case when ((cast(edad as numeric)<18 or cast(edad as numeric)>80) or cast(edad as numeric)=0) then 'Atipicos'
                            when cast(edad as numeric)>=18 and cast(edad as numeric)<28 then 'jovenes' 
                            when cast(edad as numeric)>=28 and cast(edad as numeric)<38 then 'adultos' 
                            when cast(edad as numeric)>=38 and cast(edad as numeric)<48 then 'adultos-Medio' 
                            when cast(edad as numeric)>=48 and cast(edad as numeric)<58 then 'adultos-Mayores'
                            when cast(edad as numeric)>=58 and cast(edad as numeric)<=80 then 'Abuelos'
                                    else 'revisar' end) as r_edad
,sum(trans_valor_bin_12M) as trans_valor_bin_12M, sum(trans_num_bin_12M) as trans_num_bin_12M , count(*)
FROM tabla_2 as t1
              group by [r_edad]
 ") 
write.table(r_edad, "C:/Users/Richard/Documents/Richard/Dataton/edad_2.txt", sep=";")


"Crea Las Nuevas Categorias Para Hacer El Random Forest"

tabla_3<-sqldf("SELECT id_cliente,
(case when seg_str in  ('OTRO') then 1 
when seg_str in ('PERSONAL') then 2
               when seg_str in ('EMPRENDEDOR') then 3
               when seg_str in ('PERSONAL PLUS') then 4 
               else 5 end ) as r_seg_str,
(case when ocupacion in ('2',	'I',	'4',	'S',	'O') then 1 
when ocupacion in ('1',	'8',	'5',	'6',	'7',	'0') then 2
when ocupacion in ('3') then 3
when ocupacion in ('P',	'E',	'9') then 4 
else 5 end ) as r_ocupacion,
(case when tipo_vivienda in ('','1','2','3','4') then 1 
when tipo_vivienda in ('I') then 2 
when tipo_vivienda in ('R') then 3 
when tipo_vivienda in ('F') then 4
               else 5 end ) as r_tipo_vivienda, 
(case when nivel_academico in ('') then 1 
               when nivel_academico in ('B',	'I',	'P') then 2
               when nivel_academico in ('H',	'T',	'N') then 3
               when nivel_academico in ('U') then 4 
               else 5 end ) as r_nivel_academico,
(case when estado_civil in ('S') then 1 
               when estado_civil in ('I',	'F') then 2
               when estado_civil in ('W',	'D',	'O') then 3
               when estado_civil in ('M') then 4 
               else 5 end ) as r_estado_civil,
(case when ingreso_rango in ('0',	'No disponible') then 1 
               when ingreso_rango in ('a. (0  1.1MM]',	'b. (1.1  2.2MM]') then 2
               when ingreso_rango in ('c. (2.2  3.3MM]',	'd. (3.3  4.4MM]') then 3
               when ingreso_rango in ('e. (4.4  5.5MM]',	'f. (5.5  6.6MM]',	'g. (6.6  7.6MM]') then 4 
               else 5 end ) as r_ingreso_rango,
(case when genero in ('') then 1 
               when genero in ('F') then 2
               else 3 end ) as r_genero,
cast((case when ((cast(edad as numeric)<18 or cast(edad as numeric)>80) or cast(edad as numeric)=0) then 1
                            when cast(edad as numeric)>=18 and cast(edad as numeric)<28 then 2 
               when cast(edad as numeric)>=28 and cast(edad as numeric)<38 then 3 
               when cast(edad as numeric)>=38 and cast(edad as numeric)<48 then 4 
               when cast(edad as numeric)>=48 and cast(edad as numeric)<58 then 5
               when cast(edad as numeric)>=58 and cast(edad as numeric)<=80 then 6
               else 7 end) as int) as r_edad, utili_ant,utili_ant_num,
trans_valor_bin_12M
from tabla_2") 

"Prueba Modelo1"
library(dplyr)
tabla_3$trans_valor_bin_12M=as.factor(tabla_3$trans_valor_bin_12M)

library(randomForest)
set.seed(1)
train=sample(1:nrow(tabla_3),nrow(tabla_3)*(10/10))
bag.trans2=randomForest(x = tabla_3[train,2:11],y=tabla_3[train,12],ntree=500,maxnodes=200,mtry=9)
bag.trans2

"Prueba Modelo 2, menos Nodos, muestra 70-30"
library(randomForest)
set.seed(1)
train=sample(1:nrow(tabla_3),nrow(tabla_3)*(7/10))
bag.trans3=randomForest(x = tabla_3[train,2:11],y=tabla_3[train,12],ntree=500,maxnodes=50,mtry=9)
bag.trans3


yhat_train=predict (bag.trans3,newdata=tabla_3[train,2:11],type="prob")
yhat_validacion=predict (bag.trans3,newdata=tabla_3[-train,2:11],type="prob")
yhat_total=predict (bag.trans3,newdata=tabla_3[2:11],type="prob")

"ScoreCard Train"
tabla_train<-tabla_3[train,1:13]
tabla_train$prediccion_bueno<-yhat_train[,2]

attach(tabla_train)
tabla_4 <- tabla_train[order(prediccion_bueno),]

tabla_4$numero_fila <- seq.int(nrow(tabla_4))
tabla_4$peso<-tabla_4$numero_fila/nrow(tabla_4)

"Creacion ScoreCard"
tabla_5<-sqldf("SELECT 
(case when peso<0.33 then 1 
when peso>0.33 and peso<=0.66 then 2 
when peso>0.66 then 3 else 99 end) as r_random,
sum(trans_valor_bin_12M) as buenos, count(*) as conteo 
               from tabla_4
               group by 1") 
write.table(tabla_5, "C:/Users/Richard/Documents/Richard/Dataton/modelo_train.txt", sep=";")

"ScoreCard Validacion"
tabla_validacion<-tabla_3[-train,1:13]
tabla_validacion$prediccion_bueno<-yhat_validacion[,2]

attach(tabla_validacion)
tabla_4 <- tabla_validacion[order(prediccion_bueno),]

tabla_4$numero_fila <- seq.int(nrow(tabla_4))
tabla_4$peso<-tabla_4$numero_fila/nrow(tabla_4)

"Creacion ScoreCard"
tabla_5<-sqldf("SELECT 
(case when peso<0.33 then 1 
when peso>0.33 and peso<=0.66 then 2 
when peso>0.66 then 3 else 99 end) as r_random,
sum(trans_valor_bin_12M) as buenos, count(*) as conteo 
               from tabla_4
               group by 1") 
write.table(tabla_5, "C:/Users/Richard/Documents/Richard/Dataton/modelo_validacion.txt", sep=";")

"ScoreCard Total Base"
tabla_total<-tabla_3[1:13]
tabla_total$prediccion_bueno<-yhat_total[,2]

attach(tabla_total)
tabla_4 <- tabla_total[order(prediccion_bueno),]

tabla_4$numero_fila <- seq.int(nrow(tabla_4))
tabla_4$peso<-tabla_4$numero_fila/nrow(tabla_4)

"Creacion ScoreCard"
tabla_5<-sqldf("SELECT 
(case when peso<0.33 then 1 
when peso>0.33 and peso<=0.66 then 2 
when peso>0.66 then 3 else 99 end) as r_random,
sum(trans_valor_bin_12M) as buenos, count(*) as conteo 
               from tabla_4
               group by 1") 
write.table(tabla_5, "C:/Users/Richard/Documents/Richard/Dataton/modelo_total_1.txt", sep=";")



