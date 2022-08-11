# Taxonomy

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://StructuralEquationModels.github.io/Taxonomy.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://StructuralEquationModels.github.io/Taxonomy.jl/dev/)
[![Build Status](https://github.com/StructuralEquationModels/Taxonomy.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/StructuralEquationModels/Taxonomy.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/StructuralEquationModels/Taxonomy.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/StructuralEquationModels/Taxonomy.jl)

`Taxonomy.jl` is an internal package for the "Formal Methods of Lifespan Psycholocy" Group at MPI for Human Development.
It aims to ease the coding of SEMs found in the literature:

```julia
import Pkg
Pkg.add(url = "https://github.com/StructuralEquationModels/Taxonomy.jl")
using Taxonomy
Record(location = DOI("10.2307/2095172"),
    taxons = [GFactor(nobserved = 6, nerror_covariances = 3)],
    spec = true,
    data = true
)
```
