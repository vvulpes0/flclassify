#!/usr/bin/env gap -q -b
LoadPackage("flclassify");

A := AutomatonFromATT(InputTextFile("*stdin*"));
S := SyntacticSemigroupAut(NFAtoDFA(A));

f := function(x)
	if x then return "Y"; fi;
	return "N";
end;
format := function(title, p, lp, tlp)
	return StringFormatted("{}   {}   {}   {}\n",
		String(title,12), p, lp, tlp);
end;
g := function(title, p)
	return format(title, f(p(S)), f(Locally(p, S)), f(TierLocally(p, S)));
end;
g2 := function(title, p)
	return format(title, " ", f(p(S)), f(p(ProjectedSubsemigroup(S))));
end;
rev := [];
Add(rev,format("SL"," ",f(IsStrictlyLocal(A)),f(IsTierStrictlyLocal(A))));
Add(rev,"\n");
Add(rev,g2("F",IsDefinite and IsReverseDefinite));
Add(rev,g2("K",IsReverseDefinite));
Add(rev,g2("D",IsDefinite));
Add(rev,g("Trivial",IsTrivial));
Add(rev,g("Semilattice",IsSemilattice));
Add(rev,g("Acom",IsCommutative and IsHTrivial));
Add(rev,g("PT",IsDTrivial));
Add(rev,g("Band",IsBand));
Add(rev,g("R-trivial",IsRTrivial));
Add(rev,g("L-trivial",IsLTrivial));
Add(rev,g("DA", IsDA));
Add(rev,format("SF",f(IsHTrivial(S))," "," "));
Add(rev,g("Commutative", IsCommutative));
Print("               V  LV  TLV\n");
for i in [1..Size(rev)] do
	Print(rev[Size(rev) - i + 1]);
od;
QUIT;
