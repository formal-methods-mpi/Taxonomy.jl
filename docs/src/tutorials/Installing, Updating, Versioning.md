# Tutorial: Installing, Updating, and Versioning Taxonomy.jl

This tutorial provides a detailed guide on installing the Taxonomy.jl package, 
obtaining a specific version of the package by using a commit hash, and implementing bug fixes through branching. Additionally,
we will also discuss the role of `Manifest.toml` and `Project.toml` files in package versioning.

## Installing the Newest Version of the Package

To install the newest version of Taxonomy.jl, you can use Julia's package manager. Open the Julia REPL and run the following commands:

```julia
import Pkg
using Pkg
Pkg.add(url = "https://github.com/formal-methods-mpi/Taxonomy.jl")
```

## Using Pkg.instantiate to Set Up the Environment

When working with Julia packages, it is often important to ensure that your environment is consistent with the project's specifications. This is particularly crucial when you are working on a project that has a specific set of dependencies. The `Pkg.instantiate()` command helps in setting up such an environment.

Use the following command in Julia to instantiate the environment:

```julia
using Pkg
Pkg.instantiate()
```
In short:`Pkg.instantiate()` installs the dependencies that are specified in the `Project.toml` and `Manifest.toml` files of a project.

## Installing the Version of One Commit in the Package's History
If you want to install a specific version of Taxonomy.jl corresponding to a particular commit, you can do so by specifying the commit hash. 
To find the commit hash, go to the [Taxonomy.jl GitHub repository](https://github.com/formal-methods-mpi/Taxonomy.jl), click on the commit, and copy the hash.

Use the following command to add the package based on the commit hash:

```julia
Pkg.add(url="https://github.com/formal-methods-mpi/Taxonomy.jl", rev="commit_hash_here")
```
Replace `commit_hash_here` with the actual hash of the commit you are interested in.

## Implementing Bug Fixes by Branching from the Main Branch
If you need to implement bug fixes, you can create a new branch from the main branch of the repository, 
make your changes, and install the package from that branch.

1. Fork the Taxonomy.jl repository to your account.
2. Clone the repository to your local machine.
3. Create a new branch: `git checkout -b bugfix_branch`.
4. Make your changes and commit them.
5. Push the branch to your GitHub repository: `git push origin bugfix_branch`.
6. To install this branch as your version of the package, use:

```julia
Pkg.add(url="https://github.com/your_username/Taxonomy.jl", rev="bugfix_branch")
```
Replace `your_username` with your GitHub username.

## Relating to Manifest.toml and Project.toml

**Project.toml**: This file contains metadata about the package, including its name, version, dependencies, and compatibility constraints. 
When you specify a version or branch, Julia uses the information in `Project.toml` to resolve dependencies.

**Manifest.toml**: This file contains the exact versions of the dependencies that your package used. 
It enables reproducible environments by pinning each dependency to a specific version.

When you install a package, Julia uses the `Project.toml` to determine which versions of the dependencies are compatible. 
It then generates or updates a `Manifest.toml` with the specific versions that were installed. 
This is crucial for ensuring that your environment is reproducible and that the package will work with the set of dependencies specified in the `Manifest.toml`.
`Pkg.instantiate()` will take the `Manifest.toml` and ensures that exactly these versions are installed.
