# Beam Space MIMO

## 0. Signal Model

$$
\begin{align}
\mathbf r &= \mathbf H^{\rm H}\mathbf G \mathbf s + \mathbf n \\
&= \mathbf H^{\rm H}\mathbf x + \mathbf n
\end{align}
$$

where $\mathbf x = \mathbf G \mathbf s$

$$\mathbf G = \alpha \mathbf F$$

## 1. ULA

https://blog.csdn.net/qq_23947237/article/details/89925088


## 2. UPA

$$\mathbf a(\theta_a, \theta_e)=\mathbf a_x(\theta_a) \otimes \mathbf a_y(\theta_e)$$


## 3. Dirichlet sinc function

<div align=center>
<img src="https://github.com/yashcao/Wireless-SigPro/blob/master/Beam%20Space%20MIMO/sinc.png"/>
</div>

<!--
![Dirichlet sinc function](https://github.com/yashcao/Wireless-SigPro/blob/master/Beam%20Space%20MIMO/sinc.png)
-->


## 4. Precoding matrix


- matched filter (MF)
$$\mathbf P_{MF} = \mathbf H$$

- zero-forcing (ZF)
$$\mathbf P_{ZF} = \mathbf H(\mathbf H^{\rm H} \mathbf H)^{-1}$$

- Wiener filter (WF)
$$
\mathbf P_{WF} = (\mathbf H \mathbf H^{\rm H} + \zeta \mathbf I)^{-1}\mathbf H, \zeta=\frac{\text{tr}(\mathbf \Sigma_n)}{\rho}=\frac{\sigma^2 K}{\rho}
$$
