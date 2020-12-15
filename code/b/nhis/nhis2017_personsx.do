version 6.0

* THE FOLLOWING COMMAND TEMPORARILY CHANGES THE COMMAND-
* ENDING DELIMITER FROM A CARRIAGE RETURN TO A SEMICOLON

#delimit ;

*********************************************************************
 JUNE 11, 2018  4:40 PM
 
 THIS IS AN EXAMPLE OF A STATA DO PROGRAM THAT CREATES A STATA
 FILE FROM THE 2017 NHIS Public Use Person ASCII FILE

 NOTES:

 EXECUTING THIS PROGRAM WILL REPLACE personsx.dta AND personsx.log
 IF THOSE FILES ALREADY EXIST IN THE DEFAULT DIRECTORY

 THIS PROGRAM ASSUMES THAT THE ASCII DATA FILE IS IN THE STATA WORKING
 DIRECTORY.  AN EXAMPLE OF HOW TO CHANGE THE WORKING DIRECTORY
 WITHIN STATA IS THE FOLLOWING COMMAND: cd c:\nhis2017\

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
      intv_mon     14 -  15  str fmx          16 -  17
  str fpx          18 -  19      wtia         20 -  25
      wtfa         26 -  31

      region       32 -  32      pstrat       33 -  35
      ppsu         36 -  38

      sex          39 -  39      origin_i     40 -  40
      hispan_i     41 -  42      racerpi2     43 -  44
      mracrpi2     45 -  46      mracbpi2     47 -  48
      racreci3     49 -  49      hiscodi3     50 -  50
      nowaf        51 -  51      rrp          52 -  53
  str hhreflg      54 -  54      frrp         55 -  56
      age_p        57 -  58      age_chg      59 -  59

  str fmrpflg      60 -  60  str fmreflg      61 -  61
      r_maritl     62 -  62  str fspous2      63 -  64
      cohab1       65 -  65      cohab2       66 -  66
  str fcohab3      67 -  68      cdcmstat     69 -  69
      sib_degp     70 -  70  str fmother1     71 -  72
      mom_degp     73 -  73  str ffather1     74 -  75
      dad_degp     76 -  76      parents      77 -  77
      mom_ed       78 -  79      dad_ed       80 -  81
      astatflg     82 -  82      cstatflg     83 -  83
      qcadult      84 -  84      qcchild      85 -  85

      fdrn_flg     86 -  86

      plaplylm     87 -  87      plaplyun     88 -  88
      pspedeis     89 -  89      pspedem      90 -  90
      plaadl       91 -  91      labath       92 -  92
      ladress      93 -  93      laeat        94 -  94
      labed        95 -  95      latoilt      96 -  96
      lahome       97 -  97      plaiadl      98 -  98
      plawknow     99 -  99      plawklim    100 - 100
      plawalk     101 - 101      plaremem    102 - 102
      plimany     103 - 103      la1ar       104 - 104
      lahcc1      105 - 105      lahcc2      106 - 106
      lahcc3      107 - 107      lahcc4      108 - 108
      lahcc5      109 - 109      lahcc6      110 - 110
      lahcc7a     111 - 111      lahcc8      112 - 112
      lahcc9      113 - 113      lahcc10     114 - 114
      lahcc11     115 - 115      lahcc12     116 - 116
      lahcc13     117 - 117      lahcc90     118 - 118
      lahcc91     119 - 119      lctime1     120 - 121
      lcunit1     122 - 122      lcdura1     123 - 124
      lcdurb1     125 - 125      lcchrc1     126 - 126
      lctime2     127 - 128      lcunit2     129 - 129
      lcdura2     130 - 131      lcdurb2     132 - 132
      lcchrc2     133 - 133      lctime3     134 - 135
      lcunit3     136 - 136      lcdura3     137 - 138
      lcdurb3     139 - 139      lcchrc3     140 - 140
      lctime4     141 - 142      lcunit4     143 - 143
      lcdura4     144 - 145      lcdurb4     146 - 146
      lcchrc4     147 - 147      lctime5     148 - 149
      lcunit5     150 - 150      lcdura5     151 - 152
      lcdurb5     153 - 153      lcchrc5     154 - 154
      lctime6     155 - 156      lcunit6     157 - 157
      lcdura6     158 - 159      lcdurb6     160 - 160
      lcchrc6     161 - 161      lctime7a    162 - 163
      lcunit7a    164 - 164      lcdura7a    165 - 166
      lcdurb7a    167 - 167      lcchrc7a    168 - 168
      lctime8     169 - 170      lcunit8     171 - 171
      lcdura8     172 - 173      lcdurb8     174 - 174
      lcchrc8     175 - 175      lctime9     176 - 177
      lcunit9     178 - 178      lcdura9     179 - 180
      lcdurb9     181 - 181      lcchrc9     182 - 182
      lctime10    183 - 184      lcunit10    185 - 185
      lcdura10    186 - 187      lcdurb10    188 - 188
      lcchrc10    189 - 189      lctime11    190 - 191
      lcunit11    192 - 192      lcdura11    193 - 194
      lcdurb11    195 - 195      lcchrc11    196 - 196
      lctime12    197 - 198      lcunit12    199 - 199
      lcdura12    200 - 201      lcdurb12    202 - 202
      lcchrc12    203 - 203      lctime13    204 - 205
      lcunit13    206 - 206      lcdura13    207 - 208
      lcdurb13    209 - 209      lcchrc13    210 - 210
      lctime90    211 - 212      lcunit90    213 - 213
      lcdura90    214 - 215      lcdurb90    216 - 216
      lcchrc90    217 - 217      lctime91    218 - 219
      lcunit91    220 - 220      lcdura91    221 - 222
      lcdurb91    223 - 223      lcchrc91    224 - 224
      lahca1      225 - 225      lahca2      226 - 226
      lahca3      227 - 227      lahca4      228 - 228
      lahca5      229 - 229      lahca6      230 - 230
      lahca7      231 - 231      lahca8      232 - 232
      lahca9      233 - 233      lahca10     234 - 234
      lahca11     235 - 235      lahca12     236 - 236
      lahca13     237 - 237      lahca14a    238 - 238
      lahca15     239 - 239      lahca16     240 - 240
      lahca17     241 - 241      lahca18     242 - 242
      lahca19_    243 - 243      lahca20_    244 - 244
      lahca21_    245 - 245      lahca22_    246 - 246
      lahca23_    247 - 247      lahca24_    248 - 248
      lahca25_    249 - 249      lahca26_    250 - 250
      lahca27_    251 - 251      lahca28_    252 - 252
      lahca29_    253 - 253      lahca30_    254 - 254
      lahca31_    255 - 255      lahca32_    256 - 256
      lahca33_    257 - 257      lahca34_    258 - 258
      lahca90     259 - 259      lahca91     260 - 260
      latime1     261 - 262      launit1     263 - 263
      ladura1     264 - 265      ladurb1     266 - 266
      lachrc1     267 - 267      latime2     268 - 269
      launit2     270 - 270      ladura2     271 - 272
      ladurb2     273 - 273      lachrc2     274 - 274
      latime3     275 - 276      launit3     277 - 277
      ladura3     278 - 279      ladurb3     280 - 280
      lachrc3     281 - 281      latime4     282 - 283
      launit4     284 - 284      ladura4     285 - 286
      ladurb4     287 - 287      lachrc4     288 - 288
      latime5     289 - 290      launit5     291 - 291
      ladura5     292 - 293      ladurb5     294 - 294
      lachrc5     295 - 295      latime6     296 - 297
      launit6     298 - 298      ladura6     299 - 300
      ladurb6     301 - 301      lachrc6     302 - 302
      latime7     303 - 304      launit7     305 - 305
      ladura7     306 - 307      ladurb7     308 - 308
      lachrc7     309 - 309      latime8     310 - 311
      launit8     312 - 312      ladura8     313 - 314
      ladurb8     315 - 315      lachrc8     316 - 316
      latime9     317 - 318      launit9     319 - 319
      ladura9     320 - 321      ladurb9     322 - 322
      lachrc9     323 - 323      latime10    324 - 325
      launit10    326 - 326      ladura10    327 - 328
      ladurb10    329 - 329      lachrc10    330 - 330
      latime11    331 - 332      launit11    333 - 333
      ladura11    334 - 335      ladurb11    336 - 336
      lachrc11    337 - 337      latime12    338 - 339
      launit12    340 - 340      ladura12    341 - 342
      ladurb12    343 - 343      lachrc12    344 - 344
      latime13    345 - 346      launit13    347 - 347
      ladura13    348 - 349      ladurb13    350 - 350
      lachrc13    351 - 351      ltime14a    352 - 353
      lunit14a    354 - 354      ldura14a    355 - 356
      ldurb14a    357 - 357      lchrc14a    358 - 358
      latime15    359 - 360      launit15    361 - 361
      ladura15    362 - 363      ladurb15    364 - 364
      lachrc15    365 - 365      latime16    366 - 367
      launit16    368 - 368      ladura16    369 - 370
      ladurb16    371 - 371      lachrc16    372 - 372
      latime17    373 - 374      launit17    375 - 375
      ladura17    376 - 377      ladurb17    378 - 378
      lachrc17    379 - 379      latime18    380 - 381
      launit18    382 - 382      ladura18    383 - 384
      ladurb18    385 - 385      lachrc18    386 - 386
      latime19    387 - 388      launit19    389 - 389
      ladura19    390 - 391      ladurb19    392 - 392
      lachrc19    393 - 393      latime20    394 - 395
      launit20    396 - 396      ladura20    397 - 398
      ladurb20    399 - 399      lachrc20    400 - 400
      latime21    401 - 402      launit21    403 - 403
      ladura21    404 - 405      ladurb21    406 - 406
      lachrc21    407 - 407      latime22    408 - 409
      launit22    410 - 410      ladura22    411 - 412
      ladurb22    413 - 413      lachrc22    414 - 414
      latime23    415 - 416      launit23    417 - 417
      ladura23    418 - 419      ladurb23    420 - 420
      lachrc23    421 - 421      latime24    422 - 423
      launit24    424 - 424      ladura24    425 - 426
      ladurb24    427 - 427      lachrc24    428 - 428
      latime25    429 - 430      launit25    431 - 431
      ladura25    432 - 433      ladurb25    434 - 434
      lachrc25    435 - 435      latime26    436 - 437
      launit26    438 - 438      ladura26    439 - 440
      ladurb26    441 - 441      lachrc26    442 - 442
      latime27    443 - 444      launit27    445 - 445
      ladura27    446 - 447      ladurb27    448 - 448
      lachrc27    449 - 449      latime28    450 - 451
      launit28    452 - 452      ladura28    453 - 454
      ladurb28    455 - 455      lachrc28    456 - 456
      latime29    457 - 458      launit29    459 - 459
      ladura29    460 - 461      ladurb29    462 - 462
      lachrc29    463 - 463      latime30    464 - 465
      launit30    466 - 466      ladura30    467 - 468
      ladurb30    469 - 469      lachrc30    470 - 470
      latime31    471 - 472      launit31    473 - 473
      ladura31    474 - 475      ladurb31    476 - 476
      lachrc31    477 - 477      latime32    478 - 479
      launit32    480 - 480      ladura32    481 - 482
      ladurb32    483 - 483      lachrc32    484 - 484
      latime33    485 - 486      launit33    487 - 487
      ladura33    488 - 489      ladurb33    490 - 490
      lachrc33    491 - 491      latime34    492 - 493
      launit34    494 - 494      ladura34    495 - 496
      ladurb34    497 - 497      lachrc34    498 - 498
      latime90    499 - 500      launit90    501 - 501
      ladura90    502 - 503      ladurb90    504 - 504
      lachrc90    505 - 505      latime91    506 - 507
      launit91    508 - 508      ladura91    509 - 510
      ladurb91    511 - 511      lachrc91    512 - 512
      lcondrt     513 - 513      lachronr    514 - 514
      phstat      515 - 515

      pdmed12m    516 - 516      pnmed12m    517 - 517
      phospyr2    518 - 518      hospno      519 - 521
      hpnite      522 - 524      phchm2w     525 - 525
      phchmn2w    526 - 527      phcph2wr    528 - 528
      phcphn2w    529 - 530      phcdv2w     531 - 531
      phcdvn2w    532 - 533      p10dvyr     534 - 534

      notcov      535 - 535      cover       536 - 536
      cover65     537 - 537      cover65o    538 - 538
      medicare    539 - 539      mcpart      540 - 540
      mcchoice    541 - 541      mchmo       542 - 542
      mcadvr      543 - 543      mcprem      544 - 544
      mcref       545 - 545      mcpartd     546 - 546
      medicaid    547 - 547      maflg       548 - 548
      machmd      549 - 549      mxchng      550 - 550
      medprem     551 - 551      mdprinc     552 - 552
      single      553 - 553      sstypea     554 - 554
      sstypeb     555 - 555      sstypec     556 - 556
      sstyped     557 - 557      sstypee     558 - 558
      sstypef     559 - 559      sstypeg     560 - 560
      sstypeh     561 - 561      sstypei     562 - 562
      sstypej     563 - 563      sstypek     564 - 564
      sstypel     565 - 565      private     566 - 566
      prflg       567 - 567      exchange    568 - 568
      whonam1     569 - 569      prpolh1     570 - 570
      prcooh1     571 - 571      plnwrks1    572 - 573
      plnexch1    574 - 574      exchpr1     575 - 575
      plnpay11    576 - 576      plnpay21    577 - 577
      plnpay31    578 - 578      plnpay41    579 - 579
      plnpay51    580 - 580      plnpay61    581 - 581
      plnpay71    582 - 582      plnpre1     583 - 583
      hicostr1    584 - 588      plnmgd1     589 - 589
      hdhp1       590 - 590      hsahra1     591 - 591
      mgchmd1     592 - 592      mgprmd1     593 - 593
      mgpymd1     594 - 594      pcpreq1     595 - 595
      prrxcov1    596 - 596      prdncov1    597 - 597
      pxchng      598 - 598      plexchpr    599 - 599
      pstrfprm    600 - 600      pssprinc    601 - 601
      pstdoc      602 - 602      whonam2     603 - 603
      prpolh2     604 - 604      prcooh2     605 - 605
      plnwrks2    606 - 607      plnexch2    608 - 608
      exchpr2     609 - 609      plnpay12    610 - 610
      plnpay22    611 - 611      plnpay32    612 - 612
      plnpay42    613 - 613      plnpay52    614 - 614
      plnpay62    615 - 615      plnpay72    616 - 616
      plnpre2     617 - 617      hicostr2    618 - 622
      plnmgd2     623 - 623      hdhp2       624 - 624
      hsahra2     625 - 625      mgchmd2     626 - 626
      mgprmd2     627 - 627      mgpymd2     628 - 628
      pcpreq2     629 - 629      prrxcov2    630 - 630
      prdncov2    631 - 631      prplplus    632 - 632
      fcovconf    633 - 633      schip       634 - 634
      chflg       635 - 635      chxchng     636 - 636
      strfprm1    637 - 637      chprinc     638 - 638
      stdoc1      639 - 639      othpub      640 - 640
      opflg       641 - 641      opxchng     642 - 642
      plexchop    643 - 643      strfprm2    644 - 644
      ssprinc     645 - 645      stdoc2      646 - 646
      othgov      647 - 647      ogflg       648 - 648
      ogxchng     649 - 649      plexchog    650 - 650
      strfprm3    651 - 651      ogprinc     652 - 652
      stdoc3      653 - 653      milcare     654 - 654
      milspc1     655 - 655      milspc2     656 - 656
      milspc3     657 - 657      milspc4     658 - 658
      milmanr     659 - 659      ihs         660 - 660
      hilast2     661 - 661      histop1     662 - 662
      histop2     663 - 663      histop3     664 - 664
      histop4     665 - 665      histop5     666 - 666
      histop6     667 - 667      histop7     668 - 668
      histop8     669 - 669      histop9     670 - 670
      histop10    671 - 671      histop11    672 - 672
      histop12    673 - 673      histop13    674 - 674
      histop14    675 - 675      histop15    676 - 676
      hinotyr     677 - 677      hinotmyr    678 - 679
      fhichng     680 - 680      fhikdba     681 - 681
      fhikdbb     682 - 682      fhikdbc     683 - 683
      fhikdbd     684 - 684      fhikdbe     685 - 685
      fhikdbf     686 - 686      fhikdbg     687 - 687
      fhikdbh     688 - 688      fhikdbi     689 - 689
      fhikdbj     690 - 690      fhikdbk     691 - 691
      pwrkbr1     692 - 693      hcspfyr     694 - 694
      medbill     695 - 695      medbpay     696 - 696
      medbnop     697 - 697      fsa         698 - 698
      hikindna    699 - 699      hikindnb    700 - 700
      hikindnc    701 - 701      hikindnd    702 - 702
      hikindne    703 - 703      hikindnf    704 - 704
      hikindng    705 - 705      hikindnh    706 - 706
      hikindni    707 - 707      hikindnj    708 - 708
      hikindnk    709 - 709      mcareprb    710 - 710
      mcaidprb    711 - 711      sincov      712 - 712

      plborn      713 - 713      regionbr    714 - 715
      geobrth     716 - 716      yrsinus     717 - 717
      citizenp    718 - 718      headst      719 - 719
      headstv1    720 - 720      educ1       721 - 722
      armfver     723 - 723      armfev      724 - 724
      armffc      725 - 725      armftm1p    726 - 726
      armftm2p    727 - 727      armftm3p    728 - 728
      armftm4p    729 - 729      armftm5p    730 - 730
      armftm6p    731 - 731      armftm7p    732 - 732
      doinglwp    733 - 733      whynowkp    734 - 735
      wrkhrs2     736 - 737      wrkftall    738 - 738
      wrklyr1     739 - 739      wrkmyr      740 - 741
      ernyr_p     742 - 743      hiempof     744 - 744

      fincint     745 - 745      psal        746 - 746
      pseinc      747 - 747      pssrr       748 - 748
      pssrrdb     749 - 749      pssrrd      750 - 750
      ppens       751 - 751      popens      752 - 752
      pssi        753 - 753      pssid       754 - 754
      ptanf       755 - 755      powben      756 - 756
      pintrstr    757 - 757      pdivd       758 - 758
      pchldsp     759 - 759      pincot      760 - 760
      pssapl      761 - 761      psdapl      762 - 762
      tanfmyr     763 - 764      eligpwic    765 - 765
      pwic        766 - 766      wic_flag    767 - 767

      englang     768 - 768

using $mdata/nhis_data/2017/personsx.dat;
replace wtia = wtia/10;

* DEFINE VARIABLE LABELS;

label variable rectype  "File type identifier";
label variable srvy_yr  "Year of National Health Interview Survey";
label variable hhx      "Household Number";
label variable intv_qrt "Interview Quarter";
label variable intv_mon "Assignment/Interview Month";
label variable fmx      "Family Number";
label variable fpx      "Person Number (Within family)";
label variable wtia     "Weight - Interim Annual";
label variable wtfa     "Weight - Final Annual";

label variable region   "Region";
label variable pstrat   "Pseudo-stratum for public-use file variance estimation
";
label variable ppsu     "Pseudo-PSU for public-use file variance estimation";

label variable sex      "Sex";
label variable origin_i "Hispanic Ethnicity";
label variable hispan_i "Hispanic subgroup detail";
label variable racerpi2 "OMB groups w/multiple race";
label variable mracrpi2 "Race coded to single/multiple race group";
label variable mracbpi2 "Race coded to single/multiple race group";
label variable racreci3 "Race Recode";
label variable hiscodi3 "Race/ethnicity recode";
label variable nowaf    "Armed Forces Status";
label variable rrp      "Relationship to the HH reference person";
label variable hhreflg  "HH Reference Person Flag";
label variable frrp     "Relationship to family ref. Person";
label variable age_p    "Age";
label variable age_chg  "Indication of AGE correction due to data entry error";

label variable fmrpflg  "Family Respondent Flag";
label variable fmreflg  "Family Reference Person Flag";
label variable r_maritl "Marital Status";
label variable fspous2  "Person # of spouse";
label variable cohab1   "Cohabiting person ever married";
label variable cohab2   "Cohabiting person's current marital status";
label variable fcohab3  "Person # of partner";
label variable cdcmstat "CDC standard for legal marital status";
label variable sib_degp "Degree of sibling relationship to HH reference person";
label variable fmother1 "Person # of mother";
label variable mom_degp "Type of relationship with Mother";
label variable ffather1 "Person # of father";
label variable dad_degp "Type of relationship with Father";
label variable parents  "Parent(s) present in the family";
label variable mom_ed   "Education of Mother";
label variable dad_ed   "Education of Father";
label variable astatflg "Sample Adult Flag";
label variable cstatflg "Sample Child Flag";
label variable qcadult  "Quality control flag for sample adult";
label variable qcchild  "Quality control flag for sample child";

label variable fdrn_flg "Disability Questions flag";

label variable plaplylm "Is - - limited in kind/amount play?";
label variable plaplyun "Is - - able to play at all?";
label variable pspedeis "Does - - receive Special Education or EIS?";
label variable pspedem  "
Receive Special Education/EIS due to emotional/behavioral problem";
label variable plaadl   "Does - - need help with personal care?";
label variable labath   "Does - - need help with bathing/showering?";
label variable ladress  "Does - - need help dressing?";
label variable laeat    "Does - - need help eating?";
label variable labed    "Does - - need help in/out of bed or chairs?";
label variable latoilt  "Does - - need help using the toilet?";
label variable lahome   "Does - - need help to get around in the home?";
label variable plaiadl  "Does - - need help with routine needs?";
label variable plawknow "Is - - unable to work NOW due to health problem?";
label variable plawklim "Is - - limited in kind/amount of work?";
label variable plawalk  "Does - - have difficulty walking without equipment?";
label variable plaremem "Is - - limited by difficulty remembering?";
label variable plimany  "Is - - limited in any (other) way?";
label variable la1ar    "Any limitation - all persons, all conditions";
label variable lahcc1   "Vision/problem seeing causes limitation";
label variable lahcc2   "Hearing problem causes limitation";
label variable lahcc3   "Speech problem causes limitation";
label variable lahcc4   "Asthma/breathing problem causes limitation";
label variable lahcc5   "Birth defect causes limitation";
label variable lahcc6   "Injury causes limitation";
label variable lahcc7a  "
Intellectual disability, also known as mental retardation causes limitation";
label variable lahcc8   "
Other developmental problem (e.g., cerebral palsy) causes limitation";
label variable lahcc9   "
Other mental, emotional, or behavioral problem causes limitation";
label variable lahcc10  "Bone, joint, or muscle problem causes limitation";
label variable lahcc11  "Epilepsy or seizures cause limitation";
label variable lahcc12  "Learning disability causes limitation";
label variable lahcc13  "
Attention Deficit/Hyperactivity Disorder (ADD/ADHD) causes limitation";
label variable lahcc90  "Other impairment/problem (1) causes limitation";
label variable lahcc91  "Other impairment/problem (2) causes limitation";
label variable lctime1  "Duration of vision problem: Number of units";
label variable lcunit1  "Duration of vision problem: Time unit";
label variable lcdura1  "Duration of vision problem (in years)";
label variable lcdurb1  "Duration of vision problem recode 2";
label variable lcchrc1  "Vision problem condition status";
label variable lctime2  "Duration of hearing problem: Number of units";
label variable lcunit2  "Duration of hearing problem: Time unit";
label variable lcdura2  "Duration of hearing problem (in years)";
label variable lcdurb2  "Duration of hearing problem recode 2";
label variable lcchrc2  "Hearing problem condition status";
label variable lctime3  "Duration of speech problem: Number of units";
label variable lcunit3  "Duration of speech problem: Time unit";
label variable lcdura3  "Duration of speech problem (in years)";
label variable lcdurb3  "Duration of speech problem recode 2";
label variable lcchrc3  "Speech problem condition status";
label variable lctime4  "Duration of asthma/breathing problem: Number of units";
label variable lcunit4  "Duration of asthma/breathing problem: Time unit";
label variable lcdura4  "Duration of asthma/breathing problem (in years)";
label variable lcdurb4  "Duration of asthma/breathing problem recode 2";
label variable lcchrc4  "Asthma/breathing problem condition status";
label variable lctime5  "Duration of birth defect: Number of units";
label variable lcunit5  "Duration of birth defect: Time unit";
label variable lcdura5  "Duration of birth defect (in years)";
label variable lcdurb5  "Duration of birth defect recode 2";
label variable lcchrc5  "Birth defect condition status";
label variable lctime6  "Duration of injury: Number of units";
label variable lcunit6  "Duration of injury: Time unit";
label variable lcdura6  "Duration of injury (in years)";
label variable lcdurb6  "Duration of injury recode 2";
label variable lcchrc6  "Injury condition status";
label variable lctime7a "
Duration of intellectual disability, AKA mental retardation: Number of units";
label variable lcunit7a "
Duration of intellectual disability, also known as mental retardation: Time unit
";
label variable lcdura7a "
Duration of intellectual disability, also known as mental retardation (in years)
";
label variable lcdurb7a "
Duration of intellectual disability, also known as mental retardation recode 2";
label variable lcchrc7a "
Intellectual disability, also known as mental retardation condition status";
label variable lctime8  "
Duration of other developmental problem: Number of units";
label variable lcunit8  "Duration of other developmental problem: Time unit";
label variable lcdura8  "Duration of other developmental problem (in years)";
label variable lcdurb8  "Duration of other developmental problem recode 2";
label variable lcchrc8  "Other developmental problem condition status";
label variable lctime9  "
Duration of other mental/emotional/behavioral problem: Number of units";
label variable lcunit9  "
Duration of other mental, emotional, or behavioral problem: Number of units";
label variable lcdura9  "
Duration of other mental, emotional, or behavioral problem (in years)";
label variable lcdurb9  "
Duration of other mental, emotional, or behavioral problem recode 2";
label variable lcchrc9  "
Other mental, emotional, or behavioral problem condition status";
label variable lctime10 "
Duration of bone, joint, or muscle problem: Number of units";
label variable lcunit10 "Duration of bone, joint, or muscle problem: Time unit";
label variable lcdura10 "Duration of bone, joint, or muscle problem (in years)";
label variable lcdurb10 "Duration of bone, joint, or muscle problem recode 2";
label variable lcchrc10 "Bone, joint, or muscle problem condition status";
label variable lctime11 "Duration of epilepsy or seizures: Number of units";
label variable lcunit11 "Duration of epilepsy or seizures: Time unit";
label variable lcdura11 "Duration of epilepsy or seizures (in years)";
label variable lcdurb11 "Duration of epilepsy or seizures recode 2";
label variable lcchrc11 "Epilepsy or seizures condition status";
label variable lctime12 "Duration of learning disability: Number of units";
label variable lcunit12 "Duration of learning disability: Time unit";
label variable lcdura12 "Duration of learning disability (in years)";
label variable lcdurb12 "Duration of learning disability recode 2";
label variable lcchrc12 "Learning disability condition status";
label variable lctime13 "
Duration of attention deficit/hyperactivity disorder (ADD/ADHD): Number of units
";
label variable lcunit13 "
Duration of attention deficit/hyperactivity disorder (ADD/ADHD): Time unit";
label variable lcdura13 "
Duration of attention deficit/hyperactivity disorder (ADD/ADHD) (in years)";
label variable lcdurb13 "
Duration of attention deficit/hyperactivity disorder (ADD/ADHD) recode 2";
label variable lcchrc13 "
Attention deficit/hyperactivity disorder (ADD/ADHD) condition status";
label variable lctime90 "
Duration of other impairment problem (1): Number of units";
label variable lcunit90 "Duration of other impairment/problem (1): Time unit";
label variable lcdura90 "Duration of other impairment/problem (1) (in years)";
label variable lcdurb90 "Duration of other impairment/problem (1) recode 2";
label variable lcchrc90 "Other impairment/problem (1) condition status";
label variable lctime91 "
Duration of other impairment/problem (2): Number of units";
label variable lcunit91 "Duration of other impairment/problem (2): Time unit";
label variable lcdura91 "Duration of other impairment/problem (2) (in years)";
label variable lcdurb91 "Duration of other impairment/problem (2) recode 2";
label variable lcchrc91 "Other impairment/problem (2) condition status";
label variable lahca1   "Vision/problem seeing causes limitation";
label variable lahca2   "Hearing problem causes limitation";
label variable lahca3   "Arthritis/rheumatism causes limitation";
label variable lahca4   "Back or neck problem causes limitation";
label variable lahca5   "Fracture, bone/joint injury causes limitation";
label variable lahca6   "Other injury causes limitation";
label variable lahca7   "Heart problem causes limitation";
label variable lahca8   "Stroke problem causes limitation";
label variable lahca9   "Hypertension/high blood pressure causes limitation";
label variable lahca10  "Diabetes causes limitation";
label variable lahca11  "
Lung/breathing problem (e.g., asthma and emphysema) causes limitation";
label variable lahca12  "Cancer causes limitation";
label variable lahca13  "Birth defect causes limitation";
label variable lahca14a "
Intellectual disability, also known as mental retardation causes limitation";
label variable lahca15  "
Other developmental problem (e.g., cerebral palsy) causes limitation";
label variable lahca16  "Senility causes limitation";
label variable lahca17  "Depression/anxiety/emotional problem causes limitation
";
label variable lahca18  "Weight problem causes limitation";
label variable lahca19_ "
Missing or amputated limb/finger/digit causes limitation";
label variable lahca20_ "
Musculoskeletal/connective tissue problem causes limitation";
label variable lahca21_ "
Circulation problems (including blood clots) cause limitation";
label variable lahca22_ "
Endocrine/nutritional/metabolic problem causes limitation";
label variable lahca23_ "
Nervous system/sensory organ condition causes limitation";
label variable lahca24_ "Digestive system problem causes limitation";
label variable lahca25_ "Genitourinary system problem causes limitation";
label variable lahca26_ "Skin/subcutaneous system problem causes limitation";
label variable lahca27_ "Blood or blood-forming organ problem causes limitation
";
label variable lahca28_ "Benign tumor/cyst causes limitation";
label variable lahca29_ "Alcohol/drug/substance abuse problem causes limitation
";
label variable lahca30_ "
Other mental problem/ADD/bipolar/schizophrenia causes limitation";
label variable lahca31_ "
Surgical after-effects/medical treatment causes limitation";
label variable lahca32_ "
'Old age'/elderly/aging-related problem causes limitation";
label variable lahca33_ "Fatigue/tiredness/weakness causes limitation";
label variable lahca34_ "Pregnancy-related problem causes limitation";
label variable lahca90  "Other impairment/problem (1) causes limitation";
label variable lahca91  "Other impairment/problem (2) causes limitation";
label variable latime1  "Duration of vision problem: Number of units";
label variable launit1  "Duration of vision problem: Time unit";
label variable ladura1  "Duration of vision problem (in years)";
label variable ladurb1  "Duration of vision problem recode 2";
label variable lachrc1  "Vision problem condition status";
label variable latime2  "Duration of hearing problem: Number of units";
label variable launit2  "Duration of hearing problem: Time unit";
label variable ladura2  "Duration of hearing problem (in years)";
label variable ladurb2  "Duration of hearing problem recode 2";
label variable lachrc2  "Hearing problem condition status";
label variable latime3  "Duration of arthritis/rheumatism: Number of units";
label variable launit3  "Duration of arthritis/rheumatism: Time unit";
label variable ladura3  "Duration of arthritis/rheumatism (in years)";
label variable ladurb3  "Duration of arthritis/rheumatism recode 2";
label variable lachrc3  "Arthritis/rheumatism condition status";
label variable latime4  "Duration of back or neck problem: Number of units";
label variable launit4  "Duration of back or neck problem: Time unit";
label variable ladura4  "Duration of back or neck problem (in years)";
label variable ladurb4  "Duration of back or neck problem recode 2";
label variable lachrc4  "Back or neck problem condition status";
label variable latime5  "
Duration of fracture, bone/joint injury: Number of units";
label variable launit5  "Duration of fracture, bone/joint injury: Time unit";
label variable ladura5  "Duration of fracture, bone/joint injury (in years)";
label variable ladurb5  "Duration of fracture, bone/joint injury recode 2";
label variable lachrc5  "Fracture, bone/joint injury condition status";
label variable latime6  "Duration of other injury: Number of units";
label variable launit6  "Duration of other injury: Time unit";
label variable ladura6  "Duration of other injury (in years)";
label variable ladurb6  "Duration of other injury recode 2";
label variable lachrc6  "Other injury condition status";
label variable latime7  "Duration of heart problem: Number of units";
label variable launit7  "Duration of heart problem: Time unit";
label variable ladura7  "Duration of heart problem (in years)";
label variable ladurb7  "Duration of heart problem recode 2";
label variable lachrc7  "Heart problem condition status";
label variable latime8  "Duration of stroke problem: Number of units";
label variable launit8  "Duration of stroke problem: Time unit";
label variable ladura8  "Duration of stroke problem (in years)";
label variable ladurb8  "Duration of stroke problem recode 2";
label variable lachrc8  "Stroke problem condition status";
label variable latime9  "
Duration of hypertension or high blood pressure: Number of units";
label variable launit9  "
Duration of hypertension or high blood pressure: Time unit";
label variable ladura9  "
Duration of hypertension or high blood pressure (in years)";
label variable ladurb9  "
Duration of hypertension or high blood pressure: recode 2";
label variable lachrc9  "Hypertension or high blood pressure condition status";
label variable latime10 "Duration of diabetes: Number of units";
label variable launit10 "Duration of diabetes: Time unit";
label variable ladura10 "Duration of diabetes (in years)";
label variable ladurb10 "Duration of diabetes recode 2";
label variable lachrc10 "Diabetes condition status";
label variable latime11 "
Duration of lung or breathing problem (eg asthma and emphysema): Number of units
";
label variable launit11 "
Duration of lung or breathing problem (e.g., asthma and emphysema): Time unit";
label variable ladura11 "
Duration of lung or breathing problem (e.g., asthma and emphysema) (in years)";
label variable ladurb11 "
Duration of lung or breathing problem (e.g., asthma and emphysema): recode 2";
label variable lachrc11 "
Lung or breathing problem (e.g., asthma and emphysema): condition status";
label variable latime12 "Duration of cancer: Number of units";
label variable launit12 "Duration of cancer: Time unit";
label variable ladura12 "Duration of cancer (in years)";
label variable ladurb12 "Duration of cancer recode 2";
label variable lachrc12 "Cancer condition status";
label variable latime13 "Duration of birth defect: Number of units";
label variable launit13 "Duration of birth defect: Time unit";
label variable ladura13 "Duration of birth defect (in years)";
label variable ladurb13 "Duration of birth defect recode 2";
label variable lachrc13 "Birth defect condition status";
label variable ltime14a "
Duration of intellectual disability, AKA mental retardation: Number of units";
label variable lunit14a "
Duration of intellectual disability, also known as mental retardation: Time unit
";
label variable ldura14a "
Duration of intellectual disability, also known as mental retardation (in years)
";
label variable ldurb14a "
Duration of intellectual disability, also known as mental retardation recode 2";
label variable lchrc14a "
Intellectual disability, also known as mental retardation condition status";
label variable latime15 "
Duration of other developmental problem (e.g., cerebral palsy): Number of units
";
label variable launit15 "
Duration of other developmental problem (e.g., cerebral palsy): Time unit";
label variable ladura15 "
Duration of other developmental problem (e.g., cerebral palsy) (in years)";
label variable ladurb15 "
Duration of other developmental problem (e.g., cerebral palsy) recode 2";
label variable lachrc15 "
Other developmental problem (e.g., cerebral palsy) condition status";
label variable latime16 "Duration of senility: Number of units";
label variable launit16 "Duration of senility: Time unit";
label variable ladura16 "Duration of senility (in years)";
label variable ladurb16 "Duration of senility recode 2";
label variable lachrc16 "Senility condition status";
label variable latime17 "
Duration of depression, anxiety, or emotional problem: Number of units";
label variable launit17 "
Duration of depression, anxiety, or emotional problem: Time unit";
label variable ladura17 "
Duration of depression, anxiety, or emotional problem (in years)";
label variable ladurb17 "
Duration of depression, anxiety, or emotional problem recode 2";
label variable lachrc17 "Depression/anxiety/emotional problem condition status";
label variable latime18 "Duration of weight problem: Number of units";
label variable launit18 "Duration of weight problem: Time unit";
label variable ladura18 "Duration of weight problem (in years)";
label variable ladurb18 "Duration of weight problem recode 2";
label variable lachrc18 "Weight problem condition status";
label variable latime19 "
Duration of missing limbs (fingers, toes); amputation: Number of units";
label variable launit19 "
Duration of missing limbs (fingers, toes, or digits); amputation: Time unit";
label variable ladura19 "
Duration of missing limbs (fingers, toes, or digits); amputation (in years)";
label variable ladurb19 "
Duration of missing limbs (fingers, toes, or digits); amputation recode 2";
label variable lachrc19 "
Missing limbs (fingers, toes, or digits); amputation condition status";
label variable latime20 "
Duration of musculoskeletal/connective tissue problem: Number of units";
label variable launit20 "
Duration of musculoskeletal/connective tissue problem: Time unit";
label variable ladura20 "
Duration of musculoskeletal/connective tissue problem (in years)";
label variable ladurb20 "
Duration of musculoskeletal/connective tissue problem recode 2";
label variable lachrc20 "
Musculoskeletal/connective tissue problem condition status";
label variable latime21 "
Duration of circulation problems (including blood clots) : Number of units";
label variable launit21 "
Duration of circulation problems (including blood clots): Time unit";
label variable ladura21 "
Duration of circulation problems (including blood clots) (in years)";
label variable ladurb21 "
Duration of circulation problems (including blood clots) recode 2";
label variable lachrc21 "
Circulation problems (including blood clots) condition status";
label variable latime22 "
Duration of endocrine/nutritional/metabolic problem: Number of units";
label variable launit22 "
Duration of endocrine/nutritional/metabolic problem: Time unit";
label variable ladura22 "
Duration of endocrine/nutritional/metabolic problem (in years)";
label variable ladurb22 "
Duration of endocrine/nutritional/metabolic problem recode 2";
label variable lachrc22 "
Endocrine/nutritional/metabolic problem condition status";
label variable latime23 "
Duration of nervous system /sensory organ condition: Number of units";
label variable launit23 "
Duration of nervous system/sensory organ condition: Time unit";
label variable ladura23 "
Duration of nervous system/sensory organ condition (in years)";
label variable ladurb23 "
Duration of nervous system/sensory organ condition recode 2";
label variable lachrc23 "Nervous system/sensory organ condition status";
label variable latime24 "Duration of digestive system problems: Number of units
";
label variable launit24 "Duration of digestive system problems: Number of units
";
label variable ladura24 "Duration of digestive system problems (in years)";
label variable ladurb24 "Duration of digestive system problems recode 2";
label variable lachrc24 "Digestive system problems condition status";
label variable latime25 "
Duration of genitourinary system problem: Number of units";
label variable launit25 "Duration of genitourinary system problem: Time unit";
label variable ladura25 "Duration of genitourinary system problem (in years)";
label variable ladurb25 "Duration of genitourinary system problem recode 2";
label variable lachrc25 "Genitourinary system problem condition status";
label variable latime26 "
Duration of skin/subcutaneous system problems: Number of units";
label variable launit26 "
Duration of skin/subcutaneous system problems: Time unit";
label variable ladura26 "
Duration of skin/subcutaneous system problems (in years)";
label variable ladurb26 "Duration of skin/subcutaneous system problem recode 2";
label variable lachrc26 "Skin/subcutaneous system problems condition status";
label variable latime27 "
Duration of blood or blood-forming organ problem: Number of units";
label variable launit27 "
Duration of blood or blood-forming organ problem: Time unit";
label variable ladura27 "
Duration of blood or blood-forming organ problem (in years)";
label variable ladurb27 "
Duration of blood or blood-forming organ problem recode 2";
label variable lachrc27 "Blood or blood-forming organ problem condition status";
label variable latime28 "Duration of benign tumor/cyst: Number of units";
label variable launit28 "Duration of benign tumor/cyst: Time unit";
label variable ladura28 "Duration of benign tumor/cyst (in years)";
label variable ladurb28 "Duration of benign tumor/cyst recode 2";
label variable lachrc28 "Benign tumor/cyst condition status";
label variable latime29 "
Duration of alcohol/drug/substance abuse problem: Number of units";
label variable launit29 "
Duration of alcohol/drug/substance abuse problem: Time unit";
label variable ladura29 "
Duration of alcohol/drug/substance abuse problem (in years)";
label variable ladurb29 "
Duration of alcohol/drug/substance abuse problem recode 2";
label variable lachrc29 "Alcohol/drug/substance abuse problem condition status";
label variable latime30 "
Duration of other mental problem/ADD/Bipolar/Schizophrenia: Number of units";
label variable launit30 "
Duration of other mental problem/ADD/Bipolar/Schizophrenia: Time unit";
label variable ladura30 "
Duration of other mental problem/ADD/Bipolar/Schizophrenia (in years)";
label variable ladurb30 "
Duration of other mental problem/ADD/Bipolar/Schizophrenia recode 2";
label variable lachrc30 "
Other mental problem/ADD/Bipolar/Schizophrenia condition status";
label variable latime31 "
Duration of surgical after-effects/medical treatment problems: Number of units";
label variable launit31 "
Duration of surgical after-effects/medical treatment problems: Time unit";
label variable ladura31 "
Duration of surgical after-effects/medical treatment problems (in years)";
label variable ladurb31 "
Duration of surgical after-effects/medical treatment problems recode 2";
label variable lachrc31 "
Surgical after-effects/medical treatment problems condition status";
label variable latime32 "
Duration of 'old age'/elderly/aging-related problems: Number of units";
label variable launit32 "
Duration of 'old age'/elderly/aging-related problems: Number of units";
label variable ladura32 "
Duration of 'old age'/elderly/aging-related problems (in years)";
label variable ladurb32 "
Duration of 'old age'/elderly/aging-related problems recode 2";
label variable lachrc32 "
'Old age'/elderly/aging-related problems condition status";
label variable latime33 "
Duration of fatigue/tiredness/weakness problem: Number of units";
label variable launit33 "
Duration of fatigue/tiredness/weakness problem: Time unit";
label variable ladura33 "
Duration of fatigue/tiredness/weakness problem (in years)";
label variable ladurb33 "Duration of fatigue/tiredness/weakness problem recode 2
";
label variable lachrc33 "Fatigue/tiredness/weakness problem condition status";
label variable latime34 "Duration of pregnancy-related problem: Number of units
";
label variable launit34 "Duration of pregnancy-related problem: Time unit";
label variable ladura34 "Duration of pregnancy-related problem (in years)";
label variable ladurb34 "Duration of pregnancy-related problem recode 2";
label variable lachrc34 "Pregnancy-related condition status";
label variable latime90 "
Duration of other impairment/problem N.E.C. (1): Number of units";
label variable launit90 "
Duration of other impairment/problem N.E.C. (1): Time unit";
label variable ladura90 "
Duration of other impairment/problem N.E.C. (1) (in years)";
label variable ladurb90 "
Duration of other impairment/problem N.E.C. (1) recode 2";
label variable lachrc90 "Other impairment/problem N.E.C. (1) condition status";
label variable latime91 "
Duration of other impairment/problem N.E.C. (2): Number of units";
label variable launit91 "
Duration of other impairment/problem N.E.C. (2): Time unit";
label variable ladura91 "
Duration of other impairment/problem N.E.C. (2) (in years)";
label variable ladurb91 "
Duration of other impairment/problem N.E.C. (2) recode 2";
label variable lachrc91 "Other impairment/problem N.E.C. (2) condition status";
label variable lcondrt  "
Chronic condition recode for person with limitation of activity";
label variable lachronr "
Limitation of activity recode by chronic condition status";
label variable phstat   "Reported health status";

label variable pdmed12m "Has medical care been delayed for - - (cost), 12m";
label variable pnmed12m "Did - - need and NOT get medical care (cost), 12m";
label variable phospyr2 "Has - - been in a hospital OVERNIGHT, 12m";
label variable hospno   "Number of times in hospital overnight, 12m";
label variable hpnite   "Number of nights in hospital, 12m";
label variable phchm2w  "Did - - receive HOME care by health professional, 2 wk
";
label variable phchmn2w "Number of HOME visits by health professional, 2wk";
label variable phcph2wr "Did--get advice/test results by phone, 2wk";
label variable phcphn2w "Number of PHONE calls to health professional, 2wk";
label variable phcdv2w  "Did - - see health professional in office, etc, 2wk";
label variable phcdvn2w "Number of times VISITED health professional, 2wk";
label variable p10dvyr  "Did - - receive care 10+ times, 12m";

label variable notcov   "Cov stat as used in Health United States";
label variable cover    "Health insurance hierarchy under 65";
label variable cover65  "Health insurance hierarchy 65+";
label variable cover65o "Original health insurance hierarchy 65+";
label variable medicare "Medicare coverage recode";
label variable mcpart   "Type of Medicare coverage";
label variable mcchoice "Enrolled in Medicare Advantage Plan";
label variable mchmo    "Is - - signed up with an HMO";
label variable mcadvr   "Medicare Advantage Plan";
label variable mcprem   "Premium for Medicare Advantage/ Medicare HMO";
label variable mcref    "Need a referral for special care";
label variable mcpartd  "Medicare Part D";
label variable medicaid "Medicaid coverage recode";
label variable maflg    "Medicaid reassignment flag";
label variable machmd   "Any doc, chooses from a list, doc assigned";
label variable mxchng   "Medicaid Exchange";
label variable medprem  "Medicaid Premium";
label variable mdprinc  "Medicaid Premium based on income";
label variable single   "Single service plan recode";
label variable sstypea  "Accidents";
label variable sstypeb  "AIDS care";
label variable sstypec  "Cancer treatment";
label variable sstyped  "Catastrophic care";
label variable sstypee  "Dental care";
label variable sstypef  "Disability insurance";
label variable sstypeg  "Hospice care";
label variable sstypeh  "Hospitalization only";
label variable sstypei  "Long-term care";
label variable sstypej  "Prescriptions";
label variable sstypek  "Vision care";
label variable sstypel  "Other";
label variable private  "Private health insurance recode";
label variable prflg    "Private reassignment flag";
label variable exchange "Plan through Health Insurance Exchange, NCHS algorithm
";
label variable whonam1  "Plan in whose name (Plan 1)";
label variable prpolh1  "Relationship to outside policyholder (Plan 1)";
label variable prcooh1  "Covered persons outside family roster (Plan 1)";
label variable plnwrks1 "How plan was originally obtained (Plan 1)";
label variable plnexch1 "Health Plan obtained through the MarketPlace (Plan 1)";
label variable exchpr1  "Exchange company coding, NCHS (Plan 1)";
label variable plnpay11 "Paid for by self or family (Plan 1)";
label variable plnpay21 "Paid for by employer or union (Plan 1)";
label variable plnpay31 "Paid for by someone outside the household (Plan 1)";
label variable plnpay41 "Paid for by Medicare (Plan 1)";
label variable plnpay51 "Paid for by Medicaid (Plan 1)";
label variable plnpay61 "Paid for by CHIP (Plan 1)";
label variable plnpay71 "Paid for by government program (Plan 1)";
label variable plnpre1  "Premium based on income (Plan 1)";
label variable hicostr1 "Out-of-pocket premium cost (Plan 1)";
label variable plnmgd1  "Type of private plan (Plan 1)";
label variable hdhp1    "High deductible health plan (Plan 1)";
label variable hsahra1  "
Health Savings Accounts/Health Reimbursement Accounts (plan 1)";
label variable mgchmd1  "Doctor choice (Plan 1)";
label variable mgprmd1  "Preferred list (Plan 1)";
label variable mgpymd1  "Out of plan use (Plan 1)";
label variable pcpreq1  "Primary care doctor required (Plan 1)";
label variable prrxcov1 "Prescription drug benefit (Plan 1)";
label variable prdncov1 "Dental Coverage (Plan 1)";
label variable pxchng   "
Marketplace or state exchange, reassigned from public to private";
label variable plexchpr "
Exchange company coding, NCHS, reassigned from public to private";
label variable pstrfprm "
Premium or enrollment fee on plan reassigned from public to private";
label variable pssprinc "
Premium based on income on plan reassigned from public to private";
label variable pstdoc   "
Any dr, chooses from list, dr assigned on plan reassigned from public to private
";
label variable whonam2  "Plan in whose name (Plan 2)";
label variable prpolh2  "Relationship to outside policyholder (Plan 2)";
label variable prcooh2  "Covered persons outside family roster (Plan 2)";
label variable plnwrks2 "How plan was originally obtained (Plan 2)";
label variable plnexch2 "Health Plan obtained through the MarketPlace (Plan 2)";
label variable exchpr2  "Exchange company coding, NCHS (Plan 2)";
label variable plnpay12 "Paid for by self or family (Plan 2)";
label variable plnpay22 "Paid for by employer or union (Plan 2)";
label variable plnpay32 "Paid for by someone outside the household (Plan 2)";
label variable plnpay42 "Paid for by Medicare (Plan 2)";
label variable plnpay52 "Paid for by Medicaid (Plan 2)";
label variable plnpay62 "Paid for by CHIP (Plan 2)";
label variable plnpay72 "Paid for by government program (Plan 2)";
label variable plnpre2  "Premium based on income (Plan 2)";
label variable hicostr2 "Out-of-pocket premium cost (Plan 2)";
label variable plnmgd2  "Type of private plan (plan 2)";
label variable hdhp2    "High deductible health plan (Plan 2)";
label variable hsahra2  "
Health Savings Accounts/Health Reimbursement Accounts (plan 2)";
label variable mgchmd2  "Doctor choice (Plan 2)";
label variable mgprmd2  "Preferred list (Plan 2)";
label variable mgpymd2  "Out of plan use (Plan 2)";
label variable pcpreq2  "Primary care doctor required (Plan 2)";
label variable prrxcov2 "Prescription drug benefit (Plan 2)";
label variable prdncov2 "Dental Coverage (Plan 2)";
label variable prplplus "Person has more than two private plans";
label variable fcovconf "Obtaining affordable coverage";
label variable schip    "CHIP coverage recode";
label variable chflg    "CHIP reassignment flag";
label variable chxchng  "CHIP Exchange";
label variable strfprm1 "CHIP Premium";
label variable chprinc  "CHIP Premium based on income";
label variable stdoc1   "Any doc, chooses from a list, doc assigned (SCHIP)";
label variable othpub   "State-sponsored health plan recode";
label variable opflg    "Other public reassignment flag";
label variable opxchng  "Other state program Exchange";
label variable plexchop "Exchange company coding, NCHS (OTHPUB)";
label variable strfprm2 "Other state program premium";
label variable ssprinc  "Other state program premium based on income";
label variable stdoc2   "Any doc, chooses from a list, doc assigned (OTHPUB)";
label variable othgov   "Other government program recode";
label variable ogflg    "Other government reassignment flag";
label variable ogxchng  "Other government program Exchange";
label variable plexchog "Exchange company coding, NCHS (OTHGOV)";
label variable strfprm3 "Other government program Premium";
label variable ogprinc  "Other government program Premium based on income";
label variable stdoc3   "Any doc, chooses from a list, doc assigned (OTHGOV)";
label variable milcare  "Military health care coverage recode";
label variable milspc1  "TRICARE coverage";
label variable milspc2  "VA coverage";
label variable milspc3  "CHAMP-VA coverage";
label variable milspc4  "Other military coverage";
label variable milmanr  "Type of TRICARE coverage";
label variable ihs      "Indian Health Service recode";
label variable hilast2  "How long since last had health coverage";
label variable histop1  "Lost job or changed employers";
label variable histop2  "Divorced/sep/death of spouse or parent";
label variable histop3  "Ineligible because of age/left school";
label variable histop4  "Employer does not offer/not eligible for cov";
label variable histop5  "Cost is too high";
label variable histop6  "Insurance company refused coverage";
label variable histop7  "Medicaid/medi plan stopped after pregnancy";
label variable histop8  "Lost Medicaid/new job/increase in income";
label variable histop9  "Lost Medicaid (other)";
label variable histop10 "Other";
label variable histop11 "Never had health insurance";
label variable histop12 "Moved from another county/state/country";
label variable histop13 "Self-employed";
label variable histop14 "No need for it/chooses not to have";
label variable histop15 "Got married";
label variable hinotyr  "No health coverage during past 12 months";
label variable hinotmyr "Months without coverage in past 12 months";
label variable fhichng  "No change in coverage in past 12 months";
label variable fhikdba  "
Had private health insurance coverage in the past 12 months";
label variable fhikdbb  "Had Medicare coverage in the past 12 months";
label variable fhikdbc  "Had Medi-Gap coverage in the past 12 months";
label variable fhikdbd  "Had Medicaid coverage in the past 12 months";
label variable fhikdbe  "Had CHIP coverage in the past 12 months";
label variable fhikdbf  "Had Military health care coverage in the past 12 months
";
label variable fhikdbg  "
Had Indian Health Service coverage in the past 12 months";
label variable fhikdbh  "
Had State-sponsored health plan coverage in the past 12 months";
label variable fhikdbi  "
Had Other government program coverage in the past 12 months";
label variable fhikdbj  "Had Single service plan coverage in the past 12 months
";
label variable fhikdbk  "Had no coverage in the past 12 months";
label variable pwrkbr1  "How previous private coverage was obtained";
label variable hcspfyr  "Amount family spent for medical care";
label variable medbill  "Problems paying medical bills";
label variable medbpay  "Medical bills being paid off over time";
label variable medbnop  "Unable to pay medical bills";
label variable fsa      "Flexible Spending Accounts";
label variable hikindna "Private health insurance";
label variable hikindnb "Medicare";
label variable hikindnc "Medi-Gap";
label variable hikindnd "Medicaid";
label variable hikindne "CHIP";
label variable hikindnf "Military health care";
label variable hikindng "Indian Health Service";
label variable hikindnh "State-sponsored health plan";
label variable hikindni "Other government plan";
label variable hikindnj "Single service plan";
label variable hikindnk "No coverage of any type";
label variable mcareprb "Medicare coverage probe";
label variable mcaidprb "Medicaid coverage probe";
label variable sincov   "Single service plan probe";

label variable plborn   "Born in the United States";
label variable regionbr "Geographic region of birth recode";
label variable geobrth  "Geographic place of birth recode";
label variable yrsinus  "Years that - - has been in the U.S.";
label variable citizenp "U.S. citizenship status";
label variable headst   "Now attending Head Start";
label variable headstv1 "Ever attended Head Start";
label variable educ1    "Highest level of school completed";
label variable armfver  "
Currently on full-time active duty with the Armed Forces";
label variable armfev   "
Has - - ever served in U.S. Armed Forces, Reserves, or National Guard?";
label variable armffc   "
Active duty personnel who served on a humanitarian or peacekeeping mission?";
label variable armftm1p "
Was - - active duty in the U.S. military in September, 2001 or later?";
label variable armftm2p "
Was - - active duty in U.S. military in Aug 1990 to Aug 2001 (Persian Gulf War)?
";
label variable armftm3p "
Was - - active duty in the U.S. military in May, 1975 to July, 1990?";
label variable armftm4p "
Was - - active duty in U.S. military in Aug 1964 to April 1975 (Vietnam War)?";
label variable armftm5p "
Was - - active duty in the U.S. military in February, 1955 to July, 1964?";
label variable armftm6p "
Was - - active duty in U.S. military in July 1950 to Jan 1955 (Korean War)?";
label variable armftm7p "
Was - - active duty in the U.S. military in June, 1950 or earlier?";
label variable doinglwp "What was - - doing last week";
label variable whynowkp "Main reason for not working last week";
label variable wrkhrs2  "Hours worked last week";
label variable wrkftall "Usually work full time";
label variable wrklyr1  "Work for pay last year";
label variable wrkmyr   "Months worked last year";
label variable ernyr_p  "Total earnings last year";
label variable hiempof  "Health insurance offered at workplace";

label variable fincint  "Introduction to the family income section";
label variable psal     "Received income from wages or salary (last CY)";
label variable pseinc   "Received income from self-employment (last CY)";
label variable pssrr    "
Received income from Social Security or Railroad Retirement (last CY)";
label variable pssrrdb  "
Received Social Security or Railroad Retirement income as a disability benefit";
label variable pssrrd   "Received benefit due to disability";
label variable ppens    "
Received income from disability pension exp. Soc Security or Railroad Retirement
";
label variable popens   "Received income from any other pension";
label variable pssi     "Received income from SSI";
label variable pssid    "Received SSI due to disability";
label variable ptanf    "
Received income from a state or county welfare program (e.g., TANF)";
label variable powben   "Received other government assistance";
label variable pintrstr "Received interest income";
label variable pdivd    "Received dividends from stocks, funds, etc.";
label variable pchldsp  "Received income from child support";
label variable pincot   "Received income from any other source";
label variable pssapl   "Ever applied for Supplemental Security Income (SSI)";
label variable psdapl   "
Ever applied for Social Security Disability Insurance (SSDI)";
label variable tanfmyr  "Months received welfare/TANF (last CY)";
label variable eligpwic "Anyone age-eligible for the WIC program?";
label variable pwic     "Received WIC benefits";
label variable wic_flag "WIC recipient age-eligible";

label variable englang  "How well English is spoken";

* DEFINE VALUE LABELS FOR REPORTS;

label define pep001x
   10       "10 Household"
   20       "20 Person"
   25       "25 Income Imputation"
   30       "30 Sample Adult"
   38       "38 Functioning and Disability"
   40       "40 Sample Child"
   60       "60 Family"
   63       "63 Family Disability Questions"
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
   01       "01 January"
   02       "02 February"
   03       "03 March"
   04       "04 April"
   05       "05 May"
   06       "06 June"
   07       "07 July"
   08       "08 August"
   09       "09 September"
   10       "10 October"
   11       "11 November"
   12       "12 December"
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
label define pep016x
   01       "01 White only"
   02       "02 Black/African American only"
   03       "03 AIAN only"
   04       "04 Asian only"
   05       "05 Race group not releasable (See file layout)"
   06       "06 Multiple race"
;
label define pep017x
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
label define pep018x
   01       "01 White"
   02       "02 Black/African American"
   03       "03 Indian (American) (includes Eskimo, Aleut)"
   06       "06 Chinese"
   07       "07 Filipino"
   12       "12 Asian Indian"
   16       "16 Other race (See file layout)"
   17       "17 Multiple race, no primary race selected"
;
label define pep019x
   1        "1 White"
   2        "2 Black"
   3        "3 Asian"
   4        "4 All other race groups (See file layout)"
;
label define pep020x
   1        "1 Hispanic"
   2        "2 Non-Hispanic White"
   3        "3 Non-Hispanic Black"
   4        "4 Non-Hispanic Asian"
   5        "5 Non-Hispanic All other race groups"
;
label define pep021x
   1        "1 Armed Forces"
   2        "2 Not Armed Forces"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep022x
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
label define pep024x
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
label define pep025x
   00       "00 Under 1 year"
   85       "85 85+ years"
;
label define pep026x
   1        "1 Change on AGE due to data entry error"
;
label define pep029x
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
label define pep031x
   1        "1 Yes"
   2        "2 No"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep032x
   1        "1 Married"
   2        "2 Widowed"
   3        "3 Divorced"
   4        "4 Separated"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep034x
   1        "1 Separated"
   2        "2 Divorced"
   3        "3 Married"
   4        "4 Single/never married"
   5        "5 Widowed"
   9        "9 Unknown marital status"
;
label define pep035x
   1        "1 Full or Adopted {brother/sister}"
   2        "2 Half {brother/sister}"
   3        "3 Step {brother/sister}"
   4        "4 {Brother/Sister}-in-law"
   9        "9 Other and unknown"
;
label define pep037x
   1        "1 Biological or adoptive"
   2        "2 Step"
   3        "3 In-law"
   9        "9 Other and unknown"
;
label define pep040x
   1        "1 Mother, no father"
   2        "2 Father, no mother"
   3        "3 Mother and father"
   4        "4 Neither mother nor father"
   9        "9 Unknown"
;
label define pep041x
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
label define pep043x
   0        "0 Sample Adult - no record"
   1        "1 Sample Adult - has record"
   2        "2 Not selected as Sample Adult"
   3        "3 No one selected as Sample Adult"
   4        "4 Armed Force member"
   5        "5 Armed Force member - selected as Sample Adult"
;
label define pep044x
   0        "0 Sample Child - no record"
   1        "1 Sample Child - has record"
   2        "2 Not selected as Sample Child"
   3        "3 No one selected as Sample Child"
   4        "4 Emancipated minor"
;
label define pep045x
   1        "1 No sample adult record due to quality reasons"
;
label define pep046x
   1        "1 No sample child record due to quality reasons"
;
label define pep047x
   1        "1 Families selected to receive AFD (sample adults) section"
   2        "
2 Families selected to receive FDB (all persons 1 year and older) section"
;
label define pep061x
   0        "0 Unable to work"
   1        "1 Limited in work"
   2        "2 Not limited in work"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep064x
   0        "0 Limitation previously mentioned"
   1        "1 Yes, limited in some other way"
   2        "2 Not limited in any way"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep065x
   1        "1 Limited in any way"
   2        "2 Not limited in any way"
   3        "3 Unknown if limited"
;
label define pep066x
   1        "1 Mentioned"
   2        "2 Not mentioned"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep081x
   95       "95 95+"
   96       "96 Since birth"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep082x
   1        "1 Day(s)"
   2        "2 Week(s)"
   3        "3 Month(s)"
   4        "4 Year(s)"
   6        "6 Since birth"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep083x
   00       "00 Less than 1 year"
   96       "96 Unknown number of years"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep084x
   0        "0 Since birth and child <1 year of age"
   1        "1 Less than 3 months"
   2        "2 3-5 months"
   3        "3 6-12 months"
   4        "4 More than 1 year"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep085x
   1        "1 Chronic"
   2        "2 Not chronic"
   9        "9 Unknown if chronic"
;
label define pep194x
   00       "00 Less than 1 year"
   85       "85 85+ years"
   96       "96 Unknown number of years"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep195x
   1        "1 Less than 3 months"
   2        "2 3-5 months"
   3        "3 6-12 months"
   4        "4 More than 1 year"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep372x
   1        "1 At least one condition causing limitation of activity is chronic"
   2        "2 No condition causing limitation of activity is chronic"
   9        "
9 Unknown if any condition causing limitation of activity is chronic"
;
label define pep373x
   0        "0 Not limited in any way (including unknown if limited)"
   1        "1 Limited; caused by at least one chronic condition"
   2        "2 Limited; not caused by chronic condition"
   3        "3 Limited; unknown if condition is chronic"
;
label define pep374x
   1        "1 Excellent"
   2        "2 Very good"
   3        "3 Good"
   4        "4 Fair"
   5        "5 Poor"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep378x
   997      "997 Refused"
   998      "998 Not ascertained"
   999      "999 Don't know"
;
label define pep381x
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep387x
   1        "1 Not covered"
   2        "2 Covered"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep388x
   1        "1 Private"
   2        "2 Medicaid and other public"
   3        "3 Other coverage"
   4        "4 Uninsured"
   5        "5 Don't know"
;
label define pep389x
   1        "1 Private"
   2        "2 Dual eligible"
   3        "3 Medicare Advantage"
   4        "4 Medicare only excluding Medicare Advantage"
   5        "5 Other coverage"
   6        "6 Uninsured"
   7        "7 Don't know"
;
label define pep390x
   1        "1 Private"
   2        "2 Dual eligible"
   3        "3 Medicare only"
   4        "4 Other coverage"
   5        "5 Uninsured"
   6        "6 Don't know"
;
label define pep391x
   1        "1 Yes, information"
   2        "2 Yes, but no information"
   3        "3 No"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep392x
   1        "1 Part A - Hospital only"
   2        "2 Part B - Medical only"
   3        "3 Both Part A and Part B"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep395x
   1        "1 Medicare Advantage"
   2        "2 Private plan not Medicare Advantage"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't Know"
;
label define pep400x
   1        "1 Reassigned to Medicaid from private"
;
label define pep401x
   1        "1 Any doctor"
   2        "2 Select from list"
   3        "3 Doctor is assigned"
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
   1        "1 Reassigned to private from public"
;
label define pep420x
   1        "1 Exchange plan"
   2        "2 Not exchange plan"
   8        "8 Not ascertained"
;
label define pep421x
   1        "1 In own name"
   2        "2 Someone else in family"
   3        "3 Person not in household"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep422x
   1        "1 Child (including stepchildren)"
   2        "2 Spouse"
   3        "3 Former spouse"
   4        "4 Some other relationship"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep424x
   01       "01 Through employer"
   02       "02 Through union"
   03       "03 Through workplace, but don't know if employer or union"
   04       "04 Through workplace, self-employed or professional association"
   05       "05 Purchased directly"
   06       "
06 Through Healthcare.gov or the Affordable Care Act, also known as Obamacare"
   07       "07 Through a state/local government or community program"
   08       "08 Other"
   09       "09 Through school"
   10       "10 Through parents"
   11       "11 Through relative other than parents"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep426x
   1        "1 Company provides exchange plans"
   2        "2 Not an exchange company"
   3        "3 Exchange Portal or exact exchange plan name"
   8        "8 Not ascertained"
;
label define pep434x
   1        "1 Yes"
   2        "2 No"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don’t know"
;
label define pep435x
   20000    "20000 $20,000 or more"
   99997    "99997 Refused"
   99998    "99998 Not ascertained"
   99999    "99999 Don't know"
;
label define pep436x
   1        "1 HMO/IPA"
   2        "2 PPO"
   3        "3 POS"
   4        "4 Fee-for-service/indemnity"
   5        "5 Other"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep437x
   1        "1 Less than [$1,300/$2,600]"
   2        "2 [$1,300/$2,600] or more"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep439x
   1        "1 Any doctor"
   2        "2 Select from group/list"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep449x
   1        "1 Any doctor"
   2        "2 Select from book/list"
   3        "3 Doctor is assigned"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep475x
   1        "1 Very confident"
   2        "2 Somewhat confident"
   3        "3 Not too confident"
   4        "4 Not confident at all"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don’t know"
;
label define pep477x
   1        "1 Reassigned to CHIP from private"
;
label define pep483x
   1        "1 Reassigned to other public from private"
;
label define pep490x
   1        "1 Reassigned to other government from private"
;
label define pep501x
   1        "1 TRICARE Prime"
   2        "2 TRICARE Standard and Extra"
   3        "3 Blank"
   4        "4 TRICARE for Life"
   5        "5 TRICARE other (specify)"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep503x
   1        "1 6 months or less"
   2        "2 More than 6 months, but less than 1 year"
   3        "3 1 year"
   4        "4 More than 1 year, but less than 3 years"
   5        "5 3 years or more"
   6        "6 Never"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep533x
   01       "01 Through employer"
   02       "02 Through union"
   03       "03 Through workplace, but don't know if employer or union"
   04       "04 Through workplace, self-employed or professional association"
   05       "05 Purchased directly"
   06       "06 Through a state/local government or community program"
   07       "07 Other"
   08       "08 Through school"
   09       "09 Through parents"
   10       "10 Through relative other than parents"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep534x
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
label define pep554x
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
label define pep555x
   1        "1 USA: born in one of the 50 United States or D.C."
   2        "2 USA: born in a U.S. territory"
   3        "3 Not born in the U.S. or a U.S. territory"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep556x
   1        "1 Less than 1 year"
   2        "2 1 yr., less than 5 yrs."
   3        "3 5 yrs., less than 10 yrs."
   4        "4 10 yrs., less than 15 yrs."
   5        "5 15 years or more"
   9        "9 Unknown"
;
label define pep557x
   1        "1 Yes, citizen of the United States"
   2        "2 No, not a citizen of the United States"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep560x
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
label define pep571x
   1        "1 Working for pay at a job or business"
   2        "2 With a job or business but not at work"
   3        "3 Looking for work"
   4        "4 Working, but not for pay, at a family-owned job or business"
   5        "5 Not working at a job or business and not looking for work"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep572x
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
label define pep573x
   95       "95 95+ hours"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep576x
   01       "01 1 month or less"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep577x
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
label define pep579x
   1        "1 Enter 1 to continue"
   8        "8 Not ascertained"
;
label define pep598x
   0        "0 No WIC age-eligible family members"
   1        "1 At least 1 WIC age-eligible family member"
;
label define pep600x
   0        "0 Person not age-eligible"
   1        "1 Person age-eligible"
;
label define pep601x
   1        "1 Very well"
   2        "2 Well"
   3        "3 Not well"
   4        "4 Not at all"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don’t know"
;

* ASSOCIATE VARIABLES WITH VALUE LABEL DEFINITIONS;

label values rectype   pep001x;   label values intv_qrt  pep004x;
label values intv_mon  pep005x;

label values region    pep010x;

label values sex       pep013x;   label values origin_i  pep014x;
label values hispan_i  pep015x;   label values racerpi2  pep016x;
label values mracrpi2  pep017x;   label values mracbpi2  pep018x;
label values racreci3  pep019x;   label values hiscodi3  pep020x;
label values nowaf     pep021x;   label values rrp       pep022x;
label values frrp      pep024x;   label values age_p     pep025x;
label values age_chg   pep026x;

label values r_maritl  pep029x;   label values cohab1    pep031x;
label values cohab2    pep032x;   label values cdcmstat  pep034x;
label values sib_degp  pep035x;   label values mom_degp  pep037x;
label values dad_degp  pep037x;   label values parents   pep040x;
label values mom_ed    pep041x;   label values dad_ed    pep041x;
label values astatflg  pep043x;   label values cstatflg  pep044x;
label values qcadult   pep045x;   label values qcchild   pep046x;

label values fdrn_flg  pep047x;

label values plaplylm  pep031x;   label values plaplyun  pep031x;
label values pspedeis  pep031x;   label values pspedem   pep031x;
label values plaadl    pep031x;   label values labath    pep031x;
label values ladress   pep031x;   label values laeat     pep031x;
label values labed     pep031x;   label values latoilt   pep031x;
label values lahome    pep031x;   label values plaiadl   pep031x;
label values plawknow  pep031x;   label values plawklim  pep061x;
label values plawalk   pep031x;   label values plaremem  pep031x;
label values plimany   pep064x;   label values la1ar     pep065x;
label values lahcc1    pep066x;   label values lahcc2    pep066x;
label values lahcc3    pep066x;   label values lahcc4    pep066x;
label values lahcc5    pep066x;   label values lahcc6    pep066x;
label values lahcc7a   pep066x;   label values lahcc8    pep066x;
label values lahcc9    pep066x;   label values lahcc10   pep066x;
label values lahcc11   pep066x;   label values lahcc12   pep066x;
label values lahcc13   pep066x;   label values lahcc90   pep066x;
label values lahcc91   pep066x;   label values lctime1   pep081x;
label values lcunit1   pep082x;   label values lcdura1   pep083x;
label values lcdurb1   pep084x;   label values lcchrc1   pep085x;
label values lctime2   pep081x;   label values lcunit2   pep082x;
label values lcdura2   pep083x;   label values lcdurb2   pep084x;
label values lcchrc2   pep085x;   label values lctime3   pep081x;
label values lcunit3   pep082x;   label values lcdura3   pep083x;
label values lcdurb3   pep084x;   label values lcchrc3   pep085x;
label values lctime4   pep081x;   label values lcunit4   pep082x;
label values lcdura4   pep083x;   label values lcdurb4   pep084x;
label values lcchrc4   pep085x;   label values lctime5   pep081x;
label values lcunit5   pep082x;   label values lcdura5   pep083x;
label values lcdurb5   pep084x;   label values lcchrc5   pep085x;
label values lctime6   pep081x;   label values lcunit6   pep082x;
label values lcdura6   pep083x;   label values lcdurb6   pep084x;
label values lcchrc6   pep085x;   label values lctime7a  pep081x;
label values lcunit7a  pep082x;   label values lcdura7a  pep083x;
label values lcdurb7a  pep084x;   label values lcchrc7a  pep085x;
label values lctime8   pep081x;   label values lcunit8   pep082x;
label values lcdura8   pep083x;   label values lcdurb8   pep084x;
label values lcchrc8   pep085x;   label values lctime9   pep081x;
label values lcunit9   pep082x;   label values lcdura9   pep083x;
label values lcdurb9   pep084x;   label values lcchrc9   pep085x;
label values lctime10  pep081x;   label values lcunit10  pep082x;
label values lcdura10  pep083x;   label values lcdurb10  pep084x;
label values lcchrc10  pep085x;   label values lctime11  pep081x;
label values lcunit11  pep082x;   label values lcdura11  pep083x;
label values lcdurb11  pep084x;   label values lcchrc11  pep085x;
label values lctime12  pep081x;   label values lcunit12  pep082x;
label values lcdura12  pep083x;   label values lcdurb12  pep084x;
label values lcchrc12  pep085x;   label values lctime13  pep081x;
label values lcunit13  pep082x;   label values lcdura13  pep083x;
label values lcdurb13  pep084x;   label values lcchrc13  pep085x;
label values lctime90  pep081x;   label values lcunit90  pep082x;
label values lcdura90  pep083x;   label values lcdurb90  pep084x;
label values lcchrc90  pep085x;   label values lctime91  pep081x;
label values lcunit91  pep082x;   label values lcdura91  pep083x;
label values lcdurb91  pep084x;   label values lcchrc91  pep085x;
label values lahca1    pep066x;   label values lahca2    pep066x;
label values lahca3    pep066x;   label values lahca4    pep066x;
label values lahca5    pep066x;   label values lahca6    pep066x;
label values lahca7    pep066x;   label values lahca8    pep066x;
label values lahca9    pep066x;   label values lahca10   pep066x;
label values lahca11   pep066x;   label values lahca12   pep066x;
label values lahca13   pep066x;   label values lahca14a  pep066x;
label values lahca15   pep066x;   label values lahca16   pep066x;
label values lahca17   pep066x;   label values lahca18   pep066x;
label values lahca19_  pep066x;   label values lahca20_  pep066x;
label values lahca21_  pep066x;   label values lahca22_  pep066x;
label values lahca23_  pep066x;   label values lahca24_  pep066x;
label values lahca25_  pep066x;   label values lahca26_  pep066x;
label values lahca27_  pep066x;   label values lahca28_  pep066x;
label values lahca29_  pep066x;   label values lahca30_  pep066x;
label values lahca31_  pep066x;   label values lahca32_  pep066x;
label values lahca33_  pep066x;   label values lahca34_  pep066x;
label values lahca90   pep066x;   label values lahca91   pep066x;
label values latime1   pep081x;   label values launit1   pep082x;
label values ladura1   pep194x;   label values ladurb1   pep195x;
label values lachrc1   pep085x;   label values latime2   pep081x;
label values launit2   pep082x;   label values ladura2   pep194x;
label values ladurb2   pep195x;   label values lachrc2   pep085x;
label values latime3   pep081x;   label values launit3   pep082x;
label values ladura3   pep194x;   label values ladurb3   pep195x;
label values lachrc3   pep085x;   label values latime4   pep081x;
label values launit4   pep082x;   label values ladura4   pep194x;
label values ladurb4   pep195x;   label values lachrc4   pep085x;
label values latime5   pep081x;   label values launit5   pep082x;
label values ladura5   pep194x;   label values ladurb5   pep195x;
label values lachrc5   pep085x;   label values latime6   pep081x;
label values launit6   pep082x;   label values ladura6   pep194x;
label values ladurb6   pep195x;   label values lachrc6   pep085x;
label values latime7   pep081x;   label values launit7   pep082x;
label values ladura7   pep194x;   label values ladurb7   pep195x;
label values lachrc7   pep085x;   label values latime8   pep081x;
label values launit8   pep082x;   label values ladura8   pep194x;
label values ladurb8   pep195x;   label values lachrc8   pep085x;
label values latime9   pep081x;   label values launit9   pep082x;
label values ladura9   pep194x;   label values ladurb9   pep195x;
label values lachrc9   pep085x;   label values latime10  pep081x;
label values launit10  pep082x;   label values ladura10  pep194x;
label values ladurb10  pep195x;   label values lachrc10  pep085x;
label values latime11  pep081x;   label values launit11  pep082x;
label values ladura11  pep194x;   label values ladurb11  pep195x;
label values lachrc11  pep085x;   label values latime12  pep081x;
label values launit12  pep082x;   label values ladura12  pep194x;
label values ladurb12  pep195x;   label values lachrc12  pep085x;
label values latime13  pep081x;   label values launit13  pep082x;
label values ladura13  pep194x;   label values ladurb13  pep195x;
label values lachrc13  pep085x;   label values ltime14a  pep081x;
label values lunit14a  pep082x;   label values ldura14a  pep194x;
label values ldurb14a  pep195x;   label values lchrc14a  pep085x;
label values latime15  pep081x;   label values launit15  pep082x;
label values ladura15  pep194x;   label values ladurb15  pep195x;
label values lachrc15  pep085x;   label values latime16  pep081x;
label values launit16  pep082x;   label values ladura16  pep194x;
label values ladurb16  pep195x;   label values lachrc16  pep085x;
label values latime17  pep081x;   label values launit17  pep082x;
label values ladura17  pep194x;   label values ladurb17  pep195x;
label values lachrc17  pep085x;   label values latime18  pep081x;
label values launit18  pep082x;   label values ladura18  pep194x;
label values ladurb18  pep195x;   label values lachrc18  pep085x;
label values latime19  pep081x;   label values launit19  pep082x;
label values ladura19  pep194x;   label values ladurb19  pep195x;
label values lachrc19  pep085x;   label values latime20  pep081x;
label values launit20  pep082x;   label values ladura20  pep194x;
label values ladurb20  pep195x;   label values lachrc20  pep085x;
label values latime21  pep081x;   label values launit21  pep082x;
label values ladura21  pep194x;   label values ladurb21  pep195x;
label values lachrc21  pep085x;   label values latime22  pep081x;
label values launit22  pep082x;   label values ladura22  pep194x;
label values ladurb22  pep195x;   label values lachrc22  pep085x;
label values latime23  pep081x;   label values launit23  pep082x;
label values ladura23  pep194x;   label values ladurb23  pep195x;
label values lachrc23  pep085x;   label values latime24  pep081x;
label values launit24  pep082x;   label values ladura24  pep194x;
label values ladurb24  pep195x;   label values lachrc24  pep085x;
label values latime25  pep081x;   label values launit25  pep082x;
label values ladura25  pep194x;   label values ladurb25  pep195x;
label values lachrc25  pep085x;   label values latime26  pep081x;
label values launit26  pep082x;   label values ladura26  pep194x;
label values ladurb26  pep195x;   label values lachrc26  pep085x;
label values latime27  pep081x;   label values launit27  pep082x;
label values ladura27  pep194x;   label values ladurb27  pep195x;
label values lachrc27  pep085x;   label values latime28  pep081x;
label values launit28  pep082x;   label values ladura28  pep194x;
label values ladurb28  pep195x;   label values lachrc28  pep085x;
label values latime29  pep081x;   label values launit29  pep082x;
label values ladura29  pep194x;   label values ladurb29  pep195x;
label values lachrc29  pep085x;   label values latime30  pep081x;
label values launit30  pep082x;   label values ladura30  pep194x;
label values ladurb30  pep195x;   label values lachrc30  pep085x;
label values latime31  pep081x;   label values launit31  pep082x;
label values ladura31  pep194x;   label values ladurb31  pep195x;
label values lachrc31  pep085x;   label values latime32  pep081x;
label values launit32  pep082x;   label values ladura32  pep194x;
label values ladurb32  pep195x;   label values lachrc32  pep085x;
label values latime33  pep081x;   label values launit33  pep082x;
label values ladura33  pep194x;   label values ladurb33  pep195x;
label values lachrc33  pep085x;   label values latime34  pep081x;
label values launit34  pep082x;   label values ladura34  pep194x;
label values ladurb34  pep195x;   label values lachrc34  pep085x;
label values latime90  pep081x;   label values launit90  pep082x;
label values ladura90  pep194x;   label values ladurb90  pep195x;
label values lachrc90  pep085x;   label values latime91  pep081x;
label values launit91  pep082x;   label values ladura91  pep194x;
label values ladurb91  pep195x;   label values lachrc91  pep085x;
label values lcondrt   pep372x;   label values lachronr  pep373x;
label values phstat    pep374x;

label values pdmed12m  pep031x;   label values pnmed12m  pep031x;
label values phospyr2  pep031x;   label values hospno    pep378x;
label values hpnite    pep378x;   label values phchm2w   pep031x;
label values phchmn2w  pep381x;   label values phcph2wr  pep031x;
label values phcphn2w  pep381x;   label values phcdv2w   pep031x;
label values phcdvn2w  pep381x;   label values p10dvyr   pep031x;

label values notcov    pep387x;   label values cover     pep388x;
label values cover65   pep389x;   label values cover65o  pep390x;
label values medicare  pep391x;   label values mcpart    pep392x;
label values mcchoice  pep031x;   label values mchmo     pep031x;
label values mcadvr    pep395x;   label values mcprem    pep031x;
label values mcref     pep031x;   label values mcpartd   pep031x;
label values medicaid  pep391x;   label values maflg     pep400x;
label values machmd    pep401x;   label values mxchng    pep031x;
label values medprem   pep031x;   label values mdprinc   pep031x;
label values single    pep405x;   label values sstypea   pep066x;
label values sstypeb   pep066x;   label values sstypec   pep066x;
label values sstyped   pep066x;   label values sstypee   pep066x;
label values sstypef   pep066x;   label values sstypeg   pep066x;
label values sstypeh   pep066x;   label values sstypei   pep066x;
label values sstypej   pep066x;   label values sstypek   pep066x;
label values sstypel   pep066x;   label values private   pep391x;
label values prflg     pep419x;   label values exchange  pep420x;
label values whonam1   pep421x;   label values prpolh1   pep422x;
label values prcooh1   pep031x;   label values plnwrks1  pep424x;
label values plnexch1  pep031x;   label values exchpr1   pep426x;
label values plnpay11  pep066x;   label values plnpay21  pep066x;
label values plnpay31  pep066x;   label values plnpay41  pep066x;
label values plnpay51  pep066x;   label values plnpay61  pep066x;
label values plnpay71  pep066x;   label values plnpre1   pep434x;
label values hicostr1  pep435x;   label values plnmgd1   pep436x;
label values hdhp1     pep437x;   label values hsahra1   pep031x;
label values mgchmd1   pep439x;   label values mgprmd1   pep031x;
label values mgpymd1   pep031x;   label values pcpreq1   pep031x;
label values prrxcov1  pep031x;   label values prdncov1  pep031x;
label values pxchng    pep031x;   label values plexchpr  pep426x;
label values pstrfprm  pep031x;   label values pssprinc  pep031x;
label values pstdoc    pep449x;   label values whonam2   pep421x;
label values prpolh2   pep422x;   label values prcooh2   pep031x;
label values plnwrks2  pep424x;   label values plnexch2  pep031x;
label values exchpr2   pep426x;   label values plnpay12  pep066x;
label values plnpay22  pep066x;   label values plnpay32  pep066x;
label values plnpay42  pep066x;   label values plnpay52  pep066x;
label values plnpay62  pep066x;   label values plnpay72  pep066x;
label values plnpre2   pep434x;   label values hicostr2  pep435x;
label values plnmgd2   pep436x;   label values hdhp2     pep437x;
label values hsahra2   pep031x;   label values mgchmd2   pep439x;
label values mgprmd2   pep031x;   label values mgpymd2   pep031x;
label values pcpreq2   pep031x;   label values prrxcov2  pep031x;
label values prdncov2  pep031x;   label values prplplus  pep031x;
label values fcovconf  pep475x;   label values schip     pep391x;
label values chflg     pep477x;   label values chxchng   pep031x;
label values strfprm1  pep031x;   label values chprinc   pep031x;
label values stdoc1    pep401x;   label values othpub    pep391x;
label values opflg     pep483x;   label values opxchng   pep031x;
label values plexchop  pep426x;   label values strfprm2  pep031x;
label values ssprinc   pep031x;   label values stdoc2    pep401x;
label values othgov    pep391x;   label values ogflg     pep490x;
label values ogxchng   pep031x;   label values plexchog  pep426x;
label values strfprm3  pep031x;   label values ogprinc   pep031x;
label values stdoc3    pep401x;   label values milcare   pep391x;
label values milspc1   pep066x;   label values milspc2   pep066x;
label values milspc3   pep066x;   label values milspc4   pep066x;
label values milmanr   pep501x;   label values ihs       pep031x;
label values hilast2   pep503x;   label values histop1   pep066x;
label values histop2   pep066x;   label values histop3   pep066x;
label values histop4   pep066x;   label values histop5   pep066x;
label values histop6   pep066x;   label values histop7   pep066x;
label values histop8   pep066x;   label values histop9   pep066x;
label values histop10  pep066x;   label values histop11  pep066x;
label values histop12  pep066x;   label values histop13  pep066x;
label values histop14  pep066x;   label values histop15  pep066x;
label values hinotyr   pep031x;   label values hinotmyr  pep381x;
label values fhichng   pep031x;   label values fhikdba   pep066x;
label values fhikdbb   pep066x;   label values fhikdbc   pep066x;
label values fhikdbd   pep066x;   label values fhikdbe   pep066x;
label values fhikdbf   pep066x;   label values fhikdbg   pep066x;
label values fhikdbh   pep066x;   label values fhikdbi   pep066x;
label values fhikdbj   pep066x;   label values fhikdbk   pep066x;
label values pwrkbr1   pep533x;   label values hcspfyr   pep534x;
label values medbill   pep031x;   label values medbpay   pep031x;
label values medbnop   pep031x;   label values fsa       pep031x;
label values hikindna  pep066x;   label values hikindnb  pep066x;
label values hikindnc  pep066x;   label values hikindnd  pep066x;
label values hikindne  pep066x;   label values hikindnf  pep066x;
label values hikindng  pep066x;   label values hikindnh  pep066x;
label values hikindni  pep066x;   label values hikindnj  pep066x;
label values hikindnk  pep066x;   label values mcareprb  pep031x;
label values mcaidprb  pep031x;   label values sincov    pep031x;

label values plborn    pep031x;   label values regionbr  pep554x;
label values geobrth   pep555x;   label values yrsinus   pep556x;
label values citizenp  pep557x;   label values headst    pep031x;
label values headstv1  pep031x;   label values educ1     pep560x;
label values armfver   pep031x;   label values armfev    pep031x;
label values armffc    pep031x;   label values armftm1p  pep066x;
label values armftm2p  pep066x;   label values armftm3p  pep066x;
label values armftm4p  pep066x;   label values armftm5p  pep066x;
label values armftm6p  pep066x;   label values armftm7p  pep066x;
label values doinglwp  pep571x;   label values whynowkp  pep572x;
label values wrkhrs2   pep573x;   label values wrkftall  pep031x;
label values wrklyr1   pep031x;   label values wrkmyr    pep576x;
label values ernyr_p   pep577x;   label values hiempof   pep031x;

label values fincint   pep579x;   label values psal      pep031x;
label values pseinc    pep031x;   label values pssrr     pep031x;
label values pssrrdb   pep031x;   label values pssrrd    pep031x;
label values ppens     pep031x;   label values popens    pep031x;
label values pssi      pep031x;   label values pssid     pep031x;
label values ptanf     pep031x;   label values powben    pep031x;
label values pintrstr  pep031x;   label values pdivd     pep031x;
label values pchldsp   pep031x;   label values pincot    pep031x;
label values pssapl    pep031x;   label values psdapl    pep031x;
label values tanfmyr   pep381x;   label values eligpwic  pep598x;
label values pwic      pep031x;   label values wic_flag  pep600x;

label values englang   pep601x;

* DISPLAY OVERALL DESCRIPTION OF FILE;

describe;

* DISPLAY A TEST TABLE FROM THE FILE;

tabulate rectype [fweight= wtfa];
save $mdata/nhis_data/clean/nhis2017_personsx, replace;

#delimit cr

* data file is stored in personsx.dta
* log  file is stored in personsx.log


