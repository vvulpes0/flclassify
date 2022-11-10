#
# flclassify: Classify formal languages
#
#! @Chapter Introduction
#!
#! FLClassify is a package dedicated to the algebraic theory
#! of formal languages, and specifically to the problem
#! of classifying these languages.
#! @Section Installation
#! Simply unpack the source archive in your GAP <Code>pkg</Code> directory.
#! Use of this package also requires that the Semigroups and Automata
#! packages are installed,
#! or other packages that offer a compatible interface.
#! These packages are part of the base installation.
#!
#! @Section Preliminaries
#! A semigroup is a set $S$ augmented with some operation,
#! denoted by adjacency, which is associative.
#! That is, for any $a$, $b$, and $c$ in $S$,
#! it holds that $(ab)c=a(bc)$, and thus $abc$ is without ambiguity.
#! A semigroup is a monoid iff it contains some element $1$
#! such that for all $x$, $1x=x=x1$.
#! For every semigroup $S$, there is an associated monoid $S^1$
#! which is equal to $S$ if it is already a monoid,
#! else it is equal to $S$ with an adjoined element
#! that acts as an identity.
#! Semigroups are not groups: they need not have inverses.
#! Given some element $x$, there may or may not exist some $y$
#! such that $xyx=x$.
#! If this exists, $x$ is called a regular element
#! and $y$ a pseudoinverse of $x$.
#! Note that if $y$ is a psudoinverse of $x$
#! it necessarily follows that $xyx=x$ and $yxy$
#! are pseudoinverses of one another.
#!
#! A formal language is any subset of the free monoid $\Sigma^*$,
#! although in many cases the empty word
#! is irrelevant to the membership problem,
#! and it is easier to work in terms of the free semigroup $\Sigma^+$.
#! As there is a standard construction for this structure
#! from a finite automaton, this package provides a mechanism
#! by which to import finite automata in a standard format.
#!
#! When presented with a language as a finite automaton,
#! rather than as a semigroup,
#! additional operations are unlocked.
#! These are discussed in the final chapter.
#!
#! <Alt Only="HTML">&#60;figure&#62;
#! &#60;img src="fig-hierarchy.svg"
#! alt="StarFree is above DA which is above LTrivial, RTrivial and Band.
#! Each of LTrivial and RTrivial is above PiecewiseTestable.
#! PiecewiseTestable is above Acom.
#! Each of Acom and Band is above Semilattice,
#! which is above Trivial." /&#62;&#60;figcaption&#62;
#! A hierarchy of classes which triplicates.
#! &#60;/figcaption&#62;&#60;/figure&#62;
#! </Alt>
#! <Alt Only="LaTeX">
#! \begin{figure}[htbp]\centering
#! \includegraphics{fig-hierarchy}
#! \caption{A hierarchy of classes which triplicates.}
#! \label{fig:hierarchy}
#! \end{figure}
#! </Alt>
#! @Chapter Green's Relations
#! The following relations, introduced by Green
#! <Cite Key="Green1951"/>, have been fundamental
#! in studying the structure of semigroups:
#! * $a\mathrel{\mathcal{L}}b$ iff $S^1 a=S^1 b$
#! * $a\mathrel{\mathcal{R}}b$ iff $aS^1=bS^1$
#! * $a\mathrel{\mathcal{J}}b$ iff $S^1 aS^1=S^1 bS^1$
#! * $a\mathrel{\mathcal{H}}b$ iff $a\mathrel{\mathcal{L}}b$ and $a\mathrel{\mathcal{R}}b$
#! * $a\mathrel{\mathcal{D}}b$ iff there is a $c$ where $a\mathrel{\mathcal{L}}c$ and $c\mathrel{\mathcal{R}}b$
#! A language is regular iff its syntactic semigroup is finite,
#! so for this work we can operate in a space where
#! $\mathcal{J}=\mathcal{D}$.
#!
#! Regular $\mathcal{D}$-classes are sometimes relevant.
#! A $\mathcal{D}$-class is regular iff it contains a regular element.
#!
#! @Section Triviality Under Certain Relations
#! Many important classes of languages are defined
#! by properties related to these relations.
#! The simplest are those corresponding to first-order
#! and propositional logic over general precedence.
#!
#! <ManSection>
#! <Prop Name="IsStarFree" Arg="semigroup"/>
#! <Returns>true or false</Returns>
#! <Description>
#! Determine if a semigroup recognizes only star-free languages.
#! This is implemented as a synonym, so there is no corresponding
#! <Code>HasIsStarFree</Code>.
#!
#! A language is star-free iff it is definable by a generalized
#! regular expression without the use of the star.
#! That is, it is the closure under concatenation,
#! union, intersection, and complement of singleton sets of words.
#! As demonstrated by Schützenberger <Cite Key="Schutzenberger1965"/>,
#! a language is star-free iff its syntactic semigroup
#! is finite and aperiodic.
#! Aperiodic simply means that every $\mathcal{H}$-class is singleton,
#! that the semigroup is $\mathcal{H}$-trivial.
#! McNaughton and Papert show that a language is first-order definable
#! with less-than iff it is star-free
#! <Cite Key="McNaughtonPapert1971"/>.
#! </Description>
#! </ManSection>

DeclareSynonym("IsStarFree", IsFinite and IsHTrivial);

#! <ManSection>
#! <Prop Name="IsPiecewiseTestable" Arg="semigroup"/>
#! <Returns>true or false</Returns>
#! <Description>
#! Determine if a semigroup recognizes only piecewise testable languages.
#! This is implemented as a synonym, so there is no corresponding
#! <Code>HasIsPiecewiseTestable</Code>.
#!
#! A language is piecewise testable iff it is definable by
#! its allowed sets of subsequences,
#! where a subsequence is a (finite) sequence of symbols
#! that occur in order but not necessarily adjacent to one another.
#! As demonstrated by Simon <Cite Key="Simon1975"/>,
#! a language is piecewise testable iff its syntactic semigroup
#! is finite and $\mathcal{J}$-trivial.
#! This definition corresponds to a propositional logic
#! whose propositions are the occurrence of subsequences,
#! defined by less-than alone.
#! </Description>
#! </ManSection>

DeclareSynonym("IsPiecewiseTestable", IsFinite and IsDTrivial);

#! The $\mathcal{L}$- and $\mathcal{R}$-trivial languages
#! are useful in some sense, but have not been given other names
#! in the literature.  Thus no synonyms are provided.
#! We shall see them later when discussing
#! definability by affixes.
#! First, though, let us consider two special subclasses
#! of piecewise testable semigroups:
#! Acom and semilattices.
#! <ManSection>
#! <Prop Name="IsAcom" Arg="semigroup"/>
#! <Returns>true or false</Returns>
#! <Description>
#! Determine if a semigroup is aperiodic and commutative.
#! This is implemented as a synonym, so there is no corresponding
#! <Code>HasIsAcom</Code>.
#!
#! The corresponding languages are based on restrictions
#! on their multisets of symbols,
#! where counts saturate at some threshold $t$.
#! The special case where $t=1$ is a restriction
#! on which sets of symbols appear;
#! this smaller subclass corresponds to <Code>IsSemilattice</Code>.
#! </Description>
#! </ManSection>

DeclareSynonym("IsAcom", IsStarFree and IsCommutative);

#! Finally, there is a class which contains all of the
#! $\mathcal{L}$- and $\mathcal{R}$-trivial langugaes
#! without moving all the way up to star-free:

#! @Arguments semigroup
#! @Returns true or false
#! @Description
#! Decide if a semigroup is in DA,
#! that is, whether all of its regular $\mathcal{D}$-classes
#! are aperiodic semigroups.
#! This is equivalent to asking whether all regular elements
#! are idempotent.
#! Thérien and Wilke demonstrate that this class
#! corresponds precisely to first-order definability with less-than
#! but only two formal variables
#! <Cite Key="TherienWilke1998"/>.
DeclareProperty("IsDA", IsSemigroup);

#! @Section Affixes
#! This section details languages defined by sets of permitted affixes.
#! They might just as well be in the later chapter on local properties,
#! but in fact they are decidable without invoking the mechanisms
#! of that section.
#! @BeginGroup
#! @Arguments semigroup
#! @Returns true or false
#! @Description
#! A language is generalized definite iff it is defined
#! by a Boolean combination of permitted suffixes.
#! This corresponds to having all idempotents be $\mathcal{D}$-related,
#! which trivially makes this a subclass of DA.
DeclareProperty("IsGeneralizedDefinite", IsSemigroup);
#! @Arguments semigroup
#! @Returns true or false
#! @Description
#! A language is tier-based generalized definite
#! iff its projected subsemigroup is generalized definite.
#! The projected subsemigroup
#! is the semigroup generated by $S^1\setminus\{1\}$.
DeclareProperty("IsTierGeneralizedDefinite", IsSemigroup);
#! @EndGroup

#! <ManSection>
#! <Prop Name="Is(Tier)Definite" Arg="semigroup"/>
#! <Returns>true or false</Returns>
#! <Description>
#! Determine if a semigroup is (tier-based) definite.
#! These are implemented as synonyms, so there is no corresponding
#! <Code>HasIsDefinite</Code> or <Code>HasIsTierDefinite</Code>.
#!
#! A language is (tier-based) definite iff it is defined
#! by a Boolean combination of suffixes.
#! These are all and only those languages
#! that are both (tier-based) generalized definite
#! and $\mathcal{L}$-trivial.
#! </Description>
#! </ManSection>

DeclareSynonym("IsDefinite", IsLTrivial and IsGeneralizedDefinite);
DeclareSynonym("IsTierDefinite",
               IsTierGeneralizedDefinite and IsLTrivial);

#! <ManSection>
#! <Prop Name="Is(Tier)ReverseDefinite" Arg="semigroup"/>
#! <Returns>true or false</Returns>
#! <Description>
#! Determine if a semigroup is (tier-based) reverse definite.
#! These are implemented as synonyms, so there is no corresponding
#! <Code>HasIsDefinite</Code> or <Code>HasIsTierDefinite</Code>.
#!
#! A language is (tier-based) reverse definite iff it is defined
#! by a Boolean combination of prefixes.
#! These are all and only those languages
#! that are both (tier-based) generalized definite
#! and $\mathcal{R}$-trivial.
#! </Description>
#! </ManSection>

DeclareSynonym("IsReverseDefinite", IsRTrivial and IsGeneralizedDefinite);
DeclareSynonym("IsTierReverseDefinite",
               IsTierGeneralizedDefinite and IsRTrivial);

#! @Chapter Local Properties
#! For all elements $x$ of a semigroup $S$,
#! the set $xSx=\{xsx:s\in S\}$ is a subsemigroup of $S$.
#! If further it holds that $x=xx$ then it is a submonoid
#! with identity $e$.
#! A submonoid generated by an idempotent in this way
#! is called a local submonoid.
#! @Section Generating Local Submonoids
#! @Arguments semigroup element
#! @Returns a subsemigroup
#! @Description
#! Compute the local subsemigroup of the <A>semigroup</A>
#! induced by the <A>element</A>.
DeclareOperation("LocalSubsemigroup",
                 [IsSemigroup, IsMultiplicativeElement]);
#! @Arguments semigroup
#! @Returns a list of submonoids
#! @Description
#! Determine all local submonoids of the <A>semigroup</A>.
DeclareAttribute("LocalSubmonoids", IsSemigroup);
#! @Arguments semigroup
#! @Returns an iterator of submonoids
#! @Description
#! Determine all local submonoids of the <A>semigroup</A>.
#! These are given as an external iterator
#! rather than being stored as an attribute of the <A>semigroup</A>.
DeclareOperation("IteratorOfLocalSubmonoids", [IsSemigroup]);

#! @Arguments proposition semigroup
#! @Returns true or false
#! @Description
#! Determine if all local submonoids of the <A>semigroup</A>
#! satisfy the <A>proposition</A>.
DeclareOperation("Locally", [IsFunction, IsSemigroup]);

#! As convenience, we declare some specific named attributes
#! regarding local properties.
#! As these are stored in the object,
#! they can be used implicationally to speed up classification
#! by omitting redundant tests.

#! @BeginGroup
#! @GroupTitle IsLocallyX
#! @Arguments semigroup
#! @Returns true or false
#! @Description
#! A semigroup satisfies a property locally
#! iff all of its local submonoids satisfy the property.
DeclareProperty("IsLocallyDA", IsSemigroup);
#! @Arguments semigroup
#! @Returns true or false
DeclareProperty("IsLocallyLTrivial", IsSemigroup);
#! @Arguments semigroup
#! @Returns true or false
DeclareProperty("IsLocallyRTrivial", IsSemigroup);
#! @Arguments semigroup
#! @Returns true or false
DeclareProperty("IsLocallyJTrivial", IsSemigroup);
#! @Arguments semigroup
#! @Returns true or false
#! @Description
#! A language is locally threshold testable
#! iff its syntactic semigroup is locally Acom,
#! that is, locally aperiodic and commutative.
#! This result derives from applying
#! the work of Almeida <Cite Key="Almeida1989"/>
#! to the results of Beauquier and Pin <Cite Key="BeauquierPin1989"/>.
DeclareProperty("IsLocallyThresholdTestable", IsSemigroup);
#! @Arguments semigroup
#! @Returns true or false
#! @Description
#! A language is locally testable
#! iff its syntactic semigroup is locally a semilattice,
#! that is, locally idempotent and commutative
#! <Cite Key="BrzozowskiSimon1973"/>.
DeclareProperty("IsLocallyTestable", IsSemigroup);
#! @EndGroup


#! @Arguments semigroup
#! @Returns a subsemigroup
#! @Description
#! The projected subsemigroup of a <A>semigroup</A> $S$
#! is that subsemigroup generated by $S^1\setminus\{1\}$.
#! This corresponds to the syntactic semigroup
#! of the projection of a language to all and only its salient symbols.
#! Thus this structure is in a class
#! iff <A>semigroup</A> recognizes only languages
#! of the corresponding tier-based class such as those
#! discussed by Lambert <Cite Key="Lambert2022"/>.
#! See also <Ref Oper="SalienceProjection"/>.
#! <Label Name="ProjectedSubsemigroup"/>
DeclareAttribute("ProjectedSubsemigroup", IsSemigroup);

#! @Arguments proposition semigroup
#! @Returns true or false
#! @Description
#! A semigroup satisfies a property tier-locally iff
#! its projected subsemigroup satisifies it locally.
DeclareOperation("TierLocally", [IsFunction, IsSemigroup]);

#! @BeginGroup
#! @GroupTitle IsTierLocallyX
#! @Arguments semigroup
#! @Returns true or false
#! @Description
#! Determine if the property is satisfied tier-locally.
#! These are stored on the semigroup to speed up classification
#! through implications.
DeclareProperty("IsTierLocallyDA", IsSemigroup);
#! @Arguments semigroup
DeclareProperty("IsTierLocallyLTrivial", IsSemigroup);
#! @Arguments semigroup
DeclareProperty("IsTierLocallyRTrivial", IsSemigroup);
#! @Arguments semigroup
DeclareProperty("IsTierLocallyJTrivial", IsSemigroup);
#! @Arguments semigroup
DeclareProperty("IsTierLocallyThresholdTestable", IsSemigroup);
#! @Arguments semigroup
DeclareProperty("IsTierLocallyTestable", IsSemigroup);
#! @EndGroup



#! @Chapter Operations on Automata
#!
#! While the majority of the functionality of this package
#! comes from algebraic manipulation,
#! some problems are just not amenable to that setting.
#! For those times, one might wish to work directly with finite automata.
#! Here we offer one mechanism for importing machines
#! and some decision problems that cannot be handled
#! with semigroups alone.
#!
#! @Section Importing Automata
#! @Arguments stream
#! @Returns an automaton
#! @Description
#! Import an automaton from AT&amp;T-style tabular text
#! read from <A>stream</A>.
#! Each row contains no more than five whitespace-separated fields.
#! An empty row is ignored.
#! A row with one or two fields represents an accepting state,
#! perhaps with a weight which is ignored here.
#! A row with three, four, or five fields represents a transition.
#! The first, second, and third fields always represent
#! the source, destination, and input symbol, respectively,
#! and subsequent fields are again ignored.
#!
#! For example the following text represents
#! @BeginNotLatex
#! the pictured automaton,
#! @EndNotLatex
#! @LatexOnly Figure~\ref{fig:no-ab},
#! which itself represents strings over $\Sigma=\{a,b,c\}$
#! not containing an "$ab$"-substring.
#! @BeginLogSession
#! 1 2 a
#! 1 1 b
#! 1 1 c
#! 1
#! 2 2 a
#! 2 3 b
#! 2 1 c
#! 2
#! 3 3 a
#! 3 3 b
#! 3 3 c
#! @EndLogSession
#! <Alt Only="HTML">&#60;img src="fig-no-ab.svg"/&#62;</Alt>
#! <Alt Only="LaTeX">
#! \begin{figure}[htbp]\centering
#! \includegraphics{fig-no-ab}
#! \caption{A complete minimal automaton accepting
#!     all and only those words that do not contain "$ab$".}
#! \label{fig:no-ab}
#! \end{figure}
#! </Alt>
DeclareOperation("AutomatonFromATT", [IsInputStream]);

#! @Section Strict Locality and Relativizations
#! 
#! A language is locally testable in the strict sense (strictly local)
#! iff there is some value $k$ and some set $S$
#! of anchored words of length at most $k$
#! such that the words in the language are all and only those
#! that do not contain any element of $S$ as a substring when anchored.
#! As this class is not closed under complement,
#! there can be no characterization for the class
#! based on the syntactic semigroup alone without further metadata.
#! But all is not lost.
#!
#! Characterized by closure under substitution of suffixes
#! following shared length-$k$ substrings,
#! the strictly local languages are associated with automata
#! that synchronize after no more than $k$ steps
#! <Cite Key="EdlefsenEtAl2008"/>.
#! In other words, from any state $p$ it is necessarily the case
#! that following a length-$k$ word $w$ will lead to the same state
#! as it would when following $w$ from any other state $q$.
#!
#! There exists an exponential-time algorithm for deciding 
#! membership in this class, which admits simultaneously 
#! extracting the grammar of forbidden substrings
#! <Cite Key="RogersLambert2019b"/>,
#! but the polynomial-time process of <Cite Key="EdlefsenEtAl2008"/>
#! is used here.
#! If the trim, minimal automaton has states $Q$,
#! then class membership is decidable using
#! the subgraph of the product construction containing only
#! nodes of the form $Q\times Q$ whose two components are inequal.
#! The language is strictly local iff this graph is acyclic.
#!
#! @BeginGroup
#! @GroupTitle Is(Tier)StrictlyLocal
#! @Arguments aut
#! @Returns true or false
#! @Description
#! Determine if the language represented by <A>aut</A>
#! is strictly $k$-local for some $k$
#! that is, if it is definable as a conjunction of forbidden substrings.
DeclareProperty("IsStrictlyLocal", IsAutomatonObj);
#! @Arguments aut
#! @Returns true or false
#! @Description
#! A language is <E>tier-based</E> strictly local
#! iff there is some subset $T$ of its alphabet
#! (a tier of salient symbols)
#! such that symbols not in $T$ may be freely inserted and deleted
#! and the projection to $T$ is strictly local
#! <Cite Key="Lambert2022"/>.
DeclareProperty("IsTierStrictlyLocal", IsAutomatonObj);
#! @EndGroup

#! The constructions used in deciding (tier-based) strict locality
#! are exposed in case they might be useful for other purposes.
#! Recall that salience has an algebraic characterization as well,
#! which should be preferred when possible.

#! @Arguments aut
#! @Returns an automaton
#! @Description
#! Construct an automaton whose underlying graph
#! is the pair-graph used in deciding strict locality.
#! The initial state is the pair containing two copies
#! of the initial state of <A>aut</A>,
#! and the final states are all pairs in which both
#! elements are accepting.
DeclareOperation("DoubletonGraph",[IsAutomatonObj]);

#! @Arguments aut
#! @Returns an automaton
#! @Description
#! Remove nonsalient symbols,
#! those that are freely insertable and deletable.
#! For a language in a tier-based class,
#! this provides the projection under which the grammar operates.
#! See also <Ref Attr="ProjectedSubsemigroup"/>.
#! <Label Name="SalienceProjection"/>
DeclareOperation("SalienceProjection",[IsAutomatonObj]);
