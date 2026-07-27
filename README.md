# Awesome Vision-Language Models

[![Awesome](https://awesome.re/badge.svg)](https://awesome.re)
![Update](https://img.shields.io/github/last-commit/whut09/Awesome-vision-language-model)

A curated list of peer-reviewed vision-language model (VLM) papers from major
conferences, covering vision-language pre-training, multimodal large language
models, visual grounding, video-language understanding, and evaluation.

## Table of Contents

- [Paper List](#paper-list)
  - [Vision-Language Pre-training](#vision-language-pre-training)
  - [Multimodal Large Language Models](#multimodal-large-language-models)
  - [Grounding, Region, and Pixel Understanding](#grounding-region-and-pixel-understanding)
  - [Video-Language Models](#video-language-models)
  - [Evaluation and Reliability](#evaluation-and-reliability)
- [Contributing](#contributing)
- [License](#license)

## Paper List

The list focuses on papers published at CVPR, ICCV, ECCV, NeurIPS, ICLR, ICML,
ACL, EMNLP, and AAAI. Preprint links are used when they are the most stable
public version of an accepted paper.

<!-- PAPER_TABLES:START -->
### Vision-Language Pre-training
| Year | Pub | Title | Links | Main Institution |
|:---:|:---:|:---|:---:|:---:|
| 2023 | ICLR | **VLMo: Unified Vision-Language Pre-Training With Mixture-of-Modality-Experts** | [[paper](https://arxiv.org/abs/2111.02358)] [[code](https://github.com/microsoft/unilm/tree/master/vlmo)] | Microsoft Research Asia |
| 2023 | ICLR | **Image as a Foreign Language: BEiT Pretraining for All Vision and Vision-Language Tasks** | [[paper](https://arxiv.org/abs/2208.10442)] [[code](https://github.com/microsoft/unilm/tree/master/beit3)] | Microsoft Research Asia |
| 2023 | ICLR | **PaLI: A Jointly-Scaled Multilingual Language-Image Model** | [[paper](https://arxiv.org/abs/2209.06794)] | Google Research |
| 2022 | CVPR | **An Empirical Study of Training End-to-End Vision-and-Language Transformers** | [[paper](https://arxiv.org/abs/2111.02387)] [[code](https://github.com/zdou0830/METER)] | University of California, Los Angeles |
| 2022 | ICLR | **SimVLM: Simple Visual Language Model Pretraining With Weak Supervision** | [[paper](https://arxiv.org/abs/2108.10904)] | Google Research |
| 2022 | ICML | **BLIP: Bootstrapping Language-Image Pre-training for Unified Vision-Language Understanding and Generation** | [[paper](https://arxiv.org/abs/2201.12086)] [[code](https://github.com/salesforce/BLIP)] | Salesforce Research |
| 2022 | ICML | **OFA: Unifying Architectures, Tasks, and Modalities Through a Simple Sequence-to-Sequence Learning Framework** | [[paper](https://arxiv.org/abs/2202.03052)] [[code](https://github.com/OFA-Sys/OFA)] | Microsoft Research Asia |
| 2021 | NeurIPS | **Align Before Fuse: Vision and Language Representation Learning With Momentum Distillation** | [[paper](https://arxiv.org/abs/2107.07651)] [[code](https://github.com/salesforce/ALBEF)] | Salesforce Research |
| 2021 | ICML | **Scaling Up Visual and Vision-Language Representation Learning With Noisy Text Supervision** | [[paper](https://arxiv.org/abs/2102.05918)] | Google Research |
| 2021 | CVPR | **VinVL: Revisiting Visual Representations in Vision-Language Models** | [[paper](https://arxiv.org/abs/2101.00529)] [[code](https://github.com/microsoft/scene_graph_benchmark)] | Microsoft Research |
| 2021 | AAAI | **ERNIE-ViL: Knowledge Enhanced Vision-Language Representations Through Scene Graph** | [[paper](https://arxiv.org/abs/2006.16934)] [[code](https://github.com/PaddlePaddle/ERNIE)] | Baidu |
| 2021 | ICML | **Learning Transferable Visual Models From Natural Language Supervision** | [[paper](https://arxiv.org/abs/2103.00020)] [[code](https://github.com/openai/CLIP)] | OpenAI |
| 2021 | ICML | **ViLT: Vision-and-Language Transformer Without Convolution or Region Supervision** | [[paper](https://arxiv.org/abs/2102.03334)] [[code](https://github.com/dandelin/ViLT)] | NAVER AI Lab |
| 2020 | ECCV | **UNITER: UNiversal Image-TExt Representation Learning** | [[paper](https://arxiv.org/abs/1909.11740)] [[code](https://github.com/ChenRocks/UNITER)] | Microsoft Research |
| 2020 | ECCV | **Oscar: Object-Semantics Aligned Pre-training for Vision-Language Tasks** | [[paper](https://arxiv.org/abs/2004.06165)] [[code](https://github.com/microsoft/Oscar)] | Microsoft Research |
| 2019 | NeurIPS | **ViLBERT: Pretraining Task-Agnostic Visiolinguistic Representations for Vision-and-Language Tasks** | [[paper](https://arxiv.org/abs/1908.02265)] [[code](https://github.com/facebookresearch/vilbert-multi-task)] | Facebook AI Research |
| 2019 | EMNLP | **LXMERT: Learning Cross-Modality Encoder Representations from Transformers** | [[paper](https://arxiv.org/abs/1908.07490)] [[code](https://github.com/airsplay/lxmert)] | UNC Chapel Hill |

### Multimodal Large Language Models
| Year | Pub | Title | Links | Main Institution |
|:---:|:---:|:---|:---:|:---:|
| 2026 | CVPR | **VisMem: Latent Vision Memory Unlocks Potential of Vision-Language Models** | [[paper](https://openaccess.thecvf.com/content/CVPR2026/html/Yu_VisMem_Latent_Vision_Memory_Unlocks_Potential_of_Vision-Language_Models_CVPR_2026_paper.html)] | See paper |
| 2026 | CVPR | **Think-as-You-See: Streaming Chain-of-Thought Reasoning for Large Vision-Language Models** | [[paper](https://openaccess.thecvf.com/content/CVPR2026/html/Zhang_Think-as-You-See_Streaming_Chain-of-Thought_Reasoning_for_Large_Vision-Language_Models_CVPR_2026_paper.html)] | See paper |
| 2026 | CVPR | **TTRV: Test-Time Reinforcement Learning for Vision Language Models** | [[paper](https://openaccess.thecvf.com/content/CVPR2026/html/Singh_TTRV_Test-Time_Reinforcement_Learning_for_Vision_Language_Models_CVPR_2026_paper.html)] | See paper |
| 2026 | CVPR | **Molmo2: Open Weights and Data for Vision-Language Models with Video Understanding and Grounding** | [[paper](https://openaccess.thecvf.com/content/CVPR2026/html/Clark_Molmo2_Open_Weights_and_Data_for_Vision-Language_Models_with_Video_CVPR_2026_paper.html)] | See paper |
| 2026 | CVPR | **STAR-R1: Multi-View Spatial TrAnsformation Reasoning by Reinforcing Multimodal LLMs** | [[paper](https://openaccess.thecvf.com/content/CVPR2026/html/Li_STAR-R1_Multi-View_Spatial_TrAnsformation_Reasoning_by_Reinforcing_Multimodal_LLMs_CVPR_2026_paper.html)] | See paper |
| 2025 | CVPR | **Mono-InternVL: Pushing the Boundaries of Monolithic Multimodal Large Language Models with Endogenous Visual Pre-training** | [[paper](https://openaccess.thecvf.com/content/CVPR2025/html/Luo_Mono-InternVL_Pushing_the_Boundaries_of_Monolithic_Multimodal_Large_Language_Models_CVPR_2025_paper.html)] | See paper |
| 2025 | CVPR | **HoVLE: Unleashing the Power of Monolithic Vision-Language Models with Holistic Vision-Language Embedding** | [[paper](https://openaccess.thecvf.com/content/CVPR2025/html/Tao_HoVLE_Unleashing_the_Power_of_Monolithic_Vision-Language_Models_with_Holistic_CVPR_2025_paper.html)] | See paper |
| 2025 | CVPR | **FastVLM: Efficient Vision Encoding for Vision Language Models** | [[paper](https://openaccess.thecvf.com/content/CVPR2025/html/Vasu_FastVLM_Efficient_Vision_Encoding_for_Vision_Language_Models_CVPR_2025_paper.html)] | See paper |
| 2025 | CVPR | **NVILA: Efficient Frontier Visual Language Models** | [[paper](https://openaccess.thecvf.com/content/CVPR2025/html/Liu_NVILA_Efficient_Frontier_Visual_Language_Models_CVPR_2025_paper.html)] | See paper |
| 2025 | NeurIPS | **VITA-1.5: Towards GPT-4o Level Real-Time Vision and Speech Interaction** | [[paper](https://arxiv.org/abs/2501.01957)] [[code](https://github.com/VITA-MLLM/VITA)] | Nanjing University |
| 2025 | NeurIPS | **VITA-Audio: Fast Interleaved Cross-Modal Token Generation for Efficient Large Speech-Language Model** | [[paper](https://arxiv.org/abs/2505.03739)] [[code](https://github.com/VITA-MLLM/VITA-Audio)] | Nanjing University |
| 2025 | CVPR | **Florence-VL: Enhancing Vision-Language Models with Generative Vision Encoder and Depth-Breadth Fusion** | [[paper](https://openaccess.thecvf.com/content/CVPR2025/html/Chen_Florence-VL_Enhancing_Vision-Language_Models_with_Generative_Vision_Encoder_and_Depth-Breadth_CVPR_2025_paper.html)] | See paper |
| 2024 | ICLR | **mPLUG-Owl: Modularization Empowers Large Language Models With Multimodality** | [[paper](https://arxiv.org/abs/2304.14178)] [[code](https://github.com/X-PLUG/mPLUG-Owl)] | DAMO Academy |
| 2024 | ACL | **Qwen-VL: A Versatile Vision-Language Model for Understanding, Localization, Text Reading, and Beyond** | [[paper](https://arxiv.org/abs/2308.12966)] [[code](https://github.com/QwenLM/Qwen-VL)] | Alibaba Cloud |
| 2024 | ICLR | **CogVLM: Visual Expert for Pretrained Language Models** | [[paper](https://arxiv.org/abs/2311.03079)] [[code](https://github.com/THUDM/CogVLM)] | Tsinghua University |
| 2024 | ICLR | **KOSMOS-2: Grounding Multimodal Large Language Models to the World** | [[paper](https://arxiv.org/abs/2306.14824)] [[code](https://github.com/microsoft/unilm/tree/master/kosmos-2)] | Microsoft Research |
| 2024 | CVPR | **InternVL: Scaling up Vision Foundation Models and Aligning for Generic Visual-Linguistic Tasks** | [[paper](https://arxiv.org/abs/2312.14238)] [[code](https://github.com/OpenGVLab/InternVL)] | Shanghai AI Laboratory |
| 2023 | NeurIPS | **Visual Instruction Tuning** | [[paper](https://arxiv.org/abs/2304.08485)] [[code](https://github.com/haotian-liu/LLaVA)] | University of Wisconsin-Madison |
| 2023 | ICML | **BLIP-2: Bootstrapping Language-Image Pre-training With Frozen Image Encoders and Large Language Models** | [[paper](https://arxiv.org/abs/2301.12597)] [[code](https://github.com/salesforce/LAVIS)] | Salesforce Research |
| 2023 | NeurIPS | **InstructBLIP: Towards General-purpose Vision-Language Models With Instruction Tuning** | [[paper](https://arxiv.org/abs/2305.06500)] [[code](https://github.com/salesforce/LAVIS)] | Salesforce Research |
| 2022 | NeurIPS | **Flamingo: A Visual Language Model for Few-Shot Learning** | [[paper](https://arxiv.org/abs/2204.14198)] | DeepMind |

### Grounding, Region, and Pixel Understanding
| Year | Pub | Title | Links | Main Institution |
|:---:|:---:|:---|:---:|:---:|
| 2026 | CVPR | **Grounding Everything in Tokens for Multimodal Large Language Models** | [[paper](https://openaccess.thecvf.com/content/CVPR2026/html/Ren_Grounding_Everything_in_Tokens_for_Multimodal_Large_Language_Models_CVPR_2026_paper.html)] | See paper |
| 2024 | ICLR | **Ferret: Refer and Ground Anything Anywhere at Any Granularity** | [[paper](https://arxiv.org/abs/2310.07704)] [[code](https://github.com/apple/ml-ferret)] | Apple |
| 2024 | CVPR | **GLaMM: Pixel Grounding Large Multimodal Model** | [[paper](https://arxiv.org/abs/2311.03356)] [[code](https://github.com/mbzuai-oryx/groundingLMM)] | MBZUAI |
| 2024 | CVPR | **LISA: Reasoning Segmentation via Large Language Model** | [[paper](https://arxiv.org/abs/2308.00692)] [[code](https://github.com/dvlab-research/LISA)] | The Chinese University of Hong Kong |
| 2023 | CVPR | **Generalized Decoding for Pixel, Image, and Language** | [[paper](https://arxiv.org/abs/2212.11270)] [[code](https://github.com/microsoft/X-Decoder)] | Microsoft Research |
| 2023 | ICCV | **Grounding DINO: Marrying DINO With Grounded Pre-Training for Open-Set Object Detection** | [[paper](https://arxiv.org/abs/2303.05499)] [[code](https://github.com/IDEA-Research/GroundingDINO)] | IDEA Research |
| 2022 | CVPR | **Grounded Language-Image Pre-training** | [[paper](https://arxiv.org/abs/2112.03857)] [[code](https://github.com/microsoft/GLIP)] | Microsoft Research |
| 2022 | CVPR | **RegionCLIP: Region-based Language-Image Pretraining** | [[paper](https://arxiv.org/abs/2112.09106)] [[code](https://github.com/microsoft/RegionCLIP)] | Microsoft Research |

### Video-Language Models
| Year | Pub | Title | Links | Main Institution |
|:---:|:---:|:---|:---:|:---:|
| 2026 | CVPR | **Scaling the Long Video Understanding of Multimodal Large Language Models via Visual Memory Mechanism** | [[paper](https://openaccess.thecvf.com/content/CVPR2026/html/Chen_Scaling_the_Long_Video_Understanding_of_Multimodal_Large_Language_Models_CVPR_2026_paper.html)] | See paper |
| 2026 | CVPR | **Thinking in Dynamics: How Multimodal Large Language Models Perceive, Track, and Reason Dynamics in Physical 4D World** | [[paper](https://openaccess.thecvf.com/content/CVPR2026/html/Huang_Thinking_in_Dynamics_How_Multimodal_Large_Language_Models_Perceive_Track_CVPR_2026_paper.html)] | See paper |
| 2026 | CVPR | **TimeViper: A Hybrid Mamba-Transformer Vision-Language Model for Efficient Long Video Understanding** | [[paper](https://openaccess.thecvf.com/content/CVPR2026/html/Xu_TimeViper_A_Hybrid_Mamba-Transformer_Vision-Language_Model_for_Efficient_Long_Video_CVPR_2026_paper.html)] | See paper |
| 2026 | CVPR | **Scene-VLM: Multimodal Video Scene Segmentation via Vision-Language Models** | [[paper](https://openaccess.thecvf.com/content/CVPR2026/html/Berman_Scene-VLM_Multimodal_Video_Scene_Segmentation_via_Vision-Language_Models_CVPR_2026_paper.html)] | See paper |
| 2025 | CVPR | **Video-XL: Extra-Long Vision Language Model for Hour-Scale Video Understanding** | [[paper](https://openaccess.thecvf.com/content/CVPR2025/html/Shu_Video-XL_Extra-Long_Vision_Language_Model_for_Hour-Scale_Video_Understanding_CVPR_2025_paper.html)] | See paper |
| 2025 | CVPR | **LLaVA-ST: A Multimodal Large Language Model for Fine-Grained Spatial-Temporal Understanding** | [[paper](https://openaccess.thecvf.com/content/CVPR2025/html/Li_LLaVA-ST_A_Multimodal_Large_Language_Model_for_Fine-Grained_Spatial-Temporal_Understanding_CVPR_2025_paper.html)] | See paper |
| 2024 | ACL | **VideoChatGPT: Towards Detailed Video Understanding via Large Vision and Language Models** | [[paper](https://arxiv.org/abs/2306.05424)] [[code](https://github.com/mbzuai-oryx/Video-ChatGPT)] | MBZUAI |
| 2024 | CVPR | **MovieChat: From Dense Token to Sparse Memory for Long Video Understanding** | [[paper](https://arxiv.org/abs/2307.16449)] [[code](https://github.com/rese1f/MovieChat)] | Shanghai Jiao Tong University |
| 2024 | ECCV | **LLaMA-VID: An Image is Worth 2 Tokens in Large Language Models** | [[paper](https://arxiv.org/abs/2311.17043)] [[code](https://github.com/dvlab-research/LLaMA-VID)] | The Chinese University of Hong Kong |
| 2023 | EMNLP | **Video-LLaVA: Learning United Visual Representation by Alignment Before Projection** | [[paper](https://arxiv.org/abs/2311.10122)] [[code](https://github.com/PKU-YuanGroup/Video-LLaVA)] | Peking University |
| 2021 | ICCV | **Frozen in Time: A Joint Video and Image Encoder for End-to-End Retrieval** | [[paper](https://arxiv.org/abs/2104.00650)] [[code](https://github.com/m-bain/frozen-in-time)] | University of Bath |
| 2021 | NeurIPS | **VIOLET: End-to-End Video-Language Transformers With Masked Visual-token Modeling** | [[paper](https://arxiv.org/abs/2111.12681)] [[code](https://github.com/tsujuifu/pytorch_violet)] | Microsoft Research Asia |
| 2021 | EMNLP | **VideoCLIP: Contrastive Pre-training for Zero-shot Video-Text Understanding** | [[paper](https://arxiv.org/abs/2109.14084)] [[code](https://github.com/pytorch/fairseq/tree/main/examples/MMPT)] | Facebook AI Research |

### Evaluation and Reliability
| Year | Pub | Title | Links | Main Institution |
|:---:|:---:|:---|:---:|:---:|
| 2026 | CVPR | **VL-RouterBench: A Benchmark for Vision-Language Model Routing** | [[paper](https://openaccess.thecvf.com/content/CVPR2026/html/Huang_VL-RouterBench_A_Benchmark_for_Vision-Language_Model_Routing_CVPR_2026_paper.html)] | See paper |
| 2026 | CVPR | **Flat-Pack Bench: Evaluating Spatio-Temporal Understanding in Large Vision-Language Models through Furniture Assembly** | [[paper](https://openaccess.thecvf.com/content/CVPR2026/html/Chetan_Flat-Pack_Bench_Evaluating_Spatio-Temporal_Understanding_in_Large_Vision-Language_Models_through_CVPR_2026_paper.html)] | See paper |
| 2026 | CVPR | **ENC-Bench: A Benchmark for Evaluating Multimodal Large Language Models in Electronic Navigational Chart Understanding** | [[paper](https://openaccess.thecvf.com/content/CVPR2026/html/Cheng_ENC-Bench_A_Benchmark_for_Evaluating_Multimodal_Large_Language_Models_in_CVPR_2026_paper.html)] | See paper |
| 2025 | CVPR | **Video-MME: The First-Ever Comprehensive Evaluation Benchmark of Multi-modal LLMs in Video Analysis** | [[paper](https://openaccess.thecvf.com/content/CVPR2025/html/Fu_Video-MME_The_First-Ever_Comprehensive_Evaluation_Benchmark_of_Multi-modal_LLMs_in_CVPR_2025_paper.html)] | See paper |
| 2024 | CVPR | **HallusionBench: An Advanced Diagnostic Suite for Entangled Language Hallucination and Visual Illusion in Large Vision-Language Models** | [[paper](https://arxiv.org/abs/2310.14566)] [[code](https://github.com/tianyi-lab/HallusionBench)] | Tianjin University |
| 2024 | CVPR | **MMMU: A Massive Multi-discipline Multimodal Understanding and Reasoning Benchmark for Expert AGI** | [[paper](https://arxiv.org/abs/2311.16502)] [[code](https://github.com/MMMU-Benchmark/MMMU)] | University of Hong Kong |
| 2024 | ICML | **MM-Vet: Evaluating Large Multimodal Models for Integrated Capabilities** | [[paper](https://arxiv.org/abs/2308.02490)] [[code](https://github.com/yuweihao/MM-Vet)] | University of California, Los Angeles |
| 2024 | ECCV | **MMBench: Is Your Multi-modal Model an All-around Player?** | [[paper](https://arxiv.org/abs/2307.06281)] [[code](https://github.com/open-compass/MMBench)] | Shanghai AI Laboratory |
| 2024 | ICLR | **Evaluating Object Hallucination in Large Vision-Language Models** | [[paper](https://arxiv.org/abs/2305.10355)] [[code](https://github.com/AoiDragon/POPE)] | Shanghai AI Laboratory |
| 2024 | ICLR | **MathVista: Evaluating Mathematical Reasoning of Foundation Models in Visual Contexts** | [[paper](https://arxiv.org/abs/2310.02255)] [[code](https://github.com/lupantech/MathVista)] | UCLA |
| 2024 | CVPR | **SEED-Bench: Benchmarking Multimodal LLMs With Generative Comprehension** | [[paper](https://arxiv.org/abs/2307.16125)] [[code](https://github.com/AILab-CVC/SEED-Bench)] | Tencent AI Lab |
| 2023 | ICLR | **Winoground: Probing Vision and Language Models for Visio-Linguistic Compositionality** | [[paper](https://arxiv.org/abs/2204.03162)] | AI2 |
<!-- PAPER_TABLES:END -->

## Contributing

Welcome to contribute! Please open a Pull Request or Issue for a missing
peer-reviewed VLM paper or an incorrect entry.

1. Follow the exact format of the existing table entries.
2. Include the original publication venue and year; this list targets major conferences.
3. Ensure the `[paper]` link works. Add a `[code]` link when an official implementation is available.
4. Keep entries within the most specific applicable section and avoid duplicates.

## License

Released under the [MIT License](LICENSE).
