process SALMON_QUANT {
  publishDir params.results, mode:'copy'

  container "quay.io/biocontainers/salmon:1.5.2--h84f40af_0"

  input:
  file read1
  file read2
  file index_trans

  output:
  file "quants/${read1.baseName.split('_')[0]}_quant"

  script:
  def cores = task.cpus ? "-p ${task.cpus}" : ""
  """
  salmon quant \\
  -i "${index_trans}" \\
  -l A \\
  -1 "${read1}" \\
  -2 "${read2}" \\
  "${cores}" \\
  --validateMappings \\
  -o "quants/${read1.baseName.split('_')[0]}_quant"
  """
}
