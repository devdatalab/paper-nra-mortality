cd $mdata/raw/nhis//

version 6.0

* THE FOLLOWING COMMAND TEMPORARILY CHANGES THE COMMAND-
  * ENDING DELIMITER FROM A CARRIAGE RETURN TO A SEMICOLON

#delimit ;

*********************************************************************
   JUNE 6, 2017 10:52 AM

 THIS IS AN EXAMPLE OF A STATA DO PROGRAM THAT CREATES A STATA
 FILE FROM THE 2016 NHIS Public Use Sample Adult ASCII FILE

 NOTES:

   EXECUTING THIS PROGRAM WILL REPLACE samadult.dta AND samadult.log
 IF THOSE FILES ALREADY EXIST IN THE DEFAULT DIRECTORY

 THIS PROGRAM ASSUMES THAT THE ASCII DATA FILE IS IN THE STATA WORKING
 DIRECTORY.  AN EXAMPLE OF HOW TO CHANGE THE WORKING DIRECTORY
 WITHIN STATA IS THE FOLLOWING COMMAND: cd c:\nhis2016\

 THIS PROGRAM OPENS A LOG FILE.  IF THE PROGRAM ENDS PREMATURELY, THE
 LOG FILE WILL REMAIN OPEN.  BEFORE RUNNING THIS PROGRAM AGAIN, THE
 USER SHOULD ENTER THE FOLLOWING STATA COMMAND: log close

 THIS IS STORED IN samadult.do
*********************************************************************;
clear;
set mem 200m;

* INPUT ALL VARIABLES;

infix
      rectype       1 -   2      srvy_yr       3 -   6
  str hhx           7 -  12      intv_qrt     13 -  13
      intv_mon     14 -  15  str fmx          16 -  17
  str fpx          18 -  19      wtia_sa      20 -  26
      wtfa_sa      27 -  32

      region       33 -  33      pstrat       34 -  36
      ppsu         37 -  39

      sex          40 -  40      hispan_i     41 -  42
      racerpi2     43 -  44      mracrpi2     45 -  46
      mracbpi2     47 -  48      age_p        49 -  50

      r_maritl     51 -  51      par_stat     52 -  52

      proxysa      53 -  53      prox1        54 -  54
      prox2        55 -  55      lateinta     56 -  56

      fdrn_flg     57 -  57

      doinglwa     58 -  58      whynowka     59 -  60
      everwrk      61 -  61      indstrn1     62 -  63
      indstrn2     64 -  65      occupn1      66 -  67
      occupn2      68 -  69      supervis     70 -  70
      wrkcata      71 -  71      businc1a     72 -  72
      locall1b     73 -  74      yrswrkpa     75 -  76
      wrklongh     77 -  77      hourpda      78 -  78
      pdsicka      79 -  79      onejob       80 -  80
      wrklyr4      81 -  81

      hypev        82 -  82      hypdifv      83 -  83
      hypyr1       84 -  84      hypmdev2     85 -  85
      hypmed2      86 -  86      chlev        87 -  87
      chlyr        88 -  88      chlmdev2     89 -  89
      chlmdnw2     90 -  90      chdev        91 -  91
      angev        92 -  92      miev         93 -  93
      hrtev        94 -  94      strev        95 -  95
      ephev        96 -  96      copdev       97 -  97
      aspmedev     98 -  98      aspmedad     99 -  99
      aspmdmed    100 - 100      asponown    101 - 101
      aasmev      102 - 102      aasstill    103 - 103
      aasmyr      104 - 104      aaseryr1    105 - 105
      ulcev       106 - 106      ulcyr       107 - 107
      ulccolev    108 - 108      canev       109 - 109
      cnkind1     110 - 110      cnkind2     111 - 111
      cnkind3     112 - 112      cnkind4     113 - 113
      cnkind5     114 - 114      cnkind6     115 - 115
      cnkind7     116 - 116      cnkind8     117 - 117
      cnkind9     118 - 118      cnkind10    119 - 119
      cnkind11    120 - 120      cnkind12    121 - 121
      cnkind13    122 - 122      cnkind14    123 - 123
      cnkind15    124 - 124      cnkind16    125 - 125
      cnkind17    126 - 126      cnkind18    127 - 127
      cnkind19    128 - 128      cnkind20    129 - 129
      cnkind21    130 - 130      cnkind22    131 - 131
      cnkind23    132 - 132      cnkind24    133 - 133
      cnkind25    134 - 134      cnkind26    135 - 135
      cnkind27    136 - 136      cnkind28    137 - 137
      cnkind29    138 - 138      cnkind30    139 - 139
      cnkind31    140 - 140      canage1     141 - 143
      canage2     144 - 146      canage3     147 - 149
      canage4     150 - 152      canage5     153 - 155
      canage6     156 - 158      canage7     159 - 161
      canage8     162 - 164      canage9     165 - 167
      canage10    168 - 170      canage11    171 - 173
      canage12    174 - 176      canage13    177 - 179
      canage14    180 - 182      canage15    183 - 185
      canage16    186 - 188      canage17    189 - 191
      canage18    192 - 194      canage19    195 - 197
      canage20    198 - 200      canage21    201 - 203
      canage22    204 - 206      canage23    207 - 209
      canage24    210 - 212      canage25    213 - 215
      canage26    216 - 218      canage27    219 - 221
      canage28    222 - 224      canage29    225 - 227
      canage30    228 - 230      pregever    231 - 231
      dbhvpay     232 - 232      dbhvcly     233 - 233
      dbhvwly     234 - 234      dbhvpan     235 - 235
      dbhvcln     236 - 236      dbhvwln     237 - 237
      dibrel      238 - 238      dibev1      239 - 239
      dibpre2     240 - 240      dibtest     241 - 241
      dibage1     242 - 243      difage2     244 - 245
      dibtype     246 - 246      dibpill1    247 - 247
      insln1      248 - 248      dibins2     249 - 249
      dibins3     250 - 250      dibins4     251 - 251
      dibgdm      252 - 252      dibbaby     253 - 253
      dibprgm     254 - 254      dibrefer    255 - 255
      dibbegin    256 - 256      ahayfyr     257 - 257
      sinyr       258 - 258      cbrchyr     259 - 259
      kidwkyr     260 - 260      livyr       261 - 261
      jntsymp     262 - 262      jmthp1      263 - 263
      jmthp2      264 - 264      jmthp3      265 - 265
      jmthp4      266 - 266      jmthp5      267 - 267
      jmthp6      268 - 268      jmthp7      269 - 269
      jmthp8      270 - 270      jmthp9      271 - 271
      jmthp10     272 - 272      jmthp11     273 - 273
      jmthp12     274 - 274      jmthp13     275 - 275
      jmthp14     276 - 276      jmthp15     277 - 277
      jmthp16     278 - 278      jmthp17     279 - 279
      jntchr      280 - 280      jnthp       281 - 281
      arth1       282 - 282      arthlmt     283 - 283
      paineck     284 - 284      painlb      285 - 285
      painleg     286 - 286      painface    287 - 287
      amigr       288 - 288      acold2w     289 - 289
      aintil2w    290 - 290      pregnow     291 - 291
      pregflyr    292 - 292      hraidnow    293 - 293
      hraidev     294 - 294      ahearst1    295 - 295
      avision     296 - 296      ablind      297 - 297
      vim_drev    298 - 298      vimls_dr    299 - 299
      vim_caev    300 - 300      vimls_ca    301 - 301
      vimcsurg    302 - 302      vim_glev    303 - 303
      vimls_gl    304 - 304      vim_mdev    305 - 305
      vimls_md    306 - 306      vimglass    307 - 307
      vimread     308 - 308      vimdrive    309 - 309
      avisreh     310 - 310      avisdev     311 - 311
      avdf_nws    312 - 312      avdf_cls    313 - 313
      avdf_nit    314 - 314      avdf_drv    315 - 315
      avdf_per    316 - 316      avdf_crd    317 - 317
      avisexam    318 - 318      avisact     319 - 319
      avisprot    320 - 320      lupprt      321 - 321
      chpain6m    322 - 322      painlmt     323 - 323

      wkdayr      324 - 326      beddayr     327 - 329
      ahstatyr    330 - 330      speceq      331 - 331
      flwalk      332 - 332      flclimb     333 - 333
      flstand     334 - 334      flsit       335 - 335
      flstoop     336 - 336      flreach     337 - 337
      flgrasp     338 - 338      flcarry     339 - 339
      flpush      340 - 340      flshop      341 - 341
      flsocl      342 - 342      flrelax     343 - 343
      fla1ar      344 - 344      aflhca1     345 - 345
      aflhca2     346 - 346      aflhca3     347 - 347
      aflhca4     348 - 348      aflhca5     349 - 349
      aflhca6     350 - 350      aflhca7     351 - 351
      aflhca8     352 - 352      aflhca9     353 - 353
      aflhca10    354 - 354      aflhca11    355 - 355
      aflhca12    356 - 356      aflhca13    357 - 357
      alhca14a    358 - 358      aflhca15    359 - 359
      aflhca16    360 - 360      aflhca17    361 - 361
      aflhca18    362 - 362      aflhc19_    363 - 363
      aflhc20_    364 - 364      aflhc21_    365 - 365
      aflhc22_    366 - 366      aflhc23_    367 - 367
      aflhc24_    368 - 368      aflhc25_    369 - 369
      aflhc26_    370 - 370      aflhc27_    371 - 371
      aflhc28_    372 - 372      aflhc29_    373 - 373
      aflhc30_    374 - 374      aflhc31_    375 - 375
      aflhc32_    376 - 376      aflhc33_    377 - 377
      aflhc34_    378 - 378      aflhca90    379 - 379
      aflhca91    380 - 380      altime1     381 - 382
      alunit1     383 - 383      aldura1     384 - 385
      aldurb1     386 - 386      alchrc1     387 - 387
      altime2     388 - 389      alunit2     390 - 390
      aldura2     391 - 392      aldurb2     393 - 393
      alchrc2     394 - 394      altime3     395 - 396
      alunit3     397 - 397      aldura3     398 - 399
      aldurb3     400 - 400      alchrc3     401 - 401
      altime4     402 - 403      alunit4     404 - 404
      aldura4     405 - 406      aldurb4     407 - 407
      alchrc4     408 - 408      altime5     409 - 410
      alunit5     411 - 411      aldura5     412 - 413
      aldurb5     414 - 414      alchrc5     415 - 415
      altime6     416 - 417      alunit6     418 - 418
      aldura6     419 - 420      aldurb6     421 - 421
      alchrc6     422 - 422      altime7     423 - 424
      alunit7     425 - 425      aldura7     426 - 427
      aldurb7     428 - 428      alchrc7     429 - 429
      altime8     430 - 431      alunit8     432 - 432
      aldura8     433 - 434      aldurb8     435 - 435
      alchrc8     436 - 436      altime9     437 - 438
      alunit9     439 - 439      aldura9     440 - 441
      aldurb9     442 - 442      alchrc9     443 - 443
      altime10    444 - 445      alunit10    446 - 446
      aldura10    447 - 448      aldurb10    449 - 449
      alchrc10    450 - 450      altime11    451 - 452
      alunit11    453 - 453      aldura11    454 - 455
      aldurb11    456 - 456      alchrc11    457 - 457
      altime12    458 - 459      alunit12    460 - 460
      aldura12    461 - 462      aldurb12    463 - 463
      alchrc12    464 - 464      altime13    465 - 466
      alunit13    467 - 467      aldura13    468 - 469
      aldurb13    470 - 470      alchrc13    471 - 471
      atime14a    472 - 473      aunit14a    474 - 474
      adura14a    475 - 476      adurb14a    477 - 477
      achrc14a    478 - 478      altime15    479 - 480
      alunit15    481 - 481      aldura15    482 - 483
      aldurb15    484 - 484      alchrc15    485 - 485
      altime16    486 - 487      alunit16    488 - 488
      aldura16    489 - 490      aldurb16    491 - 491
      alchrc16    492 - 492      altime17    493 - 494
      alunit17    495 - 495      aldura17    496 - 497
      aldurb17    498 - 498      alchrc17    499 - 499
      altime18    500 - 501      alunit18    502 - 502
      aldura18    503 - 504      aldurb18    505 - 505
      alchrc18    506 - 506      altime19    507 - 508
      alunit19    509 - 509      aldura19    510 - 511
      aldurb19    512 - 512      alchrc19    513 - 513
      altime20    514 - 515      alunit20    516 - 516
      aldura20    517 - 518      aldurb20    519 - 519
      alchrc20    520 - 520      altime21    521 - 522
      alunit21    523 - 523      aldura21    524 - 525
      aldurb21    526 - 526      alchrc21    527 - 527
      altime22    528 - 529      alunit22    530 - 530
      aldura22    531 - 532      aldurb22    533 - 533
      alchrc22    534 - 534      altime23    535 - 536
      alunit23    537 - 537      aldura23    538 - 539
      aldurb23    540 - 540      alchrc23    541 - 541
      altime24    542 - 543      alunit24    544 - 544
      aldura24    545 - 546      aldurb24    547 - 547
      alchrc24    548 - 548      altime25    549 - 550
      alunit25    551 - 551      aldura25    552 - 553
      aldurb25    554 - 554      alchrc25    555 - 555
      altime26    556 - 557      alunit26    558 - 558
      aldura26    559 - 560      aldurb26    561 - 561
      alchrc26    562 - 562      altime27    563 - 564
      alunit27    565 - 565      aldura27    566 - 567
      aldurb27    568 - 568      alchrc27    569 - 569
      altime28    570 - 571      alunit28    572 - 572
      aldura28    573 - 574      aldurb28    575 - 575
      alchrc28    576 - 576      altime29    577 - 578
      alunit29    579 - 579      aldura29    580 - 581
      aldurb29    582 - 582      alchrc29    583 - 583
      altime30    584 - 585      alunit30    586 - 586
      aldura30    587 - 588      aldurb30    589 - 589
      alchrc30    590 - 590      altime31    591 - 592
      alunit31    593 - 593      aldura31    594 - 595
      aldurb31    596 - 596      alchrc31    597 - 597
      altime32    598 - 599      alunit32    600 - 600
      aldura32    601 - 602      aldurb32    603 - 603
      alchrc32    604 - 604      altime33    605 - 606
      alunit33    607 - 607      aldura33    608 - 609
      aldurb33    610 - 610      alchrc33    611 - 611
      altime34    612 - 613      alunit34    614 - 614
      aldura34    615 - 616      aldurb34    617 - 617
      alchrc34    618 - 618      altime90    619 - 620
      alunit90    621 - 621      aldura90    622 - 623
      aldurb90    624 - 624      alchrc90    625 - 625
      altime91    626 - 627      alunit91    628 - 628
      aldura91    629 - 630      aldurb91    631 - 631
      alchrc91    632 - 632      alcndrt     633 - 633
      alchronr    634 - 634

      smkev       635 - 635      smkreg      636 - 637
      smknow      638 - 638      smkstat2    639 - 639
      smkqtno     640 - 641      smkqttp     642 - 642
      smkqty      643 - 644      cigsda1     645 - 646
      cigdamo     647 - 648      cigsda2     649 - 650
      cigsday     651 - 652      cigqtyr     653 - 653
      ecigev2     654 - 654      ecigcur2    655 - 655
      ecig30d2    656 - 657      cigarev2    658 - 658
      cigcur2     659 - 659      cig30d2     660 - 661
      pipev2      662 - 662      pipecur2    663 - 663
      smklstb1    664 - 664      smklscr2    665 - 665
      vigno       666 - 668      vigtp       669 - 669
      vigfreqw    670 - 671      viglngno    672 - 674
      viglngtp    675 - 675      vigmin      676 - 678
      modno       679 - 681      modtp       682 - 682
      modfreqw    683 - 684      modlngno    685 - 687
      modlngtp    688 - 688      modmin      689 - 691
      strngno     692 - 694      strngtp     695 - 695
      strfreqw    696 - 697      alc1yr      698 - 698
      alclife     699 - 699      alc12mno    700 - 702
      alc12mtp    703 - 703      alc12mwk    704 - 705
      alc12myr    706 - 708      alcamt      709 - 710
      alcstat     711 - 712      alc5upn1    713 - 715
      alc5upt1    716 - 716      alc5upy1    717 - 719
      binge1      720 - 721      aheight     722 - 723
      aweightp    724 - 726      bmi         727 - 730

      ausualpl    731 - 731      aplkind     732 - 732
      ahcplrou    733 - 733      ahcplknd    734 - 734
      ahcchgyr    735 - 735      ahcchghi    736 - 736
      aprvtryr    737 - 737      aprvtrfd    738 - 738
      adrnanp     739 - 739      adrnai      740 - 740
      ahcdlyr1    741 - 741      ahcdlyr2    742 - 742
      ahcdlyr3    743 - 743      ahcdlyr4    744 - 744
      ahcdlyr5    745 - 745      ahcafyr1    746 - 746
      ahcafyr2    747 - 747      ahcafyr3    748 - 748
      ahcafyr4    749 - 749      ahcafyr5    750 - 750
      ahcafyr6    751 - 751      aworpay     752 - 752
      ahicomp     753 - 753      arx12mo     754 - 754
      arx12_1     755 - 755      arx12_2     756 - 756
      arx12_3     757 - 757      arx12_4     758 - 758
      arx12_5     759 - 759      arx12_6     760 - 760
      adnlong2    761 - 761      ahcsyr1     762 - 762
      ahcsyr2     763 - 763      ahcsyr3     764 - 764
      ahcsyr4     765 - 765      ahcsyr5     766 - 766
      ahcsyr6     767 - 767      ahcsyr7     768 - 768
      ahcsyr8     769 - 769      ahcsyr9     770 - 770
      ahcsyr10    771 - 771      ahernoy2    772 - 773
      aervisnd    774 - 774      aerhos      775 - 775
      aerrea1r    776 - 776      aerrea2r    777 - 777
      aerrea3r    778 - 778      aerrea4r    779 - 779
      aerrea5r    780 - 780      aerrea6r    781 - 781
      aerrea7r    782 - 782      aerrea8r    783 - 783
      ahchyr      784 - 784      ahchmoyr    785 - 786
      ahchnoy2    787 - 788      ahcnoyr2    789 - 790
      asrgyr      791 - 791      asrgnoyp    792 - 793
      amdlongr    794 - 794      hit1a       795 - 795
      hit2a       796 - 796      hit3a       797 - 797
      hit4a       798 - 798      hit5a       799 - 799
      fluvacyr    800 - 800      fluvactp    801 - 801
      fluvac_m    802 - 803      fluvac_y    804 - 807
      flushpg1    808 - 808      flushpg2    809 - 809
      shtpnuyr    810 - 810      apox        811 - 811
      apox12mo    812 - 812      ahep        813 - 813
      ahepliv     814 - 814      ahepbtst    815 - 815
      shthepb     816 - 816      shepdos     817 - 817
      shthepa     818 - 818      shepanum    819 - 820
      ahepctst    821 - 821      ahepcres    822 - 822
      shingles    823 - 823      shttd       824 - 824
      shttd05     825 - 825      shttdap2    826 - 826
      shthpv2     827 - 827      shhpvdos    828 - 829
      ahpvage     830 - 832      livev       833 - 833
      travel      834 - 834      wrkhlth2    835 - 835
      wrkdir      836 - 836      apsbpchk    837 - 837
      apschchk    838 - 838      apsbschk    839 - 839
      apspap      840 - 840      apsmam      841 - 841
      apscol      842 - 842      apsdiet     843 - 843
      apssmkc     844 - 844      aindins2    845 - 845
      aindprch    846 - 846      aindwho     847 - 847
      ainddif1    848 - 848      ainddif2    849 - 849
      aexchng     850 - 850

      asicpuse    851 - 851      asisathc    852 - 852
      asitenur    853 - 853      asinhelp    854 - 854
      asincnto    855 - 855      asintru     856 - 856
      asinknt     857 - 857      asisim      858 - 858
      asisif      859 - 859      asiretr     860 - 860
      asimedc     861 - 861      asistlv     862 - 862
      asicnhc     863 - 863      asiccoll    864 - 864
      asinbill    865 - 865      asihcst     866 - 866
      asiccmp     867 - 867      asisleep    868 - 869
      asislpfl    870 - 871      asislpst    872 - 873
      asislpmd    874 - 875      asirest     876 - 877
      asisad      878 - 878      asinerv     879 - 879
      asirstls    880 - 880      asihopls    881 - 881
      asieffrt    882 - 882      asiwthls    883 - 883
      asimuch     884 - 884      acibld12    885 - 885
      asihivt     886 - 886      asihivwn    887 - 888

      balev       889 - 889      balage_p    890 - 891
      bdizz1      892 - 892      brprob1     893 - 893
      brprob2     894 - 894      brprob3     895 - 895
      brprob4     896 - 896      brprob5     897 - 897
      brprob6     898 - 898      brprob7     899 - 899
      bprob_ct    900 - 900      btype_1     901 - 901
      btype_2     902 - 902      btype_3     903 - 903
      btype_4     904 - 904      btype_5     905 - 905
      btype_6     906 - 906      btype_7     907 - 907
      btype_ct    908 - 908      bboth1      909 - 910
      bage1_p     911 - 912      boftn       913 - 915
      boftt       916 - 916      blast1      917 - 918
      btrg_01     919 - 919      btrg_02     920 - 920
      btrg_03     921 - 921      btrg_04     922 - 922
      btrg_05     923 - 923      btrg_06     924 - 924
      btrg_07     925 - 925      btrg_08     926 - 926
      btrg_09     927 - 927      btrg_10     928 - 928
      bsame_1     929 - 929      bsame_2     930 - 930
      bsame_3     931 - 931      bsame_4     932 - 932
      bsame_5     933 - 933      bsame_6     934 - 934
      bsame_7     935 - 935      bonly_1     936 - 936
      bonly_2     937 - 937      bonly_3     938 - 938
      bonly_4     939 - 939      bonly_5     940 - 940
      bonly_6     941 - 941      bonly_7     942 - 942
      bhosp2      943 - 943      bhospno1    944 - 944
      bhp1        945 - 945      bhp1_01     946 - 946
      bhp1_02     947 - 947      bhp1_03     948 - 948
      bhp1_04     949 - 949      bhp1_05     950 - 950
      bhp1_06     951 - 951      bhp1_07     952 - 952
      bhp1_08     953 - 953      bhp1_09     954 - 954
      bhp1_10     955 - 955      bhp1_11     956 - 956
      bhp1_12     957 - 957      bhp1_13     958 - 958
      bhp1_14     959 - 959      bhp1_15     960 - 960
      b5yrs1      961 - 961      bfirst1     962 - 962
      bhelp1      963 - 963      bthlp_n     964 - 966
      bthlp_t     967 - 967      bdiag1      968 - 968
      bcaus101    969 - 969      bcaus102    970 - 970
      bcaus103    971 - 971      bcaus104    972 - 972
      bcaus105    973 - 973      bcaus106    974 - 974
      bcaus107    975 - 975      bcaus108    976 - 976
      bcaus109    977 - 977      bcaus110    978 - 978
      bcaus111    979 - 979      bcaus112    980 - 980
      bcaus113    981 - 981      bcaus114    982 - 982
      btret1      983 - 983      btrt1_01    984 - 984
      btrt1_02    985 - 985      btrt1_03    986 - 986
      btrt1_04    987 - 987      btrt1_06    988 - 988
      btrt1_07    989 - 989      btrt1_08    990 - 990
      btrt1_09    991 - 991      btrt1_10    992 - 992
      btrt1_11    993 - 993      btrt1_12    994 - 994
      btrt1_13    995 - 995      btrt1_14    996 - 996
      btrt1_15    997 - 997      btrt1_16    998 - 998
      bstat1      999 - 999      bmedic1    1000 -1000
      bchng1     1001 -1001      bchg1_01   1002 -1002
      bchg1_02   1003 -1003      bchg1_03   1004 -1004
      bchg1_04   1005 -1005      bchg1_05   1006 -1006
      bchg1_06   1007 -1007      bchg1_07   1008 -1008
      bm12ws     1009 -1011      bm12ra     1012 -1014
      bprob1     1015 -1015      bmed_1     1016 -1016
      bmed_2     1017 -1017      bmed_3     1018 -1018
      bmed_4     1019 -1019      bbio1      1020 -1020
      bfall12m   1021 -1021      bfall5y    1022 -1022
      bfl1_01    1023 -1023      bfl1_02    1024 -1024
      bfl1_03    1025 -1025      bfl1_04    1026 -1026
      bfl1_05    1027 -1027      bfl1_06    1028 -1028
      bfl1_07    1029 -1029      bfall12a   1030 -1030
      bf12m_no   1031 -1033      bf12m_tp   1034 -1034
      bftime1    1035 -1035      binj1      1036 -1036
      binjws     1037 -1039      binjhp     1040 -1040
      binjhpn    1041 -1041      bfwh_01    1042 -1042
      bfwh_02    1043 -1043      bfwh_03    1044 -1044
      bfwh_04    1045 -1045      bfwh_05    1046 -1046
      bfwh_06    1047 -1047      bfwh_07    1048 -1048
      bfwh_08    1049 -1049      bfwh_09    1050 -1050
      bfwh_10    1051 -1051      bnrfall    1052 -1052
      binthi     1053 -1053      binttr     1054 -1054
      bintrs     1055 -1055

      awebuse    1056 -1056      awebofno   1057 -1059
      aweboftp   1060 -1060      awebeml    1061 -1061
      awebmno    1062 -1064      awebmtp    1065 -1065

using 2016_adult.dat;
replace wtia_sa = wtia_sa/10;
replace bmi = bmi/100;

* DEFINE VARIABLE LABELS;

label variable rectype  "File type identifier";
label variable srvy_yr  "Year of National Health Interview Survey";
label variable hhx      "Household Number";
label variable intv_qrt "Interview Quarter";
label variable intv_mon "Interview Month";
label variable fmx      "Family Number";
label variable fpx      "Person Number (Within family)";
label variable wtia_sa  "Weight - Interim Annual";
label variable wtfa_sa  "Weight - Final Annual";

label variable region   "Region";
label variable pstrat   "Pseudo-stratum for public-use file variance estimation
";
label variable ppsu     "Pseudo-PSU for public-use file variance estimation";

label variable sex      "Sex";
label variable hispan_i "Hispanic subgroup detail";
label variable racerpi2 "OMB groups w/multiple race";
label variable mracrpi2 "Race coded to single/multiple race group";
label variable mracbpi2 "Race coded to single/multiple race group";
label variable age_p    "Age";

label variable r_maritl "Marital Status";
label variable par_stat "
Sample adult is parent to 1+ minor child(ren) in the family";

label variable proxysa  "Sample adult status";
label variable prox1    "Knowledgeable proxy for Sample Adult available";
label variable prox2    "Relationship of SA proxy to SA";
label variable lateinta "Late Sample Adult interviews";

label variable fdrn_flg "Disability Questions flag";

label variable doinglwa "Corrected employment status last week";
label variable whynowka "Main reason for not working last week";
label variable everwrk  "Ever worked";
label variable indstrn1 "
Detailed industry classification based on 2012 Census codes";
label variable indstrn2 "
Simple industry classification based on 2012 Census codes";
label variable occupn1  "
Detailed occupation classification based on 2010 Census Codes";
label variable occupn2  "
Simple occupation classification based on 2010 Census codes";
label variable supervis "Supervise other employees as part of job";
label variable wrkcata  "Class of worker";
label variable businc1a "Current job an incorporated business";
label variable locall1b "Number of employees at work";
label variable yrswrkpa "Number of years on the job";
label variable wrklongh "Current/most recent job also longest held job";
label variable hourpda  "Paid by the hour at current or most recent job";
label variable pdsicka  "Paid sick leave at current or most recent job";
label variable onejob   "Have more than one job";
label variable wrklyr4  "Work status: last week, past 12 months";

label variable hypev    "Ever been told you have hypertension";
label variable hypdifv  "Ever had hypertension on 2+ visits";
label variable hypyr1   "Had hypertension, past 12 months";
label variable hypmdev2 "Ever prescribed medicine for high blood pressure";
label variable hypmed2  "Now taking prescribed medicine for high blood pressure
";
label variable chlev    "Ever told you had high cholesterol";
label variable chlyr    "Had high cholesterol, past 12 months";
label variable chlmdev2 "Ever prescribed medicine to lower cholesterol";
label variable chlmdnw2 "Now taking prescribed medicine to lower cholesterol";
label variable chdev    "Ever been told you had coronary heart disease";
label variable angev    "Ever been told you had angina pectoris";
label variable miev     "Ever been told you had a heart attack";
label variable hrtev    "Ever been told you had a heart condition/disease";
label variable strev    "Ever been told you had a stroke";
label variable ephev    "Ever been told you had emphysema";
label variable copdev   "Ever been told you had COPD";
label variable aspmedev "Ever been told to take low-dose aspirin";
label variable aspmedad "Following low-dose aspirin advice";
label variable aspmdmed "Advised to stop taking low-dose aspirin";
label variable asponown "Taking low-dose aspirin on own";
label variable aasmev   "Ever been told you had asthma";
label variable aasstill "Still have asthma";
label variable aasmyr   "Had an asthma episode/attack past 12 m";
label variable aaseryr1 "Had visit to ER due to asthma past 12 m";
label variable ulcev    "Ever been told you have an ulcer";
label variable ulcyr    "Had ulcer in past 12 m";
label variable ulccolev "
Ever been told you had Crohn's disease/ulcerative colitis";
label variable canev    "Ever told by a doctor you had cancer";
label variable cnkind1  "What kind of cancer ... Bladder";
label variable cnkind2  "What kind of cancer ... Blood";
label variable cnkind3  "What kind of cancer ... Bone";
label variable cnkind4  "What kind of cancer ... Brain";
label variable cnkind5  "What kind of cancer ... Breast";
label variable cnkind6  "What kind of cancer ... Cervix";
label variable cnkind7  "What kind of cancer ... Colon";
label variable cnkind8  "What kind of cancer ... Esophagus";
label variable cnkind9  "What kind of cancer ... Gallbladder";
label variable cnkind10 "What kind of cancer ... Kidney";
label variable cnkind11 "What kind of cancer ... larynx-windpipe";
label variable cnkind12 "What kind of cancer ... Leukemia";
label variable cnkind13 "What kind of cancer ... Liver";
label variable cnkind14 "What kind of cancer ... Lung";
label variable cnkind15 "What kind of cancer ... Lymphoma";
label variable cnkind16 "What kind of cancer ... Melanoma";
label variable cnkind17 "What kind of cancer ... mouth/tongue/lip";
label variable cnkind18 "What kind of cancer ... Ovary";
label variable cnkind19 "What kind of cancer ... Pancreas";
label variable cnkind20 "What kind of cancer ... Prostate";
label variable cnkind21 "What kind of cancer ... Rectum";
label variable cnkind22 "What kind of cancer ... skin (non-melanoma)";
label variable cnkind23 "What kind of cancer ... skin (DK kind)";
label variable cnkind24 "What kind of cancer ... soft tissue (muscle or fat)";
label variable cnkind25 "What kind of cancer ... Stomach";
label variable cnkind26 "What kind of cancer ... Testis";
label variable cnkind27 "What kind of cancer ... throat - pharynx";
label variable cnkind28 "What kind of cancer ... Thyroid";
label variable cnkind29 "What kind of cancer ... Uterus";
label variable cnkind30 "What kind of cancer ... Other";
label variable cnkind31 "What kind of cancer ... more than 3 kinds";
label variable canage1  "Age first diagnosed w/bladder cancer";
label variable canage2  "Age first diagnosed w/blood cancer";
label variable canage3  "Age first diagnosed w/bone cancer";
label variable canage4  "Age first diagnosed w/brain cancer";
label variable canage5  "Age first diagnosed w/breast cancer";
label variable canage6  "Age first diagnosed w/cervical cancer";
label variable canage7  "Age first diagnosed w/colon cancer";
label variable canage8  "Age first diagnosed w/esophageal cancer";
label variable canage9  "Age first diagnosed w/gallbladder cancer";
label variable canage10 "Age first diagnosed w/kidney cancer";
label variable canage11 "Age first diagnosed w/larynx-windpipe cancer";
label variable canage12 "Age first diagnosed w/leukemia";
label variable canage13 "Age first diagnosed w/liver cancer";
label variable canage14 "Age first diagnosed w/lung cancer";
label variable canage15 "Age first diagnosed w/lymphoma";
label variable canage16 "Age first diagnosed w/melanoma";
label variable canage17 "Age first diagnosed w/mouth/tongue/lip cancer";
label variable canage18 "Age first diagnosed w/ovarian cancer";
label variable canage19 "Age first diagnosed w/pancreatic cancer";
label variable canage20 "Age first diagnosed w/prostate cancer";
label variable canage21 "Age first diagnosed w/rectal cancer";
label variable canage22 "Age first diagnosed w/skin (non-melanoma) cancer";
label variable canage23 "Age first diagnosed w/skin (DK kind) cancer";
label variable canage24 "Age first diagnosed w/soft tissue cancer";
label variable canage25 "Age first diagnosed w/stomach cancer";
label variable canage26 "Age first diagnosed w/testicular cancer";
label variable canage27 "Age first diagnosed w/throat/pharynx cancer";
label variable canage28 "Age first diagnosed w/thyroid cancer";
label variable canage29 "Age first diagnosed w/uterine cancer";
label variable canage30 "Age first diagnosed w/other cancer";
label variable pregever "Ever been pregnant";
label variable dbhvpay  "Told to increase physical activity, past 12 m";
label variable dbhvcly  "Told to reduce fat/calories in diet, past 12 m";
label variable dbhvwly  "Told to participate in weight loss program, past 12 m";
label variable dbhvpan  "Currently increasing physical activity";
label variable dbhvcln  "Currently reducing fat/calories in diet";
label variable dbhvwln  "Currently participating in weight loss program";
label variable dibrel   "Blood relative ever had diabetes";
label variable dibev1   "Ever been told that you have diabetes";
label variable dibpre2  "Ever had prediabetes or other symptoms";
label variable dibtest  "
Time since last had blood test for high blood sugar/diabetes";
label variable dibage1  "Age first diagnosed w/diabetes";
label variable difage2  "Years since first diagnosed w/diabetes";
label variable dibtype  "Type of diabetes";
label variable dibpill1 "NOW taking diabetic pills";
label variable insln1   "NOW taking insulin";
label variable dibins2  "
Length of time before started insulin after diagnosed w/ diabetes";
label variable dibins3  "Ever stopped taking insulin for more than 6 m";
label variable dibins4  "
Stopped taking insulin first year after diagnosed w/ diabetes";
label variable dibgdm   "First told you had diabetes during pregnancy";
label variable dibbaby  "Ever had a baby that weighed 9 lbs. or more";
label variable dibprgm  "
Ever participated in year-long program to prevent Type 2 diabetes";
label variable dibrefer "Ever referred to program to prevent Type 2 diabetes";
label variable dibbegin "
Interested in beginning year-long program to prevent Type 2 diabetes";
label variable ahayfyr  "Told that you had hay fever, past 12 m";
label variable sinyr    "Told that you had sinusitis, past 12 m";
label variable cbrchyr  "Told you had chronic bronchitis, 12 m";
label variable kidwkyr  "Told you had weak/failing kidneys, 12 m";
label variable livyr    "Told you had liver condition, past 12 m";
label variable jntsymp  "Symptoms of joint pain/aching/stiffness past 30 d";
label variable jmthp1   "Which joint affected...shoulder-right";
label variable jmthp2   "Which joint affected...shoulder-left";
label variable jmthp3   "Which joint affected...elbow-right";
label variable jmthp4   "Which joint affected...elbow-left";
label variable jmthp5   "Which joint affected...hip-right";
label variable jmthp6   "Which joint affected...hip-left";
label variable jmthp7   "Which joint affected...wrist-right";
label variable jmthp8   "Which joint affected...wrist-left";
label variable jmthp9   "Which joint affected...knee-right";
label variable jmthp10  "Which joint affected...knee-left";
label variable jmthp11  "Which joint affected...ankle-right";
label variable jmthp12  "Which joint affected...ankle-left";
label variable jmthp13  "Which joint affected...toes-right";
label variable jmthp14  "Which joint affected...toes-left";
label variable jmthp15  "Which joint affected...fingers/thumb-right";
label variable jmthp16  "Which joint affected...fingers/thumb-left";
label variable jmthp17  "Which joint affected...other joint not listed";
label variable jntchr   "Joint symptoms begin more than 3 months ago";
label variable jnthp    "
Ever seen doctor or health professional for joint symptoms";
label variable arth1    "Ever been told you had arthritis";
label variable arthlmt  "Limited due to arthritis or joint symptoms";
label variable paineck  "Had neck pain, past 3 months";
label variable painlb   "Had low back pain, past 3 months";
label variable painleg  "Pain spread down leg/below knees";
label variable painface "Had pain in jaw/front of ear, past 3 months";
label variable amigr    "Had severe headache/migraine, past 3 m";
label variable acold2w  "Had a head/chest cold past 2 w";
label variable aintil2w "Had stomach prob w/vomit/diarrhea, 2 w";
label variable pregnow  "Currently pregnant";
label variable pregflyr "Recently pregnant";
label variable hraidnow "Now use a hearing aid";
label variable hraidev  "Ever used a hearing aid if not now using";
label variable ahearst1 "Hearing w/o hearing aid";
label variable avision  "Trouble seeing even w/glasses/lenses";
label variable ablind   "Blind or unable to see at all";
label variable vim_drev "EVER been told you had diabetic retinopathy";
label variable vimls_dr "Lost vision because of diabetic retinopathy";
label variable vim_caev "EVER been told you had cataracts";
label variable vimls_ca "Lost vision because of cataracts";
label variable vimcsurg "Ever had cataract surgery";
label variable vim_glev "EVER been told you had glaucoma";
label variable vimls_gl "Lost vision because of glaucoma";
label variable vim_mdev "EVER been told you had macular degeneration";
label variable vimls_md "Lost vision because of macular degeneration";
label variable vimglass "Currently wear eyeglasses or contact lenses?";
label variable vimread  "
Wear eyeglasses or contact lenses to read/write/cook/sew?";
label variable vimdrive "
Wear eyeglasses or contact lenses to drive/read signs/watch TV?";
label variable avisreh  "Use any vision rehabilitation services";
label variable avisdev  "
Use any adaptive devices such as magnifiers, talking materials";
label variable avdf_nws "
Even when wearing glasses difficult for you to read newspapers";
label variable avdf_cls "
Even when wearing glasses difficult for you to see up close/cook/sew";
label variable avdf_nit "
Even when wearing glasses difficult for you to go down stairs in dim light";
label variable avdf_drv "
Even when wearing glasses difficult for you to drive during daytime";
label variable avdf_per "
Even when wearing glasses difficult for you to notice objects while walking";
label variable avdf_crd "
Even when wearing glasses difficult for you to find something on a crowded shelf
";
label variable avisexam "Last time you had an eye exam (pupils dilated)";
label variable avisact  "
Participate in sports/other activities that can cause eye injury";
label variable avisprot "
When doing these activities, on average, do you wear eye protection";
label variable lupprt   "Lost all upper & lower natural teeth";
label variable chpain6m "How often did you have pain, past 6 m";
label variable painlmt  "How often did pain limit life/work activities, past 6 m
";

label variable wkdayr   "Number of work loss days, past 12 months";
label variable beddayr  "Number of bed days, past 12 months";
label variable ahstatyr "Health better/worse/same, compared w/ 12 months ago";
label variable speceq   "Have health problem that requires special equipment";
label variable flwalk   "
How difficult to walk 1/4 mile without special equipment";
label variable flclimb  "
How difficult to climb 10 steps without special equipment";
label variable flstand  "
How difficult to stand 2 hours without special equipment";
label variable flsit    "How difficult to sit 2 hours without special equipment
";
label variable flstoop  "
How difficult to stoop, bend or kneel without special equipment";
label variable flreach  "
How difficult to reach over head without special equipment";
label variable flgrasp  "
How difficult to grasp small objects without special equipment";
label variable flcarry  "
How difficult to lift/carry 10 lbs without special equipment";
label variable flpush   "
How difficult to push large objects without special equipment";
label variable flshop   "
How difficult to go out to events without special equipment";
label variable flsocl   "
How difficult to participate in social activities without special equipment";
label variable flrelax  "
How difficult to relax at home without special equipment";
label variable fla1ar   "Any functional limitation, all conditions";
label variable aflhca1  "Vision/problem seeing causes difficulty with activity";
label variable aflhca2  "Hearing problem causes difficulty with activity";
label variable aflhca3  "Arthritis/rheumatism causes difficulty with activity";
label variable aflhca4  "Back or neck problem causes difficulty with activity";
label variable aflhca5  "
Fracture, bone/joint injury causes difficulty with activity";
label variable aflhca6  "Other injury causes difficulty with activity";
label variable aflhca7  "Heart problem causes difficulty with activity";
label variable aflhca8  "Stroke problem causes difficulty with activity";
label variable aflhca9  "
Hypertension/high blood pressure causes difficulty with activity";
label variable aflhca10 "Diabetes causes difficulty with activity";
label variable aflhca11 "
Lung/breathing problem (e.g., asthma) causes difficulty with activity";
label variable aflhca12 "Cancer causes difficulty with activity";
label variable aflhca13 "Birth defect causes difficulty with activity";
label variable alhca14a "
Intellectual disability, AKA mental retardation causes difficulty with activity
";
label variable aflhca15 "
Other developmental problem (eg, cerebral palsy) causes difficulty with activity
";
label variable aflhca16 "Senility causes difficulty with activity";
label variable aflhca17 "
Depression/anxiety/emotional problem causes difficulty with activity";
label variable aflhca18 "Weight problem causes difficulty with activity";
label variable aflhc19_ "
Missing or amputated limb/finger/digit causes difficulty with activity";
label variable aflhc20_ "
Musculoskeletal/connective tissue problem causes difficulty with activity";
label variable aflhc21_ "
Circulation problems (including blood clots) cause difficulty with activity";
label variable aflhc22_ "
Endocrine/nutritional/metabolic problem causes difficulty with activity";
label variable aflhc23_ "
Nervous system/sensory organ condition causes difficulty with activity";
label variable aflhc24_ "
Digestive system problem causes difficulty with activity";
label variable aflhc25_ "
Genitourinary system problem causes difficulty with activity";
label variable aflhc26_ "
Skin/subcutaneous system problem causes difficulty with activity";
label variable aflhc27_ "
Blood or blood-forming organ problem causes difficulty with activity";
label variable aflhc28_ "Benign tumor/cyst causes difficulty with activity";
label variable aflhc29_ "
Alcohol/drug/substance abuse problem causes difficulty with activity";
label variable aflhc30_ "
Other mental problem/ADD/Bipolar/Schizophrenia causes difficulty with activity";
label variable aflhc31_ "
Surgical after-effects/medical treatment causes difficulty with activity";
label variable aflhc32_ "
'Old age'/elderly/aging-related problem causes difficulty with activity";
label variable aflhc33_ "
Fatigue/tiredness/weakness causes difficulty with activity";
label variable aflhc34_ "
Pregnancy-related problem causes difficulty with activity";
label variable aflhca90 "
Other impairment/problem (1) causes difficulty with activity";
label variable aflhca91 "
Other impairment/problem (2) causes difficulty with activity";
label variable altime1  "Duration of vision problem: Number of units";
label variable alunit1  "Duration of vision problem: Time unit";
label variable aldura1  "Duration (in years) of vision problem, recode 1";
label variable aldurb1  "Duration of vision problem, recode 2";
label variable alchrc1  "Vision problem condition status recode";
label variable altime2  "Duration of hearing problem: Number of units";
label variable alunit2  "Duration of hearing problem: Time unit";
label variable aldura2  "Duration (in years) of hearing problem, recode 1";
label variable aldurb2  "Duration of hearing problem, recode 2";
label variable alchrc2  "Hearing problem condition status recode";
label variable altime3  "Duration of arthritis/rheumatism: Number of units";
label variable alunit3  "Duration of arthritis/rheumatism: Time unit";
label variable aldura3  "Duration (in years) of arthritis/rheumatism, recode 1";
label variable aldurb3  "Duration of arthritis/rheumatism, recode 2";
label variable alchrc3  "Arthritis/rheumatism condition status recode";
label variable altime4  "Duration of back or neck problem: Number of units";
label variable alunit4  "Duration of back or neck problem: Time unit";
label variable aldura4  "Duration (in years) of back or neck problem, recode 1";
label variable aldurb4  "Duration of back or neck problem, recode 2";
label variable alchrc4  "Back or neck problem condition status recode";
label variable altime5  "
Duration of fracture, bone/joint injury: Number of units";
label variable alunit5  "Duration of fracture, bone/joint injury: Time unit";
label variable aldura5  "
Duration (in years) of fracture, bone/joint injury, recode 1";
label variable aldurb5  "Duration of fracture, bone/joint injury, recode 2";
label variable alchrc5  "Fracture, bone/joint injury condition status recode";
label variable altime6  "Duration of other injury: Number of units";
label variable alunit6  "Duration of other injury: Time unit";
label variable aldura6  "Duration (in years) of other injury, recode 1";
label variable aldurb6  "Duration of other injury, recode 2";
label variable alchrc6  "Other injury condition status recode";
label variable altime7  "Duration of heart problem: Number of units";
label variable alunit7  "Duration of heart problem: Time unit";
label variable aldura7  "Duration (in years) of heart problem, recode 1";
label variable aldurb7  "Duration of heart problem, recode 2";
label variable alchrc7  "Heart problem condition status recode";
label variable altime8  "Duration of stroke problem: Number of units";
label variable alunit8  "Duration of stroke problem: Time unit";
label variable aldura8  "Duration (in years) of stroke problem, recode 1";
label variable aldurb8  "Duration of stroke problem, recode 2";
label variable alchrc8  "Stroke problem condition status recode";
label variable altime9  "
Duration of hypertension or high blood pressure: Number of units";
label variable alunit9  "
Duration of hypertension or high blood pressure: Time unit";
label variable aldura9  "
Duration (in years) of hypertension or high blood pressure: recode 1";
label variable aldurb9  "
Duration of hypertension or high blood pressure: recode 2";
label variable alchrc9  "
Hypertension or high blood pressure condition status recode";
label variable altime10 "Duration of diabetes: Number of units";
label variable alunit10 "Duration of diabetes: Time unit";
label variable aldura10 "Duration (in years) of diabetes, recode 1";
label variable aldurb10 "Duration of diabetes, recode 2";
label variable alchrc10 "Diabetes condition status recode";
label variable altime11 "
Duration of lung/breathing problem (e.g., asthma and emphysema): Number of units
";
label variable alunit11 "
Duration of lung/breathing problem: (e.g., asthma and emphysema) Time unit";
label variable aldura11 "
Duration (in years) of lung/breathing problem (e.g., asthma), recode 1";
label variable aldurb11 "
Duration of lung/breathing problem (e.g., asthma and emphysema), recode 2";
label variable alchrc11 "
Lung/breathing problem (e.g., asthma and emphysema) condition status recode";
label variable altime12 "Duration of cancer: Number of units";
label variable alunit12 "Duration of cancer: Time unit";
label variable aldura12 "Duration (in years) of cancer, recode 1";
label variable aldurb12 "Duration of cancer, recode 2";
label variable alchrc12 "Cancer condition status recode";
label variable altime13 "Duration of birth defect: Number of units";
label variable alunit13 "Duration of birth defect: Time unit";
label variable aldura13 "Duration (in years) of birth defect, recode 1";
label variable aldurb13 "Duration of birth defect, recode 2";
label variable alchrc13 "Birth defect condition status recode";
label variable atime14a "
Duration of intellectual disability, AKA mental retardation: Number of units";
label variable aunit14a "
Duration of intellectual disability, also know as mental retardation: Time unit
";
label variable adura14a "
Duration (in years) of intellectual disability, AKA mental retardation, recode 1
";
label variable adurb14a "
Duration of intellectual disability, also known as mental retardation, recode 2
";
label variable achrc14a "
Intellectual disability, AKA mental retardation condition status recode";
label variable altime15 "
Duration of other developmental problem (e.g., cerebral palsy): Number of units
";
label variable alunit15 "
Duration of other developmental problem (e.g., cerebral palsy): Time unit";
label variable aldura15 "
Duration (in years) of other developmental problem (eg cerebral palsy), recode 1
";
label variable aldurb15 "
Duration of other developmental problem (e.g., cerebral palsy), recode 2";
label variable alchrc15 "
Other developmental problem (e.g., cerebral palsy) condition status recode";
label variable altime16 "Duration of senility: Number of units";
label variable alunit16 "Duration of senility: Time unit";
label variable aldura16 "Duration (in years) of senility, recode 1";
label variable aldurb16 "Duration of senility, recode 2";
label variable alchrc16 "Senility condition status recode";
label variable altime17 "
Duration of depression/anxiety/emotional problem: Number of units";
label variable alunit17 "
Duration of depression/anxiety/emotional problem: Time unit";
label variable aldura17 "
Duration (in years) of depression/anxiety/emotional problem, recode 1";
label variable aldurb17 "
Duration of depression/anxiety/emotional problem, recode 2";
label variable alchrc17 "
Depression/anxiety/emotional problem condition status recode";
label variable altime18 "Duration of weight problem: Number of units";
label variable alunit18 "Duration of weight problem: Time unit";
label variable aldura18 "Duration (in years) of weight problem, recode 1";
label variable aldurb18 "Duration of weight problem, recode 2";
label variable alchrc18 "Weight problem condition status recode";
label variable altime19 "
Duration of missing limbs (fingers, toes); amputation: Number of units";
label variable alunit19 "
Duration of missing limbs (fingers, toes, or digits); amputation: Time unit";
label variable aldura19 "
Duration (in years) of missing limbs (fingers, toes); amputation, recode 1";
label variable aldurb19 "
Duration of missing limbs (fingers, toes, or digits); amputation, recode 2";
label variable alchrc19 "
Missing limbs (fingers, toes, or digits); amputation condition status recode";
label variable altime20 "
Duration of musculoskeletal/connective tissue problem: Number of units";
label variable alunit20 "
Duration of musculoskeletal/connective tissue problem: Time unit";
label variable aldura20 "
Duration (in years) of musculoskeletal/connective tissue problem, recode 1";
label variable aldurb20 "
Duration of musculoskeletal/connective tissue problem, recode 2";
label variable alchrc20 "
Musculoskeletal/connective tissue problem condition status recode";
label variable altime21 "
Duration of circulation problems (including blood clots): Number of units";
label variable alunit21 "
Duration of circulation problems (including blood clots): Time unit";
label variable aldura21 "
Duration (in years) of circulation problems (including blood clots), recode 1";
label variable aldurb21 "
Duration of circulation problems (including blood clots), recode 2";
label variable alchrc21 "
Circulation problems (including blood clots) condition status recode";
label variable altime22 "
Duration of endocrine/nutritional/metabolic problem: Number of units";
label variable alunit22 "
Duration of endocrine/nutritional/metabolic problem: Time unit";
label variable aldura22 "
Duration (in years) of endocrine/nutritional/metabolic problem, recode 1";
label variable aldurb22 "
Duration of endocrine/nutritional/metabolic problem, recode 2";
label variable alchrc22 "
Endocrine/nutritional/metabolic problem condition status recode";
label variable altime23 "
Duration of nervous system/sensory organ condition: Number of units";
label variable alunit23 "
Duration of nervous system/sensory organ condition: Time unit";
label variable aldura23 "
Duration (in years) of nervous system/sensory organ condition, recode 1";
label variable aldurb23 "
Duration of nervous system/sensory organ condition, recode 2";
label variable alchrc23 "Nervous system/sensory organ condition status recode";
label variable altime24 "Duration of digestive system problems: Number of units
";
label variable alunit24 "Duration of digestive system problems: Time unit";
label variable aldura24 "
Duration (in years) of digestive system problems, recode 1";
label variable aldurb24 "Duration of digestive system problems, recode 2";
label variable alchrc24 "Digestive system problems condition status recode";
label variable altime25 "
Duration of genitourinary system problem: Number of units";
label variable alunit25 "Duration of genitourinary system problem: Time unit";
label variable aldura25 "
Duration (in years) of genitourinary system problem, recode 1";
label variable aldurb25 "Duration of genitourinary system problem, recode 2";
label variable alchrc25 "Genitourinary system problem condition status recode";
label variable altime26 "
Duration of skin/subcutaneous system problems: Number of units";
label variable alunit26 "
Duration of skin/subcutaneous system problems: Time unit";
label variable aldura26 "
Duration (in years) of skin/subcutaneous system problems, recode 1";
label variable aldurb26 "Duration of skin/subcutaneous system problems, recode 2
";
label variable alchrc26 "
Skin/subcutaneous system problems condition status recode";
label variable altime27 "
Duration of blood or blood-forming organ problem: Number of units";
label variable alunit27 "
Duration of blood or blood-forming organ problem: Time unit";
label variable aldura27 "
Duration (in years) of blood or blood-forming organ problem, recode 1";
label variable aldurb27 "
Duration of blood or blood-forming organ problem, recode 2";
label variable alchrc27 "
Blood or blood-forming organ problem condition status recode";
label variable altime28 "Duration of benign tumor/cyst: Number of units";
label variable alunit28 "Duration of benign tumor/cyst: Time unit";
label variable aldura28 "Duration (in years) of benign tumor/cyst, recode 1";
label variable aldurb28 "Duration of benign tumor/cyst, recode 2";
label variable alchrc28 "Benign tumor/cyst condition status recode";
label variable altime29 "
Duration of alcohol /drug/substance abuse problem: Number of units";
label variable alunit29 "
Duration of alcohol/drug/substance abuse problem: Time unit";
label variable aldura29 "
Duration (in years) of alcohol/drug/substance abuse problem, recode 1";
label variable aldurb29 "
Duration of alcohol/drug/substance abuse problem, recode 2";
label variable alchrc29 "
Alcohol /drug/substance abuse problem condition status recode";
label variable altime30 "
Duration of other mental problem/ADD/Bipolar/Schizophrenia: Number of units";
label variable alunit30 "
Duration of other mental problem/ADD/Bipolar/Schizophrenia: Time unit";
label variable aldura30 "
Duration (in years) of other mental problem/ADD/Bipolar/Schizophrenia, recode 1
";
label variable aldurb30 "
Duration of other mental problem/ADD/Bipolar/Schizophrenia, recode 2";
label variable alchrc30 "
Other mental problem/ADD/Bipolar/Schizophrenia condition status recode";
label variable altime31 "
Duration of surgical after-effects/medical treatment problems: Number of units";
label variable alunit31 "
Duration of surgical after-effects/medical treatment problems: Time unit";
label variable aldura31 "
Duration (in years) of surgical after-effects/medical treatment prob, recode 1";
label variable aldurb31 "
Duration of surgical after-effects/medical treatment problems, recode 2";
label variable alchrc31 "
Surgical after-effects/medical treatment problems condition status recode";
label variable altime32 "
Duration of 'old age'/elderly/aging-related problems: Number of units";
label variable alunit32 "
Duration of 'old age'/elderly/aging-related problems: Time unit";
label variable aldura32 "
Duration (in years) of 'old age'/elderly/aging-related problems, recode 1";
label variable aldurb32 "
Duration of 'old age'/elderly/aging-related problems, recode 2";
label variable alchrc32 "
'Old age'/elderly/aging-related problems condition status recode";
label variable altime33 "
Duration of fatigue/tiredness/weakness problem: Number of units";
label variable alunit33 "
Duration of fatigue/tiredness/weakness problem: Time unit";
label variable aldura33 "
Duration (in years) of fatigue/tiredness/weakness problem, recode 1";
label variable aldurb33 "
Duration of fatigue/tiredness/weakness problem, recode 2";
label variable alchrc33 "
Fatigue/tiredness/weakness problem condition status recode";
label variable altime34 "Duration of pregnancy-related problem: Number of units
";
label variable alunit34 "Duration of pregnancy-related problem: Time unit";
label variable aldura34 "
Duration (in years) of pregnancy-related problem, recode 1";
label variable aldurb34 "Duration of pregnancy-related problem, recode 2";
label variable alchrc34 "Pregnancy-related condition status recode";
label variable altime90 "
Duration of other impairment/problem N.E.C. (1): Number of units";
label variable alunit90 "
Duration of other impairment/problem N.E.C. (1): Time unit";
label variable aldura90 "
Duration (in years) of other impairment/problem N.E.C. (1), recode 1";
label variable aldurb90 "
Duration of other impairment/problem N.E.C. (1), recode 2";
label variable alchrc90 "
Other impairment/problem N.E.C. (1) condition status recode";
label variable altime91 "
Duration of other impairment/problem N.E.C. (2): Number of units";
label variable alunit91 "
Duration of other impairment/problem N.E.C. (2): Time unit";
label variable aldura91 "
Duration (in years) of other impairment/ problem N.E.C. (2), recode 1";
label variable aldurb91 "
Duration of other impairment/problem N.E.C. (2), recode 2";
label variable alchrc91 "
Other impairment/problem N.E.C. (2) condition status recode";
label variable alcndrt  "
Chronic condition recode for individual with functional limitation";
label variable alchronr "
Overall functional limitation recode by condition status";

label variable smkev    "Ever smoked 100 cigarettes";
label variable smkreg   "Age first smoked fairly regularly";
label variable smknow   "Smoke freq: every day/some days/not at all";
label variable smkstat2 "Smoking Status: Recode";
label variable smkqtno  "Time since quit: # of units";
  label variable smkqttp  "Time since quit: time period";
label variable smkqty   "Time since quit smoking (in years)";
label variable cigsda1  "Number cigs per day (daily smokers)";
label variable cigdamo  "Number days smoked in past 30 days";
label variable cigsda2  "Number cigs per day (some day smokers)";
label variable cigsday  "Number of cigarettes a day (all current smokers)";
label variable cigqtyr  "Tried quit smoking 1+ days, past 12 m";
label variable ecigev2  "Ever used electronic cigarettes (e-cig), even once";
label variable ecigcur2 "E-cig freq: every day/some days/not at all";
label variable ecig30d2 "Number of days used e-cigarettes, past 30 days";
label variable cigarev2 "
Ever smoked a regular cigar, cigarillo, or little filtered cigar, even once";
label variable cigcur2  "
Smoke freq:every day/some days/not at all-cigars,cigarillos,or lil' filtered cig
";
label variable cig30d2  "
Number of days smoked cigar, cigarillo, or little filtered cigar, past 30 days";
label variable pipev2   "
Ever smoked pipe filled w/tobacco - either pipe,water pipe,or hookah,even once";
label variable pipecur2 "
Smoke freq: every day/some days/not at all - either pipes,water pipes,or hookahs
";
label variable smklstb1 "Ever used smokeless tobacco products, even once";
label variable smklscr2 "Smokeless tobacco freq: every day/some days/not at all
";
label variable vigno    "Freq vigorous activity: # of units";
  label variable vigtp    "Freq vigorous activity: Time units";
label variable vigfreqw "Freq vigorous activity (times per wk)";
label variable viglngno "Duration vigorous activity: # units";
  label variable viglngtp "Duration vigorous activity: Time unit";
label variable vigmin   "Duration vigorous activity (in minutes)";
label variable modno    "Freq moderate activity: # of units";
  label variable modtp    "Freq moderate activity: Time units";
label variable modfreqw "Freq light/moderate activity (times per wk)";
label variable modlngno "Duration moderate activity: # of units";
  label variable modlngtp "Duration moderate activity: Time unit";
label variable modmin   "Duration light/moderate activity (in minutes)";
label variable strngno  "Strength activity freq: # of units";
  label variable strngtp  "Strength activity freq: Time units";
label variable strfreqw "Freq strength activity (times per wk)";
label variable alc1yr   "Ever had 12+ drinks in any  one year";
label variable alclife  "Had 12+ drinks in ENTIRE LIFE";
label variable alc12mno "Freq drank alcohol pst yr:  # of units";
  label variable alc12mtp "Freq drank alcohol pst yr:  Time unit";
label variable alc12mwk "Freq drank alcohol: Days per week";
label variable alc12myr "Freq drank alcohol: Days in past year";
label variable alcamt   "Average # drinks on days drank";
label variable alcstat  "Alcohol drinking status: Recode";
label variable alc5upn1 "Days 5+/4+ drinks, past yr: # days";
  label variable alc5upt1 "Days 5+/4+ drinks, past yr: Time unit";
label variable alc5upy1 "Number of days had 5+/4+ drinks past year";
label variable binge1   "
Number of times had 5+/4+ drinks on AN OCCASION, past 30 days";
label variable aheight  "Total height in inches";
label variable aweightp "Weight without shoes (pounds)";
label variable bmi      "Body Mass Index (BMI)";

label variable ausualpl "Place USUALLY go when sick";
label variable aplkind  "Place to go when sick (most often)";
label variable ahcplrou "USUALLY go there for routine/preventive care";
label variable ahcplknd "Place USUALLY go for routine/preventive care";
label variable ahcchgyr "Change health care place, past 12 m";
label variable ahcchghi "Change related to health insurance";
label variable aprvtryr "Trouble finding a doctor/provider, past 12 m";
label variable aprvtrfd "Able to find doctor/provider, past 12 m";
label variable adrnanp  "
Doctor's office not accept you as new patient, past 12 m";
label variable adrnai   "
Doctor's office not accept your health insurance, past 12 m";
label variable ahcdlyr1 "Couldn't get through on phone, past 12 m";
label variable ahcdlyr2 "Couldn't get appointment soon enough, past 12 m";
label variable ahcdlyr3 "Wait too long in doctor's office, past 12 m";
label variable ahcdlyr4 "Not open when you could go, past 12 m";
label variable ahcdlyr5 "No transportation, past 12 m";
label variable ahcafyr1 "Couldn't afford prescription medicine, past 12 m";
label variable ahcafyr2 "
Couldn't afford mental health care/counseling, past 12 m";
label variable ahcafyr3 "Couldn't afford dental care, past 12 m";
label variable ahcafyr4 "Couldn't afford eyeglasses, past 12 m";
label variable ahcafyr5 "Couldn't afford to see a specialist, past 12 m";
label variable ahcafyr6 "Couldn't afford follow-up care, past 12 m";
label variable aworpay  "
Get sick or have accident, worried about paying medical bills";
label variable ahicomp  "Health insurance coverage compared to a year ago";
label variable arx12mo  "
Prescribed medication by doctor/health professional, past 12 m";
label variable arx12_1  "Skipped medication doses to save money, past 12 m";
label variable arx12_2  "Took less medicine to save money, past 12 m";
label variable arx12_3  "Delayed filling a prescription to save money, past 12 m
";
label variable arx12_4  "
Asked doctor for lower cost medication to save money, past 12 m";
label variable arx12_5  "
Bought prescription drugs from another country to save money, past 12 m";
label variable arx12_6  "Used alternative therapies to save money, past 12 m";
label variable adnlong2 "Time since last saw a dentist";
label variable ahcsyr1  "Seen/talked to mental health professional, past 12 m";
label variable ahcsyr2  "Seen/talked to eye doctor, past 12 m";
label variable ahcsyr3  "Seen/talked to foot doctor, past 12 m";
label variable ahcsyr4  "Seen/talked to a chiropractor, past 12 m";
label variable ahcsyr5  "Seen/talked to therapist (PT/OT/etc.), past 12 m";
label variable ahcsyr6  "Seen/talked to a NP/PA/midwife, past 12 m";
label variable ahcsyr7  "Seen/talked to OB/GYN, past 12 m";
label variable ahcsyr8  "Seen/talked to a medical specialist, past 12 m";
label variable ahcsyr9  "Seen/talked to a general doctor, past 12 m";
label variable ahcsyr10 "Doctor treats both kids and adults";
label variable ahernoy2 "# times in ER/ED, past 12 m";
label variable aervisnd "ER visit at night or on weekend";
label variable aerhos   "ER visit resulted in hospital admission";
label variable aerrea1r "ER visit because didn't have another place to go";
label variable aerrea2r "ER visit because doctors office or clinic was not open
";
label variable aerrea3r "ER visit because advised by health provider to go";
label variable aerrea4r "
ER visit because problem too serious for doctor's office/clinic";
label variable aerrea5r "ER visit because only hospital could help";
label variable aerrea6r "ER visit because it is closest provider";
label variable aerrea7r "ER visit because it is usual place to get care";
label variable aerrea8r "Arrived at ER by ambulance/other emergency vehicle";
label variable ahchyr   "Received home care from health professional, past 12 m
";
label variable ahchmoyr "# months of home care, past 12 m";
label variable ahchnoy2 "Total number of home visits";
label variable ahcnoyr2 "Total number of office visits, past 12 m";
label variable asrgyr   "Surgery/surgical procedure, past 12 m";
label variable asrgnoyp "# of surgeries, past 12 m";
label variable amdlongr "Time since last seen/talked to health professional";
label variable hit1a    "Looked up health information on Internet, past 12 m";
label variable hit2a    "Filled a prescription on Internet, past 12 m";
label variable hit3a    "Scheduled medical appointment on Internet, past 12 m";
label variable hit4a    "
Communicated with health care provider by email, past 12 m";
label variable hit5a    "
Used chat groups to learn about health topics, past 12 m";
label variable fluvacyr "Flu vaccination, past 12 m";
label variable fluvactp "Administration method of most recent flu vaccine";
label variable fluvac_m "Month of most recent flu vaccine";
label variable fluvac_y "Year of most recent flu vaccine";
label variable flushpg1 "
Flu shot before/during current pregnancy, interviewed Jan-Mar or Aug-Dec, 2016";
label variable flushpg2 "Flu shot before/during/after a pregnancy";
label variable shtpnuyr "Pneumonia shot (EVER)";
label variable apox     "Ever had chickenpox";
label variable apox12mo "Chickenpox, past 12 m";
label variable ahep     "Ever had hepatitis";
label variable ahepliv  "Ever lived w/ someone w/ hepatitis";
label variable ahepbtst "Ever had a blood test for hepatitis B";
label variable shthepb  "Hepatitis B vaccine (EVER)";
label variable shepdos  "# doses of hepatitis B vaccine received";
label variable shthepa  "Hepatitis A vaccine (EVER)";
label variable shepanum "# shots of hepatitis A vaccine received";
label variable ahepctst "Ever had a blood test for hepatitis C";
label variable ahepcres "Main reason tested for Hepatitis C";
label variable shingles "Ever had the Zoster or Shingles vaccine";
label variable shttd    "Tetanus shot in the past 10 years";
label variable shttd05  "Tetanus shot given in 2005 or later";
label variable shttdap2 "Vaccine included pertussis/whooping cough";
label variable shthpv2  "Ever received HPV shot/vaccine";
label variable shhpvdos "Number of HPV shots received";
label variable ahpvage  "Age at first HPV shot";
label variable livev    "
Ever told you had any kind of chronic/long-term liver condition";
label variable travel   "
Ever traveled outside USA since 1995 (Excluding EUR, JPN, AUS, NZL, and CAN)";
label variable wrkhlth2 "Work or volunteer in a health care setting";
label variable wrkdir   "Direct contact with patients";
label variable apsbpchk "
Blood pressure checked by doctor/nurse/health professional, past 12 m";
label variable apschchk "
Cholesterol checked by doctor/nurse/health professional, past 12 m";
label variable apsbschk "Fasting test for high blood sugar/diabetes, past 12 m";
label variable apspap   "Pap smear/test, past 12 m";
label variable apsmam   "Mammogram, past 12 m";
label variable apscol   "Test for colon cancer, past 12 m";
label variable apsdiet  "
Doctor/health professional talked to you about diet, past 12 m";
label variable apssmkc  "
Doctor/health professional talked to you about smoking, past 12 m";
label variable aindins2 "Tried to purchase health insurance directly, past 3 yrs
";
label variable aindprch "Purchased health insurance directly, past 3 yrs";
label variable aindwho  "For whom was health insurance purchased, past 3 yrs";
label variable ainddif1 "
How difficult to find health insurance for coverage needed, past 3 yrs";
label variable ainddif2 "
How difficult to find affordable health insurance, past 3 yrs";
label variable aexchng  "
Looked into purchasing health insurance through Healthcare.gov or Marketplace";

label variable asicpuse "How often do you use a computer";
label variable asisathc "How satisfied with health care, past 12 mo";
label variable asitenur "Length of time living in neighborhood";
label variable asinhelp "Agree/disagreeÖpeople in neighborhood help each other";
label variable asincnto "Agree/disagreeÖpeople I count on in neighborhood";
label variable asintru  "Agree/disagreeÖpeople in neighborhood can be trusted";
label variable asinknt  "Agree/disagreeÖclose-knit neighborhood";
label variable asisim   "How you think of yourself (sexual orientation; male)";
label variable asisif   "
How do you think of yourself (sexual orientation; female)";
label variable asiretr  "How worried are you aboutÖmoney for retirement";
label variable asimedc  "
How worried are you aboutÖmedical costs of illness/accident";
label variable asistlv  "
How worried are you aboutÖmaintaining standard of living";
label variable asicnhc  "How worried are you aboutÖmedical costs of healthcare";
label variable asiccoll "How worried are you aboutÖpaying for children's college
";
label variable asinbill "How worried are you aboutÖpaying monthly bills";
label variable asihcst  "
How worried are you aboutÖpaying rent/mortgage/housing costs";
label variable asiccmp  "How worried are you aboutÖcredit card payments";
label variable asisleep "Hours of sleep";
label variable asislpfl "# times having trouble falling asleep, past week";
label variable asislpst "# times having trouble staying asleep, past week";
label variable asislpmd "# times taking medication for sleep, past week";
label variable asirest  "Days woke up feeling rested, past week";
label variable asisad   "So sad nothing cheers you up, past 30 days";
label variable asinerv  "How often felt nervous, past 30 days";
label variable asirstls "How often restless/fidgety, past 30 days";
label variable asihopls "How often felt hopeless, past 30 days";
label variable asieffrt "How often felt everything was an effort, past 30 days";
label variable asiwthls "How often felt worthless, past 30 days";
label variable asimuch  "Feelings interfered w/ life, past 30 days";
label variable acibld12 "Donated blood, past 12 months";
label variable asihivt  "Ever been tested for HIV";
label variable asihivwn "Main reason not tested for HIV";

label variable balev    "
Ever had problem with dizziness, lighteheadedness, passing out, feel faint";
label variable balage_p "
Age first had problem with dizziness, lightheadedness, passing out, etc.";
label variable bdizz1   "Had dizziness or balance problem, past 12 months";
label variable brprob1  "Had severe fatigue, past 12 months";
label variable brprob2  "
Had problem with drifting to side when trying to walk straight, past 12 months";
label variable brprob3  "
Had prob bumping into one side or other when walking thru doorway, past 12 mos";
label variable brprob4  "
Had difficulty walking in the dark without using support, past 12 months";
label variable brprob5  "
Had difficulty walking on uneven ground or surfaces, past 12 months";
label variable brprob6  "Had a problem with fear of heights, past 12 months";
label variable brprob7  "
Had difficulty riding an escalator or moving walkway, past 12 months";
label variable bprob_ct "Counter for the number of balance problems";
label variable btype_1  "
Symptom: spinning/ vertigo sensation/ other illusion of motion, past 12 mos";
label variable btype_2  "
Symptom: a floating, spacey, or disconnected sensation, past 12 months";
label variable btype_3  "
Symptom: felt lightheaded without a sense of motion, past 12 months";
label variable btype_4  "Symptom: felt would pass out or faint, past 12 months";
label variable btype_5  "
Symptom: blurring of vision when moving head, past 12 months";
label variable btype_6  "
Symptom: feeling off-balance or unsteady, past 12 months";
label variable btype_7  "
Symptom: other dizziness or balance problem, past 12 months";
label variable btype_ct "Counter for the number of balance symptoms";
label variable bboth1   "Which one of these bothered the most, past 12 months";
label variable bage1_p  "How old when most bothersome thing first happened?";
label variable boftn    "How often had most bothersome thing, past 12 months";
label variable boftt    "Time period of most bothersome thing";
label variable blast1   "
How long does each episode of most bothersome thing usually last?";
label variable btrg_01  "
Does looking up or down lean forward or back trigger balance/dizz problem?";
label variable btrg_02  "Does rolling over in bed trigger balance/dizz problem?
";
label variable btrg_03  "
Does getting up after sitting  or lying down trigger balance/dizz problem?";
label variable btrg_04  "
Does headache, including migraine, trigger balance/dizz problem?";
label variable btrg_05  "
Does a visual problem such as double vision trigger balance/dizz problem?";
label variable btrg_06  "
Does riding in a car/bus/airplane/boat/train trigger balance/dizz problem?";
label variable btrg_07  "
Does walking down a grocery store aisle trigger balance/dizz problem?";
label variable btrg_08  "Does hearing loud sounds trigger balance/dizz problem?
";
label variable btrg_09  "Does blowing nose trigger balance/dizz problem?";
label variable btrg_10  "
Does taking prescription or OTC meds trigger balance/dizz problems?";
label variable bsame_1  "
Does nausea or vomiting happen at the same time as balance/dizz problem?";
label variable bsame_2  "
Does hearing loss in only one ear happen same time as balance/dizz problem?";
label variable bsame_3  "
Does ringing/buzzing/roaring in one ear happen same time as balance/dizz prob?";
label variable bsame_4  "
Does fullness/pressure/stuffiness in ear happen same time as balance/dizz prob?
";
label variable bsame_5  "
Does sinus congestion happen same time as balance/dizz problem?";
label variable bsame_6  "Does anxiety happen same time as balance/dizz problem?
";
label variable bsame_7  "
Does depression happen same time as balance/dizz problem?";
label variable bonly_1  "Have nausea or vomiting only with balance/dizz problem?
";
label variable bonly_2  "Have hearing loss only with balance/dizz problem?";
label variable bonly_3  "
Have ringing in ear/tinnitus only with balance/dizz problem?";
label variable bonly_4  "
Have fullness, pressure, stuffiness only with balance/dizz problem?";
label variable bonly_5  "Have sinus congestion only with balance/dizz problem?";
label variable bonly_6  "Have anxiety only with balance/dizz problem?";
label variable bonly_7  "Have depression only with balance/dizz problem?";
label variable bhosp2   "Ever gone to hospital/ER for dizz/balance problem?";
label variable bhospno1 "
Number of times gone to hospital/ER for dizz/balance problem, past 5 years";
label variable bhp1     "
Ever seen doctor/health professional about dizz/balance problem?";
label variable bhp1_01  "
Seen fam MD/internal medicine MD/family practitioner about dizz/balance prob?";
label variable bhp1_02  "
Seen cardiologist or heart specialist about dizz/balance problem?";
label variable bhp1_03  "
Seen ear, nose, throat doctor about dizz/balance problem?";
label variable bhp1_04  "Seen neurologist about dizz/balance problem?";
label variable bhp1_05  "
Seen eye doctor, optometrist, ophthalmologist about dizz/balance problem?";
label variable bhp1_06  "
Seen dentist, orthodontist, or oral surgeon about dizz/balance problem?";
label variable bhp1_07  "Seen gynecologist, OB/GYN about dizz/balance problem?";
label variable bhp1_08  "
See psychiatrist, psychologist, or social worker about dizz/balance problem?";
label variable bhp1_09  "
Seen osteopath, doctor of osteopathy about dizz/balance problem?";
label variable bhp1_10  "
Seen occup/physical therapist, rehab specialist/MD about dizz/balance prob?";
label variable bhp1_11  "
Seen physician asst or nurse practitioner about dizz/balance problem?";
label variable bhp1_12  "
See nutritionist or dietician about dizz/balance problem?";
label variable bhp1_13  "Seen audiologist about dizz/balance problem?";
label variable bhp1_14  "Seen foot doctor about dizz/balance problem?";
label variable bhp1_15  "
Seen some other health professional about dizz/balance problem?";
label variable b5yrs1   "
How many times seen MD/oth health prof about dizz/balance prob, past 5 years?";
label variable bfirst1  "
How long ago first saw MD/ other health professional about dizz/balance problem?
";
label variable bhelp1   "
How much did these doctors/other health professionals help dizz/balance prob?";
label variable bthlp_n  "
# of days/wks/yrs btwn 1st time saw MD for dizz/bal prob & helped by treatment";
label variable bthlp_t  "
Time period btwn 1st time saw MD for dizz/balance prob & helped by treatment";
label variable bdiag1   "
Did doctor/health professionals give diagnosis for dizz/balance problem?";
label variable bcaus101 "Allergies cause of dizz/balance problem?";
label variable bcaus102 "Anxiety or depression cause of dizz/balance problem?";
label variable bcaus103 "
Benign positional vertigo (BPV) cause of dizz/balance problem?";
label variable bcaus104 "
Crystals-loose or dislodged  in ear cause of dizz/balance problem?";
label variable bcaus105 "Diabetes cause of balance problem?";
label variable bcaus106 "Headache or migraine cause of dizz/balance problem?";
label variable bcaus107 "
Head or neck trauma/concussion cause of dizz/balance problem?";
label variable bcaus108 "Heart disease cause of dizz/balance problem?";
label variable bcaus109 "
Inner ear infection/viral labrynthitis cause of dizz/balance problem?";
label variable bcaus110 "
Meniere's (Men-e-AIRZ) disease cause of dizz/balance problem?";
label variable bcaus111 "
Neurological-multiple sclerosis (MS), seizures, etc. cause of dizz/balance prob?
";
label variable bcaus112 "
Side effects from medications cause of dizz/balance problem?";
label variable bcaus113 "Stroke cause of dizz/balance problem?";
label variable bcaus114 "Other health problem(s) cause of dizz/balance problem?
";
label variable btret1   "Ever tried anything to treat dizz/balance problem?";
label variable btrt1_01 "
Ever tried exercises or physical therapy to treat dizz/balance problem?";
label variable btrt1_02 "
Ever tried bed rest for several hours/days to treat dizz/balance problem?";
label variable btrt1_03 "
Ever tried head rolling/Epley maneuver by MD/therapist to treat dizz/bal prob?";
label variable btrt1_04 "
Ever tried steroid injections to the ear to treat dizz/balance problem?";
label variable btrt1_06 "Ever tried surgery to treat dizz/balance problem?";
label variable btrt1_07 "Ever tried low salt diet to treat dizz/balance problem?
";
label variable btrt1_08 "
Ever cut back/avoided certain food or drinks to treat dizz/balance problem?";
label variable btrt1_09 "
Ever tried quit/reduce use of tobacco/cigarettes to treat dizz/balance problem?
";
label variable btrt1_10 "
Ever tried prescription medicine/drugs to treat dizz/balance problem?";
label variable btrt1_11 "
Ever tried OTC meds (allergy meds, sleep aids) to treat dizz/balance problem?";
label variable btrt1_12 "Ever tried psychiatric treatment?";
label variable btrt1_13 "
Ever tried massage therapy or chiropractic treatment or manipulation";
label variable btrt1_14 "Ever tried acupuncture?";
label variable btrt1_15 "
Ever tried herbal remedies such as feverfew tea, ginger, or ginkgo biloba?";
label variable btrt1_16 "Ever tried wearing magnets or acupressure wristband?";
label variable bstat1   "
In past 12 mos, are dizz/bal probs worse, same, imprv some, or imprv greatly?";
label variable bmedic1  "
Do you regularly take any medicine that makes your dizz/bal prob(s) worse?";
label variable bchng1   "
Do dizziness or balance probs prevent from doing things you otherwise could do?
";
label variable bchg1_01 "
Have dizz/bal probs caused changes or cut back on driving a motor vehicle?";
label variable bchg1_02 "
Dizz/bal probs caused changes/cut back on riding in car/bus/plane/boat/train?";
label variable bchg1_03 "
Dizz/bal probs caused changes or cut back on exercising or taking walks?";
label variable bchg1_04 "
Dizz/bal probs caused changes or cut back on walking down a flight of stairs?";
label variable bchg1_05 "
Dizz/bal probs caused changes/cut back on social activities outside home?";
label variable bchg1_06 "
Dizz/bal probs caused changes/cut back on chores, like cleaning or laundry?";
label variable bchg1_07 "
Dizz/bal probs caused changes or cut back on going to the toilet?";
label variable bm12ws   "
In past 12 mos, how many days of work/school missed because of dizz/bal problem?
";
label variable bm12ra   "
In past 12 mos how many days of oth activities missed bec of dizz/bal problem?";
label variable bprob1   "
In the past 12 mos, how much of a problem was your dizziness/balance condition?
";
label variable bmed_1   "
Ever taken or had Meclizine or Antivert for dizziness, nausea, or vomiting?";
label variable bmed_2   "
Ever taken/had other medicine or patches for motion sickness/nausea/vomiting?";
label variable bmed_3   "
Have you ever taken or had medicines for anxiety or depression?";
label variable bmed_4   "Have you ever taken or had chemotherapy?";
label variable bbio1    "
Any of your bio relatives had prob with dizz/bal/falling, not related to aging?
";
label variable bfall12m "In the past year, have you fallen at least one time?";
label variable bfall5y  "In the past 5 years, have you fallen at least one time?
";
label variable bfl1_01  "
In past 5 yrs, any falls just before a sense of spinning/oth movement sensation?
";
label variable bfl1_02  "
In past 5 yrs, any falls occur before a floating/spacey/disconnected feeling?";
label variable bfl1_03  "
In past 5 yrs, did any of your falls occur just before you felt lightheaded?";
label variable bfl1_04  "
In past 5 yrs, any falls occur just before felt like passing out?";
label variable bfl1_05  "
In past 5 yrs, did any falls occur just before you were having blurred vision?";
label variable bfl1_06  "
In past 5 yrs, did any falls occur just before you felt unsteady or off-balance?
";
label variable bfl1_07  "
In past 5 yrs, did any falls occur before other/general prob with dizz/imbal?";
label variable bfall12a "
In the past 12 months, have you fallen at least once a month on average?";
label variable bf12m_no "
In the past 12 months, about how many times per day/week/month have you fallen?
";
label variable bf12m_tp "Time period for time fallen";
label variable bftime1  "In the past 12 months, how many times have you fallen?
";
label variable binj1    "
In the past 12 months, did you have an injury as a result of a fall?";
label variable binjws   "
In past 12 mos, how many days of work/school missed bec of injury from falls?";
label variable binjhp   "
In past 12 mos, did you talk to/see MD/health prof about injuries from a fall?";
label variable binjhpn  "
In past 12 mos # times you talk to/saw medical prof about worst inj from a fall?
";
label variable bfwh_01  "
Have you fallen in the past 12 months because you tripped, stumbled, or slipped?
";
label variable bfwh_02  "
Have you fallen in the past 12 months because you blacked out or fainted?";
label variable bfwh_03  "
Have you fallen in the past 12 mos because you were playing sports/exercising?";
label variable bfwh_04  "
Have you fallen in the past 12 months because you had a problem with vision?";
label variable bfwh_05  "
Have you fallen in past 12 mos bec you had weakness/numbness in one/both legs?";
label variable bfwh_06  "
Have you fallen in the past 12 mos bec you hadnít eaten/had low blood sugar?";
label variable bfwh_07  "
Have you fallen in the past 12 months because you drank too much alcohol?";
label variable bfwh_08  "
Have you fallen in past 12 mos bec you had a prob using a walker/cane/other aid?
";
label variable bfwh_09  "
Have you fallen in past 12 mos because had a problem with shoes/sandals/socks?";
label variable bfwh_10  "
Have you fallen in the past 12 months because of some other reason?";
label variable bnrfall  "
In past 12 mos # times you slipped/lost balance and caught self without falling?
";
label variable binthi   "
In past 12 mos have you used the Internet to get health info on dizz/bal probs?
";
label variable binttr   "
In past 12 mos use Internet to research medical/other dizz/bal prob treatments?
";
label variable bintrs   "
In past 12 mos use Internet to find rehab/intervention progs for dizz/bal probs?
";

label variable awebuse  "Internet use";
label variable awebofno "Frequency internet use: # of units";
  label variable aweboftp "Frequency internet use: Time units";
label variable awebeml  "Email use";
label variable awebmno  "Frequency email use: # of units";
  label variable awebmtp  "Frequency email use: Time units";

* DEFINE VALUE LABELS FOR REPORTS;

label define sap001x
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
label define sap004x
   1        "1 Quarter 1"
   2        "2 Quarter 2"
   3        "3 Quarter 3"
   4        "4 Quarter 4"
;
label define sap005x
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
label define sap010x
   1        "1 Northeast"
   2        "2 Midwest"
   3        "3 South"
   4        "4 West"
;
label define sap013x
   1        "1 Male"
   2        "2 Female"
;
label define sap014x
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
label define sap015x
   01       "01 White only"
   02       "02 Black/African American only"
   03       "03 AIAN only"
   04       "04 Asian only"
   05       "05 Race group not releasable (See file layout)"
   06       "06 Multiple race"
;
label define sap016x
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
label define sap017x
   01       "01 White"
   02       "02 Black/African American"
   03       "03 Indian (American) (includes Eskimo, Aleut)"
   06       "06 Chinese"
   07       "07 Filipino"
   12       "12 Asian Indian"
   16       "16 Other race (See file layout)"
   17       "17 Multiple race, no primary race selected"
;
label define sap018x
   00       "00 Under 1 year"
   85       "85 85+ years"
;
label define sap019x
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
label define sap020x
   1        "
1 Yes, the Sample Adult is a parent of a child residing in the family"
   2        "
2 There are minor children residing in the family but the Sample Adult is not th
eir parent"
   3        "3 There are no minor children residing in the family"
   9        "9 Unknown"
;
label define sap021x
   1        "1 Physical or mental condition prohibits responding"
   2        "2 Sample adult is able to respond"
   3        "3 Unknown"
;
label define sap022x
   1        "1 Yes"
   2        "2 No"
;
label define sap023x
   1        "1 Relative who lives in household"
   2        "2 Relative who doesn't live in household"
   3        "3 Other caregiver"
   4        "4 Other"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap024x
   1        "1 Started Sample Adult Core 2+ weeks after the initial interview"
   2        "
2 Started Sample Adult Core less than 2 weeks after the initial interview"
;
label define sap025x
   1        "1 Families selected to receive AFD (sample adults) section"
   2        "
2 Families selected to receive FDB (all persons 1 year and older) section"
;
label define sap026x
   1        "1 Working for pay at a job or business"
   2        "2 With a job or business but not at work"
   3        "3 Looking for work"
   4        "4 Working, but not for pay, at a family-owned job or business"
   5        "5 Not working at a job or business and not looking for work"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap027x
   01       "01 Taking care of house or family"
   02       "02 Going to school"
   03       "03 Retired"
   04       "04 On a planned vacation from work"
   05       "05 On family or maternity leave"
   06       "06 Temporarily unable to work for health reasons"
   07       "07 Have job or contract and off-season"
   08       "08 On layoff"
   09       "09 Disabled"
   10       "10 Other"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap028x
   1        "1 Yes"
   2        "2 No"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap034x
   1        "1 Employee of a PRIVATE company for wages"
   2        "2 A FEDERAL government employee"
   3        "3 A STATE government employee"
   4        "4 A LOCAL government employee"
   5        "5 Self-employed in OWN business, professional practice or farm"
   6        "6 Working WITHOUT PAY in a family-owned business or farm"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap036x
   01       "01 1 employee"
   02       "02 2-9 employees"
   03       "03 10-24 employees"
   04       "04 25-49 employees"
   05       "05 50-99 employees"
   06       "06 100-249 employees"
   07       "07 250-499 employees"
   08       "08 500-999 employees"
   09       "09 1000 employees or more"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap037x
   00       "00 Less than 1 year"
   35       "35 35 or more years"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap042x
   0        "0 Had job last week"
   1        "1 No job last week, had job past 12 months"
   2        "2 No job last week, no job past 12 months"
   3        "3 Never worked"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap071x
   1        "1 Mentioned"
   2        "2 Not mentioned"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap102x
   85       "85 85+ years"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap140x
   1        "1 Yes"
   2        "2 No"
   3        "3 Borderline or prediabetes"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap142x
   1        "1 year ago or less"
2        "2 More than 1 year, but not more than 2 years ago"
   3        "3 More than 2 years, but not more than 3 years ago"
4        "4 More than 3 years ago"
5        "5 Never"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap144x
   00       "00 Within past year"
   85       "85 85+ years"
   96       "96 1+ year(s) with diabetes and age is 85+"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap145x
   1        "1 Type 1"
   2        "2 Type 2"
   3        "3 Other"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap148x
   1        "1 Less than 1 month"
   2        "2 1 month to less than 6 months"
3        "3 6 months to less than 1 year"
   4        "4 1 year or more"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap155x
1        "1 Very interested"
2        "2 Somewhat interested"
   3        "3 Not interested"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap194x
   1        "1 Excellent"
   2        "2 Good"
   3        "3 A little trouble hearing"
   4        "4 Moderate trouble"
   5        "5 A lot of trouble"
   6        "6 Deaf"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap211x
   0        "0 Not at all difficult"
   1        "1 Only a little difficult"
   2        "2 Somewhat difficult"
   3        "3 Very difficult"
   4        "4 Can't do at all because of eyesight"
   6        "6 Do not do this activity for other reasons"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap217x
   1        "1 Less than one month"
   2        "2 1-12 months"
   3        "3 13-24 months"
   4        "4 More than 2 years"
   5        "5 Never"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap219x
   1        "1 Always"
   2        "2 Most of the time"
   3        "3 Some of the time"
   4        "4 None of the time"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap221x
   1        "1 Never"
   2        "2 Some days"
   3        "3 Most days"
   4        "4 Every day"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap223x
   000      "000 None"
   997      "997 Refused"
   998      "998 Not ascertained"
   999      "999 Don't know"
;
label define sap225x
   1        "1 Better"
   2        "2 Worse"
   3        "3 About the same"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap227x
   0        "0 Not at all difficult"
   1        "1 Only a little difficult"
   2        "2 Somewhat difficult"
   3        "3 Very difficult"
   4        "4 Can't do at all"
   6        "6 Do not do this activity"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap239x
   1        "1 Limited in any way"
   2        "2 Not limited in any way"
   3        "3 Unknown if limited"
;
label define sap276x
   95       "95 95+"
   96       "96 Since birth"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap277x
   1        "1 Day(s)"
   2        "2 Week(s)"
   3        "3 Month(s)"
   4        "4 Year(s)"
   6        "6 Since birth"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap278x
   00       "00 Less than 1 year"
   85       "85 85+ years"
   96       "96 Unknown number of years"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap279x
   1        "1 Less than 3 months"
   2        "2 3-5 months"
   3        "3 6-12 months"
   4        "4 More than 1 year"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap280x
   1        "1 Chronic"
   2        "2 Not chronic"
   9        "9 Unknown if chronic"
;
label define sap456x
   1        "1 At least one condition causing functional limitation is chronic"
   2        "2 No condition causing functional limitation"
   9        "9 Unknown if any condition causing functional limitation is chronic
"
;
label define sap457x
   0        "0 Not limited in any way (including unknown if limited)"
   1        "1 Limited; caused by at least one chronic condition"
   2        "2 Limited; not caused by chronic condition"
   3        "3 Limited; unknown if condition is chronic"
;
label define sap459x
   85       "85 85 years or older"
   96       "96 Never smoked regularly"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap460x
   1        "1 Every day"
   2        "2 Some days"
   3        "3 Not at all"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap461x
   1        "1 Current every day smoker"
   2        "2 Current some day smoker"
   3        "3 Former smoker"
   4        "4 Never smoker"
   5        "5 Smoker, current status unknown"
   9        "9 Unknown if ever smoked"
;
label define sap462x
   95       "95 95+"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap463x
   1        "1 Day(s)"
   2        "2 Week(s)"
   3        "3 Month(s)"
   4        "4 Year(s)"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap464x
   00       "00 Less than 1 year"
   70       "70 70+ years"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap465x
   95       "95 95+ cigarettes"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap466x
   00       "00 None"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap472x
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap480x
   000      "000 Never"
   996      "996 Unable to do this type activity"
   997      "997 Refused"
   998      "998 Not ascertained"
   999      "999 Don't know"
;
label define sap481x
   0        "0 Never"
   1        "1 Per day"
   2        "2 Per week"
   3        "3 Per month"
   4        "4 Per year"
   6        "6 Unable to do this activity"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap482x
   00       "00 Less than once per week"
   95       "95 Never"
   96       "96 Unable to do vigorous activity"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap483x
   997      "997 Refused"
   998      "998 Not ascertained"
   999      "999 Don't know"
;
label define sap484x
   1        "1 Minutes"
   2        "2 Hours"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap488x
   00       "00 Less than once per week"
   95       "95 Never"
   96       "96 Unable to do light or moderate activity"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap494x
   00       "00 Less than once per week"
   95       "95 Never"
   96       "96 Unable to do strength activity"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap497x
   000      "000 Never"
   997      "997 Refused"
   998      "998 Not ascertained"
   999      "999 Don't know"
;
label define sap498x
   0        "0 Never/None"
   1        "1 Week"
   2        "2 Month"
   3        "3 Year"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap499x
   00       "00 Less than one day per week"
   95       "95 Did not drink in past year"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap500x
   000      "000 Never/none"
   997      "997 Refused"
   998      "998 Not ascertained"
   999      "999 Don't know"
;
label define sap501x
   95       "95 95+ drinks"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap502x
   01       "01 Lifetime abstainer"
   02       "02 Former infrequent"
   03       "03 Former regular"
   04       "04 Former, unknown frequency"
   05       "05 Current infrequent"
   06       "06 Current light"
   07       "07 Current moderate"
   08       "08 Current heavier"
   09       "09 Current drinker, frequency/level unknown"
   10       "10 Drinking status unknown"
;
label define sap504x
   0        "0 Never/None"
   1        "1 Per week"
   2        "2 Per month"
   3        "3 Per year"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap507x
   96       "96 Not available"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap508x
   996      "996 Not available"
   997      "997 Refused"
   998      "998 Not ascertained"
   999      "999 Don't know"
;
label define sap510x
   1        "1 Yes"
   2        "2 There is NO place"
   3        "3 There is MORE THAN ONE place"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap511x
   1        "1 Clinic or health center"
   2        "2 Doctor's office or HMO"
   3        "3 Hospital emergency room"
   4        "4 Hospital outpatient department"
   5        "5 Some other place"
   6        "6 Doesn't go to one place most often"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap513x
   0        "0 Doesn't get preventive care anywhere"
   1        "1 Clinic or health center"
   2        "2 Doctor's office or HMO"
   3        "3 Hospital emergency room"
   4        "4 Hospital outpatient department"
   5        "5 Some other place"
   6        "6 Doesn't go to one place most often"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap517x
   1        "1 Yes"
   2        "2 No"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Donít know"
;
label define sap531x
   1        "1 Very worried"
   2        "2 Somewhat worried"
   3        "3 Not at all worried"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap540x
   0        "0 Never"
   1        "1 6 months or less"
   2        "2 More than 6 mos, but not more than 1 yr ago"
   3        "3 More than 1 yr, but not more than 2 yrs ago"
   4        "4 More than 2 yrs, but not more than 5 yrs ago"
   5        "5 More than 5 years ago"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap551x
   00       "00 None"
   01       "01 1"
   02       "02 2-3"
   03       "03 4-5"
   04       "04 6-7"
   05       "05 8-9"
   06       "06 10-12"
   07       "07 13-15"
   08       "08 16 or more"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap564x
   01       "01 1"
   02       "02 2-3"
   03       "03 4-5"
   04       "04 6-7"
   05       "05 8-9"
   06       "06 10-12"
   07       "07 13-15"
   08       "08 16 or more"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap567x
   07       "07 7+ times"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap575x
   1        "1 Flu shot"
   2        "2 Flu nasal spray (spray, mist or drop in nose)"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap576x
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
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap577x
   9997     "9997 Refused"
   9998     "9998 Not ascertained"
   9999     "9999 Don't know"
;
label define sap578x
   1        "1 Before this pregnancy"
   2        "2 During this pregnancy"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap579x
   1        "1 Before this pregnancy"
   2        "2 During this pregnancy"
   3        "3 After this pregnancy"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap587x
   1        "1 Received at least 3 doses"
   2        "2 Received less than 3 doses"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap589x
   96       "96 Received all shots"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap591x
   1        "
1 You or your doctor thought you were at risk of having hepatitis C because a bl
ood test or symptoms like fatigue, nausea, stomach pain, yellowing of the eyes o
r skin indicated you might have liver disease"
   2        "2 You were born from 1945 through 1965"
   3        "
3 You were at risk of hepatitis C infection due to exposure to blood on your job
, injection drug use or receipt of transfusion before 1992"
   4        "4 Some other reason"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Donít know"
;
label define sap595x
   1        "1 Yes-included pertussis"
   2        "2 No-did not include pertussis"
   3        "3 Doctor did not say"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap596x
   1        "1 Yes"
   2        "2 No"
   3        "3 Doctor refused when asked"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap597x
   50       "50 50+ shots"
   96       "96 All shots"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap613x
   1        "1 Self"
   2        "2 Someone else in family"
   3        "3 Both"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Donít know"
;
label define sap614x
   1        "1 Very difficult"
   2        "2 Somewhat difficult"
   3        "3 Not at all difficult"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Donít know"
;
label define sap615x
   1        "1 Very difficult"
   2        "2 Somewhat difficult"
   3        "3 Not at all difficult"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap617x
   1        "1 Never or almost never"
   2        "2 Some days"
   3        "3 Most days"
   4        "4 Every day"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap618x
   1        "1 Very satisfied"
   2        "2 Somewhat satisfied"
   3        "3 Somewhat dissatisfied"
   4        "4 Very dissatisfied"
   5        "5 You haven't had health care in the past 12 months"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap619x
   1        "1 Less than 1 year"
   2        "2 1-3 years"
   3        "3 4-10 years"
   4        "4 11-20 years"
   5        "5 More than 20 years"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap620x
   1        "1 Definitely agree"
   2        "2 Somewhat agree"
   3        "3 Somewhat disagree"
   4        "4 Definitely disagree"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap624x
   1        "1 Gay"
   2        "2 Straight, that is, not gay"
   3        "3 Bisexual"
   4        "4 Something else"
   5        "5 I don't know the answer"
   7        "7 Refused"
   8        "8 Not ascertained"
;
label define sap625x
   1        "1 Lesbian or gay"
   2        "2 Straight, that is, not lesbian or gay"
   3        "3 Bisexual"
   4        "4 Something else"
   5        "5 I don't know the answer"
   7        "7 Refused"
   8        "8 Not ascertained"
;
label define sap626x
   1        "1 Very worried"
   2        "2 Moderately worried"
   3        "3 Not too worried"
   4        "4 Not worried at all"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap630x
   1        "1 Very worried"
   2        "2 Moderately worried"
   3        "3 Not too worried"
   4        "4 Not worried at all"
   5        "5 This does not apply to me"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap633x
   1        "1 Very worried"
   2        "2 Moderately worried"
   3        "3 Not too worried"
   4        "4 Not worried at all"
   5        "5 I don't have credit cards"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap635x
   00       "00 Did not have trouble falling asleep in the past week"
   07       "07 7 or more times"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap636x
   00       "00 Did not have trouble staying asleep in the past week"
   07       "07 7 or more times"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap637x
   00       "00 Did not take medication to help sleep in the past week"
   07       "07 7 or more times"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap638x
   00       "00 Never felt rested in the past week"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap639x
   1        "1 ALL of the time"
   2        "2 MOST of the time"
   3        "3 SOME of the time"
   4        "4 A LITTLE of the time"
   5        "5 NONE of the time"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap645x
   1        "1 A lot"
   2        "2 Some"
   3        "3 A little"
   4        "4 Not at all"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap648x
   01       "01 It's unlikely you've been exposed to HIV"
   02       "
02 You were afraid to find out if you were HIV positive (that you had HIV)"
   03       "03 You didn't want to think about HIV or about being HIV positive"
   04       "
04 You were worried your name would be reported to the government if you tested
positive"
   05       "05 You didn't know where to get tested"
   06       "06 You don't like needles"
   07       "
07 You were afraid of losing job, insurance, housing, friends, family, if people
 knew you were positive for AIDS infection"
   08       "08 Some other reason"
   09       "09 No particular reason"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap650x
   85       "85 85+ years"
   96       "96 Since birth"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap668x
   01       "01 the spinning, vertigo, or motion sensation"
   02       "02 the floating, spacey, or disconnected feeling"
   03       "03 the feeling of lightheadedness"
   04       "04 the feeling like you are about to pass out"
   05       "05 Blurred vision"
   06       "06 Unsteadiness"
   07       "07 Other dizziness or balance problem"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap670x
   996      "996 Constantly or almost always"
   997      "997 Refused"
   998      "998 Not ascertained"
   999      "999 Don't know"
;
label define sap671x
   1        "1 Day(s)"
   2        "2 Week(s)"
   3        "3 Month(s)"
   4        "4 Year"
   6        "6 Constantly or almost always"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap672x
   01       "01 Momentary, or less than two minutes"
   02       "02 Two minutes to less than 20 minutes"
   03       "03 20 minutes to less than 8 hours"
   04       "04 8 hours to less than 24 hours"
   05       "05 1 day to less than 14 days"
   06       "06 2 weeks to less than 3 months"
   07       "07 3 months or longer"
   97       "97 Refused"
   98       "98 Not ascertained"
   99       "99 Don't know"
;
label define sap690x
   1        "1 Only"
   2        "2 Regardless"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap698x
   0        "0 None"
   1        "1 1 time"
   2        "2 2 times"
   3        "3 3-4 times"
   4        "4 5-9 times"
   5        "5 10-14 times"
   6        "6 15 or more times"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap716x
   1        "1 Less than 12 months"
   2        "2 12 months to less than 3 years"
   3        "3 years to less than 5 years"
   4        "4 5 years to less than 10 years"
   5        "5 10 years to less than 15 years"
   6        "6 15 years or more"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap717x
   1        "1 No help at all"
   2        "2 A little help"
   3        "3 Moderate help"
   4        "4 A lot of help"
   5        "5 Problem was cured or no longer exists"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap751x
   1        "1 Gotten worse"
   2        "2 Stayed the same"
   3        "3 Improved somewhat"
   4        "4 Improved greatly"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap763x
   1        "1 No problem"
   2        "2 A small problem"
   3        "3 A moderate problem"
   4        "4 A big problem"
   5        "5 A very big problem"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap780x
   1        "1 Day(s)"
   2        "2 Week(s)"
   3        "3 Month(s)"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap781x
   0        "0 None"
   1        "1 1 time"
   2        "2 2 times"
   3        "3 3-4 times"
   4        "4 5-7 times"
   5        "5 8 or more times"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap783x
   996      "996 Doesn't work or go to school"
   997      "997 Refused"
   998      "998 Not ascertained"
   999      "999 Don't know"
;
label define sap796x
   0        "0 None"
   1        "1 1 time"
   2        "2 2 times"
   3        "3 3 to 4 times"
   4        "4 5 to 7 times"
   5        "5 8 or more times"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;
label define sap802x
   1        "1 Per day"
   2        "2 Per week"
   3        "3 Per month"
   4        "4 Per year"
   7        "7 Refused"
   8        "8 Not ascertained"
   9        "9 Don't know"
;

* ASSOCIATE VARIABLES WITH VALUE LABEL DEFINITIONS;

label values rectype   sap001x;   label values intv_qrt  sap004x;
label values intv_mon  sap005x;

label values region    sap010x;

label values sex       sap013x;   label values hispan_i  sap014x;
label values racerpi2  sap015x;   label values mracrpi2  sap016x;
label values mracbpi2  sap017x;   label values age_p     sap018x;

label values r_maritl  sap019x;   label values par_stat  sap020x;

label values proxysa   sap021x;   label values prox1     sap022x;
label values prox2     sap023x;   label values lateinta  sap024x;

label values fdrn_flg  sap025x;

label values doinglwa  sap026x;   label values whynowka  sap027x;
label values everwrk   sap028x;   label values supervis  sap028x;
label values wrkcata   sap034x;   label values businc1a  sap028x;
label values locall1b  sap036x;   label values yrswrkpa  sap037x;
label values wrklongh  sap028x;   label values hourpda   sap028x;
label values pdsicka   sap028x;   label values onejob    sap028x;
label values wrklyr4   sap042x;

label values hypev     sap028x;   label values hypdifv   sap028x;
label values hypyr1    sap028x;   label values hypmdev2  sap028x;
label values hypmed2   sap028x;   label values chlev     sap028x;
label values chlyr     sap028x;   label values chlmdev2  sap028x;
label values chlmdnw2  sap028x;   label values chdev     sap028x;
label values angev     sap028x;   label values miev      sap028x;
label values hrtev     sap028x;   label values strev     sap028x;
label values ephev     sap028x;   label values copdev    sap028x;
label values aspmedev  sap028x;   label values aspmedad  sap028x;
label values aspmdmed  sap028x;   label values asponown  sap028x;
label values aasmev    sap028x;   label values aasstill  sap028x;
label values aasmyr    sap028x;   label values aaseryr1  sap028x;
label values ulcev     sap028x;   label values ulcyr     sap028x;
label values ulccolev  sap028x;   label values canev     sap028x;
label values cnkind1   sap071x;   label values cnkind2   sap071x;
label values cnkind3   sap071x;   label values cnkind4   sap071x;
label values cnkind5   sap071x;   label values cnkind6   sap071x;
label values cnkind7   sap071x;   label values cnkind8   sap071x;
label values cnkind9   sap071x;   label values cnkind10  sap071x;
label values cnkind11  sap071x;   label values cnkind12  sap071x;
label values cnkind13  sap071x;   label values cnkind14  sap071x;
label values cnkind15  sap071x;   label values cnkind16  sap071x;
label values cnkind17  sap071x;   label values cnkind18  sap071x;
label values cnkind19  sap071x;   label values cnkind20  sap071x;
label values cnkind21  sap071x;   label values cnkind22  sap071x;
label values cnkind23  sap071x;   label values cnkind24  sap071x;
label values cnkind25  sap071x;   label values cnkind26  sap071x;
label values cnkind27  sap071x;   label values cnkind28  sap071x;
label values cnkind29  sap071x;   label values cnkind30  sap071x;
label values cnkind31  sap071x;   label values canage1   sap102x;
label values canage2   sap102x;   label values canage3   sap102x;
label values canage4   sap102x;   label values canage5   sap102x;
label values canage6   sap102x;   label values canage7   sap102x;
label values canage8   sap102x;   label values canage9   sap102x;
label values canage10  sap102x;   label values canage11  sap102x;
label values canage12  sap102x;   label values canage13  sap102x;
label values canage14  sap102x;   label values canage15  sap102x;
label values canage16  sap102x;   label values canage17  sap102x;
label values canage18  sap102x;   label values canage19  sap102x;
label values canage20  sap102x;   label values canage21  sap102x;
label values canage22  sap102x;   label values canage23  sap102x;
label values canage24  sap102x;   label values canage25  sap102x;
label values canage26  sap102x;   label values canage27  sap102x;
label values canage28  sap102x;   label values canage29  sap102x;
label values canage30  sap102x;   label values pregever  sap028x;
label values dbhvpay   sap028x;   label values dbhvcly   sap028x;
label values dbhvwly   sap028x;   label values dbhvpan   sap028x;
label values dbhvcln   sap028x;   label values dbhvwln   sap028x;
label values dibrel    sap028x;   label values dibev1    sap140x;
label values dibpre2   sap028x;   label values dibtest   sap142x;
label values dibage1   sap102x;   label values difage2   sap144x;
label values dibtype   sap145x;   label values dibpill1  sap028x;
label values insln1    sap028x;   label values dibins2   sap148x;
label values dibins3   sap028x;   label values dibins4   sap028x;
label values dibgdm    sap028x;   label values dibbaby   sap028x;
label values dibprgm   sap028x;   label values dibrefer  sap028x;
label values dibbegin  sap155x;   label values ahayfyr   sap028x;
label values sinyr     sap028x;   label values cbrchyr   sap028x;
label values kidwkyr   sap028x;   label values livyr     sap028x;
label values jntsymp   sap028x;   label values jmthp1    sap071x;
label values jmthp2    sap071x;   label values jmthp3    sap071x;
label values jmthp4    sap071x;   label values jmthp5    sap071x;
label values jmthp6    sap071x;   label values jmthp7    sap071x;
label values jmthp8    sap071x;   label values jmthp9    sap071x;
label values jmthp10   sap071x;   label values jmthp11   sap071x;
label values jmthp12   sap071x;   label values jmthp13   sap071x;
label values jmthp14   sap071x;   label values jmthp15   sap071x;
label values jmthp16   sap071x;   label values jmthp17   sap071x;
label values jntchr    sap028x;   label values jnthp     sap028x;
label values arth1     sap028x;   label values arthlmt   sap028x;
label values paineck   sap028x;   label values painlb    sap028x;
label values painleg   sap028x;   label values painface  sap028x;
label values amigr     sap028x;   label values acold2w   sap028x;
label values aintil2w  sap028x;   label values pregnow   sap028x;
label values pregflyr  sap028x;   label values hraidnow  sap028x;
label values hraidev   sap028x;   label values ahearst1  sap194x;
label values avision   sap028x;   label values ablind    sap028x;
label values vim_drev  sap028x;   label values vimls_dr  sap028x;
label values vim_caev  sap028x;   label values vimls_ca  sap028x;
label values vimcsurg  sap028x;   label values vim_glev  sap028x;
label values vimls_gl  sap028x;   label values vim_mdev  sap028x;
label values vimls_md  sap028x;   label values vimglass  sap028x;
label values vimread   sap028x;   label values vimdrive  sap028x;
label values avisreh   sap028x;   label values avisdev   sap028x;
label values avdf_nws  sap211x;   label values avdf_cls  sap211x;
label values avdf_nit  sap211x;   label values avdf_drv  sap211x;
label values avdf_per  sap211x;   label values avdf_crd  sap211x;
label values avisexam  sap217x;   label values avisact   sap028x;
label values avisprot  sap219x;   label values lupprt    sap028x;
label values chpain6m  sap221x;   label values painlmt   sap221x;

label values wkdayr    sap223x;   label values beddayr   sap223x;
label values ahstatyr  sap225x;   label values speceq    sap028x;
label values flwalk    sap227x;   label values flclimb   sap227x;
label values flstand   sap227x;   label values flsit     sap227x;
label values flstoop   sap227x;   label values flreach   sap227x;
label values flgrasp   sap227x;   label values flcarry   sap227x;
label values flpush    sap227x;   label values flshop    sap227x;
label values flsocl    sap227x;   label values flrelax   sap227x;
label values fla1ar    sap239x;   label values aflhca1   sap071x;
label values aflhca2   sap071x;   label values aflhca3   sap071x;
label values aflhca4   sap071x;   label values aflhca5   sap071x;
label values aflhca6   sap071x;   label values aflhca7   sap071x;
label values aflhca8   sap071x;   label values aflhca9   sap071x;
label values aflhca10  sap071x;   label values aflhca11  sap071x;
label values aflhca12  sap071x;   label values aflhca13  sap071x;
label values alhca14a  sap071x;   label values aflhca15  sap071x;
label values aflhca16  sap071x;   label values aflhca17  sap071x;
label values aflhca18  sap071x;   label values aflhc19_  sap071x;
label values aflhc20_  sap071x;   label values aflhc21_  sap071x;
label values aflhc22_  sap071x;   label values aflhc23_  sap071x;
label values aflhc24_  sap071x;   label values aflhc25_  sap071x;
label values aflhc26_  sap071x;   label values aflhc27_  sap071x;
label values aflhc28_  sap071x;   label values aflhc29_  sap071x;
label values aflhc30_  sap071x;   label values aflhc31_  sap071x;
label values aflhc32_  sap071x;   label values aflhc33_  sap071x;
label values aflhc34_  sap071x;   label values aflhca90  sap071x;
label values aflhca91  sap071x;   label values altime1   sap276x;
label values alunit1   sap277x;   label values aldura1   sap278x;
label values aldurb1   sap279x;   label values alchrc1   sap280x;
label values altime2   sap276x;   label values alunit2   sap277x;
label values aldura2   sap278x;   label values aldurb2   sap279x;
label values alchrc2   sap280x;   label values altime3   sap276x;
label values alunit3   sap277x;   label values aldura3   sap278x;
label values aldurb3   sap279x;   label values alchrc3   sap280x;
label values altime4   sap276x;   label values alunit4   sap277x;
label values aldura4   sap278x;   label values aldurb4   sap279x;
label values alchrc4   sap280x;   label values altime5   sap276x;
label values alunit5   sap277x;   label values aldura5   sap278x;
label values aldurb5   sap279x;   label values alchrc5   sap280x;
label values altime6   sap276x;   label values alunit6   sap277x;
label values aldura6   sap278x;   label values aldurb6   sap279x;
label values alchrc6   sap280x;   label values altime7   sap276x;
label values alunit7   sap277x;   label values aldura7   sap278x;
label values aldurb7   sap279x;   label values alchrc7   sap280x;
label values altime8   sap276x;   label values alunit8   sap277x;
label values aldura8   sap278x;   label values aldurb8   sap279x;
label values alchrc8   sap280x;   label values altime9   sap276x;
label values alunit9   sap277x;   label values aldura9   sap278x;
label values aldurb9   sap279x;   label values alchrc9   sap280x;
label values altime10  sap276x;   label values alunit10  sap277x;
label values aldura10  sap278x;   label values aldurb10  sap279x;
label values alchrc10  sap280x;   label values altime11  sap276x;
label values alunit11  sap277x;   label values aldura11  sap278x;
label values aldurb11  sap279x;   label values alchrc11  sap280x;
label values altime12  sap276x;   label values alunit12  sap277x;
label values aldura12  sap278x;   label values aldurb12  sap279x;
label values alchrc12  sap280x;   label values altime13  sap276x;
label values alunit13  sap277x;   label values aldura13  sap278x;
label values aldurb13  sap279x;   label values alchrc13  sap280x;
label values atime14a  sap276x;   label values aunit14a  sap277x;
label values adura14a  sap278x;   label values adurb14a  sap279x;
label values achrc14a  sap280x;   label values altime15  sap276x;
label values alunit15  sap277x;   label values aldura15  sap278x;
label values aldurb15  sap279x;   label values alchrc15  sap280x;
label values altime16  sap276x;   label values alunit16  sap277x;
label values aldura16  sap278x;   label values aldurb16  sap279x;
label values alchrc16  sap280x;   label values altime17  sap276x;
label values alunit17  sap277x;   label values aldura17  sap278x;
label values aldurb17  sap279x;   label values alchrc17  sap280x;
label values altime18  sap276x;   label values alunit18  sap277x;
label values aldura18  sap278x;   label values aldurb18  sap279x;
label values alchrc18  sap280x;   label values altime19  sap276x;
label values alunit19  sap277x;   label values aldura19  sap278x;
label values aldurb19  sap279x;   label values alchrc19  sap280x;
label values altime20  sap276x;   label values alunit20  sap277x;
label values aldura20  sap278x;   label values aldurb20  sap279x;
label values alchrc20  sap280x;   label values altime21  sap276x;
label values alunit21  sap277x;   label values aldura21  sap278x;
label values aldurb21  sap279x;   label values alchrc21  sap280x;
label values altime22  sap276x;   label values alunit22  sap277x;
label values aldura22  sap278x;   label values aldurb22  sap279x;
label values alchrc22  sap280x;   label values altime23  sap276x;
label values alunit23  sap277x;   label values aldura23  sap278x;
label values aldurb23  sap279x;   label values alchrc23  sap280x;
label values altime24  sap276x;   label values alunit24  sap277x;
label values aldura24  sap278x;   label values aldurb24  sap279x;
label values alchrc24  sap280x;   label values altime25  sap276x;
label values alunit25  sap277x;   label values aldura25  sap278x;
label values aldurb25  sap279x;   label values alchrc25  sap280x;
label values altime26  sap276x;   label values alunit26  sap277x;
label values aldura26  sap278x;   label values aldurb26  sap279x;
label values alchrc26  sap280x;   label values altime27  sap276x;
label values alunit27  sap277x;   label values aldura27  sap278x;
label values aldurb27  sap279x;   label values alchrc27  sap280x;
label values altime28  sap276x;   label values alunit28  sap277x;
label values aldura28  sap278x;   label values aldurb28  sap279x;
label values alchrc28  sap280x;   label values altime29  sap276x;
label values alunit29  sap277x;   label values aldura29  sap278x;
label values aldurb29  sap279x;   label values alchrc29  sap280x;
label values altime30  sap276x;   label values alunit30  sap277x;
label values aldura30  sap278x;   label values aldurb30  sap279x;
label values alchrc30  sap280x;   label values altime31  sap276x;
label values alunit31  sap277x;   label values aldura31  sap278x;
label values aldurb31  sap279x;   label values alchrc31  sap280x;
label values altime32  sap276x;   label values alunit32  sap277x;
label values aldura32  sap278x;   label values aldurb32  sap279x;
label values alchrc32  sap280x;   label values altime33  sap276x;
label values alunit33  sap277x;   label values aldura33  sap278x;
label values aldurb33  sap279x;   label values alchrc33  sap280x;
label values altime34  sap276x;   label values alunit34  sap277x;
label values aldura34  sap278x;   label values aldurb34  sap279x;
label values alchrc34  sap280x;   label values altime90  sap276x;
label values alunit90  sap277x;   label values aldura90  sap278x;
label values aldurb90  sap279x;   label values alchrc90  sap280x;
label values altime91  sap276x;   label values alunit91  sap277x;
label values aldura91  sap278x;   label values aldurb91  sap279x;
label values alchrc91  sap280x;   label values alcndrt   sap456x;
label values alchronr  sap457x;

label values smkev     sap028x;   label values smkreg    sap459x;
label values smknow    sap460x;   label values smkstat2  sap461x;
label values smkqtno   sap462x;   label values smkqttp   sap463x;
label values smkqty    sap464x;   label values cigsda1   sap465x;
label values cigdamo   sap466x;   label values cigsda2   sap465x;
label values cigsday   sap465x;   label values cigqtyr   sap028x;
label values ecigev2   sap028x;   label values ecigcur2  sap460x;
label values ecig30d2  sap472x;   label values cigarev2  sap028x;
label values cigcur2   sap460x;   label values cig30d2   sap472x;
label values pipev2    sap028x;   label values pipecur2  sap460x;
label values smklstb1  sap028x;   label values smklscr2  sap460x;
label values vigno     sap480x;   label values vigtp     sap481x;
label values vigfreqw  sap482x;   label values viglngno  sap483x;
label values viglngtp  sap484x;   label values vigmin    sap483x;
label values modno     sap480x;   label values modtp     sap481x;
label values modfreqw  sap488x;   label values modlngno  sap483x;
label values modlngtp  sap484x;   label values modmin    sap483x;
label values strngno   sap480x;   label values strngtp   sap481x;
label values strfreqw  sap494x;   label values alc1yr    sap028x;
label values alclife   sap028x;   label values alc12mno  sap497x;
label values alc12mtp  sap498x;   label values alc12mwk  sap499x;
label values alc12myr  sap500x;   label values alcamt    sap501x;
label values alcstat   sap502x;   label values alc5upn1  sap500x;
label values alc5upt1  sap504x;   label values alc5upy1  sap500x;
label values binge1    sap472x;   label values aheight   sap507x;
label values aweightp  sap508x;

label values ausualpl  sap510x;   label values aplkind   sap511x;
label values ahcplrou  sap028x;   label values ahcplknd  sap513x;
label values ahcchgyr  sap028x;   label values ahcchghi  sap028x;
label values aprvtryr  sap028x;   label values aprvtrfd  sap517x;
label values adrnanp   sap517x;   label values adrnai    sap517x;
label values ahcdlyr1  sap028x;   label values ahcdlyr2  sap028x;
label values ahcdlyr3  sap028x;   label values ahcdlyr4  sap028x;
label values ahcdlyr5  sap028x;   label values ahcafyr1  sap028x;
label values ahcafyr2  sap028x;   label values ahcafyr3  sap028x;
label values ahcafyr4  sap028x;   label values ahcafyr5  sap517x;
label values ahcafyr6  sap517x;   label values aworpay   sap531x;
label values ahicomp   sap225x;   label values arx12mo   sap028x;
label values arx12_1   sap028x;   label values arx12_2   sap517x;
label values arx12_3   sap028x;   label values arx12_4   sap028x;
label values arx12_5   sap028x;   label values arx12_6   sap028x;
label values adnlong2  sap540x;   label values ahcsyr1   sap028x;
label values ahcsyr2   sap028x;   label values ahcsyr3   sap028x;
label values ahcsyr4   sap028x;   label values ahcsyr5   sap028x;
label values ahcsyr6   sap028x;   label values ahcsyr7   sap028x;
label values ahcsyr8   sap028x;   label values ahcsyr9   sap028x;
label values ahcsyr10  sap028x;   label values ahernoy2  sap551x;
label values aervisnd  sap028x;   label values aerhos    sap028x;
label values aerrea1r  sap028x;   label values aerrea2r  sap028x;
label values aerrea3r  sap028x;   label values aerrea4r  sap028x;
label values aerrea5r  sap028x;   label values aerrea6r  sap028x;
label values aerrea7r  sap517x;   label values aerrea8r  sap517x;
label values ahchyr    sap028x;   label values ahchmoyr  sap472x;
label values ahchnoy2  sap564x;   label values ahcnoyr2  sap551x;
label values asrgyr    sap028x;   label values asrgnoyp  sap567x;
label values amdlongr  sap540x;   label values hit1a     sap517x;
label values hit2a     sap028x;   label values hit3a     sap028x;
label values hit4a     sap517x;   label values hit5a     sap517x;
label values fluvacyr  sap028x;   label values fluvactp  sap575x;
label values fluvac_m  sap576x;   label values fluvac_y  sap577x;
label values flushpg1  sap578x;   label values flushpg2  sap579x;
label values shtpnuyr  sap028x;   label values apox      sap028x;
label values apox12mo  sap028x;   label values ahep      sap028x;
label values ahepliv   sap028x;   label values ahepbtst  sap517x;
label values shthepb   sap028x;   label values shepdos   sap587x;
label values shthepa   sap028x;   label values shepanum  sap589x;
label values ahepctst  sap517x;   label values ahepcres  sap591x;
label values shingles  sap028x;   label values shttd     sap028x;
label values shttd05   sap028x;   label values shttdap2  sap595x;
label values shthpv2   sap596x;   label values shhpvdos  sap597x;
label values ahpvage   sap483x;   label values livev     sap028x;
label values travel    sap028x;   label values wrkhlth2  sap028x;
label values wrkdir    sap028x;   label values apsbpchk  sap028x;
label values apschchk  sap028x;   label values apsbschk  sap028x;
label values apspap    sap028x;   label values apsmam    sap028x;
label values apscol    sap517x;   label values apsdiet   sap028x;
label values apssmkc   sap517x;   label values aindins2  sap517x;
label values aindprch  sap517x;   label values aindwho   sap613x;
label values ainddif1  sap614x;   label values ainddif2  sap615x;
label values aexchng   sap028x;

label values asicpuse  sap617x;   label values asisathc  sap618x;
label values asitenur  sap619x;   label values asinhelp  sap620x;
label values asincnto  sap620x;   label values asintru   sap620x;
label values asinknt   sap620x;   label values asisim    sap624x;
label values asisif    sap625x;   label values asiretr   sap626x;
label values asimedc   sap626x;   label values asistlv   sap626x;
label values asicnhc   sap626x;   label values asiccoll  sap630x;
label values asinbill  sap626x;   label values asihcst   sap626x;
label values asiccmp   sap633x;   label values asisleep  sap472x;
label values asislpfl  sap635x;   label values asislpst  sap636x;
label values asislpmd  sap637x;   label values asirest   sap638x;
label values asisad    sap639x;   label values asinerv   sap639x;
label values asirstls  sap639x;   label values asihopls  sap639x;
label values asieffrt  sap639x;   label values asiwthls  sap639x;
label values asimuch   sap645x;   label values acibld12  sap028x;
label values asihivt   sap028x;   label values asihivwn  sap648x;

label values balev     sap028x;   label values balage_p  sap650x;
label values bdizz1    sap028x;   label values brprob1   sap028x;
label values brprob2   sap028x;   label values brprob3   sap028x;
label values brprob4   sap028x;   label values brprob5   sap028x;
label values brprob6   sap028x;   label values brprob7   sap028x;
label values btype_1   sap028x;   label values btype_2   sap028x;
label values btype_3   sap028x;   label values btype_4   sap028x;
label values btype_5   sap028x;   label values btype_6   sap028x;
label values btype_7   sap028x;   label values bboth1    sap668x;
label values bage1_p   sap650x;   label values boftn     sap670x;
label values boftt     sap671x;   label values blast1    sap672x;
label values btrg_01   sap028x;   label values btrg_02   sap028x;
label values btrg_03   sap028x;   label values btrg_04   sap028x;
label values btrg_05   sap028x;   label values btrg_06   sap028x;
label values btrg_07   sap028x;   label values btrg_08   sap028x;
label values btrg_09   sap028x;   label values btrg_10   sap028x;
label values bsame_1   sap028x;   label values bsame_2   sap028x;
label values bsame_3   sap028x;   label values bsame_4   sap028x;
label values bsame_5   sap028x;   label values bsame_6   sap028x;
label values bsame_7   sap028x;   label values bonly_1   sap690x;
label values bonly_2   sap690x;   label values bonly_3   sap690x;
label values bonly_4   sap690x;   label values bonly_5   sap690x;
label values bonly_6   sap690x;   label values bonly_7   sap690x;
label values bhosp2    sap028x;   label values bhospno1  sap698x;
label values bhp1      sap028x;   label values bhp1_01   sap028x;
label values bhp1_02   sap028x;   label values bhp1_03   sap028x;
label values bhp1_04   sap028x;   label values bhp1_05   sap028x;
label values bhp1_06   sap028x;   label values bhp1_07   sap028x;
label values bhp1_08   sap028x;   label values bhp1_09   sap028x;
label values bhp1_10   sap028x;   label values bhp1_11   sap028x;
label values bhp1_12   sap028x;   label values bhp1_13   sap028x;
label values bhp1_14   sap028x;   label values bhp1_15   sap028x;
label values b5yrs1    sap698x;   label values bfirst1   sap716x;
label values bhelp1    sap717x;   label values bthlp_n   sap483x;
label values bthlp_t   sap463x;   label values bdiag1    sap028x;
label values bcaus101  sap071x;   label values bcaus102  sap071x;
label values bcaus103  sap071x;   label values bcaus104  sap071x;
label values bcaus105  sap071x;   label values bcaus106  sap071x;
label values bcaus107  sap071x;   label values bcaus108  sap071x;
label values bcaus109  sap071x;   label values bcaus110  sap071x;
label values bcaus111  sap071x;   label values bcaus112  sap071x;
label values bcaus113  sap071x;   label values bcaus114  sap071x;
label values btret1    sap028x;   label values btrt1_01  sap028x;
label values btrt1_02  sap028x;   label values btrt1_03  sap028x;
label values btrt1_04  sap028x;   label values btrt1_06  sap028x;
label values btrt1_07  sap028x;   label values btrt1_08  sap028x;
label values btrt1_09  sap028x;   label values btrt1_10  sap028x;
label values btrt1_11  sap028x;   label values btrt1_12  sap028x;
label values btrt1_13  sap028x;   label values btrt1_14  sap028x;
label values btrt1_15  sap028x;   label values btrt1_16  sap028x;
label values bstat1    sap751x;   label values bmedic1   sap028x;
label values bchng1    sap028x;   label values bchg1_01  sap028x;
label values bchg1_02  sap028x;   label values bchg1_03  sap028x;
label values bchg1_04  sap028x;   label values bchg1_05  sap028x;
label values bchg1_06  sap028x;   label values bchg1_07  sap028x;
label values bm12ws    sap483x;   label values bm12ra    sap483x;
label values bprob1    sap763x;   label values bmed_1    sap028x;
label values bmed_2    sap028x;   label values bmed_3    sap028x;
label values bmed_4    sap028x;   label values bbio1     sap028x;
label values bfall12m  sap028x;   label values bfall5y   sap028x;
label values bfl1_01   sap028x;   label values bfl1_02   sap028x;
label values bfl1_03   sap028x;   label values bfl1_04   sap028x;
label values bfl1_05   sap028x;   label values bfl1_06   sap028x;
label values bfl1_07   sap028x;   label values bfall12a  sap028x;
label values bf12m_no  sap483x;   label values bf12m_tp  sap780x;
label values bftime1   sap781x;   label values binj1     sap028x;
label values binjws    sap783x;   label values binjhp    sap028x;
label values binjhpn   sap698x;   label values bfwh_01   sap028x;
label values bfwh_02   sap028x;   label values bfwh_03   sap028x;
label values bfwh_04   sap028x;   label values bfwh_05   sap028x;
label values bfwh_06   sap028x;   label values bfwh_07   sap028x;
label values bfwh_08   sap028x;   label values bfwh_09   sap028x;
label values bfwh_10   sap028x;   label values bnrfall   sap796x;
label values binthi    sap028x;   label values binttr    sap028x;
label values bintrs    sap028x;

label values awebuse   sap028x;   label values awebofno  sap483x;
label values aweboftp  sap802x;   label values awebeml   sap028x;
label values awebmno   sap483x;   label values awebmtp   sap802x;

* DISPLAY OVERALL DESCRIPTION OF FILE;

describe;

* DISPLAY A TEST TABLE FROM THE FILE;

tabulate rectype [fweight= wtfa_sa];
save 2016_adult, replace;

#delimit cr

* data file is stored in samadult.dta
* log  file is stored in samadult.log

log close
