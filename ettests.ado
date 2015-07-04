*! version 1.1.0  July 4, 2015 @ 13:15:57
program ettests, eclass
   * Initial code from Ben Jann
   *    http://repec.org/bocode/e/estout/advanced.html#advanced602
   * Updates by Jeff Shrader
version 8
   syntax varlist [if] [in], by(varname) [CASEwise * ]
   if "`casewise'" == "" {
      marksample touse
      markout `touse' `by'
   }
   else{
      marksample touse, novar
      markout `touse' `by'
   }

   tempname mu_1 mu_2 d d_se d_t d_p sd_1 sd_2 N_1 N_2 N
   foreach var of local varlist {
      quietly: ttest `var' if `touse', by(`by') `options'
      mat `mu_1' = nullmat(`mu_1'), r(mu_1)
      mat `mu_2' = nullmat(`mu_2'), r(mu_2)
      mat `d'    = nullmat(`d'   ), r(mu_1)-r(mu_2)
      mat `d_se' = nullmat(`d_se'), r(se)
      mat `d_t'  = nullmat(`d_t' ), r(t)
      mat `d_p'  = nullmat(`d_p' ), r(p)
      mat `sd_1' = nullmat(`sd_1'), r(sd_1)
      mat `sd_2' = nullmat(`sd_2'), r(sd_2)
      mat `N_1'   = nullmat(`N_1'), r(N_1)
      mat `N_2'   = nullmat(`N_2'), r(N_2)
      mat `N'   = nullmat(`N'), r(N_1)+r(N_2)
   }
   foreach mat in mu_1 mu_2 d d_se d_t d_p sd_1 sd_2 N_1 N_2 N {
      mat coln ``mat'' = `varlist'
   }
   tempname b V
   mat `b' = `mu_1'*0
   mat `V' = `b''*`b'
   eret post `b' `V'
   eret local cmd "myttests"
   foreach mat in mu_1 mu_2 d d_se d_t d_p sd_1 sd_2 N_1 N_2 N {
      eret mat `mat' = ``mat''
   }
end
