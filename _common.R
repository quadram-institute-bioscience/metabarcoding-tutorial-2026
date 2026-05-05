# Shared setup — sourced silently at the top of every chapter.
# Each chapter renders in its own R session, so paths and file vectors
# must be re-established here rather than carried over from a previous chapter.

suppressPackageStartupMessages({
  library(dada2)
  library(tidyverse)
  library(phyloseq)
})

path_reads    <- "../reads/"
path_silva    <- "../db/silva_nr_v138_train_set.fa.gz"
path_filtered <- "filtered"
path_precomp  <- "precomputed"

dir.create(path_filtered, showWarnings = FALSE)
dir.create(path_precomp,  showWarnings = FALSE)

fnFs <- sort(list.files(path_reads, pattern = "_R1.fastq.gz", full.names = TRUE))
fnRs <- sort(list.files(path_reads, pattern = "_R2.fastq.gz", full.names = TRUE))
sample.names <- sub("_R1\\.fastq\\.gz$", "", basename(fnFs))

filtFs <- file.path(path_filtered, paste0(sample.names, "_F_filt.fastq.gz"))
filtRs <- file.path(path_filtered, paste0(sample.names, "_R_filt.fastq.gz"))
names(filtFs) <- sample.names
names(filtRs) <- sample.names

# After Chapter 02 has run, restrict to samples that produced output files.
exists_both <- file.exists(filtFs) & file.exists(filtRs)
if (any(exists_both)) {
  filtFs       <- filtFs[exists_both]
  filtRs       <- filtRs[exists_both]
  sample.names <- names(filtFs)
}
