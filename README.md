<h1> 
Centralized provisioning of 
large language models
at the CHPC
</h1>

This repository provides instructions, scripts, and example notebooks 
supporting setup and use of centralized LLMs at the CHPC.

## Models location

Select models are cloned from Huggingface at `/scratch/general/vast/app-repo/huggingface`. See the [Generative AI][genai] help page on what models are available.

## Interacting with the provided models

Users are welcome to access the models from their self-installed AI frameworks. 
Alternatively, we provide a sample recipe for a container with PyTorch and
Huggingface libraries and a Jupyter notebook which uses this container environment
to access the models.

[genai]: https://www.chpc.utah.edu/documentation/software/genai.php

