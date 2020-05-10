# problem to solve

I have some code that I would like to wrap into a `while read` loop.

The code works on the command line in linux. But not inside a while loop.
The following snippet works on the command line.

```
sed -re 's#(<w nivId=")(Luke.[^"]+)(">Jesus</w>)#<entityType type="deity|supremeDeity|human|animal|celestialBeing|place|celestialEntity|idea|substance" sameAs="http://www.wikidata.org/entity/Q302" referenceType="name|title|adposition|" id="" uuid="" semanticClauseRole="Theme|Agent|Loc">\1\2\3</entityType>#g' -i numbered-text.xml

```

It "works" on the following "text" `<w nivId="Luke.4¡1">Jesus</w>` That is it finds all instances of tagged words with a text of `Jesus`, and wraps them in a parent `xml` element as indicated. Resulting in the following:

```
<entityType type="deity|supremeDeity|human|animal|celestialBeing|place|celestialEntity|idea|substance" sameAs="http://www.wikidata.org/entity/Q302" referenceType="name|title|adposition|" id="" uuid="" semanticClauseRole="Theme|Agent|Loc"><w nivId="Luke.4¡1">Jesus</w></entityType>
```

Well as it were, I have 15 or so of these single word names that I would like to wrap in parent XML tags. So I was thinking that wrapping the `sed` command in a `while read` loop would work out and I could just read the NAMES and the URIs from another file.

```
while read -r NAME URI; do  sed -re 's#(<w nivId=")(Luke.[^"]+)(">${NAME}</w>)#<entityType type="deity|supremeDeity|human|animal|celestialBeing|place|celestialEntity|idea|substance" sameAs="${URI}" referenceType="name|title|adposition|" id="" uuid="" semanticClauseRole="Theme|Agent|Loc">\1\2\3</entityType>#g' -i numbered-text.xml ; done < single-word-name-entities.txt
```

However, this fails.... and I am not sure why....  Solving this would be fantastic. Learning where my mistake was and why would be great. I've tried using escaped quotes `\"` around the curly braces and I've tried without curly braces around the variables. I've also tried setting off the variables with back ticks ``` `` ```. I have looked up and down stack-exchange too.  I've come to also accept that this is really an `xml` type problem which deserve an `xml/xslt` type solution. Rather than a `sed` solution.

In fact an xml type solution using `xmlstarlet` would be fantastic. Because I have the same basic problem: inserting parent tags when I address multi-word entities. For example:

```
<w nivId="Luke.4¡5">Holy</w>
<w nivId="Luke.4¡6">Spirit</w>
```

would need to get processed like this:
```
<entityType type="deity|supremeDeity|human|animal|celestialBeing|place|celestialEntity|idea|substance" sameAs="http://www.wikidata.org/entity/Q37302" referenceType="name|title|adposition|" id="" uuid="" semanticClauseRole="Theme|Agent|Loc"><w nivId="Luke.4¡5">Holy</w>
<w nivId="Luke.4¡6">Spirit</w></entityType>

```

However, Stack exchange has also let me down in this case too.... So, pointers or solutions to either of these methods would be appreciated.  The larger context of the problem can be read about on Github here: https://github.com/HughP/Koine-Reported-Speech-Comparison
