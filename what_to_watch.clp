(deftemplate user-answer
    (slot question (type STRING))
    (slot answer (type STRING))
)

(deftemplate question-to-display
    (slot question (type STRING))
    (multislot options (type STRING))
)

(deftemplate result
    (slot result (type STRING))
)

(defrule start
    (not (result))
    (not (question-to-display))
    =>
    (assert (question-to-display
        (question "genre")
        (options "drama" "comedy" "a-little-of-both")
    ))
)

(defrule genre-both
    ?q <- (question-to-display (question "genre"))
    (user-answer (question "genre") (answer "a-little-of-both"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "small-town-or-prison")
        (options "small-town" "prison")
    ))
)

(defrule prison
    ?q <- (question-to-display (question "small-town-or-prison"))
    (user-answer (question "small-town-or-prison") (answer "prison"))
    =>
    (retract ?q)
    (assert (result(result "Orange is the New Black")))
)

(defrule small-town
    ?q <- (question-to-display (question "small-town-or-prison"))
    (user-answer (question "small-town-or-prison") (answer "small-town"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "Gilmore Girls")))
)

(defrule genre-drama
    ?q <- (question-to-display (question "genre"))
    (user-answer (question "genre") (answer "drama"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "scifi-supernatural")
        (options "yes" "no")
    ))
)

(defrule genre-comedy
    ?q <- (question-to-display (question "genre"))
    (user-answer (question "genre") (answer "comedy"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "questionable-morals")
        (options "yes" "no")
    ))
)


(defrule scifi-yes
    ?q <- (question-to-display (question "scifi-supernatural"))
    (user-answer (question "scifi-supernatural") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "handle-core")
        (options "yes" "no")
    ))
)

(defrule handle-core-yes
    ?q <- (question-to-display (question "handle-core"))
    (user-answer (question "handle-core") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "zombies")
        (options "yes" "no")
    ))
)

(defrule zombies-yes
    ?q <- (question-to-display (question "zombies"))
    (user-answer (question "zombies") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "The Walking Dead")))
)

(defrule zombies-no
    ?q <- (question-to-display (question "zombies"))
    (user-answer (question "zombies") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "vampires")
        (options "yes" "no")
    ))
)

(defrule vampires-yes
    ?q <- (question-to-display (question "vampires"))
    (user-answer (question "vampires") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "The Vampire Diares")))
)

(defrule vampires-no
    ?q <- (question-to-display (question "vampires"))
    (user-answer (question "vampires") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "Supernatural")))
)

(defrule handle-core-no
    ?q <- (question-to-display (question "handle-core"))
    (user-answer (question "handle-core") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "british-characters")
        (options "yes" "no")
    ))
)

(defrule british-characters-no
    ?q <- (question-to-display (question "british-characters"))
    (user-answer (question "british-characters") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "Lost")))
)

(defrule british-characters-yes
    ?q <- (question-to-display (question "british-characters"))
    (user-answer (question "british-characters") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "Dr. Who")))
)

(defrule scifi-no
    ?q <- (question-to-display (question "scifi-supernatural"))
    (user-answer (question "scifi-supernatural") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "politics")
        (options "yes" "no")
    ))
)

(defrule politics-yes
    ?q <- (question-to-display (question "politics"))
    (user-answer (question "politics") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "need-action")
        (options "yes" "no")
    ))
)

(defrule need-action-yes
    ?q <- (question-to-display (question "need-action"))
    (user-answer (question "need-action") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "24")))
)

(defrule need-action-no
    ?q <- (question-to-display (question "need-action"))
    (user-answer (question "need-action") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "scandalious-romance")
        (options "yes" "no")
    ))
)

(defrule scandalious-romance-yes
    ?q <- (question-to-display (question "scandalious-romance"))
    (user-answer (question "scandalious-romance") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "Scandal")))
)

(defrule scandalious-romance-no
    ?q <- (question-to-display (question "scandalious-romance"))
    (user-answer (question "scandalious-romance") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "optimistic-cynical")
        (options "optimistic" "cynical")
    ))
)

(defrule optimistic
    ?q <- (question-to-display (question "optimistic-cynical"))
    (user-answer (question "optimistic-cynical") (answer "optimistic"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "The West Wing")))
)

(defrule cynical
    ?q <- (question-to-display (question "optimistic-cynical"))
    (user-answer (question "optimistic-cynical") (answer "cynical"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "House Of Cards")))
)

(defrule politics-no
    ?q <- (question-to-display (question "politics"))
    (user-answer (question "politics") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "crying")
        (options "yes" "no")
    ))
)

(defrule crying-yes
    ?q <- (question-to-display (question "crying"))
    (user-answer (question "crying") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "football")
        (options "yes" "no")
    ))
)

(defrule football-yes
    ?q <- (question-to-display (question "football"))
    (user-answer (question "football") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "Friday Nigh Lights")))
)

(defrule football-no
    ?q <- (question-to-display (question "football"))
    (user-answer (question "football") (answer "no"))
    (not (result))
    =>
    (assert (question-to-display
        (question "hospitals")
        (options "yes" "no")
    ))
)

(defrule hospitals-no
    ?q <- (question-to-display (question "hospitals"))
    (user-answer (question "hospitals") (answer "no"))
    (not (result))
    =>
    (assert (result(result "Parent-Hood")))
)

(defrule hospitals-yes
    ?q <- (question-to-display (question "hospitals"))
    (user-answer (question "hospitals") (answer "yes"))
    (not (result))
    =>
    (assert (result(result "Grey's Anatomy")))
)

(defrule crying-no
    ?q <- (question-to-display (question "crying"))
    (user-answer (question "crying") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "crime-shows")
        (options "yes" "no")
    ))
)

(defrule crime-shows-yes
    ?q <- (question-to-display (question "crime-shows"))
    (user-answer (question "crime-shows") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "criminals")
        (options "yes" "no")
    ))
)

(defrule criminals-yes
    ?q <- (question-to-display (question "criminals"))
    (user-answer (question "criminals") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "Dexter")))
)

(defrule criminals-no
    ?q <- (question-to-display (question "criminals"))
    (user-answer (question "criminals") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "fantastic-psychology")
        (options "fantastic" "psychology")
    ))
)

(defrule fantastic
    ?q <- (question-to-display (question "fantastic-psychology"))
    (user-answer (question "fantastic-psychology") (answer "fantastic"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "CSI: Miami")))
)

(defrule psychology
    ?q <- (question-to-display (question "fantastic-psychology"))
    (user-answer (question "fantastic-psychology") (answer "psychology"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "Criminal Minds")))
)

(defrule crime-shows-no
    ?q <- (question-to-display (question "crime-shows"))
    (user-answer (question "crime-shows") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "meth")
        (options "yes" "no")
    ))
)

(defrule meth-yes
    ?q <- (question-to-display (question "meth"))
    (user-answer (question "meth") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "Breaking Bed")))
)

(defrule meth-no
    ?q <- (question-to-display (question "meth"))
    (user-answer (question "meth") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "Mad Men")))
)

(defrule questionable-morals-no
    ?q <- (question-to-display (question "questionable-morals"))
    (user-answer (question "questionable-morals") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "strong-female-characters")
        (options "yes" "no")
    ))
)

(defrule strong-female-characters-yes
    ?q <- (question-to-display (question "strong-female-characters"))
    (user-answer (question "strong-female-characters") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "drugs")
        (options "yes" "no")
    ))
)

(defrule drugs-yes
    ?q <- (question-to-display (question "drugs"))
    (user-answer (question "drugs") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (result(result "Weeds")))
)

(defrule drugs-no
    ?q <- (question-to-display (question "drugs"))
    (user-answer (question "drugs") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "tina-amy")
        (options "tina" "amy")
    ))
)

(defrule tina
    ?q <- (question-to-display (question "tina-amy"))
    (user-answer (question "tina-amy") (answer "tina"))
    (not (result))
    =>
    (retract ?q)
    assert (result(result "30 Rock")))
)

(defrule amy
    ?q <- (question-to-display (question "tina-amy"))
    (user-answer (question "tina-amy") (answer "amy"))
    (not (result))
    =>
    (retract ?q)
    assert (result(result "Parks & Recreation")))
)

(defrule strong-female-characters-no
    ?q <- (question-to-display (question "strong-female-characters"))
    (user-answer (question "strong-female-characters") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "work-place-humor")
        (options "yes" "no")
    ))
)

(defrule work-place-humor-no
    ?q <- (question-to-display (question "work-place-humor"))
    (user-answer (question "work-place-humor") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "james-franco-seth-rogen")
        (options "yes" "no")
    ))
)

(defrule james-franco-seth-rogen-no
    ?q <- (question-to-display (question "james-franco-seth-rogen"))
    (user-answer (question "james-franco-seth-rogen") (answer "no"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "bar-cafe")
        (options "bar" "cafe")
    ))
)

(defrule bar
    ?q <- (question-to-display (question "bar-cafe"))
    (user-answer (question "bar-cafe") (answer "bar"))
    (not (result))
    =>
    (retract ?q)
    assert (result(result "How I Met Your Mother")))
)

(defrule cafe
    ?q <- (question-to-display (question "bar-cafe"))
    (user-answer (question "bar-cafe") (answer "cafe"))
    (not (result))
    =>
    (retract ?q)
    assert (result(result "Friends")))
)

(defrule james-franco-seth-rogen-yes
    ?q <- (question-to-display (question "james-franco-seth-rogen"))
    (user-answer (question "james-franco-seth-rogen") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    assert (result(result "Freaks & Geeks")))
)

(defrule work-place-humor-yes
    ?q <- (question-to-display (question "work-place-humor"))
    (user-answer (question "work-place-humor") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    assert (result(result "The Office")))
)

(defrule questionable-morals-yes
    ?q <- (question-to-display (question "questionable-morals"))
    (user-answer (question "questionable-morals") (answer "yes"))
    (not (result))
    =>
    (retract ?q)
    (assert (question-to-display
        (question "friend-group-family")
        (options "friend-group" "family")
    ))
)

(defrule friend-group
    ?q <- (question-to-display (question "friend-group-family"))
    (user-answer (question "friend-group-family") (answer "friend-group"))
    (not (result))
    =>
    (retract ?q)
    assert (result(result "It's Always Sunny In Philadelphia")))
)

(defrule family
    ?q <- (question-to-display (question "friend-group-family"))
    (user-answer (question "friend-group-family") (answer "family"))
    (not (result))
    =>
    (retract ?q)
    assert (result(result "Arrested Development")))
)








