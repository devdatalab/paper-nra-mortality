# this converts the NHIS unzipped files to lowercase 

for i in {1997..2017} 
do 
    for s in ~/iec1/mortality/nhis/$i/*
    do 
      mv "$s" "$(echo "$s" | tr '[A-Z]' '[a-z]')"
    done
done 

for s in ~/iec1/mortality/nhis/*.dat
do
          mv "$s" "$(echo "$s" | tr '[A-Z]' '[a-z]')"
done
