# Koine Reported Speech Comparison
A look at what things might be needed to annotate a corpus of New Testament Greek for _Reported Speech Events_.

## Trajectory

_Why am I doing this project? What do I hope to do at the end of this project?_

I hope to be able to programmatically scan a portion of a New Testament Translation where the target language of the translation is an under resourced (a language with few digital tools), and a low-density language (a language without a significant corpus for generating AI or machine learning based translation tooling) and determine if the translation has followed (specified) discourse patterns which are natural for that language while also still accurate communicate the actions in the text and the stylistic intent of the original language author.

### Assumptions

1. Bible translation into minority languages is often **not** from _Koine Greek_ straight into a _target language_ such as are spoken by small communities in West Africa or on the isle of Papua. Rather translation is often conducted through a _gateway language_, into which Biblical Exegetical helps have been translated or written. (Modern translations frequently undergo some sort of peer-reviewed for theological accuracy or for communicative clarity in the target language, but all translations are published as a set of compromises — which may include peer-review bias, linguistic, sociological, theological, and financial components. Additionally organizational and historical biases may also occur. Such as in cases where a particular organization chooses to do a translation to meet "beliefs" which are germane within the context of the organization, or the case where congruency with a previously published translation in the regional language-of-wider-communication is desired.)
2. Within the industry of Machine Learning, Artificial Intelligence, and Machine Translation, the use of a "massively parallel corpus" (Dufter et al. 2018, Koppel et al. 2011) is increasingly important as a translation pivot between languages, and as a set of training data for ML/AI tools (Zhao et al. 2018). This does not mean improving the training data for the AI/ML community is the only reason for undertaking this kind of investigation. Rather there is a great deal of value in providing human translators tools which can check their work, and also peer-reviewers tools which can speed up the peer-review process (processes such as those suggested in Levinsohn 2006b). Third, developing these tools in the open where funders of language development activities (inclusive of translation) can access the tools and the results profiles for a greater level of transparency in the kinds of outputs that organizations report to produce. All of these activities will impact language using communities.
3. From a literature terminological perspective, there are discourse patterns for highlighting (foregrounding), back grounding characters or themes in stories, or hortative texts. In the linguistics literature, these ideas might come under the name of topic/focus, or known/new information, or a variety of other terminological distinctions.
4. There is a great deal of typological variation between languages in how they handle specific patterns of highlighting devices or backgrounding elements. This variation can lead to confusion in the translation process, especially when translators are multi-lingual and focused on syntax, orthography, and a variety of other factors which may pull their attention away from the task of focusing on the stylistic naturalness of the target language which matches the stylistic naturalness of the language in which the resource was first written.
5. Levinsohn (2006a) reports that Theological commentaries sparsely address the issue of Koine Greek discourse patterns.
6. It takes **three** annotated corpora to do the proposed kind of check. 1) it takes an annotated Greek text of the New Testament. 2) It takes an annotated (for the same kinds of features) corpus in the target language. 3) It takes a New Testament translation in the target language.
7. The project is too big for me to do alone; more people than just me will benefit from the outcomes.
8. Reported speech is a good place to start.

A researcher in possession of all three corpora mentioned in # 5 should be able to quickly look at the output of the corpus in the target language, and see what the patterns of the target language are in various contexts.

The same researcher should also be able to "effortlessly" check a Bible translation in the same target language to see if the Bible translation uses those same discourse patterns in its translation practice.

In a sense I am proposing to label the constructions (form-function pairs) of the discourse strategies and match on the functions across languages.

If a researcher does a direct comparison between the translated text and the annotated corpus (which could be done with direct literal translation, word-based library lookup ) or a statistical comparison (closest neighbor or other statistical training model), then the researcher still doesn't know if all cases were acted upon, or if all cases were correctly translated with the right strategy in the right places.

Then since the Greek Biblical annotated corpus has the same discourse functions annotated as part of it as the annotated non-biblical-corpus in the target language, the researcher can use strategies available via the non-biblical-corpus to review the specific instances in the Bible-translation into the target language.

In this way we should have a quantification (or quantifiable measure) of the difference between the usage of discourse features in the target translation and the analysis of those features in the non-biblical-corpus of the target language.

By way of analogy: It is like the Greek corpus says: "I have this many locks in these places, and I know what kind of locks they are." While the non-biblical corpus says: "I have these kinds of keys that fit these kinds of locks." The check process then looks at the target language translation and says:" You have a lock of this kind... we expect that you would be using a key of type 'x', but you are not... this is something to look at for naturalness and accuracy."


## Reported Speech Annotation of the NT

_Why start with reported speech?_

1. It is small and achievable.
2. It is a measurable component of many discourse features.
3. There is a real chance of the mis-use of personal pronouns by languages which use logophoric pronouns, as logophoric pronouns are not part of Koine Greek or the majority of "gateway" languages. However there may be patterns of [Logophoricity](https://en.wikipedia.org/wiki/Logophoricity) in the discourse in these languages.
4. CNRS-LLCAN is conducting a [reported speech research project](https://sites.google.com/view/speechreporting/calls-and-openings) to discover a variety of patterns of use for logophoric pronouns in West-African languages. ([article](https://dumas.ccsd.cnrs.fr/LLACAN/hal-02268641v1))

## Organization of the corpus
This section lays out some of the assumptions which are marked in the corpus.

1. It is assumed that each morpheme will be dereferencable with a unique id.
2. It is assumed that each grouping of morphemes, words, or constituents which are marked will also be dereferencable.
3. It is common practice among open access and openly licensed corpora of NT Koine Greek to apply an ID to each word. Not each morpheme. This ID usually incorporates notation for the book, chapter, verse, and the number of the word in the verses. In contrast to this very useful ordering for NT texts. Texts which originate in a target language (non-translated texts) do not have the advantage of the pre-conceived book, chapter, verse schema. Additionally the Koine Greek corpora are usually not tokenized at the morpheme level. This means that the corpora are not scoped to the same level of detail.
4. Discourse episodes are overtly marked. However, linguistically they should be able to be derived.

## Distinctions

_So what sort of annotations should be made for discourse in a cross-linguistic, typological framework which focuses on reported speech?_

### reportedSpeech
#### Speech Orienter
It is important to mark the unit of text which comprises the lead-in clauses for the reported speech and the reported speech. Dooley and Levinsohn call the lead-in clauses `Speech Orienter`. The speech orienter can occur before, after or in between part of the quote. The quote is what is said by the "actor".

A tentative mark-up might look like this:

```XML

<reportedSpeech>
  <Speech Orienter/> <Reported Speech type="Direct|Indirect|Semidirect"/>
</reportedSpeech>

```

#### Closed or Open
`<reportedSpeech>` can logical come in two types. Dooley and Levinsohn label these two types as: "Closed Conversation", meaning there is no speech orienter present, and "not closed" meaning there is a speech orienter present. It is an open question as to if it is the best strategy to add these distinctions as types to `<reportedSpeech>`. I am tentatively adding them as:

```XML

<reportedSpeech type="closed">
  <Reported Speech type="Direct|Indirect|Semidirect"/>
</reportedSpeech>

```

or

```XML

<reportedSpeech type="open">
  <Speech Orienter/> <Reported Speech type="Direct|Indirect|Semidirect"/>
</reportedSpeech>

```

#### Direct, Indirect, Semidirect
Reported speech has at least three types, typologically speaking, across the worlds languages. Dooley and Levinsohn describe these three distinctions as `Direct|Indirect|Semidirect`. I add these to the XML-like markup as a `type=""` under reported speech. Doing it this way is manually intensive because the three way distinction is primarily about what pronouns are used. That is, if pronoun and antecedents were marked up directly this type distinction might be distinguishable via algorithm.

For the purposes of reported speech identification if text is not in a reportedSpeech then it can be assumed to be narration. However, there is a second layer of analysis which should be able to be marked up with future research / work. That work is the identification of the discourse purpose of portions of the narration. For instance, in Luke chapter 4, the first two verses help the reader break from the previous scene, develop a new scene and introduce the characters in the scene. These verses set the stage for the uninformed "hearer" of the story. The information is not common understanding between the narrator and the audience. When the known/new information dichotomy is altered different patterns can occur.

Therefore, it would be useful to mark up all text units with their purpose. For my purposes, I can see this as --()--

```
discourseRole: Narration, Speech Event
```
Note that `Speech Orienters` would still be marked as Narration! reportedSpeech and Narration are not mutually exclusive categories. This leads to an issue in [Overlapping Markup](https://en.wikipedia.org/wiki/Overlapping_markup).

### Purpose

Dooley and Levinsohn mention another dynamic in relation to quotes. They use the highly technical term `Purpose` to describe this dynamic, but don't name the sub-kinds of purpose. The dynamic is a function, not a syntax. However some languages may relegate the function to a specific syntactic construction:  In European languages the _Direct quote_  usually expresses - exactly what was said as said by the original source, where as the _Indirect quote_ - expresses the second sub-kind as a quote said with commentary. Such as Jesus' reading from Luke 4:18-19. I don't know that my skill in Koine Greek is up to the task on determining these. I don't even know what literature to look at to see if anyone has written about this for Koine Greek.

### Clause level semantic roles

It would be helpful to also be able to apply the following semantic categories, if they are not already available: `clauseRole: Agent, Theme, Loc`.

### Internal referencing

I need to have some way to indicate Antecedent and pronoun linkage. I see this as needing to tag _Antecedents_ and _Pronouns_ in two separate ways. First they need an ID which will link them to each other with a relationship (syntactic linkage). Second they need link to an absolute concept entity (semantic linkage). This concept entity may also need to be linked to another concept entity via a dictionary, or I need a property which allows for Metaphorical representation.  For instance: "You brood of vipers." _Vipers_ is an entity, but _brood of vipers_ is a different entity as is also the metaphorical concept that stands behind the phrase. It might be appropriate to link  _vipers_ by itself to an entity id with an attribute of animals, but it would be better suited for research if the phrase could link to the entityID for the metaphorical meaning.

Antecedent pronoun ID relationship: refersTo (entityID and InstanceID), isReferedToBy(entityID and InstanceID)

```
He shall take away the sins of the world. (He)refersTo --> Lamb of God(entityID:xxxx; sameAs:Q201171)  --> Metaphorically refers to Jesus(entityID:xxxx; sameAs:Q302).
```

![](/icons/snakes.svg)

#### Syntactic referencing
If each word of the corpus is numbered with a unique ID then a second element can be used with the number of the word to which it refers.

### Things

Broadly speaking: `Things` need to be categorized. I am not sure if this happens in the corpus or if this happens in a dictionary to which the corpus is dynamically linked (as in Linked Data linked). In dealing with pronouns, it would be very helpful if `people` and `places` had specific ID's (which are dereferenceable) worked out based on semantics (rather than Strong's numbers). One option, which I'm not a particular fan of is using something like  `sameAs: "WikiDataID"`. I am not a fan of using WikiData for two reasons:
1. the entries in WikiData seem to evolve without constraint, specifically the concepts may split or be deleted. This means that each concept adopted for my project might have a derefrencable ID, but it does not mean that that ID will continue to be the recomended or socially popular ID. Though it will likely remaine usable as an ID.
2. Concepts as a dereferenceable entity should be rooted in the linguistics and the cognitive expression the author is trying to evoke to their audience. It is not always clear how to do this with WikiData, where the endpoints are not under the editorial authority or practice of a source control by the using project. So, it might be better for a project to define its own IDs and then link those to WikiIDs.

With this in mind to primary options for markup come to mind:

1. Add markup attributes to word level tags. Such as the following:

 ```
<w thingType="person" sameAs="Q302" id="" wordAnchorID="" referenceType="Name">Jesus</w>
```

 This is rejected on the grounds that sometimes sets of word comprise a single semantic entity or thing to be ID'd. For example, `Lamb of God` is arguably a single entity, at the mental concept level.

2. Use parent/child xml structures. This is demonstrated in the following example.
  ```
<entityType="supremeDeity" sameAs="http://www.wikidata.org/entity/Q302" referenceType="name|" id="" uuid="" semanticClauseRole="Theme"><w>Jesus</w></entityType>
```
 Additionally, some languages will have clitics and morphology which will point to other words without the whole word functioning as a reverencer. In this way I would assume that `<w></w>` tags can be parents of morphology tags.

  A sub option of this strategy is to use different types of tags like: `<thing>`. `<place>` or `<person>`, as this was my first thought, but then I thought that perhaps the queries might become cumbersome.

#### Outstanding questions related to things

How do I handle titles? "Lamb of God" --> Jesus or Jesus(entity) <-- Jesus(person) <-- LambOfGod(title). Each of these concepts can be and are unique.

It seems that people can have: Name, Title, referencer (pronoun)

The devil is another case. In some instances the entity is referred to as "The Devil(Q6674)", "Lucifer", "The Great Deceiver", "Satan(Q35230)". In some sense these are all different ideas, but all reference the same entity. What is a good way to handle this? Local reference prevails over global reference.

* Place ID dictionary: the Jordan River, the wilderness, the temple, the high place(mountain), Jerusalem,

* Person ID dictionary: Luke, Devil(Q6674), http://www.wikidata.org/entity/Q302, Holy Spirit,
  * Person type typology: Deity, Supreme Deity, Human, Animal, Celestial being, not-a-person-type

- And what happens to Jesus who is both Human and Supreme Deity.

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
<corpus>
   <structureTag type="start" unit="chapter" unitID="4"></structureTag>
   <structureTag type="start" unit="verse" unitID="1"></structureTag>
   <discourseEpisode id="1">
      <discussant role="narrator" person="Luke" id="" sameAs="http://www.wikidata.org/entity/Q128538">
         <clause id="1">
            <semanticClauseRole type="Theme"><person id="Jesus" sameAs="http://www.wikidata.org/entity/Q302">Jesus</person>
            </semanticClauseRole>
 , full of the
            <semanticClauseRole type="Agent"><person id="Holy Spirit" sameAs="http://www.wikidata.org/entity/Q37302">Holy Spirit</person>
            </semanticClauseRole>
, left
            <semanticClauseRole type="Loc"><place id="Jordan river" sameAs="http://www.wikidata.org/entity/Q40059">the Jordan</place>
            </semanticClauseRole>
         </clause>
and
         <clause id="2">was led by the <person id="Holy Spirit" sameAs="http://www.wikidata.org/entity/Q37302">Spirit</person> into <place id="">the wilderness</place>,
         </clause>
         <clause id="3">where for forty days <person role="" id="" sameAs="http://www.wikidata.org/entity/Q302">he</person> was tempted by the <person id="devil">devil</person>.
          </clause>
          <clause id="4"><person id="" sameAs="http://www.wikidata.org/entity/Q302">He</person> ate nothing during those days,
          </clause>
 and
           <clause id="5">at the end of them <person id="" sameAs="http://www.wikidata.org/entity/Q302">he</person> was hungry.
          </clause>
      </discussant>
          <reportedSpeech type="open">
          <speechOrienter>
              <discussant role="narrator" person="Luke" id="" sameAs="http://www.wikidata.org/entity/Q128538">
           <clause id="6"><person id="devil">The devil</person> said to <person sameAs="http://www.wikidata.org/entity/Q302">him</person>,
          </clause>
    </discussant>
  </speechOrienter>
    <reportedSpeech type="Direct|Indirect|Semidirect"/>
    <discussant role="speaker" person="devil" id="" sameAs="" >
          <clause id="7"> “If <person id="" role="" sameAs="http://www.wikidata.org/entity/Q302">you</person> are the Son of God,
          </clause>
          <clause id="8"> tell this stone to become bread.”</clause>
    </discussant>
  </reportedSpeech>
<reportedSpeech type="open">
<speechOrienter>
  <discussant role="narrator" person="Luke" id="" sameAs=""><person sameAs="http://www.wikidata.org/entity/Q302">Jesus</person> answered,
</discussant>
</speechOrienter>
<reportedSpeech type="Direct|Indirect|Semidirect"/><discussant role="speaker" sameAs="http://www.wikidata.org/entity/Q302">“It is written: <quote source=""> ‘Man shall not live on bread alone.’”</quote>
</discussant>
</reportedSpeech>
</reportedSpeech>

  <discussant role="narrator" person="Luke" id="" sameAs="http://www.wikidata.org/entity/Q128538">
<person id="devil">The devil led <person id="" sameAs="http://www.wikidata.org/entity/Q302">him</person> up to a high place and showed <person id="" sameAs="http://www.wikidata.org/entity/Q302">him</person> in an instant all the kingdoms of the world.</discussant>
<structureTag type="end" unit="verse" unitID="5"></structureTag><structureTag type="start" unit="verse" unitID="6"></structureTag>
  <discussant role="narrator" person="Luke" id="" sameAs="http://www.wikidata.org/entity/Q128538">
 And <person id="devil">he</person> said to <person sameAs="http://www.wikidata.org/entity/Q302">him</person>,
</discussant>
<discussant role="speaker" person="devil" id="" sameAs="">
 “<person id="devil">I</person> will give you all their authority and splendor; it has been given to <person id="devil">me</person>, and <person id="devil">I</person> can give it to anyone <person id="devil">I</person> want to. <structureTag type="end" unit="verse" unitID="6"></structureTag><structureTag type="start" unit="verse" unitID="7"></structureTag> If <person id="Jesus" sameAs="http://www.wikidata.org/entity/Q302">you</person> worship <person id="devil">me</person>, it will all be yours.”
</discussant>

<discussant role="narrator" person="Luke" id="" sameAs="">
<structureTag type="end" unit="verse" unitID="7"></structureTag><structureTag type="start" unit="verse" unitID="8"></structureTag> Jesus answered,
</discussant>
<discussant role="speaker" person="Jesus" id="" sameAs="http://www.wikidata.org/entity/Q302">
“It is written: <quote source="">‘Worship the Lord your God and serve him only.’</quote>”
</discussant>

<structureTag type="end" unit="verse" unitID="8"></structureTag><structureTag type="start" unit="verse" unitID="9"></structureTag>   <discussant role="narrator" person="Luke" id="" sameAs="http://www.wikidata.org/entity/Q128538">The devil led him to Jerusalem and had him stand on the highest point of the temple.</discussant> “If you are the Son of God,” he said, “throw yourself down from here. <structureTag type="end" unit="verse" unitID="9"></structureTag><structureTag type="start" unit="verse" unitID="10"></structureTag> For it is written:

“<quote source="">‘He will command his angels concerning you
    to guard you carefully;
<structureTag type="end" unit="verse" unitID="10"></structureTag><structureTag type="start" unit="verse" unitID="11"></structureTag> they will lift you up in their hands,
    so that you will not strike your foot against a stone.’[d]</quote>”

<structureTag type="end" unit="verse" unitID="11"></structureTag><structureTag type="start" unit="verse" unitID="12"></structureTag>   <discussant role="narrator" person="Luke" id="" sameAs="http://www.wikidata.org/entity/Q128538">Jesus answered</discussant>, “It is said: <quote source="">‘Do not put the Lord your God to the test.’</quote>[e]”

<structureTag type="end" unit="verse" unitID="12"></structureTag><structureTag type="start" unit="verse" unitID="13"></structureTag> <discussant role="narrator" person="Luke" id="" sameAs="http://www.wikidata.org/entity/Q128538">When the devil had finished all this tempting, he left him until an opportune time.</discussant>

<structureTag type="end" unit="verse" unitID="13"></structureTag><structureTag type="start" unit="verse" unitID="14"></structureTag> Jesus returned to Galilee in the power of the Spirit, and news about him spread through the whole countryside. <structureTag type="end" unit="verse" unitID="14"></structureTag><structureTag type="start" unit="verse" unitID="15"></structureTag> He was teaching in their synagogues, and everyone praised him.
</discourseEpisode>
<discourseEpisode id="2">
<structureTag type="end" unit="verse" unitID="15"></structureTag><structureTag type="start" unit="verse" unitID="16"></structureTag> He went to Nazareth, where he had been brought up, and on the Sabbath day he went into the synagogue, as was his custom. He stood up to read, <structureTag type="end" unit="verse" unitID="16"></structureTag><structureTag type="start" unit="verse" unitID="17"></structureTag> and the scroll of the prophet Isaiah was handed to him. Unrolling it, he found the place where it is written:

<structureTag type="end" unit="verse" unitID="17"></structureTag><structureTag type="start" unit="verse" unitID="18"></structureTag> <quote source="">“The Spirit of the Lord is on me,
    because he has anointed me
    to proclaim good news to the poor.
He has sent me to proclaim freedom for the prisoners
    and recovery of sight for the blind,
to set the oppressed free,
<structureTag type="end" unit="verse" unitID="18"></structureTag><structureTag type="start" unit="verse" unitID="19"></structureTag>     to proclaim the year of the Lord’s favor.”</quote>[f]

<structureTag type="end" unit="verse" unitID="19"></structureTag><structureTag type="start" unit="verse" unitID="20"></structureTag> Then he rolled up the scroll, gave it back to the attendant and sat down. The eyes of everyone in the synagogue were fastened on him. <structureTag type="end" unit="verse" unitID="20"></structureTag><structureTag type="start" unit="verse" unitID="21"></structureTag> He began by saying to them, “Today this scripture is fulfilled in your hearing.”

<structureTag type="end" unit="verse" unitID="21"></structureTag><structureTag type="start" unit="verse" unitID="22"></structureTag> All spoke well of him and were amazed at the gracious words that came from his lips. “Isn’t this Joseph’s son?” they asked.

<structureTag type="end" unit="verse" unitID="22"></structureTag><structureTag type="start" unit="verse" unitID="23"></structureTag> Jesus said to them, “Surely you will quote this proverb to me: ‘Physician, heal yourself!’ And you will tell me, ‘Do here in your hometown what we have heard that you did in Capernaum.’”

<structureTag type="end" unit="verse" unitID="23"></structureTag><structureTag type="start" unit="verse" unitID="24"></structureTag> “Truly I tell you,” he continued, “no prophet is accepted in his hometown. <structureTag type="end" unit="verse" unitID="24"></structureTag><structureTag type="start" unit="verse" unitID="25"></structureTag> I assure you that there were many widows in Israel in Elijah’s time, when the sky was shut for three and a half years and there was a severe famine throughout the land. <structureTag type="end" unit="verse" unitID="25"></structureTag><structureTag type="start" unit="verse" unitID="26"></structureTag> Yet Elijah was not sent to any of them, but to a widow in Zarephath in the region of Sidon.<structureTag type="end" unit="verse" unitID="26"></structureTag><structureTag type="start" unit="verse" unitID="27"></structureTag> And there were many in Israel with leprosy[g] in the time of Elisha the prophet, yet not one of them was cleansed—only Naaman the Syrian.”
<structureTag type="end" unit="verse" unitID="27"></structureTag><structureTag type="start" unit="verse" unitID="28"></structureTag>
All the people in the synagogue were furious when they heard this. <structureTag type="end" unit="verse" unitID="28"></structureTag><structureTag type="start" unit="verse" unitID="29"></structureTag> They got up, drove him out of the town, and took him to the brow of the hill on which the town was built, in order to throw him off the cliff. <structureTag type="end" unit="verse" unitID="29"></structureTag><structureTag type="start" unit="verse" unitID="30"></structureTag> But he walked right through the crowd and went on his way.
<structureTag type="end" unit="verse" unitID="30"></structureTag>
<structureTag type="end" unit="chapter" unitID="4"></structureTag>
</discourseEpisode>
</corpus>


```
## Bibliography

* Dooley, Robert A. & [Stephen H. Levinsohn](https://scholars.sil.org/stephen_h_levinsohn/cv). 2001. Analyzing discourse: a manual of basic concepts. Dallas, Tx: SIL International.

* Dufter, Philipp, Mengjie Zhao, Martin Schmitt, Alexander Fraser & Hinrich Schütze. 2018. Embedding Learning Through Multilingual Concept Induction. In Proceedings of the 56th Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers), 1520–1530. Melbourne, Australia: Association for Computational Linguistics. https://doi.org/10.18653/v1/P18-1141. http://aclweb.org/anthology/P18-1141 (5 May, 2020).

* Koppel, Moshe, Navot Akiva, Idan Dershowitz & Nachum Dershowitz. 2011. Unsupervised Decomposition of a Document into Authorial Components. In Proceedings of the 49th Annual Meeting of the Association for Computational Linguistics: Human Language Technologies, 1356–1364. Portland, Oregon, USA: Association for Computational Linguistics. https://www.aclweb.org/anthology/P11-1136 (5 May, 2020).

* Levinsohn, Stephen H. 2006a. The Relevance of Greek Discourse Studies to Exegesis. Journal of Translation 2(2). 11–21. https://www.sil.org/resources/publications/entry/40248.

* Levinsohn, Stephen H. 2006b. Checking Translations for Discourse Features. Journal of Translation 2(2). 23–29. https://www.sil.org/resources/publications/entry/40269.

* Zhao, Helen Jiahe & Jiamou Liu. 2018. Finding Answers from the Word of God: Domain Adaptation for Neural Networks in Biblical Question Answering. In 2018 International Joint Conference on Neural Networks (IJCNN), 1–8. Rio de Janeiro: IEEE. https://doi.org10.1109/IJCNN.2018.8489756. https://ieeexplore.ieee.org/document/8489756/ (5 May, 2020).


## Consulted resources
### Names and place names

* Ariel, Mira. 1990. Accessing noun-phrase antecedents (Croom Helm Linguistics Series). London: Routledge. https://doi.org/10.4324/9781315857473.
* Ariel, Mira. 2016. Accessing noun-phrase antecedents (Routledge Library Editions. Linguistics B). London: Routledge. https://doi.org/10.4324/9781315857473 (Particularly interesting was the [hierarchy presented in section 9.2 on names and titles](https://books.google.fr/books?id=J6PIAgAAQBAJ&pg=PT140&lpg=PT140&dq=names+titles+difference+linguistics&source=bl&ots=4ryoNgSv7a&sig=ACfU3U3PL6yrMOzjOxgKZPCBATdFcPGvVw&hl=en&sa=X&ved=2ahUKEwjVupui4ZjpAhXG3YUKHflxAU4Q6AEwC3oECBMQAQ#v=onepage&q=names%20titles%20difference%20linguistics&f=false))
* Aljbour, Atef Fleih & Fawwaz Al-Abed Al-Haq. 2019. An Investigation of Feminine Personal Names in Beni Sakhr Tribe of Jordan: A Sociolinguistic Study. International Journal of Linguistics 11(6). 41. https://doi.org/10.5296/ijl.v11i6.14960. http://www.macrothink.org/journal/index.php/ijl/article/view/14960 (4 May, 2020).

* Koeva, Svetla, Cvetana Krstev, Duško Vitas, Tita Kyriacopoulou, Claude Martineau & Tsvetana Dimitrova. 2018. Semantic And Syntactic Patterns Of Multiword Names: A Cross-Language Study. In Multiword expressions: Insights from a multi- lingual perspective, 31–62. Berlin: Language Science Press. https://doi.org/10.5281/ZENODO.1182589. https://zenodo.org/record/1182589 (4 May, 2020).
*
### Greek Logophoricity and Anaphora

* Michael Chiou. 3-4 June 2010 ‘Emphatic reflexives and logophoric marking in Modern Greek. Evidence from parliamentary discourse. A pragmatic analysis'. 31st TABU Dag 2010'. Groningen University. https://www.academia.edu/20326882/Emphatic_reflexives_and_logophoric_marking_in_Modern_Greek

* Dobrov, Gregory. "The Syntax of Coreference in Greek." Classical Philology 83, no. 4 (1988): 275-88. Accessed May 5, 2020. www.jstor.org/stable/269506.
* Paul Kiparsky Greek Anaphora in Cross-Linguistic Perspective. Journal of Greek Linguistics 12 (2012) 84–117 [print-version](https://web.stanford.edu/~kiparsky/Papers/GreekAnaphoraJGL.pdf) [Preprint](https://web.stanford.edu/~kiparsky/Papers/nijmegen.refl.JGL.rev.pdf)
* Tiller, Patrick A. 2001. Reflexive Pronouns in the New Testament. Filología-Neotestamentaria 14. 43–63. https://www.bsw.org/filologia-neotestamentaria/vol-14-2001/reflexive-pronouns-in-the-new-testament/415/ (5 May, 2020).
* Lavidas, Nikolaos. 2012. Null vs. cognate objects and language contact: Evidence from Hellenistic Greek. Acta Linguistica Hafniensia 44(2). 142–168. https://doi.org/10.1080/03740463.2013.779079. http://www.tandfonline.com/doi/abs/10.1080/03740463.2013.779079 (5 May, 2020).



### Logophoricity in general
* Ameka, Felix K. 2017. “Logophoricity.” Chapter. In The Cambridge Handbook of Linguistic Typology, edited by Alexandra Y. Aikhenvald and R. M. W. Dixon, 513–37. Cambridge Handbooks in Language and Linguistics. Cambridge: Cambridge University Press. doi:[10.1017/9781316135716.016](https://doi.org/10.1017/9781316135716.016).
* Strazny, Philipp (ed.). 2005. Encyclopedia of linguistics. New York: Fitzroy Dearborn. (Pages 446, 1058-59)
* Denis CREISSELS. Intensifiers, reflexivity and logophoricity in Axaxdərə Akhvakh. Conference on the Languages of the Caucasus, Leipzig, 07 – 09 December 2007. http://www.deniscreissels.fr/public/Creissels-logoph.Akhv.pdf
* Rudnev, Pavel. 2017. Minimal pronouns, logophoricity and long-distance reflexivisation in Avar. Humanities Commons. https://doi.org/10.17613/M6BV7H. https://hcommons.org/deposits/item/hc:16961/ (5 May, 2020).

   https://www.researchgate.net/publication/246494934_Intensifiers_and_reflexives_a_typological_perspective

## Colophon

XML was validated here: http://xml.mherman.org

Many `sed` commands were modified from questions asked on stackexchange

`xsl` transform script was modified from https://stackoverflow.com/questions/4899901/wrap-words-in-tags-using-xslt

XML schema was in part modeled off of text available via [biblical humanities such as the Nestle 1904 version](https://github.com/biblicalhumanities/Nestle1904/blob/master/xml/04-luke.xml).

Scripture quotations taken from [The Holy Bible, New International Version® NIV®](https://www.biblegateway.com/passage/?search=Luke+4&version=NIV)
Copyright © 1973 1978 1984 2011 by [Biblica, Inc](https://www.biblica.com/). TM
Used by permission via [Biblica's use guidance](https://www.biblica.com/resources/bible-faqs/how-do-i-license-the-niv/). All rights reserved worldwide.

Everything else copyrighted 2020 by Hugh Paterson III and licensed under [MIT license](https://opensource.org/licenses/MIT).
