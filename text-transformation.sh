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
exit 1
####
#Discourse Marking
####

#Lets add discourse episode markers.
sed '/^<milestone unit="verse" id="Luke.4.14" />/i <discourseEpisode id="2">' -i numbered-text.xml


#Lets mark up some people names
Jesus, Elija, Elisha, Simon
# ori sed -e 's/\[\([a-zA-Z ]*\)\]/\\macro{\1}/g'
#Lets mark up some places
Capernaum, Galilee, Nazareth,Jerusalem
# ori sed -e 's/\[\([a-zA-Z ]*\)\]/\\macro{\1}/g'
#Lets mark up some referencer words related to animate entites
He, Him, You, Your, Yourself, I, me, his, they, us, their
# ori sed -e 's/\[\([a-zA-Z ]*\)\]/\\macro{\1}/g'
#Lets mark up some referencer words related to inanimate entites
where, this, here
# ori sed -e 's/\[\([a-zA-Z ]*\)\]/\\macro{\1}/g'
