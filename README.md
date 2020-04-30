# Koine Reported Speech Comparison
A look at what things might be needed to annotate a corpus of New Testament Greek for _Reported Speech Events_.

## Trajectory

Why am I doing this project? What do I hope to do at the end of this project?

I hope to be able to programmatically scan a portion of a New Testament Translation where the target language of the translation is an under resourced (a language with few digital tools), low-density language (a language without a significant corpus for generating AI or machine learning based translation tooling) and determine if the translation has followed discourse patterns which are natural for that language while also still accurate for the actions in the text and the stylistic intent of the author.

Assumptions:

1. Translation into minority languages is often **not** from Greek straight into a West African or Papuan language. Rather it is often through a "gateway" language, into which Biblical Exegetical helps have been translated or written.
2. From a literature terminological perspective, there are discourse patterns for highlighting (foregrounding), back grounding characters or themes in stories, or hortative texts. In the linguistics literature, these ideas might come under the name of topic/focus, or known/new information, or a variety of other terminological distinctions.
3. There is a great deal of typological variation between languages in how they handle various types of highlighting devices or backgrounding elements. This variation can lead to confusion in the translation process, especially when translators are multi-lingual and focused on syntax, orthography, and a variety of other factors which may pull their attention away from the task of focusing on the stylistic naturalness of the target language which matches the stylistic naturalness of the language in which the resource was first written.
4. Levinsohn reports that Theological commentaries sparsely address the issue of greek discourse patterns.
5. It takes **three** annotated corpora to do this kind of check. 1) it takes an annotated Greek text of the New Testament. 2) It takes an annotated (for the same kinds of features) corpus in the target language. 3) It takes a New Testament translation in the target language.
6. The project is too big for me to do alone; more people than just me will benefit from the outcomes.
7. Reported speech is a good place to start.

A researcher in possession of all three corpora mentioned in # 5 should be able to quickly look at the output of the corpus in the target language, and see what the patterns of the target language are in various contexts.

The same researcher should also be able to effortlessly check a Bible translation in the same target language to see if the Bible translation uses those same discourse patterns in its translation practice.

If a researcher does a direct comparison between the translated text and the annotated corpus (which could be done with direct literal translation, word-based library lookup ) or a statistical comparison (closest neighbor or other statistical training model), then the researcher still doesn't know if all cases were acted upon, or if all cases were correctly translated with the right strategy in the right places.

Then since the Greek Biblical annotated corpus has the same discourse functions annotated as part of it as the annotated corpus in the target language, the researcher can use that corpus to review the specific area in the translation into the target language.

In this way we should have a quantification (or quantifiable measure) of the difference between the usage of discourse features in the target translation and the analysis of those features in the non-biblical-corpus of the target language.


## Reported Speech Annotation of the NT
---

Why start with reported speech?

1. It is small and achievable.
2. It is a measurable component of many discourse features.
3. There is a real chance of the mis-use of personal pronouns by languages which use logophoric pronouns, as logophoric pronouns are not part of Greek or the majority of "gateway" languages.
4. CNRS-LLCAN is conducting a [reported speech research project](https://sites.google.com/view/speechreporting/calls-and-openings) to discover a variety of patterns of use for logophoric pronouns in West-African languages. ([article](https://dumas.ccsd.cnrs.fr/LLACAN/hal-02268641v1))

## Distinctions

So what sort of annotations should be made for discourse in a cross-linguistic, typological framework which focuses on reported speech?

### DiscourseQuoteUnit
#### Speech Orienter
It is important to mark the unit of text which comprises the lead-in clauses for the reported speech and the reported speech. Dooley and Levinsohn call the lead-in clauses `Speech Orienter`. The speech orienter can occur before, after or in between part of the quote. The quote is what is said by the "actor".

A tentative mark-up might look like this:

```XML

<DiscourseQuoteUnit> <Speech Orienter/> <Reported Speech type="Direct|Indirect|Semidirect"/> </DiscourseQuoteUnit>

```

#### Closed or Open
`<DiscourseQuoteUnit>` can logical come in two types. Dooley and Levinsohn label these two types as: "Closed Conversation", meaning there is no speech orienter present, and "not closed" meaning there is a speech orienter present. Is it necessary to add these types to `<DiscourseQuoteUnit>`? Perhaps as:

```XML

<DiscourseQuoteUnit type="closed">

```

#### Direct, Indirect, Semidirect
Reported speech has at least three types, typologically speaking, across the worlds languages. Dooley and Levinsohn describe these three distinctions as `Direct|Indirect|Semidirect`. I add these to the XML-like markup as a `type=""` under reported speech. Doing it this way is manually intensive because the three way distinction is primarily about what pronouns are used. That is, if pronoun and antecedents were marked up directly this type distinction might be distinguishable via algorithm.

For the purposes of reported speech identification if text is not in a DiscourseQuoteUnit then it can be assumed to be Narration. However, there is a second layer of analysis which should be able to be marked up with future research / work. That work is the identification of the discourse purpose of portions of the narration. For instance, in Luke chapter 4, the first two verses help the reader break from the previous scene, develop a new scene and introduce the characters in the scene. These verses set the stage for the uninformed "hearer" of the story. The information is not common understanding between the narrator and the audience. When the known/new information dichotomy is altered different patterns can occur.

Therefore, it would be useful to mark up all text units with their purpose. For my purposes, I can see this as

```
discourseRole: Narration, Speech Event
```
Note that `Speech Orienters` would still be marked as Narration! DiscourseQuoteUnit and Narration are not mutually exclusive categories.

### Purpose

Dooley and Levinsohn mention another dynamic in relation to quotes. They use the highly technical term `Purpose` to describe this dynamic, but don't name the sub-kinds of purpose. The dynamic is a function, not a syntax. However some languages may relegate the function to a specific syntactic construction:  In European languages the _Direct quote_  usually expresses - exactly what was said as said by the original source, where as the _Indirect quote_ - expresses the second sub-kind as a quote said with commentary. Such as Jesus' reading from Luke 4:18-19. I don't know that my skill in Koine Greek is up to the task on determining these. I don't even know what literature to look at to see if anyone has written about this for Koine Greek.

### Clause level semantic roles

It would be helpful to also be able to apply the following semantic categories, if they are not already available: `clauseRole: Agent, Theme, Loc`.

### Internal referencing

I need to have some way to indicate Antecedent and pronoun linkage. I see this as needing to tag _Antecedents_ and _Pronouns_ in two separate ways. First they need an ID which will link them to each other with a relationship. Second they need link to an absolute concept entity. This concept entity may also need to be linked to another concept entity via a dictionary, or I need a property which allows for Metaphorical representation.  For instance: "You brood of vipers." _Vipers_ is an entity, but _brood of vipers_ is a different entity as is also the metaphorical concept that stands behind the phrase. I t might be appropriate to link  _vipers_ by itself to an entity id with an attribute of animals, but it would be better suited for research if the phrase could link to the entityID for the metaphorical meaning.

Antecedent pronoun ID relationship: refersTo (entityID and InstanceID), isReferedToBy(entityID and InstanceID)

```
He shall take away the sins of the world. (He)refersTo --> Lamb of God(entityID:1234)  --> Metaphorically refers to Jesus(entityID:1233).
```

![](/icons/snakes.svg)

### Things

Broadly speaking: `Things` need to be categorized. I am not sure if this happens in the corpus or if this happens in a dictionary to which the corpus is dynamically linked (as in Linked Data linked). In dealing with pronouns, it would be very helpful if `people` and `places` had specific ID's (which are dereferenceable) worked out based on semantics (rather than Strong's numbers). One option, which I'm not a particular fan of is using something like  `sameAs: "WikiDataID"``

* Place ID dictionary: the Jordan River, the wilderness, the temple, the high place(mountain)

* Person ID dictionary: Luke, Devil, Jesus(Q302)
  * Person type typology: Deity, Supreme Deity, Human, Animal, Celestial being

Some future work may want to look at plants, or tools mentioned and mark those up. with a type, so a generalizable syntax would be desirable. This future work could also pave the the way for an alignment with Ron Moe's semantic domains and Nida's semantic domain work. I am not interested in doing that work at this time. One overwhelming aspect of semantic domain linking, is that semantic domains can be viewed as rational eg. rain, water, river, cloud; or culture based (things the culture associates together). In the case  of corpora across languages, the semantic domains do not really need to align... but translation is easier when they do.

### Embedded Quote Source
I need a way to point someone to the source text of the embedded Quote when possible. For instance Jesus says: It is written.... Well where is it written?

I still have two roles which need to be fleshed out as to why they are needed, and how they are different from each other. Clarity on this will come as I ask my wife some clarifying questions related to her work.

dialogueRole: Addressee, Addressor, discussed
discussantRole: Narrator, Speaker, Addressor, Other (off stage - specified), Other (off stage - unspecified)

---
## Example text

A very poor, inconsistent hand drawn sketch of XML which helped me think through the prose section above.

```XML
<?xml version="1.0" encoding="UTF-8"?>
<discourseEpisode>
<semanticClauseRole type="Theme">
 <person id="Jesus">Jesus</person>
</semanticClauseRole> , full of the
<semanticClauseRole type="Agent">
 <person id="Holy Spirit">Holy Spirit</person>
</semanticClauseRole>, left
<semanticClauseRole type="Loc">
 <place id="Jordan river">the Jordan</place>
</semanticClauseRole> and was led by the <person id="Holy Spirit">Spirit</person> into <place id="">the wilderness</place>, where for forty days <person role="" id="Jesus">he</person> was tempted by the <person id="devil">devil</person>. <person role="" id="Jesus">He</person> ate nothing during those days, and at the end of them <person role="" id="Jesus">he</person> was hungry. <person id="devil">The devil</person> said to <person role="" id="Jesus">him</person>,</narrator>

<person discourseRole="speaker" id="devil"> “If <person role="" id="Jesus">you</person> are the Son of God, tell this stone to become bread.”</speaker>

<person role="" id="Jesus">Jesus</person> answered, <person discourseRole="speaker" id="Jesus">“It is written: <quote source=""> ‘Man shall not live on bread alone.’”</quote></speaker>

The devil led him up to a high place and showed him in an instant all the kingdoms of the world. 6 And he said to him, “I will give you all their authority and splendor; it has been given to me, and I can give it to anyone I want to. 7 If you worship me, it will all be yours.”

8 Jesus answered, “It is written: ‘Worship the Lord your God and serve him only.’”

9 The devil led him to Jerusalem and had him stand on the highest point of the temple. “If you are the Son of God,” he said, “throw yourself down from here. 10 For it is written:

“‘He will command his angels concerning you
    to guard you carefully;
11 they will lift you up in their hands,
    so that you will not strike your foot against a stone.’[d]”

12 Jesus answered, “It is said: ‘Do not put the Lord your God to the test.’[e]”

13 When the devil had finished all this tempting, he left him until an opportune time.

14 Jesus returned to Galilee in the power of the Spirit, and news about him spread through the whole countryside. 15 He was teaching in their synagogues, and everyone praised him.
</discourseEpisode>
<discourseEpisode>
16 He went to Nazareth, where he had been brought up, and on the Sabbath day he went into the synagogue, as was his custom. He stood up to read, 17 and the scroll of the prophet Isaiah was handed to him. Unrolling it, he found the place where it is written:

18 “The Spirit of the Lord is on me,
    because he has anointed me
    to proclaim good news to the poor.
He has sent me to proclaim freedom for the prisoners
    and recovery of sight for the blind,
to set the oppressed free,
19     to proclaim the year of the Lord’s favor.”[f]

20 Then he rolled up the scroll, gave it back to the attendant and sat down. The eyes of everyone in the synagogue were fastened on him. 21 He began by saying to them, “Today this scripture is fulfilled in your hearing.”

22 All spoke well of him and were amazed at the gracious words that came from his lips. “Isn’t this Joseph’s son?” they asked.

23 Jesus said to them, “Surely you will quote this proverb to me: ‘Physician, heal yourself!’ And you will tell me, ‘Do here in your hometown what we have heard that you did in Capernaum.’”

24 “Truly I tell you,” he continued, “no prophet is accepted in his hometown. 25 I assure you that there were many widows in Israel in Elijah’s time, when the sky was shut for three and a half years and there was a severe famine throughout the land. 26 Yet Elijah was not sent to any of them, but to a widow in Zarephath in the region of Sidon. 27 And there were many in Israel with leprosy[g] in the time of Elisha the prophet, yet not one of them was cleansed—only Naaman the Syrian.”

28 All the people in the synagogue were furious when they heard this. 29 They got up, drove him out of the town, and took him to the brow of the hill on which the town was built, in order to throw him off the cliff. 30 But he walked right through the crowd and went on his way.
</discourseEpisode>

```
Scripture quotations taken from The Holy Bible, New International Version® NIV®
Copyright © 1973 1978 1984 2011 by Biblica, Inc. TM
Used by permission. All rights reserved worldwide.

Everything else copyrighted 2020 by Hugh Paterson III and licensed under MIT license.
