set more 1

/*
File:	cepr_acs_language.do
Date:	Aug 3, 2011
	Oct 29, 2012
	Dec 23, 2013
	Jan 27, 2015
	Nov 3, 2015, CEPR ACS Version 1.1
	Sep 19, 2016, CEPR ACS Version 1.1.1
	Oct 24, 2016, CEPR ACS Version 1.2
	Oct 22, 2017, CEPR ACS Version 1.3
	May 30, 2019, CEPR ACS Version 1.4
	Apr 16, 2020, CEPR ACS Version 1.5
Desc:	Creates consistent language variables for CEPR extract of American Community Survey 
*/

/* Determine survey year */

local year=year in 1

/* Ability to speak English */

if 2005<=`year' & `year'<=2018 {
replace eng=. if eng<1
replace eng=. if 4<eng
}
lab def eng	1 "Very well" ///
		2 "Well" ///
		3 "Not well" ///
		4 "Not at all"
lab var eng "Ability to speak English"
lab val eng eng
notes eng: ACS: ENG

/* Language other than English spoken at home */

if 2005<=`year' & `year'<=2018 {
replace lanx=. if lanx<1
replace lanx=. if 2<lanx
replace lanx=0 if lanx==2
}
lab var lanx "Language other than English spoken at home"
lab val lanx noyes
notes lanx: ACS: LANX

/* Household language */

if 2005<=`year' & `year'<=2018 {
replace hhl=. if hhl<1 | 5<hhl
}
lab def hhl	1 "English only" ///
		2 "Spanish" ///
		3 "Other Indo-European languages" ///
		4 "Asian and Pacific Island languages" ///
		5 "Other language"
lab var hhl "Household language"
lab val hhl hhl
notes hhl: ACS: HHL

/* Limited English speaking household */

if 2005<=`year' & `year'<=2018 {
replace lngi=. if lngi<1  | 2<lngi
replace lngi=0 if lngi==1
replace lngi=1 if lngi==2
}
lab var lngi "Limited English speaking household"
lab val lngi noyes
notes lngi: ACS: LNGI
notes lngi: A household is limited English speaking if no one age 14 or older in the HH speaks /*
*/ English only or speaks English "very well"
notes lngi: A household is not limited English speaking if at least one person age 14 or older /*
*/ in the HH speaks English only or speaks English "very well"
notes lngi: sometimes refered to as "linguistic isolation"

/* Language spoken at home */

if 2005<=`year' & `year'<=2015 {
replace lanp=. if lanp<601
replace lanp=. if 996<lanp

#delimit;
lab def lanp
601 "Jamaican Creole"
602 "Krio"
607 "German"
608 "Pennsylvania Dutch"
609 "Yiddish"
610 "Dutch"
611 "Afrikaans"
614 "Swedish"
615 "Danish"
616 "Norwegian"
619 "Italian"
620 "French"
622 "Patois"
623 "French Creole"
624 "Cajun"
625 "Spanish"
629 "Portuguese"
631 "Romanian"
635 "Irish Gaelic"
637 "Greek"
638 "Albanian"
639 "Russian"
641 "Ukrainian"
642 "Czech"
645 "Polish"
646 "Slovak"
647 "Bulgarian"
648 "Macedonian"
649 "Serbocroatian"
650 "Croatian"
651 "Serbian"
653 "Lithuanian"
654 "Lettish or Latvian"
655 "Armenian"
656 "Persian"
657 "Pashto"
658 "Kurdish"
662 "India n.e.c."
663 "Hindi"
664 "Bengali"
665 "Panjabi"
666 "Marathi"
667 "Gujarathi"
671 "Urdu"
674 "Nepali"
676 "Pakistan n.e.c."
677 "Sinhalese"
679 "Finnish"
682 "Hungarian"
691 "Turkish"
694 "Mongolian"
701 "Telugu"
702 "Kannada"
703 "Malayalam"
704 "Tamil"
708 "Chinese"
711 "Cantonese"
712 "Mandarin"
714 "Formosan"
717 "Burmese"
720 "Thai"
721 "Miao-yao, Mien"
722 "Hmong"
723 "Japanese"
724 "Korean"
725 "Laotian"
726 "Mon-Khmer, Cambodian"
728 "Vietnamese"
732 "Indonesian"
739 "Malay"
742 "Tagalog"
743 "Bisayan"
744 "Sebuano"
746 "Ilocano"
752 "Chamorro"
761 "Trukese"
767 "Samoan"
768 "Tongan"
776 "Hawaiian"
777 "Arabic"
778 "Hebrew"
779 "Syriac"
780 "Amharic"
783 "Cushite"
791 "Swahili"
792 "Bantu"
793 "Mande"
794 "Fulani"
796 "Kru, Ibo, Yoruba"
799 "African"
806 "Other Algonquian languages"
819 "Ojibwa"
862 "Apache"
864 "Navaho"
907 "Dakota"
924 "Keres"
933 "Cherokee"
964 "Zuni"
966 "American Indian"
985 "Other Indo-European languages"
986 "Other Asian languages"
988 "Other Pacific Island languages"
989 "Other specified African languages"
990 "Aleut-Eskimo languages"
992 "South/Central American Indian languages"
993 "Other Specified North American Indian languages"
994 "Other languages"
996 "Uncodable"
;
#delimit cr
lab var lanp "Language spoken at home"
lab val lanp lanp
notes lanp: ACS: LANP
notes lanp: Consistent for 2005-2015
}

if 2005<=`year' & `year'<=2015 {
  gen lanp16 = .
  gen lanp17 = .
  gen hhlanp16 = .
  gen hhlanp17 = .
}


if `year'==2016{
  destring lanp, replace
  rename lanp lanp16

#delimit;
lab def lanp16
1000 "Jamaican Creole English"
1025 "Other English-based Creole languages"
1055 "Haitian"
1069 "Kabuverdianu"
1110 "German"
1120 "Swiss German"
1125 "Pennsylvania German"
1130 "Yiddish"
1132 "Dutch"
1134 "Afrikaans"
1140 "Swedish"
1141 "Danish"
1142 "Norwegian"
1155 "Italian"
1170 "French"
1175 "Cajun French"
1200 "Spanish"
1210 "Portuguese"
1220 "Romanian"
1231 "Irish"
1235 "Greek"
1242 "Albanian"
1250 "Russian"
1260 "Ukrainian"
1262 "Czech"
1263 "Slovak"
1270 "Polish"
1273 "Bulgarian"
1274 "Macedonian"
1275 "Serbocroatian"
1276 "Bosnian"
1277 "Croatian"
1278 "Serbian"
1281 "Lithuanian"
1283 "Latvian"
1288 "Armenian"
1290 "Farsi"
1292 "Dari"
1315 "Kurdish"
1327 "Pashto"
1340 "India N.E.C."
1350 "Hindi"
1360 "Urdu"
1380 "Bengali"
1420 "Punjabi"
1435 "Konkani"
1440 "Marathi"
1450 "Gujarati"
1500 "Nepali"
1525 "Pakistan N.E.C."
1530 "Sinhala"
1540 "Other Indo-Iranian languages"
1564 "Other Indo-European languages"
1565 "Finnish"
1582 "Hungarian"
1675 "Turkish"
1690 "Mongolian"
1730 "Telugu"
1737 "Kannada"
1750 "Malayalam"
1765 "Tamil"
1900 "Khmer"
1960 "Vietnamese"
1970 "Chinese"
2000 "Mandarin"
2030 "Min Nan Chinese"
2050 "Cantonese"
2100 "Tibetan"
2160 "Burmese"
2270 "Chin languages"
2350 "Karen languages"
2430 "Thai"
2475 "Lao"
2525 "Iu Mien"
2535 "Hmong"
2560 "Japanese"
2575 "Korean"
2715 "Malay"
2770 "Indonesian"
2850 "Other languages of Asia"
2910 "Filipino"
2920 "Tagalog"
2950 "Cebuano"
3150 "Ilocano"
3190 "Other Philippine languages"
3220 "Chamorro"
3270 "Marshallese"
3350 "Chuukese"
3420 "Samoan"
3500 "Tongan"
3570 "Hawaiian"
3600 "Other Eastern Malayo-Polynesian languages"
4500 "Arabic"
4545 "Hebrew"
4560 "Assyrian Neo-Aramaic"
4565 "Chaldean Neo-Aramaic"
4590 "Amharic"
4640 "Tigrinya"
4830 "Oromo"
4840 "Somali"
4880 "Other Afro-Asiatic languages"
4900 "Nilo-Saharan languages"
5150 "Swahili"
5345 "Ganda"
5525 "Shona"
5645 "Other Bantu languages"
5845 "Manding languages"
5900 "Other Mande languages"
5940 "Fulah"
5950 "Wolof"
6120 "Akan (incl Twi)"
6205 "Ga"
6230 "Gbe languages"
6290 "Yoruba"
6300 "Edoid languages"
6370 "Igbo"
6500 "Other Niger-Congo languages"
6795 "Other languages of Africa"
6800 "Aleut languages"
6839 "Ojibwa"
6930 "Apache languages"
6933 "Navajo"
6936 "Kiowa-Tanoan languages"
7019 "Dakota languages"
7032 "Muskogean languages"
7039 "Keres"
7050 "Cherokee"
7059 "Zuni"
7060 "Uto-Aztecan languages"
7124 "Other Native North American languages"
7300 "Other Central and South American languages"
9500 "English only household"
9999 "Other and unspecified languages"
;
#delimit cr
lab var lanp16 "Language spoken at home"
lab val lanp16 lanp16
notes lanp16: ACS: LANP
notes lanp16: Consistent for 2016 only
}

if `year'==2016{
  destring hhlanp, replace
  rename hhlanp hhlanp16
  
#delimit;
lab def hhlanp16
1000 "Jamaican Creole English"
1025 "Other English-based Creole languages"
1055 "Haitian"
1069 "Kabuverdianu"
1110 "German"
1120 "Swiss German"
1125 "Pennsylvania German"
1130 "Yiddish"
1132 "Dutch"
1134 "Afrikaans"
1140 "Swedish"
1141 "Danish"
1142 "Norwegian"
1155 "Italian"
1170 "French"
1175 "Cajun French"
1200 "Spanish"
1210 "Portuguese"
1220 "Romanian"
1231 "Irish"
1235 "Greek"
1242 "Albanian"
1250 "Russian"
1260 "Ukrainian"
1262 "Czech"
1263 "Slovak"
1270 "Polish"
1273 "Bulgarian"
1274 "Macedonian"
1275 "Serbocroatian"
1276 "Bosnian"
1277 "Croatian"
1278 "Serbian"
1281 "Lithuanian"
1283 "Latvian"
1288 "Armenian"
1290 "Farsi"
1292 "Dari"
1315 "Kurdish"
1327 "Pashto"
1340 "India N.E.C."
1350 "Hindi"
1360 "Urdu"
1380 "Bengali"
1420 "Punjabi"
1435 "Konkani"
1440 "Marathi"
1450 "Gujarati"
1500 "Nepali"
1525 "Pakistan N.E.C."
1530 "Sinhala"
1540 "Other Indo-Iranian languages"
1564 "Other Indo-European languages"
1565 "Finnish"
1582 "Hungarian"
1675 "Turkish"
1690 "Mongolian"
1730 "Telugu"
1737 "Kannada"
1750 "Malayalam"
1765 "Tamil"
1900 "Khmer"
1960 "Vietnamese"
1970 "Chinese"
2000 "Mandarin"
2030 "Min Nan Chinese"
2050 "Cantonese"
2100 "Tibetan"
2160 "Burmese"
2270 "Chin languages"
2350 "Karen languages"
2430 "Thai"
2475 "Lao"
2525 "Iu Mien"
2535 "Hmong"
2560 "Japanese"
2575 "Korean"
2715 "Malay"
2770 "Indonesian"
2850 "Other languages of Asia"
2910 "Filipino"
2920 "Tagalog"
2950 "Cebuano"
3150 "Ilocano"
3190 "Other Philippine languages"
3220 "Chamorro"
3270 "Marshallese"
3350 "Chuukese"
3420 "Samoan"
3500 "Tongan"
3570 "Hawaiian"
3600 "Other Eastern Malayo-Polynesian languages"
4500 "Arabic"
4545 "Hebrew"
4560 "Assyrian Neo-Aramaic"
4565 "Chaldean Neo-Aramaic"
4590 "Amharic"
4640 "Tigrinya"
4830 "Oromo"
4840 "Somali"
4880 "Other Afro-Asiatic languages"
4900 "Nilo-Saharan languages"
5150 "Swahili"
5345 "Ganda"
5525 "Shona"
5645 "Other Bantu languages"
5845 "Manding languages"
5900 "Other Mande languages"
5940 "Fulah"
5950 "Wolof"
6120 "Akan (incl Twi)"
6205 "Ga"
6230 "Gbe languages"
6290 "Yoruba"
6300 "Edoid languages"
6370 "Igbo"
6500 "Other Niger-Congo languages"
6795 "Other languages of Africa"
6800 "Aleut languages"
6839 "Ojibwa"
6930 "Apache languages"
6933 "Navajo"
6936 "Kiowa-Tanoan languages"
7019 "Dakota languages"
7032 "Muskogean languages"
7039 "Keres"
7050 "Cherokee"
7059 "Zuni"
7060 "Uto-Aztecan languages"
7124 "Other Native North American languages"
7300 "Other Central and South American languages"
9500 "English only household"
9999 "Other and unspecified languages"
;
#delimit cr
lab var hhlanp16 "Detailed household language"
lab val hhlanp16 hhlanp16
notes hhlanp16: ACS: HHLANP
notes hhlanp16: Consistent for 2016 only
}

if `year'==2016{
  gen hhlanp17 = .
  gen lanp17 = .
  gen lanp = .
}

if 2017<=`year' & `year'<=2018 {
  destring lanp, replace
  rename lanp lanp17

#delimit;
lab def lanp17
1000 "Jamaican Creole English"
1025 "Other English-based Creole languages"
1055 "Haitian"
1069 "Kabuverdianu"
1110 "German"
1120 "Swiss German"
1125 "Pennsylvania German"
1130 "Yiddish"
1132 "Dutch"
1134 "Afrikaans"
1140 "Swedish"
1141 "Danish"
1142 "Norwegian"
1155 "Italian"
1170 "French"
1175 "Cajun French"
1200 "Spanish"
1210 "Portuguese"
1220 "Romanian"
1231 "Irish"
1235 "Greek"
1242 "Albanian"
1250 "Russian"
1260 "Ukrainian"
1262 "Czech"
1263 "Slovak"
1270 "Polish"
1273 "Bulgarian"
1274 "Macedonian"
1275 "Serbocroatian"
1276 "Bosnian"
1277 "Croatian"
1278 "Serbian"
1281 "Lithuanian"
1283 "Latvian"
1288 "Armenian"
1290 "Farsi"
1292 "Dari"
1315 "Kurdish"
1327 "Pashto"
1340 "India N.E.C."
1350 "Hindi"
1360 "Urdu"
1380 "Bengali"
1420 "Punjabi"
1435 "Konkani"
1440 "Marathi"
1450 "Gujarati"
1500 "Nepali"
1525 "Pakistan N.E.C."
1530 "Sinhala"
1540 "Other Indo-Iranian languages"
1564 "Other Indo-European languages"
1565 "Finnish"
1582 "Hungarian"
1675 "Turkish"
1690 "Mongolian"
1730 "Telugu"
1737 "Kannada"
1750 "Malayalam"
1765 "Tamil"
1900 "Khmer"
1960 "Vietnamese"
1970 "Chinese"
2000 "Mandarin"
2030 "Min Nan Chinese"
2050 "Cantonese"
2100 "Tibetan"
2160 "Burmese"
2270 "Chin languages"
2350 "Karen languages"
2430 "Thai"
2475 "Lao"
2525 "Iu Mien"
2535 "Hmong"
2560 "Japanese"
2575 "Korean"
2715 "Malay"
2770 "Indonesian"
2850 "Other languages of Asia"
2910 "Filipino"
2920 "Tagalog"
2950 "Cebuano"
3150 "Ilocano"
3190 "Other Philippine languages"
3220 "Chamorro"
3270 "Marshallese"
3350 "Chuukese"
3420 "Samoan"
3500 "Tongan"
3570 "Hawaiian"
3600 "Other Eastern Malayo-Polynesian languages"
4500 "Arabic"
4545 "Hebrew"
4560 "Assyrian Neo-Aramaic"
4565 "Chaldean Neo-Aramaic"
4590 "Amharic"
4640 "Tigrinya"
4830 "Oromo"
4840 "Somali"
4880 "Other Afro-Asiatic languages"
4900 "Nilo-Saharan languages"
5150 "Swahili"
5345 "Ganda"
5525 "Shona"
5645 "Other Bantu languages"
5845 "Manding languages"
5900 "Other Mande languages"
5940 "Fulah"
5950 "Wolof"
6120 "Akan (incl Twi)"
6205 "Ga"
6230 "Gbe languages"
6290 "Yoruba"
6300 "Edoid languages"
6370 "Igbo"
6500 "Other Niger-Congo languages"
6795 "Other languages of Africa"
6800 "Aleut languages"
6839 "Ojibwa"
6930 "Apache languages"
6933 "Navajo"
7019 "Dakota languages"
7032 "Muskogean languages"
7039 "Keres"
7050 "Cherokee"
7060 "Uto-Aztecan languages"
7124 "Other Native North American languages"
7300 "Other Central and South American languages"
9999 "Other and unspecified languages"
;
#delimit cr
lab var lanp17 "Language spoken at home"
lab val lanp17 lanp17
notes lanp17: ACS: LANP
notes lanp17: Consistent for 2017-2018
}

if 2017<=`year' & `year'<=2018 {
  destring hhlanp, replace
  rename hhlanp hhlanp17
  
#delimit;
lab def hhlanp17
1000 "Jamaican Creole English"
1025 "Other English-based Creole languages"
1055 "Haitian"
1069 "Kabuverdianu"
1110 "German"
1120 "Swiss German"
1125 "Pennsylvania German"
1130 "Yiddish"
1132 "Dutch"
1134 "Afrikaans"
1140 "Swedish"
1141 "Danish"
1142 "Norwegian"
1155 "Italian"
1170 "French"
1175 "Cajun French"
1200 "Spanish"
1210 "Portuguese"
1220 "Romanian"
1231 "Irish"
1235 "Greek"
1242 "Albanian"
1250 "Russian"
1260 "Ukrainian"
1262 "Czech"
1263 "Slovak"
1270 "Polish"
1273 "Bulgarian"
1274 "Macedonian"
1275 "Serbocroatian"
1276 "Bosnian"
1277 "Croatian"
1278 "Serbian"
1281 "Lithuanian"
1283 "Latvian"
1288 "Armenian"
1290 "Farsi"
1292 "Dari"
1315 "Kurdish"
1327 "Pashto"
1340 "India N.E.C."
1350 "Hindi"
1360 "Urdu"
1380 "Bengali"
1420 "Punjabi"
1435 "Konkani"
1440 "Marathi"
1450 "Gujarati"
1500 "Nepali"
1525 "Pakistan N.E.C."
1530 "Sinhala"
1540 "Other Indo-Iranian languages"
1564 "Other Indo-European languages"
1565 "Finnish"
1582 "Hungarian"
1675 "Turkish"
1690 "Mongolian"
1730 "Telugu"
1737 "Kannada"
1750 "Malayalam"
1765 "Tamil"
1900 "Khmer"
1960 "Vietnamese"
1970 "Chinese"
2000 "Mandarin"
2030 "Min Nan Chinese"
2050 "Cantonese"
2100 "Tibetan"
2160 "Burmese"
2270 "Chin languages"
2350 "Karen languages"
2430 "Thai"
2475 "Lao"
2525 "Iu Mien"
2535 "Hmong"
2560 "Japanese"
2575 "Korean"
2715 "Malay"
2770 "Indonesian"
2850 "Other languages of Asia"
2910 "Filipino"
2920 "Tagalog"
2950 "Cebuano"
3150 "Ilocano"
3190 "Other Philippine languages"
3220 "Chamorro"
3270 "Marshallese"
3350 "Chuukese"
3420 "Samoan"
3500 "Tongan"
3570 "Hawaiian"
3600 "Other Eastern Malayo-Polynesian languages"
4500 "Arabic"
4545 "Hebrew"
4560 "Assyrian Neo-Aramaic"
4565 "Chaldean Neo-Aramaic"
4590 "Amharic"
4640 "Tigrinya"
4830 "Oromo"
4840 "Somali"
4880 "Other Afro-Asiatic languages"
4900 "Nilo-Saharan languages"
5150 "Swahili"
5345 "Ganda"
5525 "Shona"
5645 "Other Bantu languages"
5845 "Manding languages"
5900 "Other Mande languages"
5940 "Fulah"
5950 "Wolof"
6120 "Akan (incl Twi)"
6205 "Ga"
6230 "Gbe languages"
6290 "Yoruba"
6300 "Edoid languages"
6370 "Igbo"
6500 "Other Niger-Congo languages"
6795 "Other languages of Africa"
6800 "Aleut languages"
6839 "Ojibwa"
6930 "Apache languages"
6933 "Navajo"
7019 "Dakota languages"
7032 "Muskogean languages"
7039 "Keres"
7050 "Cherokee"
7060 "Uto-Aztecan languages"
7124 "Other Native North American languages"
7300 "Other Central and South American languages"
9500 "English only household"
9999 "Other and unspecified languages"
;
#delimit cr
lab var hhlanp17 "Detailed household language"
lab val hhlanp17 hhlanp17
notes hhlanp17: ACS: HHLANP
notes hhlanp17: Consistent for 2017-2018
}

if 2017<=`year' & `year'<=2018 {
  gen hhlanp16 = .
  gen lanp16 = .
  gen lanp = .
}

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

