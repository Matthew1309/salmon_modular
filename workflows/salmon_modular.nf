#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

/*
 ========================================================================================
IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/
include { SALMON_INDEX } from '../modules/local/modules/salmon/index/main'
include { SALMON_QUANT } from '../modules/local/modules/salmon/quant/main'

workflow SALMON {
	take:
		reads1
		reads2
		transcriptome

	main:
		SALMON_INDEX ( transcriptome )
		SALMON_QUANT ( SALMON_INDEX.out.first(), reads1, reads2 )
		println('hello')

	emit: SALMON_QUANT.out

}
