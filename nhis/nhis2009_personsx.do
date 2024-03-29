version 6.0

* THE FOLLOWING COMMAND TEMPORARILY CHANGES THE COMMAND-
* ENDING DELIMITER FROM A CARRIAGE RETURN TO A SEMICOLON

#delimit ;

*********************************************************************
 JUNE 3, 2010  2:15 PM
 
 THIS IS AN EXAMPLE OF A STATA DO PROGRAM THAT CREATES A STATA
 FILE FROM THE 2009 NHIS Public Use Person ASCII FILE

 NOTES:

 EXECUTING THIS PROGRAM WILL REPLACE personsx.dta AND personsx.log
 IF THOSE FILES ALREADY EXIST IN THE DEFAULT DIRECTORY

 THIS PROGRAM ASSUMES THAT THE ASCII DATA FILE IS IN THE STATA WORKING
 DIRECTORY.  AN EXAMPLE OF HOW TO CHANGE THE WORKING DIRECTORY
 WITHIN STATA IS THE FOLLOWING COMMAND: cd C:\nhis2009\

 THIS PROGRAM OPENS A LOG FILE.  IF THE PROGRAM ENDS PREMATURELY, THE
 LOG FILE WILL REMAIN OPEN.  BEFORE RUNNING THIS PROGRAM AGAIN, THE
 USER SHOULD ENTER THE FOLLOWING STATA COMMAND: log close
 
 THIS IS STORED IN personsx.do
*********************************************************************;
clear;
set mem 200m;

* INPUT ALL VARIABLES;

infix
      rectype       1 -   2      srvy_yr       3 -   6
  str hhx           7 -  12      intv_qrt     13 -  13
      assignwk     14 -  15  str fmx          16 -  17
  str fpx          18 -  19      wtia         20 -  25
      wtfa         26 -  31

      region       32 -  32      strat_p      33 -  35
      psu_p        36 -  37

      sex          38 -  38      origin_i     39 -  39
      origimpt     40 -  40      hispan_i     41 -  42
      hispimpt     43 -  43      racerpi2     44 -  45
      raceimp2     46 -  46      mracrpi2     47 -  48
      mracbpi2     49 -  50      racreci3     51 -  51
      hiscodi3     52 -  52      erimpflg     53 -  53
      nowaf        54 -  54      rrp          55 -  56
  str hhreflg      57 -  57      frrp         58 -  59
  str dob_m        60 -  61  str dob_y_p      62 -  65
      age_p        66 -  67      age_chg      68 -  68

  str fmrpflg      69 -  69  str fmreflg      70 -  70
      r_maritl     71 -  71  str fspous2      72 -  73
      cohab1       74 -  74      cohab2       75 -  75
  str fcohab3      76 -  77      cdcmstat     78 -  78
      sib_deg      79 -  79  str fmother      80 -  81
      mom_deg      82 -  82  str ffather      83 -  84
      dad_deg      85 -  85      parents      86 -  86
      mom_ed       87 -  88      dad_ed       89 -  90
      astatflg     91 -  91      cstatflg     92 -  92
      qcadult      93 -  93      qcchild      94 -  94

      plaplylm     95 -  95      plaplyun     96 -  96
      pspedeis     97 -  97      pspedem      98 -  98
      plaadl       99 -  99      labath      100 - 100
      ladress     101 - 101      laeat       102 - 102
      labed       103 - 103      latoilt     104 - 104
      lahome      105 - 105      plaiadl     106 - 106
      plawknow    107 - 107      plawklim    108 - 108
      plawalk     109 - 109      plaremem    110 - 110
      plimany     111 - 111      la1ar       112 - 112
      lahcc1      113 - 113      lahcc2      114 - 114
      lahcc3      115 - 115      lahcc4      116 - 116
      lahcc5      117 - 117      lahcc6      118 - 118
      lahcc7      119 - 119      lahcc8      120 - 120
      lahcc9      121 - 121      lahcc10     122 - 122
      lahcc11     123 - 123      lahcc12     124 - 124
      lahcc13     125 - 125      lahcc90     126 - 126
      lahcc91     127 - 127      lctime1     128 - 129
      lcunit1     130 - 130      lcdura1     131 - 132
      lcdurb1     133 - 133      lcchrc1     134 - 134
      lctime2     135 - 136      lcunit2     137 - 137
      lcdura2     138 - 139      lcdurb2     140 - 140
      lcchrc2     141 - 141      lctime3     142 - 143
      lcunit3     144 - 144      lcdura3     145 - 146
      lcdurb3     147 - 147      lcchrc3     148 - 148
      lctime4     149 - 150      lcunit4     151 - 151
      lcdura4     152 - 153      lcdurb4     154 - 154
      lcchrc4     155 - 155      lctime5     156 - 157
      lcunit5     158 - 158      lcdura5     159 - 160
      lcdurb5     161 - 161      lcchrc5     162 - 162
      lctime6     163 - 164      lcunit6     165 - 165
      lcdura6     166 - 167      lcdurb6     168 - 168
      lcchrc6     169 - 169      lctime7     170 - 171
      lcunit7     172 - 172      lcdura7     173 - 174
      lcdurb7     175 - 175      lcchrc7     176 - 176
      lctime8     177 - 178      lcunit8     179 - 179
      lcdura8     180 - 181      lcdurb8     182 - 182
      lcchrc8     183 - 183      lctime9     184 - 185
      lcunit9     186 - 186      lcdura9     187 - 188
      lcdurb9     189 - 189      lcchrc9     190 - 190
      lctime10    191 - 192      lcunit10    193 - 193
      lcdura10    194 - 195      lcdurb10    196 - 196
      lcchrc10    197 - 197      lctime11    198 - 199
      lcunit11    200 - 200      lcdura11    201 - 202
      lcdurb11    203 - 203      lcchrc11    204 - 204
      lctime12    205 - 206      lcunit12    207 - 207
      lcdura12    208 - 209      lcdurb12    210 - 210
      lcchrc12    211 - 211      lctime13    212 - 213
      lcunit13    214 - 214      lcdura13    215 - 216
      lcdurb13    217 - 217      lcchrc13    218 - 218
      lctime90    219 - 220      lcunit90    221 - 221
      lcdura90    222 - 223      lcdurb90    224 - 224
      lcchrc90    225 - 225      lctime91    226 - 227
      lcunit91    228 - 228      lcdura91    229 - 230
      lcdurb91    231 - 231      lcchrc91    232 - 232
      lahca1      233 - 233      lahca2      234 - 234
      lahca3      235 - 235      lahca4      236 - 236
      lahca5      237 - 237      lahca6      238 - 238
      lahca7      239 - 239      lahca8      240 - 240
      lahca9      241 - 241      lahca10     242 - 242
      lahca11     243 - 243      lahca12     244 - 244
      lahca13     245 - 245      lahca14     246 - 246
      lahca15     247 - 247      lahca16     248 - 248
      lahca17     249 - 249      lahca18     250 - 250
      lahca19_    251 - 251      lahca20_    252 - 252
      lahca21_    253 - 253      lahca22_    254 - 254
      lahca23_    255 - 255      lahca24_    256 - 256
      lahca25_    257 - 257      lahca26_    258 - 258
      lahca27_    259 - 259      lahca28_    260 - 260
      lahca29_    261 - 261      lahca30_    262 - 262
      lahca31_    263 - 263      lahca32_    264 - 264
      lahca33_    265 - 265      lahca34_    266 - 266
      lahca90     267 - 267      lahca91     268 - 268
      latime1     269 - 270      launit1     271 - 271
      ladura1     272 - 273      ladurb1     274 - 274
      lachrc1     275 - 275      latime2     276 - 277
      launit2     278 - 278      ladura2     279 - 280
      ladurb2     281 - 281      lachrc2     282 - 282
      latime3     283 - 284      launit3     285 - 285
      ladura3     286 - 287      ladurb3     288 - 288
      lachrc3     289 - 289      latime4     290 - 291
      launit4     292 - 292      ladura4     293 - 294
      ladurb4     295 - 295      lachrc4     296 - 296
      latime5     297 - 298      launit5     299 - 299
      ladura5     300 - 301      ladurb5     302 - 302
      lachrc5     303 - 303      latime6     304 - 305
      launit6     306 - 306      ladura6     307 - 308
      ladurb6     309 - 309      lachrc6     310 - 310
      latime7     311 - 312      launit7     313 - 313
      ladura7     314 - 315      ladurb7     316 - 316
      lachrc7     317 - 317      latime8     318 - 319
      launit8     320 - 320      ladura8     321 - 322
      ladurb8     323 - 323      lachrc8     324 - 324
      latime9     325 - 326      launit9     327 - 327
      ladura9     328 - 329      ladurb9     330 - 330
      lachrc9     331 - 331      latime10    332 - 333
      launit10    334 - 334      ladura10    335 - 336
      ladurb10    337 - 337      lachrc10    338 - 338
      latime11    339 - 340      launit11    341 - 341
      ladura11    342 - 343      ladurb11    344 - 344
      lachrc11    345 - 345      latime12    346 - 347
      launit12    348 - 348      ladura12    349 - 350
      ladurb12    351 - 351      lachrc12    352 - 352
      latime13    353 - 354      launit13    355 - 355
      ladura13    356 - 357      ladurb13    358 - 358
      lachrc13    359 - 359      latime14    360 - 361
      launit14    362 - 362      ladura14    363 - 364
      ladurb14    365 - 365      lachrc14    366 - 366
      latime15    367 - 368      launit15    369 - 369
      ladura15    370 - 371      ladurb15    372 - 372
      lachrc15    373 - 373      latime16    374 - 375
      launit16    376 - 376      ladura16    377 - 378
      ladurb16    379 - 379      lachrc16    380 - 380
      latime17    381 - 382      launit17    383 - 383
      ladura17    384 - 385      ladurb17    386 - 386
      lachrc17    387 - 387      latime18    388 - 389
      launit18    390 - 390      ladura18    391 - 392
      ladurb18    393 - 393      lachrc18    394 - 394
      latime19    395 - 396      launit19    397 - 397
      ladura19    398 - 399      ladurb19    400 - 400
      lachrc19    401 - 401      latime20    402 - 403
      launit20    404 - 404      ladura20    405 - 406
      ladurb20    407 - 407      lachrc20    408 - 408
      latime21    409 - 410      launit21    411 - 411
      ladura21    412 - 413      ladurb21    414 - 414
      lachrc21    415 - 415      latime22    416 - 417
      launit22    418 - 418      ladura22    419 - 420
      ladurb22    421 - 421      lachrc22    422 - 422
      latime23    423 - 424      launit23    425 - 425
      ladura23    426 - 427      ladurb23    428 - 428
      lachrc23    429 - 429      latime24    430 - 431
      launit24    432 - 432      ladura24    433 - 434
      ladurb24    435 - 435      lachrc24    436 - 436
      latime25    437 - 438      launit25    439 - 439
      ladura25    440 - 441      ladurb25    442 - 442
      lachrc25    443 - 443      latime26    444 - 445
      launit26    446 - 446      ladura26    447 - 448
      ladurb26    449 - 449      lachrc26    450 - 450
      latime27    451 - 452      launit27    453 - 453
      ladura27    454 - 455      ladurb27    456 - 456
      lachrc27    457 - 457      latime28    458 - 459
      launit28    460 - 460      ladura28    461 - 462
      ladurb28    463 - 463      lachrc28    464 - 464
      latime29    465 - 466      launit29    467 - 467
      ladura29    468 - 469      ladurb29    470 - 470
      lachrc29    471 - 471      latime30    472 - 473
      launit30    474 - 474      ladura30    475 - 476
      ladurb30    477 - 477      lachrc30    478 - 478
      latime31    479 - 480      launit31    481 - 481
      ladura31    482 - 483      ladurb31    484 - 484
      lachrc31    485 - 485      latime32    486 - 487
      launit32    488 - 488      ladura32    489 - 490
      ladurb32    491 - 491      lachrc32    492 - 492
      latime33    493 - 494      launit33    495 - 495
      ladura33    496 - 497      ladurb33    498 - 498
      lachrc33    499 - 499      latime34    500 - 501
      launit34    502 - 502      ladura34    503 - 504
      ladurb34    505 - 505      lachrc34    506 - 506
      latime90    507 - 508      launit90    509 - 509
      ladura90    510 - 511      ladurb90    512 - 512
      lachrc90    513 - 513      latime91    514 - 515
      launit91    516 - 516      ladura91    517 - 518
      ladurb91    519 - 519      lachrc91    520 - 520
      lcondrt     521 - 521      lachronr    522 - 522
      phstat      523 - 523

      pdmed12m    524 - 524      pnmed12m    525 - 525
      phospyr2    526 - 526      hospno      527 - 529
      hpnite      530 - 532      phchm2w     533 - 533
      phchmn2w    534 - 535      phcph2wr    536 - 536
      phcphn2w    537 - 538      phcdv2w     539 - 539
      phcdvn2w    540 - 541      p10dvyr     542 - 542

      notcov      543 - 543      medicare    544 - 544
      mcpart      545 - 545      mcchoice    546 - 546
      mchmo       547 - 547      mcnamen     548 - 549
      mcref       550 - 550      mcpaypre    551 - 551
      mcpartd     552 - 552      medicaid    553 - 553
      machmd      554 - 554      mapcmd      555 - 555
      maref       556 - 556      single      557 - 557
      sstypea     558 - 558      sstypeb     559 - 559
      sstypec     560 - 560      sstyped     561 - 561
      sstypee     562 - 562      sstypef     563 - 563
      sstypeg     564 - 564      sstypeh     565 - 565
      sstypei     566 - 566      sstypej     567 - 567
      sstypek     568 - 568      sstypel     569 - 569
      private     570 - 570      hitypen1    571 - 571
      whonam1     572 - 572      plnwrkn1    573 - 574
      plnpay11    575 - 575      plnpay21    576 - 576
      plnpay31    577 - 577      plnpay41    578 - 578
      plnpay51    579 - 579      plnpay61    580 - 580
      plnpay71    581 - 581      hicostr1    582 - 586
      plnmgd1     587 - 587      hdhp1       588 - 588
      hsahra1     589 - 589      mgchmd1     590 - 590
      mgprmd1     591 - 591      mgpymd1     592 - 592
      mgpref1     593 - 593      prrxcov1    594 - 594
      prdncov1    595 - 595      hitypen2    596 - 596
      whonam2     597 - 597      plnwrkn2    598 - 599
      plnpay12    600 - 600      plnpay22    601 - 601
      plnpay32    602 - 602      plnpay42    603 - 603
      plnpay52    604 - 604      plnpay62    605 - 605
      plnpay72    606 - 606      hicostr2    607 - 611
      plnmgd2     612 - 612      hdhp2       613 - 613
      hsahra2     614 - 614      mgchmd2     615 - 615
      mgprmd2     616 - 616      mgpymd2     617 - 617
      mgpref2     618 - 618      prrxcov2    619 - 619
      prdncov2    620 - 620      prplplus    621 - 621
      schip       622 - 622      stdoc1      623 - 623
      stpcmd1     624 - 624      stref1      625 - 625
      othpub      626 - 626      stdoc2      627 - 627
      stpcmd2     628 - 628      stref2      629 - 629
      othgov      630 - 630      stdoc3      631 - 631
      stpcmd3     632 - 632      stref3      633 - 633
      milcare     634 - 634      milspc1     635 - 635
      milspc2     636 - 636      milspc3     637 - 637
      milspc4     638 - 638      milman      639 - 639
      ihs         640 - 640      hilast      641 - 641
      histop1     642 - 642      histop2     643 - 643
      histop3     644 - 644      histop4     645 - 645
      histop5     646 - 646      histop6     647 - 647
      histop7     648 - 648      histop8     649 - 649
      histop9     650 - 650      histop10    651 - 651
      histop11    652 - 652      histop12    653 - 653
      histop13    654 - 654      histop14    655 - 655
      histop15    656 - 656      hinotyr     657 - 657
      hinotmyr    658 - 659      hcspfyr     660 - 660
      fsa         661 - 661      hikindna    662 - 662
      hikindnb    663 - 663      hikindnc    664 - 664
      hikindnd    665 - 665      hikindne    666 - 666
      hikindnf    667 - 667      hikindng    668 - 668
      hikindnh    669 - 669      hikindni    670 - 670
      hikindnj    671 - 671      hikindnk    672 - 672
      mcareprb    673 - 673      mcaidprb    674 - 674
      sincov      675 - 675

      plborn      676 - 676      regionbr    677 - 678
      geobrth     679 - 679      yrsinus     680 - 680
      citizenp    681 - 681      headst      682 - 682
      headstv1    683 - 683      educ1       684 - 685
      pmiltry     686 - 686      doinglwp    687 - 687
      whynowkp    688 - 689      wrkhrs2     690 - 691
      wrkftall    692 - 692      wrklyr1     693 - 693
      wrkmyr      694 - 695      ernyr_p     696 - 697
      hiempof     698 - 698

      fincint     699 - 699      psal        700 - 700
      pseinc      701 - 701      pssrr       702 - 702
      pssrrdb     703 - 703      pssrrd      704 - 704
      ppens       705 - 705      popens      706 - 706
      pssi        707 - 707      pssid       708 - 708
      ptanf       709 - 709      powben      710 - 710
      pintrstr    711 - 711      pdivd       712 - 712
      pchldsp     713 - 713      pincot      714 - 714
      pssapl      715 - 715      psdapl      716 - 716
      tanfmyr     717 - 718      pfstp       719 - 719
      fstpmyr     720 - 721      eligpwic    722 - 722
      pwic        723 - 723      wic_flag    724 - 724

using $mdata/raw/nhis//2009/personsx.dat;
replace wtia = wtia/10;

* DEFINE VARIABLE LABELS;

label variable rectype  "IDN.000_00.000: File type identifier";
label variable srvy_yr  "
IDN.000_02.000: Year of National Health Interview Survey";
label variable hhx      "IDN.000_04.000: Household Serial Number";
label variable intv_qrt "IDN.000_25.000: Interview Quarter";
label variable assignwk "IDN.000_30.000: Assignment Week";
label variable fmx      "IDN.000_35.000: Family #";
label variable fpx      "IDN.000_40.000: Person Number (Within family)";
label variable wtia     "IDN.000_65.000: Weight - Interim Annual";
label variable wtfa     "IDN.000_70.000: Weight - Final Annual";

label variable region   "UCF.000_00.000: Region";
label variable strat_p  "
UCF.000_00.000: Pseudo-stratum for public-use file variance estimation";
label variable psu_p    "
UCF.000_00.000: Pseudo-PSU for public-use file variance estimation";

label variable sex      "HHC.110_00.000: Sex";
label variable origin_i "HHC.170_00.000: Hispanic Ethnicity";
label variable origimpt "HHC.170_00.000: Hispanic Origin Imputation Flag";
label variable hispan_i "HHC.180_00.000: Hispanic subgroup detail";
label variable hispimpt "HHC.180_00.000: Type of Hispanic Origin Imputation Flag
";
label variable racerpi2 "HHC.200_01.000: OMB groups w/multiple race";
label variable raceimp2 "HHC.200_01.000: Race Imputation Flag";
label variable mracrpi2 "
HHC.200_01.000: Race coded to single/multiple race group";
label variable mracbpi2 "
HHC.200_01.000: Race coded to single/multiple race group";
label variable racreci3 "HHC.200_01.000: Race Recode";
label variable hiscodi3 "HHC.200_01.000: Race/ethnicity recode";
label variable erimpflg "HHC.200_01.000: Ethnicity/Race Imputation Flag";
label variable nowaf    "HHC.230_03.000: Armed Forces Status";
label variable rrp      "HHC.260_01.000: Relationship to the HH reference person
";
label variable hhreflg  "HHC.260_01.000: HH Reference Person Flag";
label variable frrp     "HHC.260_02.000: Relationship to family ref. Person";
label variable dob_m    "HHC.405_00.000: Month of Birth";
label variable dob_y_p  "HHC.415_00.000: Year of Birth";
label variable age_p    "HHC.420_00.000: Age";
label variable age_chg  "
HHC.425_00.000: Indication of AGE correction due to data entry error";

label variable fmrpflg  "FID.060_00.000: Family Respondent Flag";
label variable fmreflg  "FID.060_00.000: Family Reference Person Flag";
label variable r_maritl "FID.250_00.000: Marital Status";
label variable fspous2  "FID.270_00.000: Person # of spouse";
label variable cohab1   "FID.280_00.000: Cohabiting person ever married";
label variable cohab2   "
FID.290_00.000: Cohabiting person's current marital status";
label variable fcohab3  "FID.300_00.000: Person # of partner";
label variable cdcmstat "FID.300_00.000: CDC standard for legal marital status";
label variable sib_deg  "FID.300_00.000: Degree of sib rel to HH ref person";
label variable fmother  "FID.326_00.000: Person # of mother";
label variable mom_deg  "FID.330_01.000: Type of relationship with Mother";
label variable ffather  "FID.340_00.000: Person # of father";
label variable dad_deg  "FID.350_01.000: Type of relationship with Father";
label variable parents  "FID: Parent(s) present in the family";
label variable mom_ed   "FID: Education of Mother";
label variable dad_ed   "FID: Education of Father";
label variable astatflg "FID: Sample Adult Flag";
label variable cstatflg "FID: Sample Child Flag";
label variable qcadult  "FID.580_00.000: Quality control flag for sample adult";
label variable qcchild  "FID.590_00.000: Quality control flag for sample child";

label variable plaplylm "FHS.010_00.000: Is - - limited in kind/amount play?";
label variable plaplyun "FHS.020_00.000: Is - - able to play at all?";
label variable pspedeis "
FHS.060_00.000: Does - - receive Special Education or EIS";
label variable pspedem  "
FHS.065_00.000: Receive Special Education/EIS due to emotional/behavioral proble
m";
label variable plaadl   "FHS.080_00.000: Does - - need help with personal care?
";
label variable labath   "
FHS.090_01.000: Does - -  need help with bathing/showering?";
label variable ladress  "FHS.090_02.000: Does - -  need help dressing?";
label variable laeat    "FHS.090_03.000: Does - -  need help eating?";
label variable labed    "
FHS.090_04.000: Does - -  need help in/out of bed or chairs?";
label variable latoilt  "FHS.090_05.000: Does - -  need help using the toilet?";
label variable lahome   "
FHS.090_06.000: Does - -  need help to get around in the home?";
label variable plaiadl  "FHS.160_00.000: Does - - need help with routine needs?
";
label variable plawknow "
FHS.180_00.000: Is - - unable to work NOW due to health problem?";
label variable plawklim "FHS.200_00.000: Is - - limited in kind/amount of work?
";
label variable plawalk  "
FHS.220_00.000: Does - - have difficulty walking without equipment?";
label variable plaremem "
FHS.240_00.000: Is - - limited by difficulty remembering?";
label variable plimany  "FHS.260_00.000: Is - - limited in any (other) way?";
label variable la1ar    "FHS: Any limitation - all persons, all conditions";
label variable lahcc1   "FHS.270_01.000: Vision problem causes limitation";
label variable lahcc2   "FHS.270_02.000: Hearing problem causes limitation";
label variable lahcc3   "FHS.270_03.000: Speech problem causes limitation";
label variable lahcc4   "
FHS.270_04.000: Asthma/breathing problem causes limitation";
label variable lahcc5   "FHS.270_05.000: Birth defect causes limitation";
label variable lahcc6   "FHS.270_06.000: Injury causes limitation";
label variable lahcc7   "FHS.270_07.000: Mental retardation causes limitation";
label variable lahcc8   "
FHS.270_08.000: Other developmental problem causes limitation";
label variable lahcc9   "
FHS.270_09.000: Other mental/emotional/behavioral problem causes limitation";
label variable lahcc10  "
FHS.270_10.000: Bone/joint/muscle problem causes limitation";
label variable lahcc11  "FHS.270_11.000: Epilepsy/seizures causes limitation";
label variable lahcc12  "FHS.270_12.000: Learning disability causes  limitation
";
label variable lahcc13  "FHS.270_13.000: ADD/ADHD causes limitation";
label variable lahcc90  "
FHS.270_90.000: Other impairment/problem (1) causes limitation";
label variable lahcc91  "
FHS.270_91.000: Other impairment/problem (2) causes limitation";
label variable lctime1  "
FHS.280_01.000: Duration of vision problem: Number of units";
label variable lcunit1  "FHS.280_02.000: Duration of vision problem: Time unit";
label variable lcdura1  "FHS.280_02.000: Duration of vision problem (in years)";
label variable lcdurb1  "FHS.280_02.000: Duration of vision problem recode 2";
label variable lcchrc1  "FHS.280_02.000: Vision problem condition status";
label variable lctime2  "
FHS.282_01.000: Duration of hearing problem: Number of units";
label variable lcunit2  "FHS.282_02.000: Duration of hearing problem: Time unit
";
label variable lcdura2  "FHS.282_02.000: Duration of hearing problem (in years)
";
label variable lcdurb2  "FHS.282_02.000: Duration of hearing problem recode 2";
label variable lcchrc2  "FHS.282_02.000: Hearing problem condition status";
label variable lctime3  "
FHS.284_01.000: Duration of speech problem: Number of units";
label variable lcunit3  "FHS.284_02.000: Duration of speech problem: Time unit";
label variable lcdura3  "FHS.284_02.000: Duration of speech problem (in years)";
label variable lcdurb3  "FHS.284_02.000: Duration of speech problem recode 2";
label variable lcchrc3  "FHS.284_02.000: Speech problem condition status";
label variable lctime4  "
FHS.286_01.000: Duration of asthma/breathing problem: Number of units";
label variable lcunit4  "
FHS.286_02.000: Duration of asthma/breathing problem: Time unit";
label variable lcdura4  "
FHS.286_02.000: Duration of asthma/breathing problem (in years)";
label variable lcdurb4  "
FHS.286_02.000: Duration of asthma/breathing problem recode 2";
label variable lcchrc4  "
FHS.286_02.000: Asthma/breathing problem condition status";
label variable lctime5  "
FHS.287_01.000: Duration of birth defect: Number of units";
label variable lcunit5  "FHS.287_02.000: Duration of birth defect: Time unit";
label variable lcdura5  "FHS.287_02.000: Duration of birth defect (in years)";
label variable lcdurb5  "FHS.287_02.000: Duration of birth defect recode 2";
label variable lcchrc5  "FHS.287_02.000: Birth defect condition status";
label variable lctime6  "FHS.288_01.000: Duration of injury: Number of units";
label variable lcunit6  "FHS.288_02.000: Duration of injury: Time unit";
label variable lcdura6  "FHS.288_02.000: Duration of injury (in years)";
label variable lcdurb6  "FHS.288_02.000: Duration of injury recode 2";
label variable lcchrc6  "FHS.288_02.000: Injury condition status";
label variable lctime7  "
FHS.290_01.000: Duration of mental retardation: Number of units";
label variable lcunit7  "
FHS.290_02.000: Duration of mental retardation: Time unit";
label variable lcdura7  "
FHS.290_02.000: Duration of mental retardation (in years)";
label variable lcdurb7  "FHS.290_02.000: Duration of mental retardation recode 2
";
label variable lcchrc7  "FHS.290_02.000: Mental retardation condition status";
label variable lctime8  "
FHS.292_01.000: Duration of other developmental problem: Number of units";
label variable lcunit8  "
FHS.292_02.000: Duration of other developmental problem: Time unit";
label variable lcdura8  "
FHS.292_02.000: Duration of other developmental problem (in years)";
label variable lcdurb8  "
FHS.292_02.000: Duration of other developmental problem recode 2";
label variable lcchrc8  "
FHS.292_02.000: Other developmental problem condition status";
label variable lctime9  "
FHS.294_01.000: Duration of other mental/emotional/behavioral  problem: Number o
f units";
label variable lcunit9  "
FHS.294_02.000: Duration of other mental/emotional/behavioral  problem: Number o
f units";
label variable lcdura9  "
FHS.294_02.000: Duration of other mental/emotional/behavioral  problem (in years
)";
label variable lcdurb9  "
FHS.294_02.000: Duration of other mental/emotional/behavioral problem recode 2";
label variable lcchrc9  "
FHS.294_02.000: Other mental/emotional/behavioral problem condition status";
label variable lctime10 "
FHS.296_01.000: Duration of bone/joint/muscle problem: Number of units";
label variable lcunit10 "
FHS.296_02.000: Duration of bone/joint/muscle problem: Time unit";
label variable lcdura10 "
FHS.296_02.000: Duration of bone/joint/muscle problem (in years)";
label variable lcdurb10 "
FHS.296_02.000: Duration of bone/joint/muscle problem recode 2";
label variable lcchrc10 "
FHS.296_02.000: Bone/joint/muscle problem condition status";
label variable lctime11 "
FHS.298_01.000: Duration of epilepsy/seizures: Number of units";
label variable lcunit11 "
FHS.298_02.000: Duration of epilepsy/seizures: Time unit";
label variable lcdura11 "
FHS.298_02.000: Duration of epilepsy/seizures (in years)";
label variable lcdurb11 "FHS.298_02.000: Duration of epilepsy/seizures recode 2
";
label variable lcchrc11 "FHS.298_02.000: Epilepsy/seizures condition status";
label variable lctime12 "
FHS.300_01.000: Duration of learning disability: Number of units";
label variable lcunit12 "
FHS.300_02.000: Duration of learning disability: Time unit";
label variable lcdura12 "
FHS.300_02.000: Duration of learning disability (in years)";
label variable lcdurb12 "
FHS.300_02.000: Duration of learning disability recode 2";
label variable lcchrc12 "FHS.300_02.000: Learning disability condition status";
label variable lctime13 "FHS.302_01.000: Duration of ADD/ADHD: Number of units";
label variable lcunit13 "FHS.302_02.000: Duration of ADD/ADHD: Time unit";
label variable lcdura13 "FHS.302_02.000: Duration of ADD/ADHD (in years)";
label variable lcdurb13 "FHS.302_02.000: Duration of ADD/ADHD recode 2";
label variable lcchrc13 "FHS.302_02.000: ADD/ADHD condition status";
label variable lctime90 "
FHS.304_01.000: Duration of other impairment problem (1): Number of units";
label variable lcunit90 "
FHS.304_02.000: Duration of other impairment/problem (1): Time unit";
label variable lcdura90 "
FHS.304_02.000: Duration of other impairment/problem (1) (in years)";
label variable lcdurb90 "
FHS.304_02.000: Duration of other impairment/problem (1) recode 2";
label variable lcchrc90 "
FHS.304_02.000: Other impairment/problem (1) condition status";
label variable lctime91 "
FHS.306_01.000: Duration of other impairment/problem (2): Number of units";
label variable lcunit91 "
FHS.306_02.000: Duration of other impairment/problem (2): Time unit";
label variable lcdura91 "
FHS.306_02.000: Duration of other impairment/problem (2) (in years)";
label variable lcdurb91 "
FHS.306_02.000: Duration of other impairment/problem (2) recode 2";
label variable lcchrc91 "
FHS.306_02.000: Other impairment/problem (2) condition status";
label variable lahca1   "FHS.350_01.000: Vision problem causes limitation";
label variable lahca2   "FHS.350_02.000: Hearing problem causes limitation";
label variable lahca3   "FHS.350_03.000: Arthritis/rheumatism causes limitation
";
label variable lahca4   "FHS.350_04.000: Back/neck problem causes limitation";
label variable lahca5   "
FHS.350_05.000: Fracture/bone/joint injury causes limitation";
label variable lahca6   "FHS.350_06.000: Other injury causes limitation";
label variable lahca7   "FHS.350_07.000: Heart problem causes limitation";
label variable lahca8   "FHS.350_08.000: Stroke causes limitation";
label variable lahca9   "FHS.350_09.000: Hypertension causes limitation";
label variable lahca10  "FHS.350_10.000: Diabetes causes limitation";
label variable lahca11  "
FHS.350_11.000: Lung/breathing problem causes limitation";
label variable lahca12  "FHS.350_12.000: Cancer causes limitation";
label variable lahca13  "FHS.350_13.000: Birth defect causes limitation";
label variable lahca14  "FHS.350_14.000: Mental retardation causes limitation";
label variable lahca15  "
FHS.350_15.000: Other developmental problem causes limitation";
label variable lahca16  "FHS.350_16.000: Senility causes limitation";
label variable lahca17  "
FHS.350_17.000: Depression/anxiety/emotional problem causes limitation";
label variable lahca18  "FHS.350_18.000: Weight problem causes limitation";
label variable lahca19_ "
FHS.350_18.000: Missing or amputated limb/finger/digit causes limitation";
label variable lahca20_ "
FHS.350_18.000: Musculoskeletal/connective tissue problem causes limitation";
label variable lahca21_ "FHS.350_18.000: Circulation problem causes limitation";
label variable lahca22_ "
FHS.350_18.000: Endocrine/nutritional/metabolic problem causes limitation";
label variable lahca23_ "
FHS.350_18.000: Nervous system/sensory organ condition causes limitation";
label variable lahca24_ "
FHS.350_18.000: Digestive system problem causes limitation";
label variable lahca25_ "
FHS.350_18.000: Genitourinary system problem causes limitation";
label variable lahca26_ "
FHS.350_18.000: Skin/subcutaneous system problem causes limitation";
label variable lahca27_ "
FHS.350_18.000: Blood or blood-forming organ problem causes limitation";
label variable lahca28_ "FHS.350_18.000: Benign tumor/cyst causes limitation";
label variable lahca29_ "
FHS.350_18.000: Alcohol/drug/substance abuse problem causes limitation";
label variable lahca30_ "
FHS.350_18.000: Other mental problem/ADD/bipolar/schizophrenia causes limitation
";
label variable lahca31_ "
FHS.350_18.000: Surgical after-effects/medical treatment causes limitation";
label variable lahca32_ "
FHS.350_18.000: 'Old age'/elderly/aging-related problem causes limitation";
label variable lahca33_ "
FHS.350_18.000: Fatigue/tiredness/weakness causes limitation";
label variable lahca34_ "
FHS.350_18.000: Pregnancy-related problem causes limitation";
label variable lahca90  "
FHS.350_90.000: Other impairment/problem(1) causes limitation";
label variable lahca91  "
FHS.350_91.000: Other impairment/problem(2) causes limitation";
label variable latime1  "
FHS.360_01.000: Duration of vision problem: Number of units";
label variable launit1  "FHS.360_02.000: Duration of vision problem: Time unit";
label variable ladura1  "FHS.360_02.000: Duration of vision problem (in years)";
label variable ladurb1  "FHS.360_02.000: Duration of vision problem recode 2";
label variable lachrc1  "FHS.360_02.000: Vision problem condition status";
label variable latime2  "
FHS.362_01.000: Duration of hearing problem: Number of units";
label variable launit2  "FHS.362_02.000: Duration of hearing problem: Time unit
";
label variable ladura2  "FHS.362_02.000: Duration of hearing problem (in years)
";
label variable ladurb2  "FHS.362_02.000: Duration of hearing problem recode 2";
label variable lachrc2  "FHS.362_02.000: Hearing problem condition status";
label variable latime3  "
FHS.364_01.000: Duration of arthritis/rheumatism: Number of units";
label variable launit3  "
FHS.364_02.000: Duration of arthritis/rheumatism: Time unit";
label variable ladura3  "
FHS.364_02.000: Duration of arthritis/rheumatism (in years)";
label variable ladurb3  "
FHS.364_02.000: Duration of arthritis/rheumatism recode 2";
label variable lachrc3  "FHS.364_02.000: Arthritis/rheumatism condition status";
label variable latime4  "
FHS.366_01.000: Duration of back/neck problem: Number of units";
label variable launit4  "
FHS.366_02.000: Duration of back/neck problem: Time unit";
label variable ladura4  "
FHS.366_02.000: Duration of back/neck problem (in years)";
label variable ladurb4  "FHS.366_02.000: Duration of back/neck problem recode 2
";
label variable lachrc4  "FHS.366_02.000: Back/neck problem condition status";
label variable latime5  "
FHS.368_01.000: Duration of fracture/bone/joint injury: Number of units";
label variable launit5  "
FHS.368_02.000: Duration of fracture/bone/joint injury: Time unit";
label variable ladura5  "
FHS.368_02.000: Duration of fracture/bone/joint injury (in years)";
label variable ladurb5  "
FHS.368_02.000: Duration of fracture/bone/joint injury recode 2";
label variable lachrc5  "
FHS.368_02.000: Fracture/bone/joint injury condition status";
label variable latime6  "
FHS.370_01.000: Duration of other injury: Number of units";
label variable launit6  "FHS.370_02.000: Duration of other injury: Time unit";
label variable ladura6  "FHS.370_02.000: Duration of other injury (in years)";
label variable ladurb6  "FHS.370_02.000: Duration of other injury recode 2";
label variable lachrc6  "FHS.370_02.000: Other injury condition status";
label variable latime7  "
FHS.372_01.000: Duration of heart problem: Number of units";
label variable launit7  "FHS.372_02.000: Duration of heart problem: Time unit";
label variable ladura7  "FHS.372_02.000: Duration of heart problem (in years)";
label variable ladurb7  "FHS.372_02.000: Duration of heart problem recode 2";
label variable lachrc7  "FHS.372_02.000: Heart problem condition status";
label variable latime8  "FHS.374_01.000: Duration of stroke: Number of units";
label variable launit8  "FHS.374_02.000: Duration of stroke: Time unit";
label variable ladura8  "FHS.374_02.000: Duration of stroke (in years)";
label variable ladurb8  "FHS.374_02.000: Duration of stroke recode 2";
label variable lachrc8  "FHS.374_02.000: Stroke condition status";
label variable latime9  "
FHS.376_01.000: Duration of hypertension: Number of units";
label variable launit9  "FHS.376_02.000: Duration of hypertension: Time unit";
label variable ladura9  "FHS.376_02.000: Duration of hypertension (in years)";
label variable ladurb9  "FHS.376_02.000: Duration of hypertension recode 2";
label variable lachrc9  "FHS.376_02.000: Hypertension condition status";
label variable latime10 "FHS.378_01.000: Duration of diabetes: Number of units";
label variable launit10 "FHS.378_02.000: Duration of diabetes: Time unit";
label variable ladura10 "FHS.378_02.000: Duration of diabetes (in years)";
label variable ladurb10 "FHS.378_02.000: Duration of diabetes recode 2";
label variable lachrc10 "FHS.378_02.000: Diabetes condition status";
label variable latime11 "
FHS.380_01.000: Duration of lung/breathing problem: Number of units";
label variable launit11 "
FHS.380_02.000: Duration of lung/breathing problem: Time unit";
label variable ladura11 "
FHS.380_02.000: Duration of lung/breathing problem (in years)";
label variable ladurb11 "
FHS.380_02.000: Duration of lung/breathing problem recode 2";
label variable lachrc11 "FHS.380_02.000: Lung/breathing problem condition status
";
label variable latime12 "FHS.382_01.000: Duration of cancer: Number of units";
label variable launit12 "FHS.382_02.000: Duration of cancer: Time unit";
label variable ladura12 "FHS.382_02.000: Duration of cancer (in years)";
label variable ladurb12 "FHS.382_02.000: Duration of cancer recode 2";
label variable lachrc12 "FHS.382_02.000: Cancer condition status";
label variable latime13 "
FHS.383_01.000: Duration of birth defect: Number of units";
label variable launit13 "FHS.383_02.000: Duration of birth defect: Time unit";
label variable ladura13 "FHS.383_02.000: Duration of birth defect (in years)";
label variable ladurb13 "FHS.383_02.000: Duration of birth defect recode 2";
label variable lachrc13 "FHS.383_02.000: Birth defect condition status";
label variable latime14 "
FHS.384_01.000: Duration of mental retardation: Number of units";
label variable launit14 "
FHS.384_02.000: Duration of mental retardation: Time unit";
label variable ladura14 "
FHS.384_02.000: Duration of mental retardation (in years)";
label variable ladurb14 "FHS.384_02.000: Duration of mental retardation recode 2
";
label variable lachrc14 "FHS.384_02.000: Mental retardation condition status";
label variable latime15 "
FHS.386_01.000: Duration of other developmental problem: Number of units";
label variable launit15 "
FHS.386_02.000: Duration of other developmental problem: Time unit";
label variable ladura15 "
FHS.386_02.000: Duration of other developmental problem (in years)";
label variable ladurb15 "
FHS.386_02.000: Duration of other developmental problem recode 2";
label variable lachrc15 "
FHS.386_02.000: Other developmental problem condition status";
label variable latime16 "FHS.388_01.000: Duration of senility: Number of units";
label variable launit16 "FHS.388_02.000: Duration of senility: Time unit";
label variable ladura16 "FHS.388_02.000: Duration of senility (in years)";
label variable ladurb16 "FHS.388_02.000: Duration of senility recode 2";
label variable lachrc16 "FHS.388_02.000: Senility condition status";
label variable latime17 "
FHS.390_01.000: Duration of depression/anxiety/emotional problem: Number of unit
s";
label variable launit17 "
FHS.390_02.000: Duration of depression/anxiety/emotional problem: Time unit";
label variable ladura17 "
FHS.390_02.000: Duration of depression/anxiety/emotional problem (in years)";
label variable ladurb17 "
FHS.390_02.000: Duration of depression/anxiety/emotional problem recode 2";
label variable lachrc17 "
FHS.390_02.000: Depression/anxiety/emotional problem condition status";
label variable latime18 "
FHS.392_01.000: Duration of weight problem: Number of units";
label variable launit18 "FHS.392_02.000: Duration of weight problem: Time unit";
label variable ladura18 "FHS.392_02.000: Duration of weight problem (in years)";
label variable ladurb18 "FHS.392_02.000: Duration of weight problem recode 2";
label variable lachrc18 "FHS.392_02.000: Weight problem condition status";
label variable latime19 "
FHS.394_01.000 RECOD: Duration of missing limb/amputation: Number of units";
label variable launit19 "
FHS.394_02.000 RECOD: Duration of missing limb/amputation: Time unit";
label variable ladura19 "
FHS.394_02.000: Duration of missing limb/amputation (in years)";
label variable ladurb19 "
FHS.394_02.000: Duration of missing limb/amputation recode 2";
label variable lachrc19 "
FHS.394_02.000: Missing limb/amputation condition status";
label variable latime20 "
FHS.396_01.000 RECOD: Duration of musculoskeletal problem: Number of units";
label variable launit20 "
FHS.396_02.000 RECOD: Duration of musculoskeletal problem: Time unit";
label variable ladura20 "
FHS.396_02.000: Duration of musculoskeletal problem (in years)";
label variable ladurb20 "
FHS.396_02.000: Duration of musculoskeletal problem recode 2";
label variable lachrc20 "
FHS.396_02.000: Musculoskeletal problem condition status";
label variable latime21 "
FHS.398_01.000 RECOD: Duration of circulation problem: Number of units";
label variable launit21 "
FHS.398_02.000 RECOD: Duration of circulation problem: Time unit";
label variable ladura21 "
FHS.398_02.000: Duration of circulation problem (in years)";
label variable ladurb21 "
FHS.398_02.000: Duration of circulation problem recode 2";
label variable lachrc21 "FHS.398_02.000: Circulation problem condition status";
label variable latime22 "
FHS.400_01.000 RECOD: Duration of endocrine problem: Number of units";
label variable launit22 "
FHS.400_02.000 RECOD: Duration of endocrine problem: Time unit";
label variable ladura22 "
FHS.400_02.000: Duration of endocrine problem (in years)";
label variable ladurb22 "FHS.400_02.000: Duration of endocrine problem recode 2
";
label variable lachrc22 "FHS.400_02.000: Endocrine problem condition status";
label variable latime23 "
FHS.402_01.000 RECOD: Duration of nervous system condition: Number of units";
label variable launit23 "
FHS.402_02.000 RECOD: Duration of nervous system condition: Time unit";
label variable ladura23 "
FHS.402_02.000: Duration of nervous system condition (in years)";
label variable ladurb23 "
FHS.402_02.000: Duration of nervous system condition recode 2";
label variable lachrc23 "FHS.402_02.000: Nervous system condition status";
label variable latime24 "
FHS.404_01.000 RECOD: Duration of digestive problems: Number of units";
label variable launit24 "
FHS.404_02.000 RECOD: Duration of digestive problems: Number of units";
label variable ladura24 "
FHS.404_02.000: Duration of digestive problems (in years)";
label variable ladurb24 "FHS.404_02.000: Duration of digestive problem recode 2
";
label variable lachrc24 "FHS.404_02.000: Digestive problem condition status";
label variable latime25 "
FHS.406_01.000 RECOD: Duration of genitourinary problem: Number of units";
label variable launit25 "
FHS.406_02.000 RECOD: Duration of genitourinary problem: Time unit";
label variable ladura25 "
FHS.406_02.000: Duration of genitourinary problem (in years)";
label variable ladurb25 "
FHS.406_02.000: Duration of genitourinary problem recode 2";
label variable lachrc25 "FHS.406_02.000: Genitourinary problem condition status
";
label variable latime26 "
FHS.408_01.000 RECOD: Duration of skin problems: Number of units";
label variable launit26 "
FHS.408_02.000 RECOD: Duration of skin problems: Time unit";
label variable ladura26 "FHS.408_02.000: Duration of skin problems (in years)";
label variable ladurb26 "FHS.408_02.000: Duration of skin problem recode 2";
label variable lachrc26 "FHS.408_02.000: Skin problems condition status";
label variable latime27 "
FHS.410_01.000 RECOD: Duration of blood problem: Number of units";
label variable launit27 "
FHS.410_02.000 RECOD: Duration of blood problem: Time unit";
label variable ladura27 "FHS.410_02.000: Duration of blood problem (in years)";
label variable ladurb27 "FHS.410_02.000: Duration of blood problem recode 2";
label variable lachrc27 "FHS.410_02.000: Blood problem condition status";
label variable latime28 "
FHS.412_01.000 RECOD: Duration of benign tumor: Number of units";
label variable launit28 "
FHS.412_02.000 RECOD: Duration of benign tumor: Time unit";
label variable ladura28 "FHS.412_02.000: Duration of benign tumor (in years)";
label variable ladurb28 "FHS.412_02.000: Duration of benign tumor recode 2";
label variable lachrc28 "FHS.412_02.000: Benign tumor condition status";
label variable latime29 "
FHS.414_01.000 RECOD: Duration of alcohol or drug problem: Number of units";
label variable launit29 "
FHS.414_02.000 RECOD: Duration of alcohol or drug problem: Time unit";
label variable ladura29 "
FHS.414_02.000: Duration of alcohol or drug problem (in years)";
label variable ladurb29 "
FHS.414_02.000: Duration of alcohol or drug problem recode 2";
label variable lachrc29 "
FHS.414_02.000: Alcohol or drug problem condition status";
label variable latime30 "
FHS.416_01.000 RECOD: Duration of other mental problem: Number of units";
label variable launit30 "
FHS.416_02.000 RECOD: Duration of other mental problem: Time unit";
label variable ladura30 "
FHS.416_02.000: Duration of other mental problem (in years)";
label variable ladurb30 "
FHS.416_02.000: Duration of other mental problem recode 2";
label variable lachrc30 "FHS.416_02.000: Other mental problem condition status";
label variable latime31 "
FHS.418_01.000 RECOD: Duration of surgical after-effects: Number of units";
label variable launit31 "
FHS.418_02.000 RECOD: Duration of surgical after-effects: Time unit";
label variable ladura31 "
FHS.418_02.000: Duration of surgical after-effects (in years)";
label variable ladurb31 "
FHS.418_02.000: Duration of surgical after-effects recode 2";
label variable lachrc31 "FHS.418_02.000: Surgical after-effects condition status
";
label variable latime32 "
FHS.420_01.000 RECOD: Duration of 'old age': Number of units";
label variable launit32 "
FHS.420_02.000 RECOD: Duration of 'old age': Number of units";
label variable ladura32 "FHS.420_02.000: Duration of 'old age' (in years)";
label variable ladurb32 "FHS.420_02.000: Duration of 'old age' recode 2";
label variable lachrc32 "FHS.420_02.000: 'Old age' condition status";
label variable latime33 "
FHS.422_01.000 RECOD: Duration of fatigue problem: Number of units";
label variable launit33 "
FHS.422_02.000 RECOD: Duration of fatigue problem: Time unit";
label variable ladura33 "FHS.422_02.000: Duration of fatigue problem (in years)
";
label variable ladurb33 "FHS.422_02.000: Duration of fatigue problem recode 2";
label variable lachrc33 "FHS.422_02.000: Fatigue problem condition status";
label variable latime34 "
FHS.424_01.000 RECOD: Duration of pregnancy-related problem: Number of units";
label variable launit34 "
FHS.424_02.000 RECOD: Duration of pregnancy-related problem: Time unit";
label variable ladura34 "
FHS.424_02.000: Duration of pregnancy-related problem (in years)";
label variable ladurb34 "
FHS.424_02.000: Duration of pregnancy-related problem recode 2";
label variable lachrc34 "FHS.424_02.000: Pregnancy-related condition status";
label variable latime90 "
FHS.450_01.000: Duration of other N.E.C. problem (1): Number of units";
label variable launit90 "
FHS.450_02.000: Duration of other N.E.C. problem (1): Time unit";
label variable ladura90 "
FHS.450_02.000: Duration of other N.E.C. problem (1) (in years)";
label variable ladurb90 "
FHS.450_02.000: Duration of other N.E.C. problem (1) recode 2";
label variable lachrc90 "
FHS.450_02.000: Other N.E.C. problem (1) condition status";
label variable latime91 "
FHS.452_01.000: Duration of other N.E.C. problem (2): Number of units";
label variable launit91 "
FHS.452_02.000: Duration of other N.E.C. problem (2): Time unit";
label variable ladura91 "
FHS.452_02.000: Duration of other N.E.C. problem (2) (in years)";
label variable ladurb91 "
FHS.452_02.000: Duration of other N.E.C. problem (2) recode 2";
label variable lachrc91 "
FHS.452_02.000: Other N.E.C. problem (2) condition status";
label variable lcondrt  "
FHS.452_02.000: Chronic condition recode for person with limitation of activity
";
label variable lachronr "
FHS.452_02.000: Limitation of activity recode by chronic condition status";
label variable phstat   "FHS.500_00.000: Reported health status";

label variable pdmed12m "
FAU.020_00.000: Was medical care delayed for - - (cost), 12m";
label variable pnmed12m "
FAU.040_00.000: Did - - need and NOT get medical care (cost), 12m";
label variable phospyr2 "FAU.060_00.000: Was - - in a hospital OVERNIGHT, 12m";
label variable hospno   "
FAU.070_00.000: Number of times in hospital overnight, 12m";
label variable hpnite   "FAU.110_00.000: Number of nights in hospital, 12m";
label variable phchm2w  "
FAU.130_00.000: Did - - receive HOME care by health professional, 2 wk";
label variable phchmn2w "
FAU.140_00.000: Number of HOME visits by health professional, 2wk";
label variable phcph2wr "
FAU.160_00.000: Did--get advice/test results by phone, 2wk";
label variable phcphn2w "
FAU.170_00.000: Number of PHONE calls to health professional, 2wk";
label variable phcdv2w  "
FAU.190_00.000: Did - - see health professional in office, etc, 2wk";
label variable phcdvn2w "
FAU.200_00.000: Number of times VISITED health professional, 2wk";
label variable p10dvyr  "FAU.220_00.000: Did - - receive care 10+ times, 12m";

label variable notcov   "
FHI.070_00.000: Cov stat as used in Health United States";
label variable medicare "FHI.070_00.000: Medicare coverage recode";
label variable mcpart   "FHI.090_00.000: Type of Medicare coverage";
label variable mcchoice "FHI.095_00.000: Enrolled in Medicare Advantage Plan";
label variable mchmo    "FHI.100_00.000: Is - - signed up with an HMO";
label variable mcnamen  "FHI.110_00.000: Medicare HMO name";
label variable mcref    "FHI.114_00.000: Need a referral for special care";
label variable mcpaypre "FHI.116_00.000: More comprehensive benefit plan";
label variable mcpartd  "FHI.118_00.000: Medicare Part D";
label variable medicaid "FHI.070_00.000: Medicaid coverage recode";
label variable machmd   "
FHI.120_00.000: Any doc, chooses from a list, doc assigned";
label variable mapcmd   "FHI.140_00.000: Primary care physician for routine care
";
label variable maref    "FHI.150_00.000: Need a referral for special care";
label variable single   "FHI.070_00.000: Single service plan recode";
label variable sstypea  "FHI.156_01.000: Accidents";
label variable sstypeb  "FHI.156_02.000: AIDS care";
label variable sstypec  "FHI.156_03.000: Cancer treatment";
label variable sstyped  "FHI.156_04.000: Catastrophic care";
label variable sstypee  "FHI.156_05.000: Dental care";
label variable sstypef  "FHI.156_06.000: Disability insurance";
label variable sstypeg  "FHI.156_07.000: Hospice care";
label variable sstypeh  "FHI.156_08.000: Hospitalization only";
label variable sstypei  "FHI.156_09.000: Long-term care";
label variable sstypej  "FHI.156_10.000: Prescriptions";
label variable sstypek  "FHI.156_11.000: Vision care";
label variable sstypel  "FHI.156_12.000: Other";
label variable private  "FHI.070_00.000: Private health insurance recode";
label variable hitypen1 "FHI.160_00.000: Name of plan (Plan 1)";
label variable whonam1  "FHI.200_01.000: Plan in whose name (Plan 1)";
label variable plnwrkn1 "
FHI.210_01.000: How plan was originally obtained (plan 1)";
label variable plnpay11 "FHI.220_11.000: Paid for by self or family (Plan 1)";
label variable plnpay21 "FHI.220_12.000: Paid for by employer or union (Plan 1)
";
label variable plnpay31 "
FHI.220_13.000: Paid for by someone outside the household (Plan 1)";
label variable plnpay41 "FHI.220_14.000: Paid for by Medicare (Plan 1)";
label variable plnpay51 "FHI.220_15.000: Paid for by Medicaid (Plan 1)";
label variable plnpay61 "FHI.220_16.000: Paid for by CHIP (Plan 1)";
label variable plnpay71 "FHI.220_17.000: Paid for by government program (Plan 1)
";
label variable hicostr1 "FHI.230_12.000: Out-of-pocket premium cost (Plan 1)";
label variable plnmgd1  "FHI.240_01.000: Type of private plan (Plan 1)";
label variable hdhp1    "FHI.241_01.000: High deductible health plan (plan 1)";
label variable hsahra1  "
FHI.242_01.000: Health Savings Accounts/Health Reimbursement Accounts (plan 1)";
label variable mgchmd1  "FHI.243_01.000: Doctor choice (Plan 1)";
label variable mgprmd1  "FHI.244_01.000: Preferred list (Plan 1)";
label variable mgpymd1  "FHI.246_01.000: Out of plan use (Plan 1)";
label variable mgpref1  "FHI.248_01.000: Private referral (Plan 1)";
label variable prrxcov1 "FHI.249_01.000: Prescription drug benefit (Plan 1)";
label variable prdncov1 "FHI.249_05.000: Dental Coverage (Plan 1)";
label variable hitypen2 "FHI.172_00.000: Name of plan (Plan 2)";
label variable whonam2  "FHI.200_02.000: Plan in whose name (Plan 2)";
label variable plnwrkn2 "
FHI.210_02.000: How plan was originally obtained (Plan 2)";
label variable plnpay12 "FHI.220_21.000: Paid for by self or family (Plan 2)";
label variable plnpay22 "FHI.220_22.000: Paid for by employer or union (Plan 2)
";
label variable plnpay32 "
FHI.220_23.000: Paid for by someone outside the household (Plan 2)";
label variable plnpay42 "FHI.220_24.000: Paid for by Medicare (Plan 2)";
label variable plnpay52 "FHI.220_25.000: Paid for by Medicaid (Plan 2)";
label variable plnpay62 "FHI.220_26.000: Paid for by CHIP (Plan 2)";
label variable plnpay72 "FHI.220_27.000: Paid for by government program (Plan 2)
";
label variable hicostr2 "FHI.230_22.000: Out-of-pocket premium cost (Plan 2)";
label variable plnmgd2  "FHI.240_02.000: Type of private plan (plan 2)";
label variable hdhp2    "FHI.241_02.000: High deductible health plan (plan 2)";
label variable hsahra2  "
FHI.242_02.000: Health Savings Accounts/Health Reimbursement Accounts (plan 2)";
label variable mgchmd2  "FHI.243_02.000: Doctor choice (Plan 2)";
label variable mgprmd2  "FHI.244_02.000: Preferred list (Plan 2)";
label variable mgpymd2  "FHI.246_02.000: Out of plan use (Plan 2)";
label variable mgpref2  "FHI.248_02.000: Private referral (Plan 2)";
label variable prrxcov2 "FHI.249_02.000: Prescription drug benefit (Plan 2)";
label variable prdncov2 "FHI.249_06.000: Dental Coverage (Plan 2)";
label variable prplplus "FHI.175_00.000: Person has more than two private plans
";
label variable schip    "FHI.070_00.000: SCHIP coverage recode";
label variable stdoc1   "
FHI.251_00.000: Any doc, chooses from a list, doc assigned (SCHIP)";
label variable stpcmd1  "
FHI.252_00.000: Primary care physician for routine care (SCHIP)";
label variable stref1   "
FHI.253_00.000: Need a referral for special care (SCHIP)";
label variable othpub   "FHI.070_00.000: State-sponsored health plan recode";
label variable stdoc2   "
FHI.258_00.000: Any doc, chooses from a list, doc assigned (OTHPUB)";
label variable stpcmd2  "
FHI.259_00.000: Primary care physician for routine care (OTHPUB)";
label variable stref2   "
FHI.260_00.000: Need a referral for special care (OTHPUB)";
label variable othgov   "FHI.070_00.000: Other government program recode";
label variable stdoc3   "
FHI.265_00.000: Any doc, chooses from a list, doc assigned (OTHGOV)";
label variable stpcmd3  "
FHI.266_00.000: Primary care physician for routine care (OTHGOV)";
label variable stref3   "
FHI.267_00.000: Need a referral for special care (OTHGOV)";
label variable milcare  "FHI.070_00.000: Military health care coverage recode";
label variable milspc1  "FHI.270_01.000: TRICARE coverage";
label variable milspc2  "FHI.270_02.000: VA coverage";
label variable milspc3  "FHI.270_03.000: CHAMP-VA coverage";
label variable milspc4  "FHI.270_04.000: Other military coverage";
label variable milman   "FHI.275_00.000: Type of TRICARE coverage";
label variable ihs      "FHI.070_00.000: Indian Health Service recode";
label variable hilast   "FHI.280_00.000: How long since last had health coverage
";
label variable histop1  "FHI.290_01.000: Lost job or changed employers";
label variable histop2  "FHI.290_02.000: Divorced/sep/death of spouse or parent
";
label variable histop3  "FHI.290_03.000: Ineligible because of age/left school";
label variable histop4  "
FHI.290_04.000: Employer does not offer/not eligible for cov";
label variable histop5  "FHI.290_05.000: Cost is too high";
label variable histop6  "FHI.290_06.000: Insurance company refused coverage";
label variable histop7  "
FHI.290_07.000: Medicaid/medi plan stopped after pregnancy";
label variable histop8  "
FHI.290_08.000: Lost Medicaid/new job/increase in income";
label variable histop9  "FHI.290_09.000: Lost Medicaid (other)";
label variable histop10 "FHI.290_10.000: Other";
label variable histop11 "FHI.290_10.000: Never had health insurance";
label variable histop12 "FHI.290_10.000: Moved from another county/state/country
";
label variable histop13 "FHI.290_10.000: Self-employed";
label variable histop14 "FHI.290_10.000: No need for it/chooses not to have";
label variable histop15 "FHI.290_10.000: Got married";
label variable hinotyr  "
FHI.300_00.000: No health coverage during past 12 months";
label variable hinotmyr "
FHI.310_00.000: Months without coverage in past 12 months";
label variable hcspfyr  "FHI.320_00.000: Amount family spent for medical care";
label variable fsa      "FHI.330_00.000: Flexible Spending Accounts";
label variable hikindna "FHI.070_01.000: Private health insurance";
label variable hikindnb "FHI.070_02.000: Medicare";
label variable hikindnc "FHI.070_03.000: Medi-Gap";
label variable hikindnd "FHI.070_04.000: Medicaid";
label variable hikindne "FHI.070_05.000: SCHIP";
label variable hikindnf "FHI.070_06.000: Military health care";
label variable hikindng "FHI.070_07.000: Indian Health Service";
label variable hikindnh "FHI.070_08.000: State-sponsored health plan";
label variable hikindni "FHI.070_09.000: Other government plan";
label variable hikindnj "FHI.070_10.000: Single service plan";
label variable hikindnk "FHI.070_11.000: No coverage of any type";
label variable mcareprb "FHI.072_00.000: Medicare coverage probe";
label variable mcaidprb "FHI.073_00.000: Medicaid coverage probe";
label variable sincov   "FHI.074_00.000: Single service plan probe";

label variable plborn   "FSD.001_00.000: Born in the United States";
label variable regionbr "FSD.003_01.000: Geographic region of birth recode";
label variable geobrth  "FSD.003_01.000: Geographic place of birth recode";
label variable yrsinus  "FSD.005_00.000: Years that - - has been in the U.S.";
label variable citizenp "FSD.006_00.000: U.S. citizenship status";
label variable headst   "FSD.007_00.000: Now attending Head Start";
label variable headstv1 "FSD.008_00.000: Ever attended Head Start";
label variable educ1    "FSD.010_00.000: Highest level of school completed";
label variable pmiltry  "FSD.042_00.000: Did - - receive honorable discharge";
label variable doinglwp "FSD.050_00.000: What was - - doing last week";
label variable whynowkp "FSD.060_00.000: Main reason for not working last week";
label variable wrkhrs2  "FSD.070_00.000: Hours worked last week";
label variable wrkftall "FSD.080_00.000: Usually work full time";
label variable wrklyr1  "FSD.100_00.000: Work for pay last year";
label variable wrkmyr   "FSD.110_00.000: Months worked last year";
label variable ernyr_p  "FSD.120_00.000: Total earnings last year";
label variable hiempof  "FSD.130_00.000: Health insurance offered at workplace";

label variable fincint  "
FIN.010_00.000: Introduction to the family income section";
label variable psal     "
FIN.040_00.000: Receive income from wages/salary (last CY)";
label variable pseinc   "
FIN.060_00.000: Receive income from self-employment (last CY)";
label variable pssrr    "FIN.080_00.000: Receive income from SS or RR (last CY)
";
label variable pssrrdb  "
FIN.084_00.000: Received SS or RR as a disability benefit";
label variable pssrrd   "FIN.086_00.000: Received benefit due to disability";
label variable ppens    "
FIN.100_00.000: Receive income from other pensions (disability)";
label variable popens   "FIN.104_00.000: Receive income from any other pension";
label variable pssi     "FIN.120_00.000: Received income from SSI";
label variable pssid    "FIN.122_00.000: Received SSI due to disability";
label variable ptanf    "FIN.160_00.000: Received income from welfare/TANF";
label variable powben   "FIN.166_00.000: Received other government assistance";
label variable pintrstr "FIN.180_00.000: Receive interest income";
label variable pdivd    "
FIN.200_00.000: Receive dividends from stocks, funds, etc.";
label variable pchldsp  "FIN.220_00.000: Receive income from child support";
label variable pincot   "FIN.240_00.000: Received income from any other source";
label variable pssapl   "FIN.310_00.000: Ever applied for SSI";
label variable psdapl   "FIN.340_00.000: Ever applied for SSDI";
label variable tanfmyr  "FIN.350_00.000: Months received welfare/TANF (last CY)
";
label variable pfstp    "
FIN.370_00.000: Person authorized to receive food stamps (last CY)";
label variable fstpmyr  "FIN.380_00.000: Months received food stamps (last CY)";
label variable eligpwic "
FIN.384_00.000: Anyone age-eligible for the WIC program?";
label variable pwic     "FIN.385_00.000: Received WIC benefits";
label variable wic_flag "FIN.385_00.000: WIC recipient age-eligible";

* DEFINE VALUE LABELS FOR REPORTS;

label define pep001x
   10       "10 Household"
   20       "20 Person"
   25       "25 Income Imputation"
   30       "30 Sample Adult"
   40       "40 Sample Child"
   60       "60 Family"
   63       "63 Disability Questions Tests 2008/2009"
   65       "65 Paradata"
   70       "70 Injury/Poisoning Episode"
   75       "75 Injury/Poisoning Verbatim"
;
label define pep004x
   1        "1 Quarter 1"
   2        "2 Quarter 2"
   3        "3 Quarter 3"
   4        "4 Quarter 4"
;
label define pep005x
   01       "01 Week 1"
   02       "02 Week 2"
   03       "03 Week 3"
   04       "04 Week 4"
   05       "05 Week 5"
   06       "06 Week 6"
   07       "07 Week 7"
   08       "08 Week 8"
   09       "09 Week 9"
   10       "10 Week 10"
   11       "11 Week 11"
   12       "12 Week 12"
   13       "13 Week 13"
;
label define pep010x
   1        "1 Northeast"
   2        "2 Midwest"
   3        "3 South"
   4        "4 West"
;
label define pep013x
   1        "1 Male"
   2        "2 Female"
;
label define pep014x
   1        "1 Yes"
   2        "2 No"
;
label define pep015x
   1        "1 Imputed: was 'refused' Hispanic Origin"
   2        "2 Imputed: was 'not ascertained' Hispanic Origin"
   3        "3 Imputed: was 'does not know' Hispanic Origin"
   4        "4 Hispanic origin given by respondent/proxy"
;
label define pep016x
   00       "00 Multiple Hispanic"
   01       "01 Puerto Rico"
   02       "02 Mexican"
   03       "03 Mexican-American"
   04       "04 Cuban/Cuban American"
   05       "05 Dominican (Republic)"
   06       "06 Central or South American"
   07       "07 Other Latin American, type not specified"
   08       "08 Other Spanish"
   09       "09 Hispanic/Latino/Spanish, non-specific type"
   10       "10 Hispanic/Latino/Spanish, type refused"
   11       "11 Hispanic/Latino/Spanish, type not ascertained"
   12       "12 Not Hispanic/Spanish origin"
;
label define pep017x
   1        "1 Imputed: was 'refused' Hispanic Origin"
   2        "2 Imputed: was 'not ascertained' Hispanic Origin"
   3        "3 Imputed: was 'does not know' Hispanic Origin"
   4        "4 Hispanic Origin type given by respondent/proxy"
;
label define pep018x
   01       "01 White only"
   02       "02 Black/African American only"
   03       "03 AIAN only"
   04       "04 Asian only"
   05       "05 Race group not releasable (See file layout)"
   06       "06 Multiple race"
;
label define pep019x
   1        "1 Imputed: was 'refused'"
   2        "2 Imputed: was 'not ascertained'"
   3        "3 Imputed: was 'does not know'"
   4        "4 Imputed: was other race'"
   5        "5 Imputed: was 'unspecified multiple race'"
   6        "6 Race given by respondent/proxy"
;
label define pep020x
   01       "01 White"
   02       "02 Black/African American"
   03       "03 Indian (American), Alaska Native"
   09       "09 Asian Indian"
   10       "10 Chinese"
   11       "11 Filipino"
   15       "15 Other Asian (See file layout)"
   16       "16 Primary race not releasable (See file layout)"
   17       "17 Multiple race, no primary race selected"
;
label define pep021x
   01       "01 White"
   02       "02 Black/African American"
   03       "03 Indian (American) (includes Eskimo, Aleut)"
   06       "06 Chinese"
   07       "07 Filipino"
   12       "12 Asian Indian"
   16       "16 Other race (See file layout)"
   17       "17 Multiple race, no primary race selected"
;
label define pep022x
   1        "1 White"
   2        "2 Black"
   3        "3 Asian"
   4        "4 All other race groups (See file layout)"
;
label define pep023x
   1        "1 Hispanic"
   2        "2 Non-Hispanic White"
   3        "3 Non-Hispanic Black"
   4        "4 Non-Hispanic Asian"
   5        "5 Non-Hispanic All other race groups"
;
label define pep024x
   1        "1 Ethnicity/race imputed"
   2        "2 Ethnicity/race given by respondent/proxy"
;
label define pep025x
   1        "1 Armed Forces"
   2        "2 Not Armed Forces"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep026x
   01       "01 Household reference person"
   02       "02 Spouse (husband/wife)"
   03       "03 Unmarried Partner"
   04       "04 Child (biological/adoptive/in-law/step/foster)"
   05       "05 Child of partner"
   06       "06 Grandchild"
   07       "07 Parent (biological/adoptive/in-law/step/foster)"
   08       "08 Brother/sister (biological/adoptive/in-law/step/foster)"
   09       "09 Grandparent (Grandmother/Grandfather)"
   10       "10 Aunt/Uncle"
   11       "11 Niece/Nephew"
   12       "12 Other relative"
   13       "13 Housemate/roommate"
   14       "14 Roomer/Boarder"
   15       "15 Other nonrelative"
   16       "16 Legal guardian"
   17       "17 Ward"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep028x
   01       "01 Family reference person"
   02       "02 Spouse (husband/wife)"
   03       "03 Unmarried Partner"
   04       "04 Child (biological/adoptive/in-law/step/foster)"
   05       "05 Child of partner"
   06       "06 Grandchild"
   07       "07 Parent (biological/adoptive/in-law/step/foster)"
   08       "08 Brother/sister (biological/adoptive/in-law/step/foster)"
   09       "09 Grandparent (Grandmother/Grandfather)"
   10       "10 Aunt/Uncle"
   11       "11 Niece/Nephew"
   12       "12 Other relative"
   16       "16 Legal guardian"
   17       "17 Ward"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep031x
   00       "00 Under 1 year"
   85       "85 85+ years"
;
label define pep032x
   1        "1 Change on AGE due to data entry error"
;
label define pep035x
   0        "0 Under 14 years"
   1        "1 Married - spouse in household"
   2        "2 Married - spouse not in household"
   3        "3 Married - spouse in household unknown"
   4        "4 Widowed"
   5        "5 Divorced"
   6        "6 Separated"
   7        "7 Never married"
   8        "8 Living with partner"
   9        "9 Unknown marital status"
;
label define pep037x
   1        "1 Yes"
   2        "2 No"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep038x
   1        "1 Married"
   2        "2 Widowed"
   3        "3 Divorced"
   4        "4 Separated"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep040x
   1        "1 Separated"
   2        "2 Divorced"
   3        "3 Married"
   4        "4 Single/never married"
   5        "5 Widowed"
   9        "9 Unknown marital status"
;
label define pep041x
   1        "1 Full {brother/sister}"
   2        "2 Half {brother/sister}"
   3        "3 Adopted {brother/sister}"
   4        "4 Step {brother/sister}"
   5        "5 Foster {brother/sister}"
   6        "6 {Brother/Sister}-in-law"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep043x
   1        "1 Biological"
   2        "2 Adoptive"
   3        "3 Step"
   4        "4 Foster"
   5        "5 In-law"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep046x
   1        "1 Mother, no father"
   2        "2 Father, no mother"
   3        "3 Mother and father"
   4        "4 Neither mother nor father"
   9        "9 Unknown"
;
label define pep047x
   01       "01 Less than/equal to 8th grade"
   02       "02 9-12th grade, no high school diploma"
   03       "03 High school graduate/GED recipient"
   04       "04 Some college, no degree"
   05       "05 AA degree, technical or vocational"
   06       "06 AA degree, academic program"
   07       "07 Bachelor's degree"
   08       "08 Master's, professional, or doctoral degree"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep049x
   0        "0 Sample Adult - no record"
   1        "1 Sample Adult - has record"
   2        "2 Not selected as Sample Adult"
   3        "3 No one selected as Sample Adult"
   4        "4 Armed Force member"
   5        "5 Armed Force member - selected as Sample Adult"
;
label define pep050x
   0        "0 Sample Child - no record"
   1        "1 Sample Child - has record"
   2        "2 Not selected as Sample Child"
   3        "3 No one selected as Sample Child"
   4        "4 Emancipated minor"
;
label define pep051x
   1        "1 No sample adult record due to quality reasons"
;
label define pep052x
   1        "1 No sample child record due to quality reasons"
;
label define pep066x
   0        "0 Unable to work"
   1        "1 Limited in work"
   2        "2 Not limited in work"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep069x
   0        "0 Limitation previously mentioned"
   1        "1 Yes, limited in some other way"
   2        "2 Not limited in any way"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep070x
   1        "1 Limited in any way"
   2        "2 Not limited in any way"
   3        "3 Unknown if limited"
;
label define pep071x
   1        "1 Mentioned"
   2        "2 Not mentioned"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep086x
   95       "95 95+"
   96       "96 Since birth"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep087x
   1        "1 Day(s)"
   2        "2 Week(s)"
   3        "3 Month(s)"
   4        "4 Year(s)"
   6        "6 Since birth"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep088x
   00       "00 Less than 1 year"
   96       "96 Unknown number of years"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep089x
   0        "0 Since birth and child <1 year of age"
   1        "1 Less than 3 months"
   2        "2 3-5 months"
   3        "3 6-12 months"
   4        "4 More than 1 year"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep090x
   1        "1 Chronic"
   2        "2 Not chronic"
   9        "9 Unknown if chronic"
;
label define pep199x
   00       "00 Less than 1 year"
   85       "85 85+ years"
   96       "96 Unknown number of years"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep200x
   1        "1 Less than 3 months"
   2        "2 3-5 months"
   3        "3 6-12 months"
   4        "4 More than 1 year"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep377x
   1        "1 At least one condition causing limitation of activity is chronic"
   2        "2 No condition causing limitation of activity is chronic"
   9        "
9 Unknown if any condition causing limitation of activity is chronic"
;
label define pep378x
   0        "0 Not limited in any way (including unknown if limited)"
   1        "1 Limited; caused by at least one chronic condition"
   2        "2 Limited; not caused by chronic condition"
   3        "3 Limited; unknown if condition is chronic"
;
label define pep379x
   1        "1 Excellent"
   2        "2 Very good"
   3        "3 Good"
   4        "4 Fair"
   5        "5 Poor"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep383x
   997      "997 Refused"
   998      "998 Not ascertained"
   999      "999 Don't know"
;
label define pep386x
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep392x
   1        "1 Not covered"
   2        "2 Covered"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep393x
   1        "1 Yes, information"
   2        "2 Yes, but no information"
   3        "3 No"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep394x
   1        "1 Part A - Hospital only"
   2        "2 Part B - Medical only"
   3        "3 Both Part A and Part B"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep397x
   04       "04 Medigap plan"
   12       "12 Group"
   22       "22 Staff"
   32       "32 IPA"
   92       "92 Other"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep402x
   1        "1  Any doctor"
   2        "2  Select from book/list"
   3        "3  Doctor is assigned"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep405x
   1        "1 Yes, with information"
   2        "2 Yes, but no information"
   3        "3 No"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep419x
   1        "1 HMO"
   2        "2 Non-HMO"
   3        "3 Unknown model type"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep420x
   1        "1 In own name"
   2        "2 Someone else in family"
   3        "3 Person not in household"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep421x
   01       "01 Through employer"
   02       "02 Through union"
   03       "03 Through workplace, but don't know if employer or union"
   04       "04 Through workplace, self-employed or professional association"
   05       "05 Purchased directly"
   06       "06 Through a state/local government or community program"
   07       "07 Other"
   08       "08 Through school"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep429x
   20000    "20000 $20,000 or more"
   99997    "99997 Refused"
   99998    "99998 Not ascertained"
   99999    "99999 Don't know"
;
label define pep430x
   1        "1 HMO/IPA"
   2        "2 PPO"
   3        "3 POS"
   4        "4 Fee-for-service/indemnity"
   5        "5 Other"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep431x
   1        "1 Less than [$1,150/$2,300]"
   2        "2 [$1,150/$2,300] or more"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep433x
   1        "1 Any doctor"
   2        "2 Select from group/list"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep468x
   1        "1 Yes, information"
   2        "2 Yes, but no information"
   3        "3 No"
   7        "7 Refused"
   8        "8 Not asertained"
   9        "9 Don't know"
;
label define pep477x
   1        "1 TRICARE Prime"
   2        "2 TRICARE Extra"
   3        "3 TRICARE Standard"
   4        "4 TRICARE for life"
   5        "5 TRICARE other (specify)"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep479x
   1        "1 6 months or less"
   2        "2 More than 6 months, but not more than 1 year ago"
   3        "3 More than 1 year, but not more than 3 years ago"
   4        "4 More than 3 years"
   5        "5 Never"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep497x
   0        "0 Zero"
   1        "1 Less than $500"
   2        "2 $500 - $1,999"
   3        "3 $2,000 - $2,999"
   4        "4 $3,000 - $4,999"
   5        "5 $5,000 or more"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep514x
   01       "01 United States"
   02       "02 Mexico, Central America, Caribbean Islands"
   03       "03 South America"
   04       "04 Europe"
   05       "05 Russia (and former USSR areas)"
   06       "06 Africa"
   07       "07 Middle East"
   08       "08 Indian Subcontinent"
   09       "09 Asia"
   10       "10 SE Asia"
   11       "11 Elsewhere"
   99       "99 Unknown"
;
label define pep515x
   1        "1 USA: born in one of the 50 United States or D.C."
   2        "2 USA: born in a U.S. territory"
   3        "3 Not born in the U.S. or a U.S. territory"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep516x
   1        "1 Less than 1 year"
   2        "2 1 yr., less than 5 yrs."
   3        "3 5 yrs., less than 10 yrs."
   4        "4 10 yrs., less than 15 yrs."
   5        "5 15 years or more"
   9        "9 Unknown"
;
label define pep517x
   1        "1 Yes, citizen of the United States"
   2        "2 No, not a citizen of the United States"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep520x
   00       "00 Never attended/kindergarten only"
   01       "01 1st grade"
   02       "02 2nd grade"
   03       "03 3rd grade"
   04       "04 4th grade"
   05       "05 5th grade"
   06       "06 6th grade"
   07       "07 7th grade"
   08       "08 8th grade"
   09       "09 9th grade"
   10       "10 10th grade"
   11       "11 11th grade"
   12       "12 12th grade, no diploma"
   13       "13 GED or equivalent"
   14       "14 High School Graduate"
   15       "15 Some college, no degree"
   16       "16 Associate degree: occupational, technical, or vocational program
"
   17       "17 Associate degree: academic program"
   18       "18 Bachelor's degree (Example: BA, AB, BS, BBA)"
   19       "19 Master's degree (Example: MA, MS, MEng, MEd, MBA)"
   20       "20 Professional School degree (Example: MD, DDS, DVM, JD)"
   21       "21 Doctoral degree (Example: PhD, EdD)"
   96       "96 Child under 5 years old"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep522x
   1        "1 Working for pay at a job or business"
   2        "2 With a job or business but not at work"
   3        "3 Looking for work"
   4        "4 Working, but not for pay, at a family-owned job or business"
   5        "5 Not working at a job or business and not looking for work"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep523x
   01       "01 Taking care of house or family"
   02       "02 Going to school"
   03       "03 Retired"
   04       "04 On a planned vacation from work"
   05       "05 On family or maternity leave"
   06       "06 Temporarily unable to work for health reasons"
   07       "07 Have job/contract and off-season"
   08       "08 On layoff"
   09       "09 Disabled"
   10       "10 Other"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep524x
   95       "95 95+ hours"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep527x
   01       "01 1 month or less"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep528x
   01       "01 $01-$4,999"
   02       "02 $5,000-$9,999"
   03       "03 $10,000-$14,999"
   04       "04 $15,000-$19,999"
   05       "05 $20,000-$24,999"
   06       "06 $25,000-$34,999"
   07       "07 $35,000-$44,999"
   08       "08 $45,000-$54,999"
   09       "09 $55,000-$64,999"
   10       "10 $65,000-$74,999"
   11       "11 $75,000 and over"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep530x
   1        "1 Enter 1 to continue"
   8        "8 Not ascertained"
;
label define pep551x
   0        "0 No WIC age-eligible family members"
   1        "1 At least 1 WIC age-eligible family member"
;
label define pep553x
   0        "0 Person not age-eligible"
   1        "1 Person age-eligible"
;

* ASSOCIATE VARIABLES WITH VALUE LABEL DEFINITIONS;

label values rectype   pep001x;   label values intv_qrt  pep004x;
label values assignwk  pep005x;

label values region    pep010x;

label values sex       pep013x;   label values origin_i  pep014x;
label values origimpt  pep015x;   label values hispan_i  pep016x;
label values hispimpt  pep017x;   label values racerpi2  pep018x;
label values raceimp2  pep019x;   label values mracrpi2  pep020x;
label values mracbpi2  pep021x;   label values racreci3  pep022x;
label values hiscodi3  pep023x;   label values erimpflg  pep024x;
label values nowaf     pep025x;   label values rrp       pep026x;
label values frrp      pep028x;   label values age_p     pep031x;
label values age_chg   pep032x;

label values r_maritl  pep035x;   label values cohab1    pep037x;
label values cohab2    pep038x;   label values cdcmstat  pep040x;
label values sib_deg   pep041x;   label values mom_deg   pep043x;
label values dad_deg   pep043x;   label values parents   pep046x;
label values mom_ed    pep047x;   label values dad_ed    pep047x;
label values astatflg  pep049x;   label values cstatflg  pep050x;
label values qcadult   pep051x;   label values qcchild   pep052x;

label values plaplylm  pep037x;   label values plaplyun  pep037x;
label values pspedeis  pep037x;   label values pspedem   pep037x;
label values plaadl    pep037x;   label values labath    pep037x;
label values ladress   pep037x;   label values laeat     pep037x;
label values labed     pep037x;   label values latoilt   pep037x;
label values lahome    pep037x;   label values plaiadl   pep037x;
label values plawknow  pep037x;   label values plawklim  pep066x;
label values plawalk   pep037x;   label values plaremem  pep037x;
label values plimany   pep069x;   label values la1ar     pep070x;
label values lahcc1    pep071x;   label values lahcc2    pep071x;
label values lahcc3    pep071x;   label values lahcc4    pep071x;
label values lahcc5    pep071x;   label values lahcc6    pep071x;
label values lahcc7    pep071x;   label values lahcc8    pep071x;
label values lahcc9    pep071x;   label values lahcc10   pep071x;
label values lahcc11   pep071x;   label values lahcc12   pep071x;
label values lahcc13   pep071x;   label values lahcc90   pep071x;
label values lahcc91   pep071x;   label values lctime1   pep086x;
label values lcunit1   pep087x;   label values lcdura1   pep088x;
label values lcdurb1   pep089x;   label values lcchrc1   pep090x;
label values lctime2   pep086x;   label values lcunit2   pep087x;
label values lcdura2   pep088x;   label values lcdurb2   pep089x;
label values lcchrc2   pep090x;   label values lctime3   pep086x;
label values lcunit3   pep087x;   label values lcdura3   pep088x;
label values lcdurb3   pep089x;   label values lcchrc3   pep090x;
label values lctime4   pep086x;   label values lcunit4   pep087x;
label values lcdura4   pep088x;   label values lcdurb4   pep089x;
label values lcchrc4   pep090x;   label values lctime5   pep086x;
label values lcunit5   pep087x;   label values lcdura5   pep088x;
label values lcdurb5   pep089x;   label values lcchrc5   pep090x;
label values lctime6   pep086x;   label values lcunit6   pep087x;
label values lcdura6   pep088x;   label values lcdurb6   pep089x;
label values lcchrc6   pep090x;   label values lctime7   pep086x;
label values lcunit7   pep087x;   label values lcdura7   pep088x;
label values lcdurb7   pep089x;   label values lcchrc7   pep090x;
label values lctime8   pep086x;   label values lcunit8   pep087x;
label values lcdura8   pep088x;   label values lcdurb8   pep089x;
label values lcchrc8   pep090x;   label values lctime9   pep086x;
label values lcunit9   pep087x;   label values lcdura9   pep088x;
label values lcdurb9   pep089x;   label values lcchrc9   pep090x;
label values lctime10  pep086x;   label values lcunit10  pep087x;
label values lcdura10  pep088x;   label values lcdurb10  pep089x;
label values lcchrc10  pep090x;   label values lctime11  pep086x;
label values lcunit11  pep087x;   label values lcdura11  pep088x;
label values lcdurb11  pep089x;   label values lcchrc11  pep090x;
label values lctime12  pep086x;   label values lcunit12  pep087x;
label values lcdura12  pep088x;   label values lcdurb12  pep089x;
label values lcchrc12  pep090x;   label values lctime13  pep086x;
label values lcunit13  pep087x;   label values lcdura13  pep088x;
label values lcdurb13  pep089x;   label values lcchrc13  pep090x;
label values lctime90  pep086x;   label values lcunit90  pep087x;
label values lcdura90  pep088x;   label values lcdurb90  pep089x;
label values lcchrc90  pep090x;   label values lctime91  pep086x;
label values lcunit91  pep087x;   label values lcdura91  pep088x;
label values lcdurb91  pep089x;   label values lcchrc91  pep090x;
label values lahca1    pep071x;   label values lahca2    pep071x;
label values lahca3    pep071x;   label values lahca4    pep071x;
label values lahca5    pep071x;   label values lahca6    pep071x;
label values lahca7    pep071x;   label values lahca8    pep071x;
label values lahca9    pep071x;   label values lahca10   pep071x;
label values lahca11   pep071x;   label values lahca12   pep071x;
label values lahca13   pep071x;   label values lahca14   pep071x;
label values lahca15   pep071x;   label values lahca16   pep071x;
label values lahca17   pep071x;   label values lahca18   pep071x;
label values lahca19_  pep071x;   label values lahca20_  pep071x;
label values lahca21_  pep071x;   label values lahca22_  pep071x;
label values lahca23_  pep071x;   label values lahca24_  pep071x;
label values lahca25_  pep071x;   label values lahca26_  pep071x;
label values lahca27_  pep071x;   label values lahca28_  pep071x;
label values lahca29_  pep071x;   label values lahca30_  pep071x;
label values lahca31_  pep071x;   label values lahca32_  pep071x;
label values lahca33_  pep071x;   label values lahca34_  pep071x;
label values lahca90   pep071x;   label values lahca91   pep071x;
label values latime1   pep086x;   label values launit1   pep087x;
label values ladura1   pep199x;   label values ladurb1   pep200x;
label values lachrc1   pep090x;   label values latime2   pep086x;
label values launit2   pep087x;   label values ladura2   pep199x;
label values ladurb2   pep200x;   label values lachrc2   pep090x;
label values latime3   pep086x;   label values launit3   pep087x;
label values ladura3   pep199x;   label values ladurb3   pep200x;
label values lachrc3   pep090x;   label values latime4   pep086x;
label values launit4   pep087x;   label values ladura4   pep199x;
label values ladurb4   pep200x;   label values lachrc4   pep090x;
label values latime5   pep086x;   label values launit5   pep087x;
label values ladura5   pep199x;   label values ladurb5   pep200x;
label values lachrc5   pep090x;   label values latime6   pep086x;
label values launit6   pep087x;   label values ladura6   pep199x;
label values ladurb6   pep200x;   label values lachrc6   pep090x;
label values latime7   pep086x;   label values launit7   pep087x;
label values ladura7   pep199x;   label values ladurb7   pep200x;
label values lachrc7   pep090x;   label values latime8   pep086x;
label values launit8   pep087x;   label values ladura8   pep199x;
label values ladurb8   pep200x;   label values lachrc8   pep090x;
label values latime9   pep086x;   label values launit9   pep087x;
label values ladura9   pep199x;   label values ladurb9   pep200x;
label values lachrc9   pep090x;   label values latime10  pep086x;
label values launit10  pep087x;   label values ladura10  pep199x;
label values ladurb10  pep200x;   label values lachrc10  pep090x;
label values latime11  pep086x;   label values launit11  pep087x;
label values ladura11  pep199x;   label values ladurb11  pep200x;
label values lachrc11  pep090x;   label values latime12  pep086x;
label values launit12  pep087x;   label values ladura12  pep199x;
label values ladurb12  pep200x;   label values lachrc12  pep090x;
label values latime13  pep086x;   label values launit13  pep087x;
label values ladura13  pep199x;   label values ladurb13  pep200x;
label values lachrc13  pep090x;   label values latime14  pep086x;
label values launit14  pep087x;   label values ladura14  pep199x;
label values ladurb14  pep200x;   label values lachrc14  pep090x;
label values latime15  pep086x;   label values launit15  pep087x;
label values ladura15  pep199x;   label values ladurb15  pep200x;
label values lachrc15  pep090x;   label values latime16  pep086x;
label values launit16  pep087x;   label values ladura16  pep199x;
label values ladurb16  pep200x;   label values lachrc16  pep090x;
label values latime17  pep086x;   label values launit17  pep087x;
label values ladura17  pep199x;   label values ladurb17  pep200x;
label values lachrc17  pep090x;   label values latime18  pep086x;
label values launit18  pep087x;   label values ladura18  pep199x;
label values ladurb18  pep200x;   label values lachrc18  pep090x;
label values latime19  pep086x;   label values launit19  pep087x;
label values ladura19  pep199x;   label values ladurb19  pep200x;
label values lachrc19  pep090x;   label values latime20  pep086x;
label values launit20  pep087x;   label values ladura20  pep199x;
label values ladurb20  pep200x;   label values lachrc20  pep090x;
label values latime21  pep086x;   label values launit21  pep087x;
label values ladura21  pep199x;   label values ladurb21  pep200x;
label values lachrc21  pep090x;   label values latime22  pep086x;
label values launit22  pep087x;   label values ladura22  pep199x;
label values ladurb22  pep200x;   label values lachrc22  pep090x;
label values latime23  pep086x;   label values launit23  pep087x;
label values ladura23  pep199x;   label values ladurb23  pep200x;
label values lachrc23  pep090x;   label values latime24  pep086x;
label values launit24  pep087x;   label values ladura24  pep199x;
label values ladurb24  pep200x;   label values lachrc24  pep090x;
label values latime25  pep086x;   label values launit25  pep087x;
label values ladura25  pep199x;   label values ladurb25  pep200x;
label values lachrc25  pep090x;   label values latime26  pep086x;
label values launit26  pep087x;   label values ladura26  pep199x;
label values ladurb26  pep200x;   label values lachrc26  pep090x;
label values latime27  pep086x;   label values launit27  pep087x;
label values ladura27  pep199x;   label values ladurb27  pep200x;
label values lachrc27  pep090x;   label values latime28  pep086x;
label values launit28  pep087x;   label values ladura28  pep199x;
label values ladurb28  pep200x;   label values lachrc28  pep090x;
label values latime29  pep086x;   label values launit29  pep087x;
label values ladura29  pep199x;   label values ladurb29  pep200x;
label values lachrc29  pep090x;   label values latime30  pep086x;
label values launit30  pep087x;   label values ladura30  pep199x;
label values ladurb30  pep200x;   label values lachrc30  pep090x;
label values latime31  pep086x;   label values launit31  pep087x;
label values ladura31  pep199x;   label values ladurb31  pep200x;
label values lachrc31  pep090x;   label values latime32  pep086x;
label values launit32  pep087x;   label values ladura32  pep199x;
label values ladurb32  pep200x;   label values lachrc32  pep090x;
label values latime33  pep086x;   label values launit33  pep087x;
label values ladura33  pep199x;   label values ladurb33  pep200x;
label values lachrc33  pep090x;   label values latime34  pep086x;
label values launit34  pep087x;   label values ladura34  pep199x;
label values ladurb34  pep200x;   label values lachrc34  pep090x;
label values latime90  pep086x;   label values launit90  pep087x;
label values ladura90  pep199x;   label values ladurb90  pep200x;
label values lachrc90  pep090x;   label values latime91  pep086x;
label values launit91  pep087x;   label values ladura91  pep199x;
label values ladurb91  pep200x;   label values lachrc91  pep090x;
label values lcondrt   pep377x;   label values lachronr  pep378x;
label values phstat    pep379x;

label values pdmed12m  pep037x;   label values pnmed12m  pep037x;
label values phospyr2  pep037x;   label values hospno    pep383x;
label values hpnite    pep383x;   label values phchm2w   pep037x;
label values phchmn2w  pep386x;   label values phcph2wr  pep037x;
label values phcphn2w  pep386x;   label values phcdv2w   pep037x;
label values phcdvn2w  pep386x;   label values p10dvyr   pep037x;

label values notcov    pep392x;   label values medicare  pep393x;
label values mcpart    pep394x;   label values mcchoice  pep037x;
label values mchmo     pep037x;   label values mcnamen   pep397x;
label values mcref     pep037x;   label values mcpaypre  pep037x;
label values mcpartd   pep037x;   label values medicaid  pep393x;
label values machmd    pep402x;   label values mapcmd    pep037x;
label values maref     pep037x;   label values single    pep405x;
label values sstypea   pep071x;   label values sstypeb   pep071x;
label values sstypec   pep071x;   label values sstyped   pep071x;
label values sstypee   pep071x;   label values sstypef   pep071x;
label values sstypeg   pep071x;   label values sstypeh   pep071x;
label values sstypei   pep071x;   label values sstypej   pep071x;
label values sstypek   pep071x;   label values sstypel   pep071x;
label values private   pep393x;   label values hitypen1  pep419x;
label values whonam1   pep420x;   label values plnwrkn1  pep421x;
label values plnpay11  pep071x;   label values plnpay21  pep071x;
label values plnpay31  pep071x;   label values plnpay41  pep071x;
label values plnpay51  pep071x;   label values plnpay61  pep071x;
label values plnpay71  pep071x;   label values hicostr1  pep429x;
label values plnmgd1   pep430x;   label values hdhp1     pep431x;
label values hsahra1   pep037x;   label values mgchmd1   pep433x;
label values mgprmd1   pep037x;   label values mgpymd1   pep037x;
label values mgpref1   pep037x;   label values prrxcov1  pep037x;
label values prdncov1  pep037x;   label values hitypen2  pep419x;
label values whonam2   pep420x;   label values plnwrkn2  pep421x;
label values plnpay12  pep071x;   label values plnpay22  pep071x;
label values plnpay32  pep071x;   label values plnpay42  pep071x;
label values plnpay52  pep071x;   label values plnpay62  pep071x;
label values plnpay72  pep071x;   label values hicostr2  pep429x;
label values plnmgd2   pep430x;   label values hdhp2     pep431x;
label values hsahra2   pep037x;   label values mgchmd2   pep433x;
label values mgprmd2   pep037x;   label values mgpymd2   pep037x;
label values mgpref2   pep037x;   label values prrxcov2  pep037x;
label values prdncov2  pep037x;   label values prplplus  pep037x;
label values schip     pep393x;   label values stdoc1    pep402x;
label values stpcmd1   pep037x;   label values stref1    pep037x;
label values othpub    pep393x;   label values stdoc2    pep402x;
label values stpcmd2   pep037x;   label values stref2    pep037x;
label values othgov    pep468x;   label values stdoc3    pep402x;
label values stpcmd3   pep037x;   label values stref3    pep037x;
label values milcare   pep393x;   label values milspc1   pep071x;
label values milspc2   pep071x;   label values milspc3   pep071x;
label values milspc4   pep071x;   label values milman    pep477x;
label values ihs       pep037x;   label values hilast    pep479x;
label values histop1   pep071x;   label values histop2   pep071x;
label values histop3   pep071x;   label values histop4   pep071x;
label values histop5   pep071x;   label values histop6   pep071x;
label values histop7   pep071x;   label values histop8   pep071x;
label values histop9   pep071x;   label values histop10  pep071x;
label values histop11  pep071x;   label values histop12  pep071x;
label values histop13  pep071x;   label values histop14  pep071x;
label values histop15  pep071x;   label values hinotyr   pep037x;
label values hinotmyr  pep386x;   label values hcspfyr   pep497x;
label values fsa       pep037x;   label values hikindna  pep071x;
label values hikindnb  pep071x;   label values hikindnc  pep071x;
label values hikindnd  pep071x;   label values hikindne  pep071x;
label values hikindnf  pep071x;   label values hikindng  pep071x;
label values hikindnh  pep071x;   label values hikindni  pep071x;
label values hikindnj  pep071x;   label values hikindnk  pep071x;
label values mcareprb  pep037x;   label values mcaidprb  pep037x;
label values sincov    pep037x;

label values plborn    pep037x;   label values regionbr  pep514x;
label values geobrth   pep515x;   label values yrsinus   pep516x;
label values citizenp  pep517x;   label values headst    pep037x;
label values headstv1  pep037x;   label values educ1     pep520x;
label values pmiltry   pep037x;   label values doinglwp  pep522x;
label values whynowkp  pep523x;   label values wrkhrs2   pep524x;
label values wrkftall  pep037x;   label values wrklyr1   pep037x;
label values wrkmyr    pep527x;   label values ernyr_p   pep528x;
label values hiempof   pep037x;

label values fincint   pep530x;   label values psal      pep037x;
label values pseinc    pep037x;   label values pssrr     pep037x;
label values pssrrdb   pep037x;   label values pssrrd    pep037x;
label values ppens     pep037x;   label values popens    pep037x;
label values pssi      pep037x;   label values pssid     pep037x;
label values ptanf     pep037x;   label values powben    pep037x;
label values pintrstr  pep037x;   label values pdivd     pep037x;
label values pchldsp   pep037x;   label values pincot    pep037x;
label values pssapl    pep037x;   label values psdapl    pep037x;
label values tanfmyr   pep386x;   label values pfstp     pep037x;
label values fstpmyr   pep386x;   label values eligpwic  pep551x;
label values pwic      pep037x;   label values wic_flag  pep553x;

* DISPLAY OVERALL DESCRIPTION OF FILE;

describe;

* DISPLAY A TEST TABLE FROM THE FILE;

tabulate rectype [fweight= wtfa];
save $mdata/int/nhis/clean/nhis2009_personsx, replace;

#delimit cr

* data file is stored in personsx.dta
* log  file is stored in personsx.log

