# Perfilamiento de gastos por clientes

En este folder se muestra una de las soluciones propuestas para la dataton. Esta solución consiste en un modelo supervisado que tiene como objetivo pronosticar la probabilidad de que una persona tenga un gasto en el futuro. La variable a pronosticar se construyó utilizando la base de transacciones; de ella se sacó el valor transaccional que ha tenido cada uno de los clientes por mes desde un punto de observación definido (201609) para los siguientes 12 meses. 

Con este vector se calculó el promedio de transacciones futuras. Finalmente, los clientes que estaban por encima del promedio del valor transaccional del total de la base se marcaron con 1 y el resto con 0. El objetivo es identificar a través de un modelo qué clientes van a tener un alto valor transaccional en los siguientes 12 meses.

Este folder contiene un archivo **1-Script_Modelo_Transaccional.R**, que contiene el código en R utilizado para el desarrollo del modelo. Adicionalmente, el documento **Perfilamiento de clientes.pdf** contiene una descripción más detallada del trabajo realizado en esta herramienta analítica, así como los resultados obtenidos.
