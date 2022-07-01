var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = Taxonomy","category":"page"},{"location":"#Taxonomy","page":"Home","title":"Taxonomy","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for Taxonomy.","category":"page"},{"location":"#Index","page":"Home","title":"Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Metadata","page":"Home","title":"Metadata","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Meta\napa\njson\nauthor\nyear\njournal\nMinimalMeta\nIncompleteMeta\nExtensiveMeta","category":"page"},{"location":"#Taxonomy.apa","page":"Home","title":"Taxonomy.apa","text":"Get an APA citation.\n\njulia> apa(DOI(\"10.5281/zenodo.6719627\"))\n\"Ernst, M. S., &amp; Peikert, A. (2022). <i>StructuralEquationModels.jl</i> (Version v0.1.0) [Computer software]. Zenodo. https://doi.org/10.5281/ZENODO.6719627\"\n\n\n\n\n\n","category":"function"},{"location":"#Taxonomy.json","page":"Home","title":"Taxonomy.json","text":"Get a Citeproc JSON.\n\nCSL JSON Documentation\n\nCSL JSON can be read by Zotero and automatically generated by doi.org from DOI. All availible information are included and saved in a Dict.\n\njulia> json(DOI(\"10.5281/zenodo.6719627\"))\nDict{String, Any} with 11 entries:\n  \"publisher\" => \"Zenodo\"\n  \"issued\"    => Dict{String, Any}(\"date-parts\"=>Any[Any[2022, 6, 24]])\n  \"author\"    => Any[Dict{String, Any}(\"family\"=>\"Ernst\", \"given\"=>\"Maximilian …\n  \"id\"        => \"https://doi.org/10.5281/zenodo.6719627\"\n  \"copyright\" => \"MIT License\"\n  \"version\"   => \"v0.1.0\"\n  \"DOI\"       => \"10.5281/ZENODO.6719627\"\n  \"URL\"       => \"https://zenodo.org/record/6719627\"\n  \"title\"     => \"StructuralEquationModels.jl\"\n  \"abstract\"  => \"StructuralEquationModels v0.1.0 This is a package for Structu…\n  \"type\"      => \"book\"\n\n\n\n\n\n","category":"function"},{"location":"#Taxonomy.author","page":"Home","title":"Taxonomy.author","text":"Extract the author.\n\njulia> doi = MetaData(DOI(\"10.1126/SCIENCE.169.3946.635\"));\n\njulia> author(doi)\n\"Frank, Henry S.\"\n\n\n\n\n\n","category":"function"},{"location":"#Taxonomy.year","page":"Home","title":"Taxonomy.year","text":"Extract the year.\n\njulia> doi = MetaData(DOI(\"10.1126/SCIENCE.169.3946.635\"));\n\njulia> year(doi)\n1970\n\n\n\n\n\n","category":"function"},{"location":"#Taxonomy.journal","page":"Home","title":"Taxonomy.journal","text":"Extract the journal.\n\njulia> doi = MetaData(DOI(\"10.1126/SCIENCE.169.3946.635\"));\n\njulia> journal(doi)\n\"Science\"\n\n\n\n\n\n","category":"function"},{"location":"#Taxonomy.MinimalMeta","page":"Home","title":"Taxonomy.MinimalMeta","text":"A representation of the most important metadata.\n\njulia> min = MetaData(\"Peikert, Aaron\", 2022, \"Journal of Statistical Software\");\n\njulia> typeof(min)\nMinimalMeta\n\n\n\n\n\n","category":"type"},{"location":"#Taxonomy.IncompleteMeta","page":"Home","title":"Taxonomy.IncompleteMeta","text":"A representation of Metadata when we can not even capture the most important metadata.\n\njulia> incomplete = MetaData(missing, 2022, \"Journal of Statistical Software\");\n\njulia> typeof(incomplete)\nIncompleteMeta\n\n\n\n\n\n","category":"type"},{"location":"#Taxonomy.ExtensiveMeta","page":"Home","title":"Taxonomy.ExtensiveMeta","text":"The metadata we can gather from doi.org.\n\njulia> doi = MetaData(DOI(\"10.1126/SCIENCE.169.3946.635\"));\n\njulia> typeof(doi)\nExtensiveMeta\n\n\n\n\n\n","category":"type"},{"location":"#DOI","page":"Home","title":"DOI","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"DOI\nUsualDOI\nUnusualDOI\nNoDOI\nurl\nvalid_doi","category":"page"},{"location":"#Taxonomy.DOI","page":"Home","title":"Taxonomy.DOI","text":"Alias for UsualDOI.\n\n\n\n\n\n","category":"type"},{"location":"#Taxonomy.UsualDOI","page":"Home","title":"Taxonomy.UsualDOI","text":"Construct a validated DOI\n\nMost valid DOIs (not all) can be simply validated via a regular expression.\n\nArguments\n\ndoi::String: a DOI without resolver (e.g. without doi.org), capitalization does not matter\nfallback::String: an optional fallback link where one maybe can find the content in case the doi fails\n\njulia> DOI(\"10.5281/zenodo.6719627\")\nUsualDOI{String, Missing}(\"10.5281/ZENODO.6719627\", missing)\n\njulia> DOI(\"10.5281/zenodo.6719627\", \"https://github.com/StructuralEquationModels/StructuralEquationModels.jl\")\nUsualDOI{String, String}(\"10.5281/ZENODO.6719627\", \"https://github.com/StructuralEquationModels/StructuralEquationModels.jl\")\n\n\n\n\n\n","category":"type"},{"location":"#Taxonomy.UnusualDOI","page":"Home","title":"Taxonomy.UnusualDOI","text":"Construct an unvalidated DOI\n\nYou should prefer an validated UsualDOI but if you have tested the DOI and are sure it links were it supposed to link, go ahead and create an unvalidated doi.\n\njulia> UnusualDOI(\"weird10.5281doi/zenodo.6719627\")\nUnusualDOI{String, Missing}(\"WEIRD10.5281DOI/ZENODO.6719627\", missing)\n\njulia> UnusualDOI(\"weird10.5281doi/zenodo.6719627\", \"https://github.com/StructuralEquationModels/StructuralEquationModels.jl\")\nUnusualDOI{String, String}(\"WEIRD10.5281DOI/ZENODO.6719627\", \"https://github.com/StructuralEquationModels/StructuralEquationModels.jl\")\n\n\n\n\n\n","category":"type"},{"location":"#Taxonomy.NoDOI","page":"Home","title":"Taxonomy.NoDOI","text":"What to do if there is no doi\n\nLast resort if there is no DOI. Than we save other metadata, similar to BibTex.\n\nArguments\n\nurl::String: an link where one maybe can find the content in case the doi fails\nauthor::String: like in BibTex, e.g. \"Peikert, Aaron and Ernst, Maximilian S. and Bode, Clifford\"\ndate::Union{Date, Missing}: optional date\nyear::Union{Int64}: optional if date is supplied\njournal::String: The outlet of the publication\nother::Dict: more BibTexlike metadata\n\nNoDOI(\n    url = \"https://github.com/StructuralEquationModels/StructuralEquationModels.jl\",\n    author = \"Ernst, Maximilian Stefan and Peikert, Aaron\",\n    title = \"StructuralEquationModels.jl: A fast and flexible SEM framework\",\n    date = Date(\"2022-06-24\"), # year is inferred\n    journal = \"No Real Journal\",\n    awesome = \"Yes\", # other metadata\n    software = \"naturally\", # some more metadata\n    citations = 500\n)\nNoDOI(\n    url = \"https://github.com/StructuralEquationModels/StructuralEquationModels.jl\",\n    author = \"Ernst, Maximilian Stefan and Peikert, Aaron\",\n    title = \"StructuralEquationModels.jl: A fast and flexible SEM framework\",\n    year = 2022, # date is omitted\n    journal = \"No Real Journal\"\n)\n\n\n\n\n\n","category":"type"},{"location":"#Taxonomy.url","page":"Home","title":"Taxonomy.url","text":"Get URL from location.\n\njulia> url(DOI(\"10.1126/SCIENCE.169.3946.635\"))\n\"https://doi.org/10.1126/SCIENCE.169.3946.635\"\n\nlocation = NoDOI(\n    url = \"https://github.com/StructuralEquationModels/StructuralEquationModels.jl\",\n    author = \"Ernst, Maximilian Stefan and Peikert, Aaron\",\n    title = \"StructuralEquationModels.jl: A fast and flexible SEM framework\",\n    year = 2022, # date is omitted\n    journal = \"No Real Journal\"\n)\n\nurl(location)\n\n# output\n\n\"https://github.com/StructuralEquationModels/StructuralEquationModels.jl\"\n\n\n\n\n\n","category":"function"},{"location":"#Taxonomy.valid_doi","page":"Home","title":"Taxonomy.valid_doi","text":"Validate DOI via Regex\n\nRegular expression taken from:\n\nhttps://www.crossref.org/blog/dois-and-matching-regular-expressions/\n\n\n\n\n\n","category":"function"}]
}
