/*
File:	cepr_acs_keepord.do
Date:	Aug 11, 2011
	Dec 23, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Nov 9, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Preserves and orders data extracted and processed from
	the American Community Survey for CEPR extract
Note:	See copyright notice at end of program.
*/

capture program drop keepord
program define keepord

keep /*idvar*/ year serialno sporder resmode hsgwgt wgtp1 wgtp2 wgtp3 /*
*/wgtp4 wgtp5 wgtp6 wgtp7 wgtp8 wgtp9 wgtp10 wgtp11 wgtp12 wgtp13 /*
*/wgtp14 wgtp15 wgtp16 wgtp17 wgtp18 wgtp19 wgtp20 wgtp21 wgtp22 /*
*/wgtp23 wgtp24 wgtp25 wgtp26 wgtp27 wgtp28 wgtp29 wgtp30 wgtp31 /*
*/wgtp32 wgtp33 wgtp34 wgtp35 wgtp36 wgtp37 wgtp38 wgtp39 wgtp40 /*
*/wgtp40 wgtp41 wgtp42 wgtp43 wgtp44 wgtp45 wgtp46 wgtp47 wgtp48 /*
*/wgtp49 wgtp50 wgtp51 wgtp52 wgtp53 wgtp54 wgtp55 wgtp56 wgtp57 /*
*/wgtp58 wgtp59 wgtp60 wgtp61 wgtp62 wgtp63 wgtp64 wgtp65 wgtp66 /*
*/wgtp67 wgtp68 wgtp69 wgtp70 wgtp71 wgtp72 wgtp73 wgtp74 wgtp75 /*
*/wgtp76 wgtp77 wgtp78 wgtp79 wgtp80 perwgt pwgtp1 pwgtp2 pwgtp3 /*
*/pwgtp4 pwgtp5 pwgtp6 pwgtp7 pwgtp8 pwgtp9 pwgtp10 pwgtp11 pwgtp12 /*
*/pwgtp13 pwgtp14 pwgtp15 pwgtp16 pwgtp17 pwgtp18 pwgtp19 pwgtp20 /*
*/pwgtp21 pwgtp22 pwgtp23 pwgtp24 pwgtp25 pwgtp26 pwgtp27 pwgtp28 /*
*/pwgtp29 pwgtp30 pwgtp31 pwgtp32 pwgtp33 pwgtp34 pwgtp35 pwgtp36 /*
*/pwgtp37 pwgtp38 pwgtp39 pwgtp40 pwgtp41 pwgtp42 pwgtp43 pwgtp44 /*
*/pwgtp45 pwgtp46 pwgtp47 pwgtp48 pwgtp49 pwgtp50 pwgtp51 pwgtp52 /*
*/pwgtp53 pwgtp54 pwgtp55 pwgtp56 pwgtp57 pwgtp58 pwgtp59 pwgtp60 /*
*/pwgtp61 pwgtp62 pwgtp63 pwgtp64 pwgtp65 pwgtp66 pwgtp67 pwgtp68 /*
*/pwgtp69 pwgtp70 pwgtp71 pwgtp72 pwgtp73 pwgtp74 pwgtp75 pwgtp76 /*
*/pwgtp77 pwgtp78 pwgtp79 pwgtp80 /*
geog*/region division state puma00 puma10 /*
housing*/adj_h type vacant acr ags bath bdsp bld bus conp_adj /*
*/elep_adj fulp_adj gasp_adj hfl insp_adj mhp_adj /*
*/mrgi mrgp_adj mrgt mrgx refr rmsp rntm rntp_adj rwat sink /*
*/smp_adj stove tel ten hmown hmrnt toilet vacs value value08_adj /*
*/watp_adj ybl08 ybl05 ybl_all grntp_adj kitchen mv plumbing /*
*/smocp_adj smx srnt sval taxp_amt taxp veh access broadbnd compothx dialup dsl fiberop/*
*/ handheld laptop modem hispeed smartphone tablet othsvcex satellite /*
demog*/age female rac1p rac2p2005 rac2p2012 rac3p2005 rac3p2012 wbho wbhao /*
*/wbhapo wbhapom aapi asian asian_d2005 asian_d2012 pi pi_d2005 pi_d2012 aapisub /*
*/ aapisub2_2005 aapisub2_2012 hisp racaian racasn racblk racnhpi /*
*/ racnum racwht anc anc1p05 anc2p05 anc1p08 anc2p08 /*
*/ anc1p12 anc2p12 anc1p17 anc2p17 anc1p18 anc2p18 forborn citizen citstat /*
*/ yoep yoep05 yoep12 yoep17 yoep18 citwp citwp08 citwp12 citwp17 /*
*/ waob waob18 pobp05 pobp09 pobp12 pobp17 nop forbornm forbornf /*
*/ vps veteran /*
family*/mar married rel05 rel08 sfr psf hht partner perhh hh60 /*
*/hhsenior wif fes wkexrel esp perfam noc hhoc nfchild hhchild /*
*/nhhchild hhrc hhgc child nr fer multgen npp gcr ssmc /*
empstat*/lfstat esr milstat mil_ly civnonmil wkw05 wkslyr hrslyr /*
*/emp1014 clslyr military ftptlyr ftfy ptpy nowork wkl nwlk nwab /*
*/nwla nwav selfemp selfinc pubsect pubfed pubst publoc nonprof /*
*/powsp00 powsp10 powpuma00 powpuma10 jwmnp jwrip jwtr pubtran jwap jwdp /*
educ*/educ educ05 educ08 fod1p09 fod2p09 fod1p10 fod2p10 /*
*/fod1p11 fod2p11 sciengp sciengrlp sch enrolled grade grade05 grade08 /*
ind*/ind3d_05 ind3d_08 ind3d_09 ind3d_12 ind3d_13 ind3d_18 ind_naics05 /*
*/ ind_naics08 ind_naics09 ind_naics12 ind_naics13 ind_naics18 /*
occ*/ occp05 occp10 occp12 occp18 socp05 socp06 socp10 socp12 socp18 /*
income*/adj incp_all_adj incp_ern_adj /*
*/incp_wag_adj hrearn05_adj hrwage05_adj /*
*/ incp_se_adj incp_paw_adj incp_ss_adj /*
*/ incp_ssi_adj incp_ret_adj incp_int_adj /*
*/ incp_oth_adj incp_uer_adj incf_all_adj /*
*/ inch_all_adj inch_fs_adj foodst /*
income_real*/ rincp_all_adj rincp_ern_adj /*
*/rincp_wag_adj rhrearn05_adj rhrwage05_adj /*
*/ rincp_se_adj rincp_paw_adj /*
*/rincp_ss_adj rincp_ssi_adj rincp_ret_adj /*
*/rincp_int_adj rincp_oth_adj rincp_uer_adj /*
*/rincf_all_adj rinch_all_adj rinch_fs_adj /*
poverty*/povpip poor pov200 /*
health*/hins hipriv hiep hipind himcaid himcare hiothpub hiva /*
*/hiihs hipub hins_imputed hiep_imputed hipind_imputed himcaid_imputed /*
*/himcare_imputed hiothpub_imputed hiva_imputed hiihs_imputed /*
*/hipub_imputed hipriv_imputed /*
disability*/dis dself dhear dvis dind damb dcog drat ddrs05 deye05 /*
*/dout05 dphy05 drem05 dwrk05 /*
language*/eng lanx hhl lngi lanp lanp16 lanp17 hhlanp16 hhlanp17 /*
migrate*/mig mover migsp migsp12 migsp17 migpuma00 migpuma10 fmigp fmigsp


order /*idvar*/ year serialno sporder resmode hsgwgt wgtp1 wgtp2 wgtp3 /*
*/wgtp4 wgtp5 wgtp6 wgtp7 wgtp8 wgtp9 wgtp10 wgtp11 wgtp12 wgtp13 /*
*/wgtp14 wgtp15 wgtp16 wgtp17 wgtp18 wgtp19 wgtp20 wgtp21 wgtp22 /*
*/wgtp23 wgtp24 wgtp25 wgtp26 wgtp27 wgtp28 wgtp29 wgtp30 wgtp31 /*
*/wgtp32 wgtp33 wgtp34 wgtp35 wgtp36 wgtp37 wgtp38 wgtp39 wgtp40 /*
*/wgtp40 wgtp41 wgtp42 wgtp43 wgtp44 wgtp45 wgtp46 wgtp47 wgtp48 /*
*/wgtp49 wgtp50 wgtp51 wgtp52 wgtp53 wgtp54 wgtp55 wgtp56 wgtp57 /*
*/wgtp58 wgtp59 wgtp60 wgtp61 wgtp62 wgtp63 wgtp64 wgtp65 wgtp66 /*
*/wgtp67 wgtp68 wgtp69 wgtp70 wgtp71 wgtp72 wgtp73 wgtp74 wgtp75 /*
*/wgtp76 wgtp77 wgtp78 wgtp79 wgtp80 perwgt pwgtp1 pwgtp2 pwgtp3 /*
*/pwgtp4 pwgtp5 pwgtp6 pwgtp7 pwgtp8 pwgtp9 pwgtp10 pwgtp11 pwgtp12 /*
*/pwgtp13 pwgtp14 pwgtp15 pwgtp16 pwgtp17 pwgtp18 pwgtp19 pwgtp20 /*
*/pwgtp21 pwgtp22 pwgtp23 pwgtp24 pwgtp25 pwgtp26 pwgtp27 pwgtp28 /*
*/pwgtp29 pwgtp30 pwgtp31 pwgtp32 pwgtp33 pwgtp34 pwgtp35 pwgtp36 /*
*/pwgtp37 pwgtp38 pwgtp39 pwgtp40 pwgtp41 pwgtp42 pwgtp43 pwgtp44 /*
*/pwgtp45 pwgtp46 pwgtp47 pwgtp48 pwgtp49 pwgtp50 pwgtp51 pwgtp52 /*
*/pwgtp53 pwgtp54 pwgtp55 pwgtp56 pwgtp57 pwgtp58 pwgtp59 pwgtp60 /*
*/pwgtp61 pwgtp62 pwgtp63 pwgtp64 pwgtp65 pwgtp66 pwgtp67 pwgtp68 /*
*/pwgtp69 pwgtp70 pwgtp71 pwgtp72 pwgtp73 pwgtp74 pwgtp75 pwgtp76 /*
*/pwgtp77 pwgtp78 pwgtp79 pwgtp80 /*
geog*/region division state puma00 puma10 /*
housing*/adj_h type vacant acr ags bath bdsp bld bus conp_adj /*
*/elep_adj fulp_adj gasp_adj hfl insp_adj mhp_adj /*
*/mrgi mrgp_adj mrgt mrgx refr rmsp rntm rntp_adj rwat sink /*
*/smp_adj stove tel ten hmown hmrnt toilet vacs value value08_adj /*
*/watp_adj ybl08 ybl05 ybl_all grntp_adj kitchen mv plumbing /*
*/smocp_adj smx srnt sval taxp_amt taxp veh access broadbnd compothx dialup dsl fiberop/*
*/ handheld laptop modem hispeed smartphone tablet othsvcex satellite /*
demog*/age female rac1p rac2p2005 rac2p2012 rac3p2005 rac3p2012 wbho wbhao /*
*/wbhapo wbhapom aapi asian asian_d2005 asian_d2012 pi pi_d2005 pi_d2012 aapisub /*
*/ aapisub2_2005 aapisub2_2012 hisp racaian racasn racblk racnhpi /*
*/ racnum racwht anc anc1p05 anc2p05 anc1p08 anc2p08 anc1p12 anc2p12 /*
*/ anc1p17 anc2p17 anc1p18 anc2p18 forborn citizen citstat /*
*/ yoep yoep05 yoep12 yoep17 yoep18 citwp citwp08 citwp12 citwp17 /*
*/ waob waob18 pobp05 pobp09 pobp12 nop forbornm forbornf /*
*/ vps veteran /*
family*/mar married rel05 rel08 sfr psf hht partner perhh hh60 /*
*/hhsenior wif fes wkexrel esp perfam noc hhoc nfchild hhchild /*
*/nhhchild hhrc hhgc child nr fer multgen npp gcr ssmc /*
empstat*/lfstat esr milstat mil_ly civnonmil wkw05 wkslyr hrslyr /*
*/emp1014 clslyr military ftptlyr ftfy ptpy nowork wkl nwlk nwab /*
*/nwla nwav selfemp selfinc pubsect pubfed pubst publoc nonprof /*
*/powsp00 powsp10 powpuma00 powpuma10 jwmnp jwrip jwtr pubtran jwap jwdp /*
educ*/educ educ05 educ08 fod1p09 fod2p09 fod1p10 fod2p10 /*
*/fod1p11 fod2p11 sciengp sciengrlp sch enrolled grade grade05 grade08 /*
ind*/ind3d_05 ind3d_08 ind3d_09 ind3d_12 ind3d_13 ind3d_18 ind_naics05 /*
*/ ind_naics08 ind_naics09 ind_naics12 ind_naics13 ind_naics18 /*
occ*/ occp05 occp10 occp12 occp18 socp05 socp06 socp10 socp12 socp18 /*
income*/adj incp_all_adj incp_ern_adj /*
*/incp_wag_adj hrearn05_adj hrwage05_adj /*
*/ incp_se_adj incp_paw_adj incp_ss_adj /*
*/ incp_ssi_adj incp_ret_adj incp_int_adj /*
*/ incp_oth_adj incp_uer_adj incf_all_adj /*
*/ inch_all_adj inch_fs_adj foodst /*
income_real*/ rincp_all_adj rincp_ern_adj /*
*/rincp_wag_adj rhrearn05_adj rhrwage05_adj /*
*/ rincp_se_adj rincp_paw_adj /*
*/rincp_ss_adj rincp_ssi_adj rincp_ret_adj /*
*/rincp_int_adj rincp_oth_adj rincp_uer_adj /*
*/rincf_all_adj rinch_all_adj rinch_fs_adj /*
poverty*/povpip poor pov200 /*
health*/hins hipriv hiep hipind himcaid himcare hiothpub hiva /*
*/hiihs hipub hins_imputed hiep_imputed hipind_imputed himcaid_imputed /*
*/himcare_imputed hiothpub_imputed hiva_imputed hiihs_imputed /*
*/hipub_imputed hipriv_imputed /*
disability*/dis dself dhear dvis dind damb dcog drat ddrs05 deye05 /*
*/dout05 dphy05 drem05 dwrk05 /*
language*/eng lanx hhl lngi lanp lanp16 lanp17 hhlanp16 hhlanp17 /*
migrate*/mig mover migsp migsp12 migsp17 migpuma00 migpuma10 fmigp fmigsp

end

/*
Copyright 2020 CEPR, John Schmitt, Hye Jin Rho, Janelle Jones, Cherrie Bucknor,
Brian Dew, Hayley Brown

This file is part of the cepr_acs_master.do program. This file and all
programs referenced in it are free software. You can redistribute the
program or modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
USA.
*/


