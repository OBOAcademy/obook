# Using OntoGPT to boost ontology curation

OntoGPT is a Python package for extracting structured information from text with large language models (LLMs), instruction prompts, and ontology-based grounding.
Two different strategies for knowledge extraction are currently implemented in OntoGPT:
- SPIRES: A Zero-shot learning (ZSL) approach to extracting nested semantic structures from text
- TALISMAN (previously known as SPINDOCTOR): Summarizes gene set descriptions (pseudo gene-set enrichment)

More info about OntoGPT:
- Documentation: <https://monarch-initiative.github.io/ontogpt/>
- Source: <https://github.com/monarch-initiative/ontogpt>
- Preprints:
  - Caufield JH, Hegde H, Emonet V, Harris NL, Joachimiak MP, Matentzoglu N, et al. Structured prompt interrogation and recursive extraction of semantics (SPIRES): A method for populating knowledge bases using zero-shot learning. <http://arxiv.org/abs/2304.02711>
  - Joachimiak MP, Caufield JH, Harris NL, Kim H, Mungall CJ. Gene Set Summarization using Large Language Models. <http://arxiv.org/abs/2305.13338>

We are also working on a curation-specific tool, [CurateGPT](https://github.com/monarch-initiative/curate-gpt),
a prototype web application and framework for performing general purpose AI-guided curation and curation-related operations over collections of objects.
