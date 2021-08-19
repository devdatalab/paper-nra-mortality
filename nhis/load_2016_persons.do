log using personsx.log, replace

cd $mdata/raw/nhis//

version 6.0

* THE FOLLOWING COMMAND TEMPORARILY CHANGES THE COMMAND-
  * ENDING DELIMITER FROM A CARRIAGE RETURN TO A SEMICOLON

#delimit ;

*********************************************************************
   JUNE 6, 2017  9:13 AM

 THIS IS AN EXAMPLE OF A STATA DO PROGRAM THAT CREATES A STATA
 FILE FROM THE 2016 NHIS Public Use Person ASCII FILE

 NOTES:

   EXECUTING THIS PROGRAM WILL REPLACE personsx.dta AND personsx.log
 IF THOSE FILES ALREADY EXIST IN THE DEFAULT DIRECTORY

 THIS PROGRAM ASSUMES THAT THE ASCII DATA FILE IS IN THE STATA WORKING
 DIRECTORY.  AN EXAMPLE OF HOW TO CHANGE THE WORKING DIRECTORY
 WITHIN STATA IS THE FOLLOWING COMMAND: cd c:\nhis2016\

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
      origimpt     41 -  41      hispan_i     42 -  43
      hispimpt     44 -  44      racerpi2     45 -  46
      raceimp2     47 -  47      mracrpi2     48 -  49
      mracbpi2     50 -  51      racreci3     52 -  52
      hiscodi3     53 -  53      erimpflg     54 -  54
      nowaf        55 -  55      rrp          56 -  57
  str hhreflg      58 -  58      frrp         59 -  60
  str dob_y_p      61 -  64      age_p        65 -  66
      age_chg      67 -  67

  str fmrpflg      68 -  68  str fmreflg      69 -  69
      r_maritl     70 -  70  str fspous2      71 -  72
      cohab1       73 -  73      cohab2       74 -  74
  str fcohab3      75 -  76      cdcmstat     77 -  77
      sib_degp     78 -  78  str fmother1     79 -  80
      mom_degp     81 -  81  str ffather1     82 -  83
      dad_degp     84 -  84      parents      85 -  85
      mom_ed       86 -  87      dad_ed       88 -  89
      astatflg     90 -  90      cstatflg     91 -  91
      qcadult      92 -  92      qcchild      93 -  93

      fdrn_flg     94 -  94

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
      lahcc7a     119 - 119      lahcc8      120 - 120
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
      lcchrc6     169 - 169      lctime7a    170 - 171
      lcunit7a    172 - 172      lcdura7a    173 - 174
      lcdurb7a    175 - 175      lcchrc7a    176 - 176
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
      lahca13     245 - 245      lahca14a    246 - 246
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
      lachrc13    359 - 359      ltime14a    360 - 361
      lunit14a    362 - 362      ldura14a    363 - 364
      ldurb14a    365 - 365      lchrc14a    366 - 366
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

      notcov      543 - 543      cover       544 - 544
      cover65     545 - 545      cover65o    546 - 546
      medicare    547 - 547      mcpart      548 - 548
      mcchoice    549 - 549      mchmo       550 - 550
      mcadvr      551 - 551      mcprem      552 - 552
      mcref       553 - 553      mcpartd     554 - 554
      medicaid    555 - 555      maflg       556 - 556
      machmd      557 - 557      mxchng      558 - 558
      medprem     559 - 559      mdprinc     560 - 560
      single      561 - 561      sstypea     562 - 562
      sstypeb     563 - 563      sstypec     564 - 564
      sstyped     565 - 565      sstypee     566 - 566
      sstypef     567 - 567      sstypeg     568 - 568
      sstypeh     569 - 569      sstypei     570 - 570
      sstypej     571 - 571      sstypek     572 - 572
      sstypel     573 - 573      private     574 - 574
      prflg       575 - 575      exchange    576 - 576
      whonam1     577 - 577      prpolh1     578 - 578
      prcooh1     579 - 579      plnwrks1    580 - 581
      plnexch1    582 - 582      exchpr1     583 - 583
      plnpay11    584 - 584      plnpay21    585 - 585
      plnpay31    586 - 586      plnpay41    587 - 587
      plnpay51    588 - 588      plnpay61    589 - 589
      plnpay71    590 - 590      plnpre1     591 - 591
      hicostr1    592 - 596      plnmgd1     597 - 597
      hdhp1       598 - 598      hsahra1     599 - 599
      mgchmd1     600 - 600      mgprmd1     601 - 601
      mgpymd1     602 - 602      pcpreq1     603 - 603
      prrxcov1    604 - 604      prdncov1    605 - 605
      pxchng      606 - 606      plexchpr    607 - 607
      pstrfprm    608 - 608      pssprinc    609 - 609
      pstdoc      610 - 610      whonam2     611 - 611
      prpolh2     612 - 612      prcooh2     613 - 613
      plnwrks2    614 - 615      plnexch2    616 - 616
      exchpr2     617 - 617      plnpay12    618 - 618
      plnpay22    619 - 619      plnpay32    620 - 620
      plnpay42    621 - 621      plnpay52    622 - 622
      plnpay62    623 - 623      plnpay72    624 - 624
      plnpre2     625 - 625      hicostr2    626 - 630
      plnmgd2     631 - 631      hdhp2       632 - 632
      hsahra2     633 - 633      mgchmd2     634 - 634
      mgprmd2     635 - 635      mgpymd2     636 - 636
      pcpreq2     637 - 637      prrxcov2    638 - 638
      prdncov2    639 - 639      prplplus    640 - 640
      fcovconf    641 - 641      schip       642 - 642
      chflg       643 - 643      chxchng     644 - 644
      strfprm1    645 - 645      chprinc     646 - 646
      stdoc1      647 - 647      othpub      648 - 648
      opflg       649 - 649      opxchng     650 - 650
      plexchop    651 - 651      strfprm2    652 - 652
      ssprinc     653 - 653      stdoc2      654 - 654
      othgov      655 - 655      ogflg       656 - 656
      ogxchng     657 - 657      plexchog    658 - 658
      strfprm3    659 - 659      ogprinc     660 - 660
      stdoc3      661 - 661      milcare     662 - 662
      milspc1     663 - 663      milspc2     664 - 664
      milspc3     665 - 665      milspc4     666 - 666
      milmanr     667 - 667      ihs         668 - 668
      hilast2     669 - 669      histop1     670 - 670
      histop2     671 - 671      histop3     672 - 672
      histop4     673 - 673      histop5     674 - 674
      histop6     675 - 675      histop7     676 - 676
      histop8     677 - 677      histop9     678 - 678
      histop10    679 - 679      histop11    680 - 680
      histop12    681 - 681      histop13    682 - 682
      histop14    683 - 683      histop15    684 - 684
      hinotyr     685 - 685      hinotmyr    686 - 687
      fhichng     688 - 688      fhikdba     689 - 689
      fhikdbb     690 - 690      fhikdbc     691 - 691
      fhikdbd     692 - 692      fhikdbe     693 - 693
      fhikdbf     694 - 694      fhikdbg     695 - 695
      fhikdbh     696 - 696      fhikdbi     697 - 697
      fhikdbj     698 - 698      fhikdbk     699 - 699
      pwrkbr1     700 - 701      hcspfyr     702 - 702
      medbill     703 - 703      medbpay     704 - 704
      medbnop     705 - 705      fsa         706 - 706
      hikindna    707 - 707      hikindnb    708 - 708
      hikindnc    709 - 709      hikindnd    710 - 710
      hikindne    711 - 711      hikindnf    712 - 712
      hikindng    713 - 713      hikindnh    714 - 714
      hikindni    715 - 715      hikindnj    716 - 716
      hikindnk    717 - 717      mcareprb    718 - 718
      mcaidprb    719 - 719      sincov      720 - 720

      plborn      721 - 721      regionbr    722 - 723
      geobrth     724 - 724      yrsinus     725 - 725
      citizenp    726 - 726      headst      727 - 727
      headstv1    728 - 728      educ1       729 - 730
      armfver     731 - 731      armfev      732 - 732
      armffc      733 - 733      armftm1p    734 - 734
      armftm2p    735 - 735      armftm3p    736 - 736
      armftm4p    737 - 737      armftm5p    738 - 738
      armftm6p    739 - 739      armftm7p    740 - 740
      doinglwp    741 - 741      whynowkp    742 - 743
      wrkhrs2     744 - 745      wrkftall    746 - 746
      wrklyr1     747 - 747      wrkmyr      748 - 749
      ernyr_p     750 - 751      hiempof     752 - 752

      fincint     753 - 753      psal        754 - 754
      pseinc      755 - 755      pssrr       756 - 756
      pssrrdb     757 - 757      pssrrd      758 - 758
      ppens       759 - 759      popens      760 - 760
      pssi        761 - 761      pssid       762 - 762
      ptanf       763 - 763      powben      764 - 764
      pintrstr    765 - 765      pdivd       766 - 766
      pchldsp     767 - 767      pincot      768 - 768
      pssapl      769 - 769      psdapl      770 - 770
      tanfmyr     771 - 772      eligpwic    773 - 773
      pwic        774 - 774      wic_flag    775 - 775

      englang     776 - 776

using 2016_persons.dat;
replace wtia = wtia/10;

* DEFINE VARIABLE LABELS;

label variable rectype  "File type identifier";
label variable srvy_yr  "Year of National Health Interview Survey";
label variable hhx      "Household Number";
label variable intv_qrt "Interview Quarter";
label variable intv_mon "Interview Month";
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
label variable origimpt "Hispanic Origin Imputation Flag";
label variable hispan_i "Hispanic subgroup detail";
label variable hispimpt "Type of Hispanic Origin Imputation Flag";
label variable racerpi2 "OMB groups w/multiple race";
label variable raceimp2 "Race Imputation Flag";
label variable mracrpi2 "Race coded to single/multiple race group";
label variable mracbpi2 "Race coded to single/multiple race group";
label variable racreci3 "Race Recode";
label variable hiscodi3 "Race/ethnicity recode";
label variable erimpflg "Ethnicity/Race Imputation Flag";
label variable nowaf    "Armed Forces Status";
label variable rrp      "Relationship to the HH reference person";
label variable hhreflg  "HH Reference Person Flag";
label variable frrp     "Relationship to family ref. Person";
label variable dob_y_p  "Year of Birth";
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
label variable schip    "SCHIP coverage recode";
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
label variable fhikdbe  "Had SCHIP coverage in the past 12 months";
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
label variable hikindne "SCHIP";
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
Was -- active duty in the U.S. military in June, 1950 or earlier?";
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
label define pep030x
   00       "00 Under 1 year"
   85       "85 85+ years"
;
label define pep031x
   1        "1 Change on AGE due to data entry error"
;
label define pep034x
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
label define pep036x
   1        "1 Yes"
   2        "2 No"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep037x
   1        "1 Married"
   2        "2 Widowed"
   3        "3 Divorced"
   4        "4 Separated"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep039x
   1        "1 Separated"
   2        "2 Divorced"
   3        "3 Married"
   4        "4 Single/never married"
   5        "5 Widowed"
   9        "9 Unknown marital status"
;
label define pep040x
   1        "1 Full or Adopted {brother/sister}"
   2        "2 Half {brother/sister}"
   3        "3 Step {brother/sister}"
   4        "4 {Brother/Sister}-in-law"
   9        "9 Other and unknown"
;
label define pep042x
   1        "1 Biological or adoptive"
   2        "2 Step"
   3        "3 In-law"
   9        "9 Other and unknown"
;
label define pep045x
   1        "1 Mother, no father"
   2        "2 Father, no mother"
   3        "3 Mother and father"
   4        "4 Neither mother nor father"
   9        "9 Unknown"
;
label define pep046x
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
label define pep048x
   0        "0 Sample Adult - no record"
   1        "1 Sample Adult - has record"
   2        "2 Not selected as Sample Adult"
   3        "3 No one selected as Sample Adult"
   4        "4 Armed Force member"
   5        "5 Armed Force member - selected as Sample Adult"
;
label define pep049x
   0        "0 Sample Child - no record"
   1        "1 Sample Child - has record"
   2        "2 Not selected as Sample Child"
   3        "3 No one selected as Sample Child"
   4        "4 Emancipated minor"
;
label define pep050x
   1        "1 No sample adult record due to quality reasons"
;
label define pep051x
   1        "1 No sample child record due to quality reasons"
;
label define pep052x
   1        "1 Families selected to receive AFD (sample adults) section"
   2        "
2 Families selected to receive FDB (all persons 1 year and older) section"
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
   1        "1 Private"
   2        "2 Medicaid and other public"
   3        "3 Other coverage"
   4        "4 Uninsured"
   5        "5 Don't know"
;
label define pep394x
   1        "1 Private"
   2        "2 Dual eligible"
   3        "3 Medicare Advantage"
   4        "4 Medicare only excluding Medicare Advantage"
   5        "5 Other coverage"
   6        "6 Uninsured"
   7        "7 Don't know"
;
label define pep395x
   1        "1 Private"
   2        "2 Dual eligible"
   3        "3 Medicare only"
   4        "4 Other coverage"
   5        "5 Uninsured"
   6        "6 Don't know"
;
label define pep396x
   1        "1 Yes, information"
   2        "2 Yes, but no information"
   3        "3 No"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep397x
   1        "1 Part A - Hospital only"
   2        "2 Part B - Medical only"
   3        "3 Both Part A and Part B"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep400x
   1        "1 Medicare Advantage"
   2        "2 Private plan not Medicare Advantage"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't Know"
;
label define pep405x
   1        "1 Reassigned to Medicaid from private"
;
label define pep406x
   1        "1 Any doctor"
   2        "2 Select from list"
   3        "3 Doctor is assigned"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep410x
   1        "1 Yes, with information"
   2        "2 Yes, but no information"
   3        "3 No"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep424x
   1        "1 Reassigned to private from public"
;
label define pep425x
   1        "1 Exchange plan"
   2        "2 Not exchange plan"
   8        "8 Not ascertained"
;
label define pep426x
   1        "1 In own name"
   2        "2 Someone else in family"
   3        "3 Person not in household"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep427x
   1        "1 Child (including stepchildren)"
   2        "2 Spouse"
   3        "3 Former spouse"
   4        "4 Some other relationship"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep429x
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
label define pep431x
   1        "1 Company provides exchange plans"
   2        "2 Not an exchange company"
   3        "3 Exchange Portal or exact exchange plan name"
   8        "8 Not ascertained"
;
label define pep439x
   1        "1 Yes"
   2        "2 No"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Donít know"
;
label define pep440x
   20000    "20000 $20,000 or more"
   99997    "99997 Refused"
   99998    "99998 Not ascertained"
   99999    "99999 Don't know"
;
label define pep441x
   1        "1 HMO/IPA"
   2        "2 PPO"
   3        "3 POS"
   4        "4 Fee-for-service/indemnity"
   5        "5 Other"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep442x
   1        "1 Less than [$1,300/$2,600]"
   2        "2 [$1,300/$2,600] or more"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep444x
   1        "1 Any doctor"
   2        "2 Select from group/list"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep454x
   1        "1 Any doctor"
   2        "2 Select from book/list"
   3        "3 Doctor is assigned"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep480x
   1        "1 Very confident"
   2        "2 Somewhat confident"
   3        "3 Not too confident"
   4        "4 Not confident at all"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Donít know"
;
label define pep482x
   1        "1 Reassigned to CHIP from private"
;
label define pep488x
   1        "1 Reassigned to other public from private"
;
label define pep495x
   1        "1 Reassigned to other government from private"
;
label define pep506x
   1        "1 TRICARE Prime"
   2        "2 TRICARE Standard and Extra"
   3        "3 Blank"
   4        "4 TRICARE for Life"
   5        "5 TRICARE other (specify)"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep508x
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
label define pep538x
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
label define pep539x
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
label define pep559x
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
label define pep560x
   1        "1 USA: born in one of the 50 United States or D.C."
   2        "2 USA: born in a U.S. territory"
   3        "3 Not born in the U.S. or a U.S. territory"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep561x
   1        "1 Less than 1 year"
   2        "2 1 yr., less than 5 yrs."
   3        "3 5 yrs., less than 10 yrs."
   4        "4 10 yrs., less than 15 yrs."
   5        "5 15 years or more"
   9        "9 Unknown"
;
label define pep562x
   1        "1 Yes, citizen of the United States"
   2        "2 No, not a citizen of the United States"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep565x
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
label define pep576x
   1        "1 Working for pay at a job or business"
   2        "2 With a job or business but not at work"
   3        "3 Looking for work"
   4        "4 Working, but not for pay, at a family-owned job or business"
   5        "5 Not working at a job or business and not looking for work"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define pep577x
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
label define pep578x
   95       "95 95+ hours"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep581x
   01       "01 1 month or less"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define pep582x
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
label define pep584x
   1        "1 Enter 1 to continue"
   8        "8 Not ascertained"
;
label define pep603x
   0        "0 No WIC age-eligible family members"
   1        "1 At least 1 WIC age-eligible family member"
;
label define pep605x
   0        "0 Person not age-eligible"
   1        "1 Person age-eligible"
;
label define pep606x
   1        "1 Very well"
   2        "2 Well"
   3        "3 Not well"
   4        "4 Not at all"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Donít know"
;

* ASSOCIATE VARIABLES WITH VALUE LABEL DEFINITIONS;

label values rectype   pep001x;   label values intv_qrt  pep004x;
label values intv_mon  pep005x;

label values region    pep010x;

label values sex       pep013x;   label values origin_i  pep014x;
label values origimpt  pep015x;   label values hispan_i  pep016x;
label values hispimpt  pep017x;   label values racerpi2  pep018x;
label values raceimp2  pep019x;   label values mracrpi2  pep020x;
label values mracbpi2  pep021x;   label values racreci3  pep022x;
label values hiscodi3  pep023x;   label values erimpflg  pep024x;
label values nowaf     pep025x;   label values rrp       pep026x;
label values frrp      pep028x;   label values age_p     pep030x;
label values age_chg   pep031x;

label values r_maritl  pep034x;   label values cohab1    pep036x;
label values cohab2    pep037x;   label values cdcmstat  pep039x;
label values sib_degp  pep040x;   label values mom_degp  pep042x;
label values dad_degp  pep042x;   label values parents   pep045x;
label values mom_ed    pep046x;   label values dad_ed    pep046x;
label values astatflg  pep048x;   label values cstatflg  pep049x;
label values qcadult   pep050x;   label values qcchild   pep051x;

label values fdrn_flg  pep052x;

label values plaplylm  pep036x;   label values plaplyun  pep036x;
label values pspedeis  pep036x;   label values pspedem   pep036x;
label values plaadl    pep036x;   label values labath    pep036x;
label values ladress   pep036x;   label values laeat     pep036x;
label values labed     pep036x;   label values latoilt   pep036x;
label values lahome    pep036x;   label values plaiadl   pep036x;
label values plawknow  pep036x;   label values plawklim  pep066x;
label values plawalk   pep036x;   label values plaremem  pep036x;
label values plimany   pep069x;   label values la1ar     pep070x;
label values lahcc1    pep071x;   label values lahcc2    pep071x;
label values lahcc3    pep071x;   label values lahcc4    pep071x;
label values lahcc5    pep071x;   label values lahcc6    pep071x;
label values lahcc7a   pep071x;   label values lahcc8    pep071x;
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
label values lcchrc6   pep090x;   label values lctime7a  pep086x;
label values lcunit7a  pep087x;   label values lcdura7a  pep088x;
label values lcdurb7a  pep089x;   label values lcchrc7a  pep090x;
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
label values lahca13   pep071x;   label values lahca14a  pep071x;
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
label values lachrc13  pep090x;   label values ltime14a  pep086x;
label values lunit14a  pep087x;   label values ldura14a  pep199x;
label values ldurb14a  pep200x;   label values lchrc14a  pep090x;
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

label values pdmed12m  pep036x;   label values pnmed12m  pep036x;
label values phospyr2  pep036x;   label values hospno    pep383x;
label values hpnite    pep383x;   label values phchm2w   pep036x;
label values phchmn2w  pep386x;   label values phcph2wr  pep036x;
label values phcphn2w  pep386x;   label values phcdv2w   pep036x;
label values phcdvn2w  pep386x;   label values p10dvyr   pep036x;

label values notcov    pep392x;   label values cover     pep393x;
label values cover65   pep394x;   label values cover65o  pep395x;
label values medicare  pep396x;   label values mcpart    pep397x;
label values mcchoice  pep036x;   label values mchmo     pep036x;
label values mcadvr    pep400x;   label values mcprem    pep036x;
label values mcref     pep036x;   label values mcpartd   pep036x;
label values medicaid  pep396x;   label values maflg     pep405x;
label values machmd    pep406x;   label values mxchng    pep036x;
label values medprem   pep036x;   label values mdprinc   pep036x;
label values single    pep410x;   label values sstypea   pep071x;
label values sstypeb   pep071x;   label values sstypec   pep071x;
label values sstyped   pep071x;   label values sstypee   pep071x;
label values sstypef   pep071x;   label values sstypeg   pep071x;
label values sstypeh   pep071x;   label values sstypei   pep071x;
label values sstypej   pep071x;   label values sstypek   pep071x;
label values sstypel   pep071x;   label values private   pep396x;
label values prflg     pep424x;   label values exchange  pep425x;
label values whonam1   pep426x;   label values prpolh1   pep427x;
label values prcooh1   pep036x;   label values plnwrks1  pep429x;
label values plnexch1  pep036x;   label values exchpr1   pep431x;
label values plnpay11  pep071x;   label values plnpay21  pep071x;
label values plnpay31  pep071x;   label values plnpay41  pep071x;
label values plnpay51  pep071x;   label values plnpay61  pep071x;
label values plnpay71  pep071x;   label values plnpre1   pep439x;
label values hicostr1  pep440x;   label values plnmgd1   pep441x;
label values hdhp1     pep442x;   label values hsahra1   pep036x;
label values mgchmd1   pep444x;   label values mgprmd1   pep036x;
label values mgpymd1   pep036x;   label values pcpreq1   pep036x;
label values prrxcov1  pep036x;   label values prdncov1  pep036x;
label values pxchng    pep036x;   label values plexchpr  pep431x;
label values pstrfprm  pep036x;   label values pssprinc  pep036x;
label values pstdoc    pep454x;   label values whonam2   pep426x;
label values prpolh2   pep427x;   label values prcooh2   pep036x;
label values plnwrks2  pep429x;   label values plnexch2  pep036x;
label values exchpr2   pep431x;   label values plnpay12  pep071x;
label values plnpay22  pep071x;   label values plnpay32  pep071x;
label values plnpay42  pep071x;   label values plnpay52  pep071x;
label values plnpay62  pep071x;   label values plnpay72  pep071x;
label values plnpre2   pep439x;   label values hicostr2  pep440x;
label values plnmgd2   pep441x;   label values hdhp2     pep442x;
label values hsahra2   pep036x;   label values mgchmd2   pep444x;
label values mgprmd2   pep036x;   label values mgpymd2   pep036x;
label values pcpreq2   pep036x;   label values prrxcov2  pep036x;
label values prdncov2  pep036x;   label values prplplus  pep036x;
label values fcovconf  pep480x;   label values schip     pep396x;
label values chflg     pep482x;   label values chxchng   pep036x;
label values strfprm1  pep036x;   label values chprinc   pep036x;
label values stdoc1    pep406x;   label values othpub    pep396x;
label values opflg     pep488x;   label values opxchng   pep036x;
label values plexchop  pep431x;   label values strfprm2  pep036x;
label values ssprinc   pep036x;   label values stdoc2    pep406x;
label values othgov    pep396x;   label values ogflg     pep495x;
label values ogxchng   pep036x;   label values plexchog  pep431x;
label values strfprm3  pep036x;   label values ogprinc   pep036x;
label values stdoc3    pep406x;   label values milcare   pep396x;
label values milspc1   pep071x;   label values milspc2   pep071x;
label values milspc3   pep071x;   label values milspc4   pep071x;
label values milmanr   pep506x;   label values ihs       pep036x;
label values hilast2   pep508x;   label values histop1   pep071x;
label values histop2   pep071x;   label values histop3   pep071x;
label values histop4   pep071x;   label values histop5   pep071x;
label values histop6   pep071x;   label values histop7   pep071x;
label values histop8   pep071x;   label values histop9   pep071x;
label values histop10  pep071x;   label values histop11  pep071x;
label values histop12  pep071x;   label values histop13  pep071x;
label values histop14  pep071x;   label values histop15  pep071x;
label values hinotyr   pep036x;   label values hinotmyr  pep386x;
label values fhichng   pep036x;   label values fhikdba   pep071x;
label values fhikdbb   pep071x;   label values fhikdbc   pep071x;
label values fhikdbd   pep071x;   label values fhikdbe   pep071x;
label values fhikdbf   pep071x;   label values fhikdbg   pep071x;
label values fhikdbh   pep071x;   label values fhikdbi   pep071x;
label values fhikdbj   pep071x;   label values fhikdbk   pep071x;
label values pwrkbr1   pep538x;   label values hcspfyr   pep539x;
label values medbill   pep036x;   label values medbpay   pep036x;
label values medbnop   pep036x;   label values fsa       pep036x;
label values hikindna  pep071x;   label values hikindnb  pep071x;
label values hikindnc  pep071x;   label values hikindnd  pep071x;
label values hikindne  pep071x;   label values hikindnf  pep071x;
label values hikindng  pep071x;   label values hikindnh  pep071x;
label values hikindni  pep071x;   label values hikindnj  pep071x;
label values hikindnk  pep071x;   label values mcareprb  pep036x;
label values mcaidprb  pep036x;   label values sincov    pep036x;

label values plborn    pep036x;   label values regionbr  pep559x;
label values geobrth   pep560x;   label values yrsinus   pep561x;
label values citizenp  pep562x;   label values headst    pep036x;
label values headstv1  pep036x;   label values educ1     pep565x;
label values armfver   pep036x;   label values armfev    pep036x;
label values armffc    pep036x;   label values armftm1p  pep071x;
label values armftm2p  pep071x;   label values armftm3p  pep071x;
label values armftm4p  pep071x;   label values armftm5p  pep071x;
label values armftm6p  pep071x;   label values armftm7p  pep071x;
label values doinglwp  pep576x;   label values whynowkp  pep577x;
label values wrkhrs2   pep578x;   label values wrkftall  pep036x;
label values wrklyr1   pep036x;   label values wrkmyr    pep581x;
label values ernyr_p   pep582x;   label values hiempof   pep036x;

label values fincint   pep584x;   label values psal      pep036x;
label values pseinc    pep036x;   label values pssrr     pep036x;
label values pssrrdb   pep036x;   label values pssrrd    pep036x;
label values ppens     pep036x;   label values popens    pep036x;
label values pssi      pep036x;   label values pssid     pep036x;
label values ptanf     pep036x;   label values powben    pep036x;
label values pintrstr  pep036x;   label values pdivd     pep036x;
label values pchldsp   pep036x;   label values pincot    pep036x;
label values pssapl    pep036x;   label values psdapl    pep036x;
label values tanfmyr   pep386x;   label values eligpwic  pep603x;
label values pwic      pep036x;   label values wic_flag  pep605x;

label values englang   pep606x;

* DISPLAY OVERALL DESCRIPTION OF FILE;

describe;

* DISPLAY A TEST TABLE FROM THE FILE;

tabulate rectype [fweight= wtfa];
save 2016_persons, replace;

#delimit cr

* data file is stored in personsx.dta
* log  file is stored in personsx.log

log close
