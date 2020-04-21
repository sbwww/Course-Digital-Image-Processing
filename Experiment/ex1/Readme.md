#  Matlab图像处理初步

## 一、实验目的：

熟悉Matlab语言关于图像处理的基本操作

## 二、实验内容：

练习imread、imshow、iminfo、imwrite、subplot、for等命令以及矩阵计算有关命令。

## 三、实验要求：

1. 读取并显示cameraman.tif图像（提示：imread）。
2. 将图像中间的1/3部分（如图）分别作如下处理，其余部分不变
    - 每个像素点的值都乘以2，即f(x,y)=2*f(x,y)，显示处理前后的图像（提示：imshow），同一个图像窗口左右显示（提示：subplot），左边显示原始图像，右边显示处理后图像，处理后图像保存为cameraman1.bmp（提示：imwrite）
    - 每个像素点取反色，即f(x,y)=255-f(x,y);显示处理前后的图像，同一个图像窗口上下显示（提示：subplot），上边显示原始图像，下边显示处理后图像，处理后图像保存为cameraman2.bmp（提示：imwrite）
