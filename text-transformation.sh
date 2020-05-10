#!/bin/bash


#The NIV text uses U+2019 ’ RIGHT SINGLE QUOTATION MARK as an apostrophe. This is not errant in that Unicode 3.0 and above have stated that this is the perfered character to use for apostrophe. However we are going to use gnu sed to switch U+2019 for U+0027 APOSTROPHE. because we need to use the single quotes to look at reported speech inside of reported speech.

#Tool for finding out which character is used https://www.babelstone.co.uk/Unicode/whatisit.html

#Lets make a copy of the text
cp original_text.txt marked-up-text2.txt

# Lets replace U+2019 where it occurs in contractions with U+0027

sed -e "s/’t/'t/g" -i marked-up-text2.txt
sed -e "s/’s/'s/g" -i marked-up-text2.txt

#lets get rid of the colophone (11 lines)
sed -e :a -e '$d;N;2,11ba' -e 'P;D' -i marked-up-text2.txt

# Lets get rid of the top two lines
sed -e 1,2d -i marked-up-text2.txt

#lets get rid of the section headings
sed -e "s/Jesus Heals Many//g" -i marked-up-text2.txt
sed -e "s/Jesus Rejected at Nazareth//g" -i marked-up-text2.txt
sed -e "s/Jesus Drives Out an Impure Spirit//g" -i marked-up-text2.txt

#Lets delete the empty lines
sed '/^$/d' -i marked-up-text2.txt

#Lets put the text in some tags so that the xslt doesnot scream at us
sed  -i '1i <corpus>' marked-up-text2.txt
sed -e "\$a</corpus>" -i marked-up-text2.txt

#Lets get rid of the fotnot refences
# ori sed -e 's/\[\([a-zA-Z ]*\)\]/\\macro{\1}/g'
sed -e 's/\[\([a-zA-Z ]*\)\]/@/g'  -i marked-up-text2.txt


# Lets mark up all the words with XML #This script was sourced here: https://stackoverflow.com/questions/4899901/wrap-words-in-tags-using-xslt
xsltproc -o numbered-text.xml number-words.xsl marked-up-text2.txt
# Lets change the numbers in the texts to milestone tags
sed -e 's/\([0-9]\+ \)/<milestone unit=\"verse\" id=\"Luke.4.\1\"\/>/g'  -i numbered-text.xml
sed -e 's/\([0-9]\+\)\( \)/\1/g'  -i numbered-text.xml

sed -e 's/ \* //g' -i numbered-text.xml

#And change the first number to a chapter marker.
sed -e '0,/verse/ s/verse/chapter/' -i numbered-text.xml #Maual clean this 4.4 to just 4

# Lets add some markup around the punctuation. And lets do this before we put in the correct XML declaratoin so that the period doesn't give us a match.
xsltproc -o numbered-text2.xml surrounded-punctuation.xsl numbered-text.xml

mv numbered-text2.xml numbered-text.xml
#mv numbered-text2.xml numbered-text.xml
#Lets get rid of that bad XML declaration
sed -i 1d numbered-text.xml
sed -e '/<pc>\[\n\]<\/pc>/d' -i numbered-text.xml

sed -e "s/+/\./g" -i numbered-text.xml
sed -e "s/-/¡/g" -i numbered-text.xml

#Lets put in the correct XML declaration
sed  -i '1i <?xml version="1.0" encoding="UTF-8"?>' numbered-text.xml

tidy -m -xml -utf8 -q numbered-text.xml

#Lets get rid of the fotnot refences
sed -e 's/<pc>@<\/pc>/<quote source=""><\/quote>/g' -i numbered-text.xml


sed -e "s/<pc><\/pc>//g" -i numbered-text.xml
#Lets delete the empty lines
sed '/^$/d' -i  numbered-text.xml
rm marked-up-text2.txt

# Lets change the chapter ID
sed -e 's#<milestone unit="chapter" id="Luke.4.4" />#<milestone unit="chapter" id="Luke.4" />#g' -i numbered-text.xml

####
#Discourse Marking
####

#Lets add discourse episode markers.
sed -e '/^<milestone unit="verse" id="Luke.4.1" \/>/i <discourseEpisode id="1">' -i numbered-text.xml
sed -e '/^<milestone unit="verse" id="Luke.4.14" \/>/i <discourseEpisode id="2">' -i numbered-text.xml
sed -e '/^<discourseEpisode id="2">/i <\/discourseEpisode>' -i numbered-text.xml
sed -e '/^<milestone unit="verse" id="Luke.4.31" \/>/i <discourseEpisode id="3">' -i numbered-text.xml
sed -e '/^<discourseEpisode id="3">/i <\/discourseEpisode>' -i numbered-text.xml
sed -e '/^<milestone unit="verse" id="Luke.4.38" \/>/i <discourseEpisode id="4">' -i numbered-text.xml
sed -e '/^<discourseEpisode id="4">/i <\/discourseEpisode>' -i numbered-text.xml
sed 's/<\/corpus>/\n<\/corpus>/g' -i numbered-text.xml
sed -e '/<\/corpus>/i <\/discourseEpisode>' -i numbered-text.xml

#sed remove inaccurate quote lines

#Let's do some entity Identification.

#xmlstarlet ed --insert "///w[text()='Jesus']" --type attr -n thingType -v person numbered-text.xml > numbered-text2.xml


#xmlstarlet ed --insert "///w[not(@person)]" --type attr -n person -v foobar numbered-text.xml > numbered-text2.xml

#for ///w{Jesus}

# for each line in file single-word-name-entities.txt
#   get first field, and put it the first field in the sed command
#   get second field, and put it the second field in the sed command
# done
#
# awk -F '#' '{print $1 ":" $2}' < single-word-name-entities.txt

#awk -F '!' '{print $1 $2}' < single-word-name-entities.txt


while read -r NAME URI; do  sed -re 's#(<w nivId=")(Luke.[^"]+)(">${NAME}</w>)#<entityType type="deity|supremeDeity|human|animal|celestialBeing|place|celestialEntity|idea|substance" sameAs="${URI}" referenceType="name|title|adposition|" id="" uuid="" semanticClauseRole="Theme|Agent|Loc">\1\2\3</entityType>#g' -i numbered-text.xml ; done < single-word-name-entities.txt
exit 1

tidy -m -xml -utf8 -q numbered-text.xml
exit 1

sed -re 's#(<w nivId=")(Luke.[^"]+)(">`$NAME`</w>)#<entityType type="deity|supremeDeity|human|animal|celestialBeing|place|celestialEntity|idea|substance" sameAs="`$URI`" referenceType="name|title|adposition|" id="" uuid="" semanticClauseRole="Theme|Agent|Loc">\1\2\3</entityType>#g' -i numbered-text.xml

sed -re 's#(<w nivId=")(Luke.[^"]+)(">Jesus</w>)#<entityType type="deity|supremeDeity|human|animal|celestialBeing|place|celestialEntity|idea|substance" sameAs="http://www.wikidata.org/entity/Q302" referenceType="name|title|adposition|" id="" uuid="" semanticClauseRole="Theme|Agent|Loc">\1\2\3</entityType>#g' -i numbered-text.xml

<entityType="deity|supremeDeity|human|animal|celestialBeing|place|celestialEntity|idea|substance" sameAs="http://www.wikidata.org/entity/Q302" referenceType="name|title|adposition|" id="" uuid="" semanticClauseRole="Theme|Agent|Loc"></entityType>



<person id="Jesus" sameAs="http://www.wikidata.org/entity/Q302">Jesus</person>

<w thingType="person" sameAs="Q302" id="jesus" wordAnchorID="" referenceType="name">Jesus</w>

sed 's/(<w nivId=")(Luke.[^"]+)(")(>)(Jesus</w>)/ \1\2\3 sometext \4\5/g'
<w nivId="Luke.4¡1">Jesus</w>

sed 's#(<w nivId=")(Luke.[^"]+)(">Jesus</w>)#<entityType="deity|supremeDeity|human|animal|celestialBeing|place|celestialEntity|idea|substance" sameAs="http://www.wikidata.org/entity/Q302" referenceType="name|title|adposition|" id="" uuid="" semanticClauseRole="Theme|Agent|Loc"> \1\2\3 </entityType>#g'
<w nivId="Luke.4¡1">Jesus</w>

 perl -CS -pe 's/\N{U+FFF9}//g'

<clause id="">
<discussant role="narrator" person="Luke" id="" sameAs="http://www.wikidata.org/entity/Q128538">


<wordType="referer"></
#Lets mark up some people names
Holy Spirit: http://www.wikidata.org/entity/Q37302
Luke: http://www.wikidata.org/entity/Q128538
Jesus: http://www.wikidata.org/entity/Q302
Elija: http://www.wikidata.org/entity/Q133507
 Elisha: http://www.wikidata.org/entity/Q206238
 Simon (peter): http://www.wikidata.org/entity/Q33923
 Simon's Mother inlaw: http://www.wikidata.org/entity/Q23581940
[Naaman] the Syrian: http://www.wikidata.org/entity/Q126778
[Joseph]’s son: http://www.wikidata.org/entity/Q128267
The  Devil: http://www.wikidata.org/entity/Q6674
# ori sed -e 's/\[\([a-zA-Z ]*\)\]/\\macro{\1}/g'
#Lets mark up some places
Capernaum: http://www.wikidata.org/entity/Q59174
Galilee: http://www.wikidata.org/entity/Q83241
Nazareth: http://www.wikidata.org/entity/Q430776
Jerusalem: http://www.wikidata.org/entity/Q1218
Judea (Roman Province): http://www.wikidata.org/entity/Q1003997
[Zarephath: http://www.wikidata.org/entity/Q616837] in the region of [Sidon: https://www.wikidata.org/wiki/Q163490]
Specific Places without a name:
the Jordan (river): http://www.wikidata.org/entity/Q40059
the wilderness(Mount Quarantania): http://www.wikidata.org/entity/Q10742877
synagogue at Capernaum: http://www.wikidata.org/entity/Q2916829
synagogue at Nazareth: http://www.wikidata.org/entity/Q7661936
the temple
the high place(mountain)



# or is animacy really the distinuisnig feature here? These might be dictic referencers.

# ori sed -e 's/\[\([a-zA-Z ]*\)\]/\\macro{\1}/g'
#Lets mark up some referencer words related to animate entites
He, Him, You, Your, Yourself, I, me, his, they, us, their

# ori sed -e 's/\[\([a-zA-Z ]*\)\]/\\macro{\1}/g'
#Lets mark up some referencer words related to inanimate entites
where, this, here
# ori sed -e 's/\[\([a-zA-Z ]*\)\]/\\macro{\1}/g'
