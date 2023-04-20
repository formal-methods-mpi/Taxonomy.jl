```@meta
CurrentModule = Taxonomy
```

# Taxonomy

`Taxonomy.jl` is work in progress but here is our vision about what it is supposed to do when finished:

## What?

Taxonomy.jl aims to serve as a comprehensive database of structural equation models (SEMs) that can be used to infer distributions of both structures and parameters.
This will greatly facilitate simulation studies that accurately reflect real-world conditions.
Additionally, Taxonomy.jl will provide a user-friendly interface for researchers to easily sample these parameters for use in their own simulation studies.

### End product

A Julia package that enables filtering a taxonomy database and construct samplers for structure and parameters.
These samplers can quickly be turned into models for [StructuralEquationModels.jl](github.com/StructuralEquationModels/StructuralEquationModels.jl).


## So what?

Simulations are only in so far helpful as they reflect some (simplified) aspect of reality.
A simulation that is only based on the guess of the researchers conducting it is prone to fail to represent realistic conditions and may even favour the procedures that are investigated unduly.
Being able to base simulations on a sample of the literature strengtens the inference and practical impact of simulation studies.

### Impact on scientific community

The Julia package will provide an according database and interface, and therefore lower the threshold for the conduction of (better) simulation studies. 
By this, it may enable more general claims and facilitate preregistration of simulations.
Furthermore, Bayesian methodology has highlighted the importance of incorporating prior knowledge in the form of prior distributions.
Taxonomy.jl seeks to make this process more transparent and accessible for researchers and consumers of science, which can greatly facilitate cumulative science.
Besides enabling better simulations, knowing what types of SEMs are how common may greatly help guiding the development of new methodolgies.

## Index

```@index
```

## Taxons

```@docs
Taxon
Factor
CFA
```

## Extractors

```@docs
n_sample
```

## ID

```@docs
generate_id
```

### Judgement

```@docs
Judgement
J
NoJudgement
rating
location(::Judgement)
certainty
```
## Metadata

```@docs
MetaData
apa
json
author
year
journal
MinimalMeta
IncompleteMeta
ExtensiveMeta
```

### DOI

```@docs
DOI
UsualDOI
UnusualDOI
NoDOI
NoLocation
url
valid_doi
```
