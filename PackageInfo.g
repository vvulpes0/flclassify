#
# flclassify: Classify formal languages
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "FLClassify",
Subtitle := "Classify formal languages",
Version := "0.1.0",
Date := "10/11/2022", # dd/mm/yyyy format
License := "MIT",

Persons := [
  rec(
    FirstNames := "Dakotah",
    LastName := "Lambert",
    WWWHome := "https://vvulpes0.github.io/",
    Email := "dakotahlambert@acm.org",
    IsAuthor := true,
    IsMaintainer := true,
    #PostalAddress := TODO,
    #Place := TODO,
    #Institution := TODO,
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/vvulpes0/flclassify",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://vvulpes0.github.io/flclassify/",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "flclassify",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Classify formal languages",
),

AutoDoc := rec(
  TitlePage := rec(
    Abstract := """FLClassify is a GAP package whose purpose
is to analyze and classify formal languages.
""",
    Copyright := """Copyright © 2022 Dakotah Lambert.
<P/>
Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:
<P/>
The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.
<P/>
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
<P/>
Additionally, this manual alone may be distributed
under the terms of the Creative Commons Attribution 4.0
International License.
To view a copy of this license, visit
<URL>http://creativecommons.org/licenses/by/4.0/</URL>.
<P/>
<Alt Only="HTML">
&#60;a rel="license" href="http://creativecommons.org/licenses/by/4.0/"&#62;
&#60;img alt="Creative Commons License" style="border-width:0" src="ccby.svg" /&#62;&#60;/a&#62;
</Alt>
<Alt Only="LaTeX">
\includegraphics{ccby}
</Alt>
""",
  ),
),

Dependencies := rec(
  GAP := ">= 4.11",
  NeededOtherPackages := [ ["semigroups", ">= 5.0"],
                           ["automata", ">= 1.14"],
                         ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));


