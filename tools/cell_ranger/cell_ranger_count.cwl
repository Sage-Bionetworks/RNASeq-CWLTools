class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com'
id: cellr_count
baseCommand: ['cellranger', 'count']
inputs:
  - id: fastq_dir
    type: Directory
  - id: genome_dir
    type: Directory
outputs:
  - id: output
    type: Directory
    outputBinding:
      glob: '*'
label: cellr_count
arguments:
  - position: 0
    prefix: '--id='
    separate: false
    valueFrom: test
  - position: 1
    prefix: '--fastqs='
    separate: false
    valueFrom: $(inputs.fastq_dir)
  - position: 2
    prefix: '--transcriptome='
    separate: false
    valueFrom: $(inputs.genome_dir)
  - position: 3
    prefix: '--chemistry='
    separate: false
    valueFrom: threeprime
requirements:
  - class: DockerRequirement
    dockerPull: sagebionetworks/cellranger
  - class: InlineJavascriptRequirement

