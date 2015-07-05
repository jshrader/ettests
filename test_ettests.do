* Test package to make sure ettests is working
*
* Jeff Shrader
* 2015-07-05

* This is currently written to test the development version of ettests.ado
capture program drop ettests
cap ado uninstall ettests
net install ettests, from(~/google_drive/bin/stata/ettests/)

sysuse auto.dta, clear
ettests price mpg, by(foreign)
 esttab , cells("mu_1 mu_2 d N_1 N_2" "sd_1 sd_2 d_se")
ettests price mpg rep78, by(foreign)
 esttab , cells("mu_1 mu_2 d N_1 N_2" "sd_1 sd_2 d_se")
ettests price mpg rep78, by(foreign) casewise
 esttab , cells("mu_1 mu_2 d N_1 N_2" "sd_1 sd_2 d_se")


* Test the published version
capture program drop ettests
cap ado uninstall ettests
net install ettests, from("https://raw.githubusercontent.com/jshrader/ettests/master/")

sysuse auto.dta, clear
ettests price mpg, by(foreign)
 esttab , cells("mu_1 mu_2 d N_1 N_2" "sd_1 sd_2 d_se")
ettests price mpg rep78, by(foreign)
 esttab , cells("mu_1 mu_2 d N_1 N_2" "sd_1 sd_2 d_se")
ettests price mpg rep78, by(foreign) casewise
 esttab , cells("mu_1 mu_2 d N_1 N_2" "sd_1 sd_2 d_se")

* Make sure the help file installs
help ettests

