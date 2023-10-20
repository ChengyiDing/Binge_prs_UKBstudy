
stset ArC_deaths_date, fail(ArC) o(t ts_53_0_0) scale(365.25) 

// Figure 1  		  
xi: stcox ib0.binge4 alltotalc_0 ib0.n_2443_0_0 ib1.bmi sex age ethnic n_189_0_0 ib0.vig ib0.smoke ib0.alctype ib1.meals if misscovs==0

// Figure 2	 		  			  
xi: stcox ib0.binge4#ib0.rivas_prs3 alltotalc_0 ib0.n_2443_0_0 ib1.bmi sex age ethnic n_189_0_0 ib0.vig ib0.smoke ib0.alctype ib1.meals ///
           genobatch n_22009_0_1 n_22009_0_2 n_22009_0_3 n_22009_0_4 n_22009_0_5 n_22009_0_6 n_22009_0_7 n_22009_0_8 n_22009_0_9 n_22009_0_10
		   
// Figure 3
xi: stcox ib0.binge4#ib0.n_2443_0_0 ///
          alltotalc_0 ib0.rivas_prs3 ib1.bmi sex age ethnic n_189_0_0 ib0.vig ib0.smoke ib0.alctype ib1.meals ///
          genobatch n_22009_0_1 n_22009_0_2 n_22009_0_3 n_22009_0_4 n_22009_0_5 n_22009_0_6 n_22009_0_7 n_22009_0_8 n_22009_0_9 n_22009_0_10
		
xi: stcox ib0.rivas_prs3#ib0.n_2443_0_0 ///
          ib0.binge4 alltotalc_0 ib1.bmi sex age ethnic n_189_0_0 ib0.vig ib0.smoke ib0.alctype ib1.meals ///
          genobatch n_22009_0_1 n_22009_0_2 n_22009_0_3 n_22009_0_4 n_22009_0_5 n_22009_0_6 n_22009_0_7 n_22009_0_8 n_22009_0_9 n_22009_0_10
		  

***************************************************************************************************************************************		
// p value for multiplicative interaction 

xi: stcox ib0.binge4 alltotalc_0 ib0.n_2443_0_0 ib1.bmi sex age ethnic n_189_0_0 ib0.vig ib0.smoke ib0.alctype ib1.meals ///
          ib0.rivas_prs3 genobatch n_22009_0_1 n_22009_0_2 n_22009_0_3 n_22009_0_4 n_22009_0_5 n_22009_0_6 n_22009_0_7 n_22009_0_8 n_22009_0_9 n_22009_0_10

estimates store multiplicative	

// binge4 # rivas_prs3	  
xi: stcox ib0.binge4##ib0.rivas_prs3 alltotalc_0 ib0.n_2443_0_0 ib1.bmi sex age ethnic n_189_0_0 ib0.vig ib0.smoke ib0.alctype ib1.meals ///
          genobatch n_22009_0_1 n_22009_0_2 n_22009_0_3 n_22009_0_4 n_22009_0_5 n_22009_0_6 n_22009_0_7 n_22009_0_8 n_22009_0_9 n_22009_0_10
		  
lrtest multiplicative .		  

// binge4 # diabetes	  
xi: stcox ib0.binge4##ib0.n_2443_0_0 alltotalc_0 ib0.rivas_prs3 ib1.bmi sex age ethnic n_189_0_0 ib0.vig ib0.smoke ib0.alctype ib1.meals ///
          genobatch n_22009_0_1 n_22009_0_2 n_22009_0_3 n_22009_0_4 n_22009_0_5 n_22009_0_6 n_22009_0_7 n_22009_0_8 n_22009_0_9 n_22009_0_10 
		  
lrtest multiplicative .		
		 
// rivas_prs3 # diabetes	  
xi: stcox ib0.rivas_prs3##ib0.n_2443_0_0 ib0.binge4 alltotalc_0 ib1.bmi sex age ethnic n_189_0_0 ib0.vig ib0.smoke ib0.alctype ib1.meals ///
          genobatch n_22009_0_1 n_22009_0_2 n_22009_0_3 n_22009_0_4 n_22009_0_5 n_22009_0_6 n_22009_0_7 n_22009_0_8 n_22009_0_9 n_22009_0_10
		  
lrtest multiplicative .	
	
	
***************************************************************************************************************************************				 
// two way additive interaction between binge4 (4 groups coded 0,1,2,3) and rivas_prs3 (3 groups coded 0,1,2)
// for more explanation for the codes please see: https://www.degruyter.com/document/doi/10.1515/em-2013-0005/html

gen g=0 if binge4==0
replace g=1 if binge4==3 

gen e=0 if rivas_prs3==0
replace e=1 if rivas_prs3==2 /* changes values for binge4 and rivas_prs3 to caculate additive interaction between different binge and prs groups */

gen Ige=g*e

stcox sex age ethnic n_189_0_0 ib0.vig ib0.smoke alltotalc_0 ib0.alctype ib1.meals ib0.n_2443_0_0 ib1.bmi g e Ige ///
      genobatch n_22009_0_1 n_22009_0_2 n_22009_0_3 n_22009_0_4 n_22009_0_5 n_22009_0_6 n_22009_0_7 n_22009_0_8 n_22009_0_9 n_22009_0_10
	  

nlcom RERI: exp(_b[g]+_b[e]+_b[Ige])-exp(_b[g])-exp(_b[e])+1


nlcom AP: (exp(_b[g]+_b[e]+_b[Ige])-exp(_b[g])-exp(_b[e])+1)/exp(_b[g]+_b[e]+_b[Ige])


nlcom SI: (exp(_b[g]+_b[e]+_b[Ige])-1)/(exp(_b[g])+exp(_b[e])-2), post
test _b[SI] = 1


**************************************************************************************************************************************			 
// three way additive interaction between binge4, rivas_prs3 and diabetes (n_2443_0_0 coded 0,1)
// more complex example please see: https://www.tandfonline.com/doi/full/10.1080/24709360.2020.1850171

gen     x1=0 if binge4==0
replace x1=1 if binge4==3 

gen     x2=0 if rivas_prs3==0
replace x2=1 if rivas_prs3==2

gen     x3=0 if n_2443_0_0==0
replace x3=1 if n_2443_0_0==1 /* changes values for binge4, rivas_prs3 and n_2443_0_0 to caculate additive interaction between different binge, prs and diabetes groups */

gen x1x2=x1*x2
gen x1x3=x1*x3
gen x2x3=x2*x3
gen x1x2x3=x1*x2*x3

stcox x1 x2 x3 x1x2 x1x3 x2x3 x1x2x3 sex age ethnic n_189_0_0 ib0.vig ib0.smoke alltotalc_0 ib0.alctype ib1.meals ib1.bmi ///
      genobatch n_22009_0_1 n_22009_0_2 n_22009_0_3 n_22009_0_4 n_22009_0_5 n_22009_0_6 n_22009_0_7 n_22009_0_8 n_22009_0_9 n_22009_0_10
	  
nlcom TotRERI3: exp(_b[x1]+_b[x2]+_b[x3]+_b[x1x2]+_b[x1x3]+_b[x2x3]+_b[x1x2x3])- ///
                exp(_b[x1])-exp(_b[x2])-exp(_b[x3])+2

nlcom RERI3: exp(_b[x1]+_b[x2]+_b[x3]+_b[x1x2]+_b[x1x3]+_b[x2x3]+_b[x1x2x3])- ///
             exp(_b[x1]+_b[x2]+_b[x1x2])-exp(_b[x1]+_b[x3]+_b[x1x3])- ///
			 exp(_b[x2]+_b[x3]+_b[x2x3])+exp(_b[x1])+exp(_b[x2])+exp(_b[x3])-1

nlcom AP: (exp(_b[x1]+_b[x2]+_b[x3]+_b[x1x2]+_b[x1x3]+_b[x2x3]+_b[x1x2x3])- exp(_b[x1])-exp(_b[x2])-exp(_b[x3])+2)/ ///
              exp(_b[x1]+_b[x2]+_b[x3]+_b[x1x2]+_b[x1x3]+_b[x2x3]+_b[x1x2x3])


nlcom SI: (exp(_b[x1]+_b[x2]+_b[x3]+_b[x1x2]+_b[x1x3]+_b[x2x3]+_b[x1x2x3])-1)/(exp(_b[x1])+exp(_b[x2])+exp(_b[x3])-3), post
test _b[SI] = 1
	  
