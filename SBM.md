### SBM算法

​	SBM是一种非参数建模方法，它将给定的历史状态向量集合在矩阵D中，来表征系统正常运行时的状态。然后SBM评估当前状态向量与D内所有向量的相似性，来评估当前系统是否正常运行。

![image-20211018090154596](C:\Users\Mazhe\AppData\Roaming\Typora\typora-user-images\image-20211018090154596.png)

![image-20211018102625409](C:\Users\Mazhe\AppData\Roaming\Typora\typora-user-images\image-20211018102625409.png)



+ 特征选择：

  + 离散小波变换系数
  + 离散频变换系数
  + 统计时域特征
  + 统计频域特征

+ D矩阵的建立：

  + MSET MODELING OF CRYSTAL RIVER-3 VENTURI FLOW METE：

    + 插入每个向量的最大值和最小值
    + 剩余按照L2范数大小递减，并以t为因子进行抽取

  + Improved similarity-based modeling for the classification of rotating-machine failures：

    + 首先选择向量的几何中值作为初始状态（ H. Cardot , P. Cénac , P. - A . Zitt , Efficient and fast estimation of the geometric median in Hilbert spaces with an averaged stochastic gradient algorithm, Bernoulli 19 (1) (2013) 18–43）

      + ![image-20211018105512478](C:\Users\Mazhe\AppData\Roaming\Typora\typora-user-images\image-20211018105512478.png)

    + 将剩余的状态与当前选定有元素进行比较，若差值小于阈值则选入D中

      ![image-20211018105527367](C:\Users\Mazhe\AppData\Roaming\Typora\typora-user-images\image-20211018105527367.png)

      

+ 相似性的度量：

  + ![image-20211018102218882](C:\Users\Mazhe\AppData\Roaming\Typora\typora-user-images\image-20211018102218882.png)
  + ![image-20211018102517479](C:\Users\Mazhe\AppData\Roaming\Typora\typora-user-images\image-20211018102517479.png)
  + Cauchy核：![image-20211018102542180](C:\Users\Mazhe\AppData\Roaming\Typora\typora-user-images\image-20211018102542180.png)
  + Wegerich similarity function：![image-20211018102610484](C:\Users\Mazhe\AppData\Roaming\Typora\typora-user-images\image-20211018102610484.png)
  + ![image-20211018102655357](C:\Users\Mazhe\AppData\Roaming\Typora\typora-user-images\image-20211018102655357.png)
  + ![image-20211018102700687](C:\Users\Mazhe\AppData\Roaming\Typora\typora-user-images\image-20211018102700687.png)

