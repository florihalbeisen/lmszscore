## lmszscore -  Calculation of z scores from LMS refernce values

This package allows to calculate BMI and height z scores 
using LMS reference parameters in R. 

Z scores are caculated using following formula: 

<a href="https://www.codecogs.com/eqnedit.php?latex=Z_{ind}&space;=&space;\frac{\left&space;[&space;y/M(t)&space;\right&space;]^{L(t)}&space;-&space;1}{S(t)L(t)}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?Z_{ind}&space;=&space;\frac{\left&space;[&space;y/M(t)&space;\right&space;]^{L(t)}&space;-&space;1}{S(t)L(t)}" title="Z_{ind} = \frac{\left [ y/M(t) \right ]^{L(t)} - 1}{S(t)L(t)}" /></a>

Reference:
Cole TJ, Green PJ (1992). Smoothing reference centile curves: the LMS method and penalized likelihood. Statistics in Medicine, 11:1305–1319.



**Installation**

Open R, and give:

      devtools::install_git("https://github.com/florihalbeisen/lmszscore.git")

If you do not have the package "devtools", first install it from CRAN with:

      install.packages("devtools")

Alternatively, you can install and use package "githubinstall" to install rspiro:

      install.packages("githubinstall")
      library("githubinstall")
      githubinstall("lmszscore")


**Disclaimer**

Although every effort has been made to verify correct operation of this 
software, I cannot accept any liability arising from its use. The 
software is provided "as is", without any express or implied warranty,
and no implication of fitness for a particular use.
