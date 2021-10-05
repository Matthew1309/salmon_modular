process SALMON_INDEX {
  publishDir params.results, mode:'copy'
  
  container "quay.io/biocontainers/salmon:1.5.2--h84f40af_0"

  input:
  file ref_trans

  output:
  file "${ref_trans.getSimpleName()}_index"

  script:
  """
  salmon index \\
  -t "${ref_trans}" \\
  -i "${ref_trans.getSimpleName()}_index"
  """
}
