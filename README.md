# ettests
Place t-tests in `e()` for table creation in Stata.

This command can be used as is to perform multiple t-tests and report their results. The main purpose of the command, however, is to load those results into `e()` so that they can be formatted into a nice table by a command like `esttab` or `est2tex`. Using those commands you can, for instance, quickly make a baseline balance table or a summary statistics table broken down by a binary variable.

# Other commands to use with this
`esttab` by Ben Jann: http://repec.org/bocode/e/estout/esttab.html
`est2tex` by Mark Muendler http://econweb.ucsd.edu/muendler/docs/stata/est2tex.html

# Sytax
```
ettests varlist [if] [in], by(varname) [CASEwise * ]
```
# Options
`casewise` - By default the command computes ttests over observations where all variables in the varlist are nonmissing. The casewise option causes the command to take all observations of each variable, subject to if and in.

# Example
```
sysuse auto.dta, clear
ettests length turn weight, by(foreign)
```
To make a nice looking tex table, you can issue a cal to `esttab`:
```
esttab, cells("mu_1 mu_2 d N" "sd_1(par) sd_2(par) se(par)") noobs
```
I like something more complicated, like the following:
```
esttab, cells("mu_1(fmt(a2) label(Mean)) mu_2(fmt(a2) label(Mean)) d(star pvalue(d_p) label(Diff.)) N(label(Total obs.))" "sd_1(par fmt(a2) label((SD))) sd_2(par fmt(a2) label((SD))) se(par fmt(a2) label((SE)))") star(* 0.10 ** 0.05 *** 0.01) compress label tex noobs nomtitles
```
