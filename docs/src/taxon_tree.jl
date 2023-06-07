"""
This prints a tree displaying the type strucuture of Taxon. 

using GraphRecipes, Plots, Taxonomy, AbstractTrees
AbstractTrees.children(d::DataType) = subtypes(d)
print_tree(Taxonomy.Taxon)

# output 
Taxon
├─ AbstractCFA
│  └─ Measurement
├─ AbstractCLPM
├─ AbstractLGCM
│  └─ SimpleLGCM
├─ AbstractPathmodel
│  └─ Structural
└─ NoAbstractTaxon
   └─ NoTaxon
"""