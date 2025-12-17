(deftemplate question
    (slot id (type STRING))
    (multislot valid-answers)
)

(deftemplate answer
    (slot id (type STRING))
    (slot value (type STRING))
)

(deftemplate ui-state
    (slot id (type STRING))
    (multislot options)
)

(deftemplate recommendation
    (slot value (type STRING))
)

(deftemplate need-to-ask
    (slot id (type STRING))
)

(deffacts knowledge-base
    (question (id "genre") (valid-answers "drama" "comedy" "a-little-of-both"))
    (question (id "small-town-or-prison") (valid-answers "small-town" "prison"))
    (question (id "scifi-supernatural") (valid-answers "yes" "no"))
    (question (id "handle-gore") (valid-answers "yes" "no"))
    (question (id "zombies") (valid-answers "yes" "no"))
    (question (id "vampires") (valid-answers "yes" "no"))
    (question (id "british-characters") (valid-answers "yes" "no"))
    (question (id "politics") (valid-answers "yes" "no"))
    (question (id "need-action") (valid-answers "yes" "no"))
    (question (id "scandalious-romance") (valid-answers "yes" "no"))
    (question (id "optimistic-cynical") (valid-answers "optimistic" "cynical"))
    (question (id "crying") (valid-answers "yes" "no"))
    (question (id "football") (valid-answers "yes" "no"))
    (question (id "hospitals") (valid-answers "yes" "no"))
    (question (id "crime-shows") (valid-answers "yes" "no"))
    (question (id "criminals") (valid-answers "yes" "no"))
    (question (id "forensics-psychology") (valid-answers "forensics" "psychology"))
    (question (id "meth") (valid-answers "yes" "no"))
    (question (id "questionable-morals") (valid-answers "yes" "no"))
    (question (id "strong-female-characters") (valid-answers "yes" "no"))
    (question (id "drugs") (valid-answers "yes" "no"))
    (question (id "tina-amy") (valid-answers "tina" "amy"))
    (question (id "work-place-humor") (valid-answers "yes" "no"))
    (question (id "james-franco-seth-rogen") (valid-answers "yes" "no"))
    (question (id "bar-cafe") (valid-answers "bar" "cafe"))
    (question (id "friend-group-family") (valid-answers "friend-group" "family"))
)

(defrule start
    (not (answer (id "genre")))
    =>
    (assert (need-to-ask (id "genre")))
)

(defrule flow-genre-both
    (answer (id "genre") (value "a-little-of-both"))
    =>
    (assert (need-to-ask (id "small-town-or-prison")))
)

(defrule res-orange
    (answer (id "small-town-or-prison") (value "prison"))
    =>
    (assert (recommendation (value "Orange is the New Black")))
)

(defrule res-gilmore
    (answer (id "small-town-or-prison") (value "small-town"))
    =>
    (assert (recommendation (value "Gilmore Girls")))
)

(defrule flow-genre-drama
    (answer (id "genre") (value "drama"))
    =>
    (assert (need-to-ask (id "scifi-supernatural")))
)

(defrule flow-scifi-yes
    (answer (id "scifi-supernatural") (value "yes"))
    =>
    (assert (need-to-ask (id "handle-gore")))
)

(defrule flow-gore-yes
    (answer (id "handle-gore") (value "yes"))
    =>
    (assert (need-to-ask (id "zombies")))
)

(defrule res-walking-dead
    (answer (id "zombies") (value "yes"))
    =>
    (assert (recommendation (value "The Walking Dead")))
)

(defrule flow-zombies-no
    (answer (id "zombies") (value "no"))
    =>
    (assert (need-to-ask (id "vampires")))
)

(defrule res-vampire-diaries
    (answer (id "vampires") (value "yes"))
    =>
    (assert (recommendation (value "The Vampire Diaries")))
)

(defrule res-supernatural
    (answer (id "vampires") (value "no"))
    =>
    (assert (recommendation (value "Supernatural")))
)

(defrule flow-gore-no
    (answer (id "handle-gore") (value "no"))
    =>
    (assert (need-to-ask (id "british-characters")))
)

(defrule res-lost
    (answer (id "british-characters") (value "no"))
    =>
    (assert (recommendation (value "Lost")))
)

(defrule res-dr-who
    (answer (id "british-characters") (value "yes"))
    =>
    (assert (recommendation (value "Doctor Who")))
)

(defrule flow-scifi-no
    (answer (id "scifi-supernatural") (value "no"))
    =>
    (assert (need-to-ask (id "politics")))
)

(defrule flow-politics-yes
    (answer (id "politics") (value "yes"))
    =>
    (assert (need-to-ask (id "need-action")))
)

(defrule res-24
    (answer (id "need-action") (value "yes"))
    =>
    (assert (recommendation (value "24")))
)

(defrule flow-need-action-no
    (answer (id "need-action") (value "no"))
    =>
    (assert (need-to-ask (id "scandalious-romance")))
)

(defrule res-scandal
    (answer (id "scandalious-romance") (value "yes"))
    =>
    (assert (recommendation (value "Scandal")))
)

(defrule flow-scandal-no
    (answer (id "scandalious-romance") (value "no"))
    =>
    (assert (need-to-ask (id "optimistic-cynical")))
)

(defrule res-west-wing
    (answer (id "optimistic-cynical") (value "optimistic"))
    =>
    (assert (recommendation (value "The West Wing")))
)

(defrule res-house-of-cards
    (answer (id "optimistic-cynical") (value "cynical"))
    =>
    (assert (recommendation (value "House of Cards")))
)

(defrule flow-politics-no
    (answer (id "politics") (value "no"))
    =>
    (assert (need-to-ask (id "crying")))
)

(defrule flow-crying-yes
    (answer (id "crying") (value "yes"))
    =>
    (assert (need-to-ask (id "football")))
)

(defrule res-friday-night
    (answer (id "football") (value "yes"))
    =>
    (assert (recommendation (value "Friday Night Lights")))
)

(defrule flow-football-no
    (answer (id "football") (value "no"))
    =>
    (assert (need-to-ask (id "hospitals")))
)

(defrule res-parenthood
    (answer (id "hospitals") (value "no"))
    =>
    (assert (recommendation (value "Parenthood")))
)

(defrule res-greys
    (answer (id "hospitals") (value "yes"))
    =>
    (assert (recommendation (value "Greys Anatomy")))
)

(defrule flow-crying-no
    (answer (id "crying") (value "no"))
    =>
    (assert (need-to-ask (id "crime-shows")))
)

(defrule flow-crime-yes
    (answer (id "crime-shows") (value "yes"))
    =>
    (assert (need-to-ask (id "criminals")))
)

(defrule res-dexter
    (answer (id "criminals") (value "yes"))
    =>
    (assert (recommendation (value "Dexter")))
)

(defrule flow-criminals-no
    (answer (id "criminals") (value "no"))
    =>
    (assert (need-to-ask (id "forensics-psychology")))
)

(defrule res-csi
    (answer (id "forensics-psychology") (value "forensics"))
    =>
    (assert (recommendation (value "CSI Miami")))
)

(defrule res-criminal-minds
    (answer (id "forensics-psychology") (value "psychology"))
    =>
    (assert (recommendation (value "Criminal Minds")))
)

(defrule flow-crime-no
    (answer (id "crime-shows") (value "no"))
    =>
    (assert (need-to-ask (id "meth")))
)

(defrule res-breaking-bad
    (answer (id "meth") (value "yes"))
    =>
    (assert (recommendation (value "Breaking Bad")))
)

(defrule res-mad-men
    (answer (id "meth") (value "no"))
    =>
    (assert (recommendation (value "Mad Men")))
)

(defrule flow-genre-comedy
    (answer (id "genre") (value "comedy"))
    =>
    (assert (need-to-ask (id "questionable-morals")))
)

(defrule flow-morals-no
    (answer (id "questionable-morals") (value "no"))
    =>
    (assert (need-to-ask (id "strong-female-characters")))
)

(defrule flow-female-yes
    (answer (id "strong-female-characters") (value "yes"))
    =>
    (assert (need-to-ask (id "drugs")))
)

(defrule res-weeds
    (answer (id "drugs") (value "yes"))
    =>
    (assert (recommendation (value "Weeds")))
)

(defrule flow-drugs-no
    (answer (id "drugs") (value "no"))
    =>
    (assert (need-to-ask (id "tina-amy")))
)

(defrule res-30-rock
    (answer (id "tina-amy") (value "tina"))
    =>
    (assert (recommendation (value "30 Rock")))
)

(defrule res-parks-rec
    (answer (id "tina-amy") (value "amy"))
    =>
    (assert (recommendation (value "Parks and Recreation")))
)

(defrule flow-female-no
    (answer (id "strong-female-characters") (value "no"))
    =>
    (assert (need-to-ask (id "work-place-humor")))
)

(defrule res-office
    (answer (id "work-place-humor") (value "yes"))
    =>
    (assert (recommendation (value "The Office")))
)

(defrule flow-work-no
    (answer (id "work-place-humor") (value "no"))
    =>
    (assert (need-to-ask (id "james-franco-seth-rogen")))
)

(defrule res-freaks
    (answer (id "james-franco-seth-rogen") (value "yes"))
    =>
    (assert (recommendation (value "Freaks and Geeks")))
)

(defrule flow-franco-no
    (answer (id "james-franco-seth-rogen") (value "no"))
    =>
    (assert (need-to-ask (id "bar-cafe")))
)

(defrule res-himym
    (answer (id "bar-cafe") (value "bar"))
    =>
    (assert (recommendation (value "How I Met Your Mother")))
)

(defrule res-friends
    (answer (id "bar-cafe") (value "cafe"))
    =>
    (assert (recommendation (value "Friends")))
)

(defrule flow-morals-yes
    (answer (id "questionable-morals") (value "yes"))
    =>
    (assert (need-to-ask (id "friend-group-family")))
)

(defrule res-sunny
    (answer (id "friend-group-family") (value "friend-group"))
    =>
    (assert (recommendation (value "Its Always Sunny in Philadelphia")))
)

(defrule res-arrested
    (answer (id "friend-group-family") (value "family"))
    =>
    (assert (recommendation (value "Arrested Development")))
)

(defrule generate-ui-question
    ?req <- (need-to-ask (id ?id))
    (question (id ?id) (valid-answers $?options))
    (not (ui-state))
    =>
    (retract ?req)
    (assert (ui-state (id ?id) (options $?options)))
)