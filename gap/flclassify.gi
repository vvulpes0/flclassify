#
# flclassify: Classify formal languages
#
# Implementations
#
InstallMethod(IsDA,
[IsSemigroup],
function(S)
	return ForAll(RegularDClasses(S),
		c -> NrIdempotents(c) = NrHClasses(c));
end);

InstallMethod(IsGeneralizedDefinite, "for a semigroup",
[IsSemigroup],
function(S)
	if NrRegularDClasses(S) <> 1 then return false; fi;
	return IsDA(S);
end);





InstallTrueMethod(IsLocallyTestable, IsGeneralizedDefinite);
InstallTrueMethod(IsLocallyTestable, IsSemilattice);
InstallMethod(IsLocallyTestable, "for a semigroup",
[IsSemigroup],
function(S)
	return Locally(IsSemilattice, S);
end);
InstallTrueMethod(IsLocallyAcom, IsLocallyThresholdTestable);
InstallTrueMethod(IsLocallyAcom, IsAcom);
InstallMethod(IsLocallyAcom, "for a semigroup",
[IsSemigroup],
function(S)
	return IsStarFree(S) and Locally(IsCommutative, S);
end);
InstallTrueMethod(IsLocallyThresholdTestable, IsLocallyTestable);
InstallTrueMethod(IsLocallyThresholdTestable, IsAcom);
InstallMethod(IsLocallyThresholdTestable, "for a semigroup",
[IsSemigroup],
function(S)
	local a,b,c,e,f,x,y,idem,elem;
	if not IsStarFree(S) then return false; fi;
	idem := Idempotents(S);
	elem := AsList(S);
	for e in idem do for f in idem do
		for a in elem do for b in elem do for c in elem do
			x := e * a * f * b * e * c * f;
			y := e * c * f * b * e * a * f;
			if x<>y then return false; fi;
	od;od;od;od;od;
	return true;
end);
InstallTrueMethod(IsLocallyJTrivial, IsLocallyAcom);
InstallTrueMethod(IsLocallyJTrivial, IsDTrivial and IsFinite);
InstallMethod(IsLocallyJTrivial, "for a semigroup",
[IsSemigroup],
function(S)
	return Locally(IsDTrivial, S);
end);
InstallTrueMethod(IsLocallyLTrivial, IsLocallyJTrivial);
InstallTrueMethod(IsLocallyLTrivial, IsLTrivial);
InstallMethod(IsLocallyLTrivial, "for a semigroup",
[IsSemigroup],
function(S)
	return Locally(IsLTrivial, S);
end);
InstallTrueMethod(IsLocallyRTrivial, IsLocallyJTrivial);
InstallTrueMethod(IsLocallyRTrivial, IsRTrivial);
InstallMethod(IsLocallyRTrivial, "for a semigroup",
[IsSemigroup],
function(S)
	return Locally(IsRTrivial, S);
end);
InstallTrueMethod(IsLocallyDA, IsLocallyLTrivial);
InstallTrueMethod(IsLocallyDA, IsLocallyRTrivial);
InstallTrueMethod(IsLocallyDA, IsDA);
InstallMethod(IsLocallyDA, "for a semigroup",
[IsSemigroup],
function(S)
	return Locally(IsDA, S);
end);





InstallTrueMethod(IsTierGeneralizedDefinite, IsGeneralizedDefinite);
InstallMethod(IsTierGeneralizedDefinite, "for a semigroup",
[IsSemigroup],
function(S)
	return TierLocally(IsTrivial, S);
end);
InstallTrueMethod(IsTierLocallyTestable, IsTierGeneralizedDefinite);
InstallTrueMethod(IsTierLocallyTestable, IsLocallyTestable);
InstallMethod(IsTierLocallyTestable, "for a semigroup",
[IsSemigroup],
function(S)
	return TierLocally(IsSemilattice, S);
end);
InstallTrueMethod(IsTierLocallyAcom, IsTierLocallyThresholdTestable);
InstallTrueMethod(IsTierLocallyAcom, IsLocallyAcom);
InstallMethod(IsTierLocallyAcom, "for a semigroup",
[IsSemigroup],
function(S)
	return IsStarFree(S) and TierLocally(IsCommutative, S);
end);
InstallTrueMethod(IsTierLocallyThresholdTestable, IsTierLocallyTestable);
InstallTrueMethod(IsTierLocallyThresholdTestable, IsLocallyThresholdTestable);
InstallMethod(IsTierLocallyThresholdTestable, "for a semigroup",
[IsSemigroup],
function(S)
	return IsStarFree(S)
		and IsLocallyThresholdTestable(ProjectedSubsemigroup(S));
end);
InstallTrueMethod(IsTierLocallyJTrivial, IsTierLocallyThresholdTestable);
InstallTrueMethod(IsTierLocallyJTrivial, IsLocallyJTrivial);
InstallMethod(IsTierLocallyJTrivial, "for a semigroup",
[IsSemigroup],
function(S)
	return TierLocally(IsDTrivial, S);
end);
InstallTrueMethod(IsTierLocallyLTrivial, IsTierLocallyJTrivial);
InstallTrueMethod(IsTierLocallyLTrivial, IsLocallyLTrivial);
InstallMethod(IsTierLocallyLTrivial, "for a semigroup",
[IsSemigroup],
function(S)
	return TierLocally(IsLTrivial, S);
end);
InstallTrueMethod(IsTierLocallyRTrivial, IsTierLocallyJTrivial);
InstallTrueMethod(IsTierLocallyRTrivial, IsLocallyRTrivial);
InstallMethod(IsLocallyRTrivial, "for a semigroup",
[IsSemigroup],
function(S)
	return TierLocally(IsRTrivial, S);
end);
InstallTrueMethod(IsTierLocallyDA, IsTierLocallyLTrivial);
InstallTrueMethod(IsTierLocallyDA, IsTierLocallyRTrivial);
InstallTrueMethod(IsTierLocallyDA, IsLocallyDA);
InstallMethod(IsTierLocallyDA, "for a semigroup",
[IsSemigroup],
function(S)
	return TierLocally(IsDA, S);
end);





InstallMethod(LocalSubsemigroup, "for a semigroup",
IsCollsElms,
[IsSemigroup, IsMultiplicativeElement],
function(S, x)
	return AsSubsemigroup(S, AsSet(x*AsList(S)*x));
end);

InstallMethod(LocalSubmonoids, "for a semigroup",
[IsSemigroup],
function(S)
	return List(Idempotents(S),
		e->Range(IsomorphismMonoid(IsMonoid,
			LocalSubsemigroup(S, e))));
end);

InstallMethod(IteratorOfLocalSubmonoids, "for a semigroup",
[IsSemigroup],
function(S)
	local advance;
	advance := function(iter)
		local c, x;
		if IsDoneIterator(iter!.elems) then return; fi;
		c := ShallowCopy(iter!.elems);
		x := NextIterator(c);
		while x <> fail and not IsIdempotent(x) do
			NextIterator(iter!.elems);
			if IsDoneIterator(c) then break; fi;
			x := NextIterator(c);
		od;
	end;
	return IteratorByFunctions(rec(
		elems := Iterator(S),
		NextIterator := function(iter)
			if IsDoneIterator(iter) then return fail; fi;
			return LocalSubsemigroup(S,
					NextIterator(iter!.elems));
		end,
		IsDoneIterator := function(iter)
			advance(iter);
			return IsDoneIterator(iter!.elems);
		end,
		ShallowCopy :=
			iter -> rec(elems := ShallowCopy(iter!.elems)),
	));
end);

InstallMethod(ProjectedSubsemigroup, "for a semigroup",
[IsSemigroup],
function(S)
	if IsMonoidAsSemigroup(S) then
		return Semigroup(Filtered(AsList(S), x -> x<>One(S)));
	else
		return S;
	fi;
end);

InstallMethod(Locally, "for a semigroup",
[IsFunction, IsSemigroup],
function(p, S)
	return ForAll(List(IteratorOfLocalSubmonoids(S)), p);
end);

InstallMethod(Locally, "for a semigroup",
[IsFunction, IsSemigroup and HasLocalSubmonoids],
function(p, S)
	return ForAll(LocalSubmonoids(S), p);
end);

InstallMethod(TierLocally, "for a semigroup",
[IsFunction, IsSemigroup],
function(p, S)
	return Locally(p, ProjectedSubsemigroup(S));
end);





InstallMethod(DoubletonGraph, "for deterministic automata",
[IsAutomatonObj],
function(A)
	local cardQ, cardSigma, delta, F, p, q, s, T, x, y;
	if not IsDeterministicAutomaton(A) then
		TryNextMethod();
	fi;
	cardSigma := AlphabetOfAutomaton(A);
	cardQ := NumberStatesOfAutomaton(A);
	delta := TransitionMatrixOfAutomaton(A);
	T := NullMat(cardSigma, cardQ);
	F := [];
	for p in [1..cardQ] do
		for q in [1..cardQ] do
			if p in FinalStatesOfAutomaton(A)
			and q in FinalStatesOfAutomaton(A)
			then Add(F, (p-1)*cardQ + q);
			fi;
			if p = q then continue; fi;
			for s in [1..cardSigma] do
				if not IsBound(delta[s][p])
				or delta[s][p] = 0
				or not IsBound(delta[s][q])
				or delta[s][q] = 0
				then
					continue;
				fi;
				x := delta[s][p];
				y := delta[s][q];
				if x = y then continue; fi;
				T[s][(p-1)*cardQ + q] := (x-1)*cardQ + y;
			od;
		od;
	od;
	return Automaton("det", cardQ * cardQ, cardSigma, T,
		List(InitialStatesOfAutomaton(A),
		     p -> (p-1) * cardQ + p), F);
end);

InstallMethod(SalienceProjection, "for deterministic automata",
[IsAutomatonObj],
function(A)
	local asc, i, P, Sigma, T;
	if not IsDeterministicAutomaton(A) then
		TryNextMethod();
	fi;
	T := TransitionMatrixOfAutomaton(A);
	P := [];
	Sigma := [];
	for i in [1..Length(T)] do
		if not IsBound(asc) then
			asc := [1..Length(T[i])];
		fi;
		if T[i] <> asc then
			Add(P,T[i]);
			Add(Sigma,AlphabetOfAutomatonAsList(A)[i]);
		fi;
	od;
	return Automaton("det", NumberStatesOfAutomaton(A),
	                 Sigma, P,
	                 InitialStatesOfAutomaton(A),
	                 FinalStatesOfAutomaton(A));
end);

InstallMethod(IsStrictlyLocal, "for an automaton",
[IsAutomatonObj],
function(aut)
	local A;
	A := RemovedSinkStates(MinimalizedAut(NFAtoDFA(aut)));
	return AutoIsAcyclicGraph(
	    UnderlyingGraphOfAutomaton(DoubletonGraph(A)));
end);

InstallMethod(IsTierStrictlyLocal, "for an automaton",
[IsAutomatonObj],
function(aut)
	local A;
	A := RemovedSinkStates(MinimalizedAut(NFAtoDFA(aut)));
	return IsStrictlyLocal(SalienceProjection(A));
end);





InstallMethod(AutomatonFromATT, "for input streams",
[IsInputStream],
function(s)
	local a, b, bound, delta, fields, finals, haseps,
	      i, line, states, symbols, trans, type, x;
	states := [];
	finals := [];
	trans := [];
	symbols := [];
	haseps := false;
	delta := [];
	line := ReadLine(s);
	while line <> fail do;
		fields := SplitString(line,""," \t\r\n");
		if Length(fields) = 0 then
			;
		elif Length(fields) < 3 then
			if not fields[1] in states then
				Add(states, fields[1]);
			fi;
			if not fields[1] in finals then
				Add(finals, fields[1]);
			fi;
		elif Length(fields) < 6 then
			if not fields[1] in states then
				Add(states, fields[1]);
			fi;
			if not fields[2] in states then
				Add(states, fields[2]);
			fi;
			if fields[3] <> "0"
			   and not fields[3] in symbols then
				Add(symbols, fields[3]);
			fi;
			if fields[3] = "0" then
				haseps := true;
			fi;
			Add(trans, rec(src:=fields[1],
			               dst:=fields[2],
			               sym:=fields[3]));
		fi;
		line := ReadLine(s);
	od;
	CloseStream(s);
	if haseps then Add(symbols, "0"); fi;
	for i in [1..Length(symbols)] do
		delta[i] := [];
	od;
	for i in trans do
		x := Position(symbols, i.sym);
		bound := PositionsBound(delta[x]);
		a := Position(states, i.src);
		b := Position(states, i.dst);
		if a in bound and not IsList(delta[x][a]) then
			delta[x][a] := [delta[x][a], b];
		elif a in bound then
			Add(delta[x][a], b);
		else
			delta[x][a] := b;
		fi;
	od;
	type := "det";
	if ForAny(delta, p->ForAny(p,IsList)) then type := "nondet"; fi;
	if haseps then type := "epsilon"; fi;
	if states = [] then states := [1]; fi;
	return Automaton(type, Length(states), symbols,
	                 delta, [1],
	                 List(finals, f->Position(states, f)));
end);
