% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MegaLMM_functions.R
\name{get_posterior_FUN}
\alias{get_posterior_FUN}
\title{Calculates the posterior mean of a function of parameters}
\usage{
get_posterior_FUN(MegaLMM_state, FUN, samples = NULL, mc.cores = 1)
}
\arguments{
\item{MegaLMM_state}{A MegaLMM_state object including a re-loaded Posterior list}

\item{FUN}{Operations to be applied to each posterior sample. Write as if this were operating
within current_state. Can use priors, data_matrices, and other elements of current_state}

\item{samples}{(optional) vector of sample indexes to use in the computation}

\item{mc.cores}{(optional) number of cores to use for computations. See note about memory requirements.}
}
\value{
array of n_samples x dim1 x dim2 where dim1 and dim2 are the dimensions of the calculated
    parameter per posterior sample
}
\description{
This function will apply the supplied function to each posterior sample of the chain. Variables
   referenced in FUN will be selected from the following search locations (in this order):
   1) Posterior$posteriorSample_params
   2) data_matrices
   3) priors
   4) Posterior$posteriorMean_params
   5) current_state
   6) calling environment (ex. sapply)
   7) global environment
}
\details{
If mc.cores > 1, the operation will be parallelized. To reduce memory requirements,
if mc.cores > 1, a PSOCK cluster is created. This cluster only copyies in data when it
is actually used. The code is written so that only necessary objects are used by this cluster,
not the whole user's environment. Inside this cluster, mclapply is run, which forks the process inside the PSOCK
cluster. Creating the cluster takes some time, so often mc.cores=1 is faster. If the operation
is large and Posterior has many samples, this can still create memory issues, so limiting mc.cores
might still be necessary
}
