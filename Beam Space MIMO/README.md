# Beam Space MIMO

## 0. Signal Model

$$
\begin{align}
\mathbf r &= \mathbf H^{\rm H}\mathbf G \mathbf s + \mathbf n \\
&= \mathbf H^{\rm H}\mathbf x + \mathbf n
\end{align}
$$

where

$$
\begin{align}
\mathbf G = \alpha \mathbf F
\end{align}
$$

where $\mathbf F$ is Precoding matrix and $\mathbf x = \mathbf G \mathbf s$.

The signal power is limited by

$$
\begin{aligned}
\mathbb E[\Vert \mathbf x \Vert^2] &= \mathbb E[\mathbf x^{\rm H} \mathbf x] \\
&= \text{tr}(\mathbb E[\mathbf x^{\rm H} \mathbf x]) = \text{tr}(\mathbb E[\mathbf x \mathbf x^{\rm H}]) \\
&= \text{tr}(\mathbf G \mathbb E[\mathbf s \mathbf s^{\rm H}] \mathbf G^{\rm H}) \\
&= \text{tr}(\mathbf G \mathbf \Lambda_s \mathbf G^{\rm H}) =\rho
\end{aligned}
$$



## 1. ULA

please refer to:
<https://blog.csdn.net/qq_23947237/article/details/89925088>


## 2. UPA

$$
\begin{align}
\mathbf a(\theta_a, \theta_e)=\mathbf a_x(\theta_a) \otimes \mathbf a_y(\theta_e)
\end{align}
$$


## 3. Dirichlet sinc function

<div align=center>
<img src="https://github.com/yashcao/Wireless-SigPro/blob/master/Beam%20Space%20MIMO/sinc.png"/>
</div>

<!--
![Dirichlet sinc function](https://github.com/yashcao/Wireless-SigPro/blob/master/Beam%20Space%20MIMO/sinc.png)
-->


## 4. Precoding matrix


- matched filter (MF)
$$
\begin{align}
\mathbf P_{MF} = \mathbf H
\end{align}
$$

- zero-forcing (ZF)
$$
\begin{align}
\mathbf P_{ZF} = \mathbf H(\mathbf H^{\rm H} \mathbf H)^{-1}
\end{align}
$$

- Wiener filter (WF)
$$
\begin{align}
\mathbf P_{WF} = (\mathbf H \mathbf H^{\rm H} + \zeta \mathbf I)^{-1}\mathbf H, \zeta=\frac{\text{tr}(\mathbf \Sigma_n)}{\rho}=\frac{\sigma^2 K}{\rho}
\end{align}
$$
