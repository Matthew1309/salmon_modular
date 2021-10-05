#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

/*
==================================================
	DEFINE CHANNELS
==================================================
*/
reads1 = Channel.fromPath(params.fastq_reads_1)
reads2 = Channel.fromPath(params.fastq_reads_2)
transcriptome = Channel.fromPath(params.ref_transcriptome)

reads1.view()
/*
==================================================
	INCLUDE WORKFLOWS
==================================================
*/

// Performs quantification of reads without alignment
include { SALMON } from './workflows/salmon_modular.nf'

//
// WORKFLOW: Run main salmon analysis pipeline
//
workflow PERFORM_SALMON {
	SALMON(reads1, reads2, transcriptome)
}

//
// WORKFLOW: Main workflow that actually runs everything (they do this because of some sort of issue
//
workflow {
	PERFORM_SALMON()
}
