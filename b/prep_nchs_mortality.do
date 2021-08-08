/*********************************************************/
/* This dofile loads in the US mortality data from NVSS  */
/*********************************************************/

version 13.1
clear
cap log close
cd  "$mdata/raw"

#delimit ;

*1989*;
	infix
		year 01-02
		resstatus 20
		region 26
		divstoc 27-28
		str popsizr 50
		str popsmsa 51
		educ89 52-53
		month 55-56
		sex 59
		race 60-61
		racerec3 62
		ageunit 64
		age 65-66
		marstat 77
		state_born 78-79
		hispanic 80-81
		hisprec 82
		bustype 85-87
		occup 88-90
		occupr9 100-101
		fipssto 119-120
		fipsctyo 121-123
		fipsstr 124-125
		fipsctyr 126-128 str
		fipssmsar 129-132 str
		icd 142-145
		icdn 142-145
		icd282 146-150
	using "$mdata/raw/nchs/MULT1989.AllCnty.txt" ;
		compress;
replace year=1989;
	save $mdata/int/nchs/Mort1989.dta, replace;

clear;
*1990*;
	infix
		year 01-02
		resstatus 20
		region 26
		divstoc 27-28
		str popsizr 50
		str popsmsa 51
		educ89 52-53
		month 55-56
		sex 59
		race 60-61
		racerec3 62
		ageunit 64
		age 65-66
		marstat 77
		state_born 78-79
		hispanic 80-81
		hisprec 82
		bustype 85-87
		occup 88-90
		occupr9 100-101
		fipssto 119-120
		fipsctyo 121-123
		fipsstr 124-125
		fipsctyr 126-128 str
		fipssmsar 129-132 str
		icd 142-145
		icdn 142-145
		icd282 146-150
	using "$mdata/raw/nchs/MULT1990.AllCnty.txt" ;
	compress;
	replace year=1990;

	save $mdata/int/nchs/Mort1990.dta, replace;
clear;
*1991*;
	infix
		year 01-02
		resstatus 20
		region 26
		divstoc 27-28
		str popsizr 50
		str popsmsa 51
		educ89 52-53
		month 55-56
		sex 59
		race 60-61
		racerec3 62
		ageunit 64
		age 65-66
		marstat 77
		state_born 78-79
		hispanic 80-81
		hisprec 82
		bustype 85-87
		occup 88-90
		occupr9 100-101
		fipssto 119-120
		fipsctyo 121-123
		fipsstr 124-125
		fipsctyr 126-128 str
		fipssmsar 129-132 str
		icd 142-145
		icdn 142-145
		icd282 146-150
	using "$mdata/raw/nchs/MULT1991.AllCnty.txt" ;
		compress;
	replace year=1991;

	save $mdata/int/nchs/Mort1991.dta, replace;
clear;
*1992*;
	infix
		year 01-02
		resstatus 20
		region 26
		divstoc 27-28
		str popsizr 50
		str popsmsa 51
		educ89 52-53
		month 55-56
		sex 59
		race 60-61
		racerec3 62
		ageunit 64
		age 65-66
		marstat 77
		state_born 78-79
		hispanic 80-81
		hisprec 82
		bustype 85-87
		occup 88-90
		occupr9 100-101
		fipssto 119-120
		fipsctyo 121-123
		fipsstr 124-125
		fipsctyr 126-128 str
		fipssmsar 129-132 str
		icd 142-145
		icdn 142-145
		icd282 146-150
	using "$mdata/raw/nchs/MULT1992.AllCnty.txt" ;
		compress;
	replace year=1992;

	save $mdata/int/nchs/Mort1992.dta, replace;
clear;
*1993;
	infix
		year 01-02
		resstatus 20
		region 26
		divstoc 27-28
		str popsizr 50
		str popsmsa 51
		educ89 52-53
		month 55-56
		sex 59
		race 60-61
		racerec3 62
		ageunit 64
		age 65-66
		marstat 77
		state_born 78-79
		hispanic 80-81
		hisprec 82
		bustype 85-87
		occup 88-90
		fipssto 119-120
		fipsctyo 121-123
		fipsstr 124-125
		fipsctyr 126-128 str
		fipssmsar 129-132 str
		icd 142-145
		icdn 142-145
		icd282 146-150
	using "$mdata/raw/nchs/MULT1993.AllCnty.txt" ;
	compress;
		replace year=1993;

	save $mdata/int/nchs/Mort1993.dta, replace;
clear;
*1994;
	infix
		year 01-02
		resstatus 20
		region 26
		divstoc 27-28
		str popsizr 50
		str popsmsa 51
		educ89 52-53
		month 55-56
		sex 59
		race 60-61
		racerec3 62
		ageunit 64
		age 65-66
		marstat 77
		state_born 78-79
		hispanic 80-81
		hisprec 82
		bustype 85-87
		occup 88-90
		fipssto 119-120
		fipsctyo 121-123
		fipsstr 124-125
		fipsctyr 126-128 str
		fipssmsar 129-132 str
		icd 142-145
		icdn 142-145
		icd282 146-150
	using "$mdata/raw/nchs/MULT1994.AllCnty.txt" ;
	compress;
		replace year=1994;

	save $mdata/int/nchs/Mort1994.dta, replace;
clear;
*1995;
	infix
		year 01-02
		resstatus 20
		region 26
		divstoc 27-28
		str popsizr 50
		str popsmsa 51
		educ89 52-53
		month 55-56
		sex 59
		race 60-61
		racerec3 62
		ageunit 64
		age 65-66
		marstat 77
		state_born 78-79
		hispanic 80-81
		hisprec 82
		bustype 85-87
		occup 88-90
		fipssto 119-120
		fipsctyo 121-123
		fipsstr 124-125
		fipsctyr 126-128 str
		fipssmsar 129-132 str
		icd 142-145
		icdn 142-145
		icd282 146-150
	using "$mdata/raw/nchs/MULT1995.AllCnty.txt" ;
		replace year=1995;

	compress;
	save $mdata/int/nchs/Mort1995.dta, replace;
clear;
*1996;
	infix
		resstatus 20
		region 26
		divstoc 27-28
		str popsizr 50
		str popsmsa 51
		educ89 52-53
		month 55-56
		sex 59
		race 60-61
		racerec3 62
		ageunit 64
		age 65-66
		marstat 77
		state_born 78-79
		hispanic 80-81
		hisprec 82
		bustype 85-87
		occup 88-90
		fipssto 119-120
		fipsctyo 121-123
		fipsstr 124-125
		fipsctyr 126-128 str
		fipssmsar 129-132 str
		icd 142-145
		icdn 142-145
		icd282 146-150
	using "$mdata/raw/nchs/MULT1996.AllCnty.txt" ;
	gen year=1996;
	compress;
	save $mdata/int/nchs/Mort1996.dta, replace;
#delimit ;
clear;
*1997;
	infix
		resstatus 20
		region 26
		divstoc 27-28
		str popsizr 50
		str popsmsa 51
		educ89 52-53
		month 55-56
		sex 59
		race 60-61
		racerec3 62
		ageunit 64
		age 65-66
		marstat 77
		state_born 78-79
		hispanic 80-81
		hisprec 82
		bustype 85-87
		occup 88-90
		fipssto 119-120
		fipsctyo 121-123
		fipsstr 124-125
		fipsctyr 126-128 str
		fipssmsar 129-132 str
		icd 142-145
		icdn 142-145
		icd282 146-150
	using "$mdata/raw/nchs/MULT1997.AllCnty.txt" ;
	gen year=1997;
	compress;
	save $mdata/int/nchs/Mort1997.dta, replace;

#delimit ;
clear;
*1998;
	infix
		resstatus 20
		region 26
		divstoc 27-28
		str popsizr 50
		str popsmsa 51
		educ89 52-53
		month 55-56
		sex 59
		race 60-61
		racerec3 62
		ageunit 64
		age 65-66
		marstat 77
		state_born 78-79
		hispanic 80-81
		hisprec 82
		bustype 85-87
		occup 88-90
		fipssto 119-120
		fipsctyo 121-123
		fipsstr 124-125
		fipsctyr 126-128 str
		fipssmsar 129-132 str
		icd 142-145
		icdn 142-145
		icd282 146-150
	using "$mdata/raw/nchs/MULT1998.AllCnty.txt" ;
	gen year=1998;
	compress;
	save $mdata/int/nchs/Mort1998.dta, replace;
	#delimit ;
	clear;

	*1999;
		infix
			resstatus 20
			region 26
			divstoc 27-28
			str popsizr 50
			str popsmsa 51
			educ89 52-53
			month 55-56
			sex 59
			race 60-61
			racerec3 62
			ageunit 64
			age 65-66
			marstat 77
			state_born 78-79
			hispanic 80-81
			hisprec 82
			bustype 85-87
			occup 88-90
			fipssto 119-120
			fipsctyo 121-123
			fipsstr 124-125
			fipsctyr 126-128 str
			fipssmsar 129-132 str
			icd10 142-145 str
			icd358 146-148
          	using "$mdata/raw/nchs/MULT1999.AllCnty.txt" ;
		gen year=1999;
		compress;
		save $mdata/int/nchs/Mort1999.dta, replace;
#delimit ;
	clear;
	*2000;
		infix
			resstatus 20
			region 26
			divstoc 27-28
			str popsizr 50
			str popsmsa 51
			educ89 52-53
			month 55-56
			sex 59
			race 60-61
			racerec3 62
			ageunit 64
			age 65-66
			marstat 77
			state_born 78-79
			hispanic 80-81
			hisprec 82
			fipssto 119-120
			fipsctyo 121-123
			fipsstr 124-125
			fipsctyr 126-128 str
			fipssmsar 129-132 str
			icd10 142-145 str
			icd358 146-148
                using "$mdata/raw/nchs/MULT2000.USAllCnty.txt" ;
		gen year=2000;
		compress;
		save $mdata/int/nchs/Mort2000.dta, replace;
#delimit ;
	clear;
	*2001;
		infix
			resstatus 20
			region 26
			divstoc 27-28
			str popsizr 50
			str popsmsa 51
			educ89 52-53
			month 55-56
			sex 59
			race 60-61
			racerec3 62
			ageunit 64
			age 65-66
			marstat 77
			state_born 78-79
			hispanic 80-81
			hisprec 82
			fipssto 119-120
			fipsctyo 121-123
			fipsstr 124-125
			fipsctyr 126-128 str
			fipssmsar 129-132 str
			icd10 142-145 str
			icd358 146-148

                using "$mdata/raw/nchs/MULT2001.AllCnty.txt" ;
		gen year=2001;
		compress;
		save $mdata/int/nchs/Mort2001.dta, replace;
#delimit ;
	clear;
	*2002;
		infix
			resstatus 20
			region 26
			divstoc 27-28
			str popsizr 50
			str popsmsa 51
			educ89 52-53
			month 55-56
			sex 59
			race 60-61
			racerec3 62
			ageunit 64
			age 65-66
			marstat 77
			state_born 78-79
			hispanic 80-81
			hisprec 82
			fipssto 119-120
			fipsctyo 121-123
			fipsstr 124-125
			fipsctyr 126-128 str
			fipssmsar 129-132 str
			icd10 142-145 str
			icd358 146-148
                using "$mdata/raw/nchs/MULT2002.USAllCnty.txt" ;
		gen year=2002;
		compress;
		save $mdata/int/nchs/Mort2002.dta, replace;

#delimit ;
	clear;
	*2003;
		infix
			resstatus 20
			str fipssto 21-22
			str fipsctyo 23-25
			str fipsstr 29-30
			fipsctyr 35-37
			str popcyr 43
			fipssmsar 47-50
			str popsizr 51
			str popsmsa 52
			str state_bornA 55-56
			educ89 61-62
			educ20003 63
			educflag 64
			month 65-66
			str sex 69
			ageunit 70
			age 71-73
			str marstatA 84
			str icd10 146-149
			str icd358 150-152
			race 445-446
			racerec3 449
			hispanic2003 484-486
			hisprec 488
                using "$mdata/raw/nchs/MULT2003.USAllCnty.txt" ;
		gen year=2003;
		compress;
		save $mdata/int/nchs/Mort2003.dta, replace;
#delimit ;
	clear;
	*2004;
		infix
			resstatus 20
			str fipssto 21-22
			str fipsctyo 23-25
			str fipsstr 29-30
			fipsctyr 35-37
			str popcyr 43
			fipssmsar 47-50
			str popsizr 51
			str popsmsa 52
			str state_bornA 55-56
			educ89 61-62
			educ20003 63
			educflag 64
			month 65-66
			str sex 69
			ageunit 70
			age 71-73
			str marstatA 84
			str icd10 146-149
			str icd358 150-152
			race 445-446
			racerec3 449
			hispanic2003 484-486
			hisprec 488
                using "$mdata/raw/nchs/MULT2004.USAllCnty.txt" ;
		gen year=2004;
		compress;
		save $mdata/int/nchs/Mort2004.dta, replace;
#delimit ;
	clear;
	*2005;
		infix
			resstatus 20
			str fipssto 21-22
			str fipsctyo 23-25
			str fipsstr 29-30
			fipsctyr 35-37
			str popcyr 43
			fipssmsar 47-50
			str popsizr 51
			str popsmsa 52
			str state_bornA 55-56
			educ89 61-62
			educ20003 63
			educflag 64
			month 65-66
			str sex 69
			ageunit 70
			age 71-73
			str marstatA 84
			str icd10 146-149
			str icd358 150-152
			race 445-446
			racerec3 449
			hispanic2003 484-486
			hisprec 488
                using "$mdata/raw/nchs/MULT2005.USAllCnty.txt" ;
		gen year=2005;
		compress;
		save $mdata/int/nchs/Mort2005.dta, replace;
#delimit ;
	clear;
	*2006;
		infix
			resstatus 20
			str fipssto 21-22
			str fipsctyo 23-25
			str fipsstr 29-30
			fipsctyr 35-37
			str popcyr 43
			fipssmsar 47-50
			str popsizr 51
			str popsmsa 52
			str state_bornA 55-56
			educ89 61-62
			educ20003 63
			educflag 64
			month 65-66
			str sex 69
			ageunit 70
			age 71-73
			str marstatA 84
			str icd10 146-149
			str icd358 150-152
			race 445-446
			racerec3 449
			hispanic2003 484-486
			hisprec 488
                using "$mdata/raw/nchs/MULT2006.USAllCnty.txt" ;
		gen year=2006;
		compress;
		save $mdata/int/nchs/Mort2006.dta, replace;
#delimit ;
	clear;
	*2007;
		infix
			resstatus 20
			str fipssto 21-22
			str fipsctyo 23-25
			str fipsstr 29-30
			fipsctyr 35-37
			str popcyr 43
			fipssmsar 47-50
			str popsizr 51
			str popsmsa 52
			str state_bornA 55-56
			educ89 61-62
			educ20003 63
			educflag 64
			month 65-66
			str sex 69
			ageunit 70
			age 71-73
			str marstatA 84
			str icd10 146-149
			str icd358 150-152
			race 445-446
			racerec3 449
			hispanic2003 484-486
			hisprec 488
                using "$mdata/raw/nchs/MULT2007.USAllCnty.txt" ;
		gen year=2007;
		compress;
		save $mdata/int/nchs/Mort2007.dta, replace;
#delimit ;
	clear;
	*2008;
		infix
			resstatus 20
			str fipssto 21-22
			str fipsctyo 23-25
			str fipsstr 29-30
			fipsctyr 35-37
			str popcyr 43
			fipssmsar 47-50
			str popsizr 51
			str popsmsa 52
			str state_bornA 55-56
			educ89 61-62
			educ20003 63
			educflag 64
			month 65-66
			str sex 69
			ageunit 70
			age 71-73
			str marstatA 84
			str icd10 146-149
			str icd358 150-152
			race 445-446
			racerec3 449
			hispanic2003 484-486
			hisprec 488
                using "$mdata/raw/nchs/MULT2008.USAllCnty.txt" ;
		gen year=2008;
		compress;
		save $mdata/int/nchs/Mort2008.dta, replace;
#delimit ;
	clear;
	*2009;
		infix
			resstatus 20
			str fipssto 21-22
			str fipsctyo 23-25
			str fipsstr 29-30
			fipsctyr 35-37
			str popcyr 43
			fipssmsar 47-50
			str popsizr 51
			str popsmsa 52
			str state_bornA 55-56
			educ89 61-62
			educ20003 63
			educflag 64
			month 65-66
			str sex 69
			ageunit 70
			age 71-73
			str marstatA 84
			str icd10 146-149
			str icd358 150-152
			race 445-446
			racerec3 449
			hispanic2003 484-486
			hisprec 488
                using "$mdata/raw/nchs/MULT2009.USAllCnty.txt" ;
		gen year=2009;
		compress;
		save $mdata/int/nchs/Mort2009.dta, replace;
#delimit ;
	clear;
	*2010;
		infix
			resstatus 20
			str fipssto 21-22
			str fipsctyo 23-25
			str fipsstr 29-30
			fipsctyr 35-37
			str popcyr 43
			fipssmsar 47-50
			str popsizr 51
			str popsmsa 52
			str state_bornA 55-56
			educ89 61-62
			educ20003 63
			educflag 64
			month 65-66
			str sex 69
			ageunit 70
			age 71-73
			str marstatA 84
			str icd10 146-149
			str icd358 150-152
			race 445-446
			racerec3 449
			hispanic2003 484-486
			hisprec 488
                using "$mdata/raw/nchs/MULT2010.USAllCnty.txt" ;
		gen year=2010;
		compress;
		save $mdata/int/nchs/Mort2010.dta, replace;
#delimit ;
	clear;
	*2011;
		infix
			resstatus 20
			str fipssto 21-22
			str fipsctyo 23-25
			str fipsstr 29-30
			fipsctyr 35-37
			str popcyr 43
			fipssmsar 47-50
			str popsizr 51
			str popsmsa 52
			str state_bornA 55-56
			educ89 61-62
			educ20003 63
			educflag 64
			month 65-66
			str sex 69
			ageunit 70
			age 71-73
			str marstatA 84
			str icd10 146-149
			str icd358 150-152
			race 445-446
			racerec3 449
			hispanic2003 484-486
			hisprec 488
                using "$mdata/raw/nchs/MULT2011.USAllCnty.txt" ;
		gen year=2011;
		compress;
		save $mdata/int/nchs/Mort2011.dta, replace;



#delimit ;
	clear;
	*2012;
		infix
			resstatus 20
			str fipssto 21-22
			str fipsctyo 23-25
			str fipsstr 29-30
			fipsctyr 35-37
			str popcyr 43
			fipssmsar 47-50
			str popsizr 51
			str popsmsa 52
			str state_bornA 55-56
			educ89 61-62
			educ20003 63
			educflag 64
			month 65-66
			str sex 69
			ageunit 70
			age 71-73
			str marstatA 84
			str icd10 146-149
			str icd358 150-152
			race 445-446
			racerec3 449
			hispanic2003 484-486
			hisprec 488
                using "$mdata/raw/nchs/MULT2012.USAllCnty.txt" ;
		gen year=2012;
		compress;
		save $mdata/int/nchs/Mort2012.dta, replace;



#delimit ;
	clear;
	*2013;
		infix
			resstatus 20
			str fipssto 21-22
			str fipsctyo 23-25
			str fipsstr 29-30
			fipsctyr 35-37
			str popcyr 43
			fipssmsar 47-50
			str popsizr 51
			str popsmsa 52
			str state_bornA 55-56
			educ89 61-62
			educ20003 63
			educflag 64
			month 65-66
			str sex 69
			ageunit 70
			age 71-73
			str marstatA 84
			str icd10 146-149
			str icd358 150-152
			race 445-446
			racerec3 449
			hispanic2003 484-486
			hisprec 488
                using "$mdata/raw/nchs/MULT2013.USAllCnty.txt" ;
		gen year=2013;
		compress;
		save $mdata/int/nchs/Mort2013.dta, replace;
#delimit ;
	clear;
	*2014;
		infix
			resstatus 20
			str fipssto 21-22
			str fipsctyo 23-25
			str fipsstr 29-30
			fipsctyr 35-37
			str popcyr 43
			fipssmsar 47-50
			str popsizr 51
			str popsmsa 52
			str state_bornA 55-56
			educ89 61-62
			educ20003 63
			educflag 64
			month 65-66
			str sex 69
			ageunit 70
			age 71-73
			str marstatA 84
			str icd10 146-149
			str icd358 150-152
			race 445-446
			racerec3 449
			hispanic2003 484-486
			hisprec 488
                using "$mdata/raw/nchs/MULT2014.USAllCnty.txt" ;
		gen year=2014;
		compress;
		save $mdata/int/nchs/Mort2014.dta, replace;

*/

#delimit ;


	clear;
	*2015;
		infix
			resstatus 20
			str fipssto 21-22
			str fipsctyo 23-25
			str fipsstr 29-30
			fipsctyr 35-37
			str popcyr 43
			fipssmsar 47-50
			str popsizr 51
			str popsmsa 52
			str state_bornA 55-56
			educ89 61-62
			educ20003 63
			educflag 64
			month 65-66
			str sex 69
			ageunit 70
			age 71-73
			str marstatA 84
			str icd10 146-149
			str icd358 150-152
			race 445-446
			racerec3 449
			hispanic2003 484-486
			hisprec 488
                using "$mdata/raw/nchs/MULT2015.USAllCnty.txt" ;
		gen year=2015;
		compress;

		save $mdata/int/nchs/Mort2015.dta, replace;


/* 2016 */ 
    clear; 
    #delimit ;
		infix    
    resstatus 20
    str fipssto 21-22
    str fipsctyo 23-25
    str fipsstr 29-30
    fipsctyr 35-37
    str popcyr 43
    fipssmsar 47-50
    str popsizr 51
    str popsmsa 52
    str state_bornA 55-56
    educ89 61-62
    educ20003 63
    educflag 64
    month 65-66
    str sex 69
    ageunit 70
    age 71-73
    str marstatA 84
    str icd10 146-149
    str icd358 150-152
    race 445-446
    racerec3 449
    hispanic2003 484-486
    hisprec 488
                using "$mdata/raw/nchs/MULT2016.USAllCnty.txt" ;
		gen year=2016;
		compress;

		save $mdata/int/nchs/Mort2016.dta, replace;

/* 2017 */
    clear;
    #delimit ;
		infix    
    resstatus 20
    str fipssto 21-22
    str fipsctyo 23-25
    str fipsstr 29-30
    fipsctyr 35-37
    str popcyr 43
    fipssmsar 47-50
    str popsizr 51
    str popsmsa 52
    str state_bornA 55-56
    educ89 61-62
    educ20003 63
    educflag 64
    month 65-66
    str sex 69
    ageunit 70
    age 71-73
    str marstatA 84
    str icd10 146-149
    str icd358 150-152
    race 445-446
    racerec3 449
    hispanic2003 484-486
    hisprec 488
                using "$mdata/raw/nchs/MULT2017.USAllCnty.txt" ;
		gen year=2017;
		compress;

		save $mdata/int/nchs/Mort2017.dta, replace;

/* 2018  */
clear; 
    #delimit ;
		infix    
    resstatus 20
    str fipssto 21-22
    str fipsctyo 23-25
    str fipsstr 29-30
    fipsctyr 35-37
    str popcyr 43
    fipssmsar 47-50
    str popsizr 51
    str popsmsa 52
    str state_bornA 55-56
    educ89 61-62
    educ20003 63
    educflag 64
    month 65-66
    str sex 69
    ageunit 70
    age 71-73
    str marstatA 84
    str icd10 146-149
    str icd358 150-152
    race 445-446
    racerec3 449
    hispanic2003 484-486
    hisprec 488
                using "$mdata/raw/nchs/Mort2018US.AllCnty.txt" ;
		gen year=2018;
		compress;

		save $mdata/int/nchs/Mort2018.dta, replace;


    




#delimit ;
cd $mdata ; 
/*********************************************/
/* read in these files, by race educ and sex */
/*********************************************/
clear ;
tempfile tempbig ;

use $mdata/int/nchs/Mort1989.dta ;

/* ignore foreign residents - they aren't in population denominators  */
/* and keep only those with age in years */
drop if resstatus>3;
keep if ageunit==0;
keep if age>=25 & age<=74;

keep year region educ89 hisprec sex age fipsstr fipsctyr icd icdn icd282;
/* CDC doesn't count hispanic origin unknown in its counts by ethnicity - only in its overall mortality count */
        ren icd icd9;
        ren icdn icd9n;

        gen ind_WNH = hisprec==6;                replace ind_WNH=. if hisprec==9;
        gen ind_BNH = hisprec==7;                replace ind_BNH=. if hisprec==9;
        gen ind_hisp = hisprec>=1 & hisprec<=5; replace ind_hisp=. if hisprec==9;

        gen edclass=1 if educ89<=12;
        replace edclass=2 if educ89>=13 & educ89<=15;
        replace edclass=3 if educ89>=16 & educ89<=17;

/* get the more detailed education variables */
gen edclass_detailed = edclass + 1 ; 
replace edclass_detailed = 1 if educ89 < 12  ;

save `tempbig', replace;

forval i = 90(1) 98 {;
use $mdata/int/nchs/Mort19`i'.dta;

        drop if resstatus>3;
        keep if ageunit==0;
        keep if age>=25 & age<=74;

keep year region educ89 hisprec sex age fipsstr fipsctyr icd icdn icd282;
        ren icd icd9;
        ren icdn icd9n;
        gen ind_WNH = hisprec==6; replace ind_WNH=. if hisprec==9;
        gen ind_BNH = hisprec==7; replace ind_BNH=. if hisprec==9;
        gen ind_hisp = hisprec>=1 & hisprec<=5; replace ind_hisp=. if hisprec==9;

        gen edclass=1 if educ89<=12;
        replace edclass=2 if educ89>=13 & educ89<=15;
        replace edclass=3 if educ89>=16 & educ89<=17;


/* get detailed educations */
gen edclass_detailed = edclass + 1; 
replace edclass_detailed = 1 if educ89 < 12;
                     
append using `tempbig';
save `tempbig', replace;
};


forval i = 1999(1) 2002 {;
use $mdata/int/nchs/Mort`i'.dta;

        drop if resstatus>3;
        keep if ageunit==0;
        keep if age>=25 & age<=74;

keep year region educ89 hisprec sex age fipsstr fipsctyr icd10 icd358;
        gen icd358R = real(icd358);
        drop icd358; ren icd358R icd358;

        gen ind_WNH = hisprec==6; replace ind_WNH=. if hisprec==9;
        gen ind_BNH = hisprec==7; replace ind_BNH=. if hisprec==9;
        gen ind_hisp = hisprec>=1 & hisprec<=5; replace ind_hisp=. if hisprec==9;

        gen edclass=1 if educ89<=12;
        replace edclass=2 if educ89>=13 & educ89<=15;
        replace edclass=3 if educ89>=16 & educ89<=17;

/* get detailed educations */
gen edclass_detailed = edclass + 1;
replace edclass_detailed = 1 if educ89 < 12;
                         
append using `tempbig';
save `tempbig', replace;
};

forval i = 2003(1)2018 {;
use $mdata/int/nchs/Mort`i'.dta, clear;

ren fipsstr stlab;
merge m:1 stlab using raw/misc/state_lab_fips, keepusing(stlab st_FIPS);
        tab stlab if _m==1;
        drop if _m==1; drop _m;
        ren st_FIPS fipsstr;

drop if resstatus>3;
keep if ageunit==1;
keep if age>=25 & age<=74;

keep year educ* hisprec sex age fipsstr fipsctyr icd10 icd358;
gen sexx=1 if sex=="M";
replace sexx=2 if sex=="F";
drop sex;
ren sexx sex;

gen icd358R = real(icd358);
drop icd358; ren icd358R icd358;

gen ind_WNH = hisprec==6; replace ind_WNH=. if hisprec==9;
gen ind_BNH = hisprec==7; replace ind_BNH=. if hisprec==9;
gen ind_hisp = hisprec>=1 & hisprec<=5; replace ind_hisp=. if hisprec==9;

gen edclass=1 if educ89<=12 ;
replace edclass=2 if educ89>12  & educ89<=15 ;
replace edclass=3 if educ89>=16  & educ89<=17 ;
replace edclass=1 if educ20003<=3 & educflag==1;
replace edclass=2 if educ20003>=4 & educ20003<=5 & educflag==1;
replace edclass=3 if educ20003>=6 & educ20003<=8 & educflag==1;

/* get detailed ed var */
gen edclass_detailed = edclass + 1 ; 
replace edclass_detailed = 1 if educ89 < 12 & educflag != 1;
replace edclass_detailed = 1 if educ20003 <= 2 & educflag == 1;
                        
append using `tempbig';
save `tempbig', replace;
};

gen race=1 if ind_WNH==1;
replace race=2 if ind_BNH==1;
replace race=3 if ind_hisp==1;
tab hisprec if race==.;

/* these are NH other races and hisp origin UNK */
*drop if race ==.;
label var race "1 WNH 2 BNH 3 Hisp";

gen age_gp=25 if age>=25 & age<=29;
replace age_gp=30 if age>=30 & age<=34;
replace age_gp=35 if age>=35 & age<=39;
replace age_gp=40 if age>=40 & age<=44;
replace age_gp=45 if age>=45 & age<=49;
replace age_gp=50 if age>=50 & age<=54;
replace age_gp=55 if age>=55 & age<=59;
replace age_gp=60 if age>=60 & age<=64;
replace age_gp=65 if age>=65 & age<=69;
replace age_gp=70 if age>=70 & age<=74;
label var age_gp "25-29, 30-34, etc.";

replace edclass = 99 if edclass==.;
label def edlab 1 "LEHS" 2 "SomeC" 3 "4+yrs" 99 "missing";
label val edclass edlab;

replace edclass_detailed = 99 if edclass_detailed == .;


/* rename edclass to suit conventions */
ren edclass edclass_3bin ;
ren edclass_detailed edclass ;

save $mdata/int/nchs/mort_8918, replace;

