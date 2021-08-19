for i in {1992..2014} 
do 
    cp nhis/Stata-Read-in-Program-All-Surveys.do nhis/nhis${i}_mort.do
done


for i in {1992..2014} 
do 
    sed -i "s?using \*\*SURVEY\*\*_?using \$mdata/raw/nhis//NHIS_${i}_?g" ~/ddl/mortality/nhis/nhis${i}_mort.do
    sed -i "s?save \*\*SURVEY\*\*_PUF?save \$mdata/int/nhis/clean/nhis${i}_pmort?g" ~/ddl/mortality/nhis/nhis${i}_mort.do
done
