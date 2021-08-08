# this unzips all the persons files from the NHIS data 

for i in {1997..2017}
do 
    rm -f ~/iec1/mortality/nhis/$i/*
    unzip ~/iec1/mortality/nhis/personsx$i.zip -d ~/iec1/mortality/nhis/$i/
done 

    
