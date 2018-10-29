# Clasificación de transacciones en categorías

En este folder se muestra una de las soluciones propuestas para la dataton. Esta solución consiste en encontrar temas (o categorías) en las cuales clasificar las transacciones. Estas categorías son encontradas mediante un modelo no supervisado que estudia los textos descriptivos de las transacciones y trata de agruparlos.

Sin embargo, menos del 30% de los datos de transacciones tienen la información completa en sus campos de texto. Por este motivo, se entrenó luego un modelo supervisado para clasificar una transacción, a partir de datos del pagador y de la transacción, dentro de una de las categorías anteriormente determinadas.

Este folder se compone por tres *jupyter notebooks*, que van en orden de acuerdo a su numeración y van describiendo todo el proceso de análisis que se hizo, junto al código utilizado y los resultados obtenidos. También hay un documento en Excel que contiene los temas/categorías encontrados.
