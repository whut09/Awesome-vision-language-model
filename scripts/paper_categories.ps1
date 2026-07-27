$PaperSections = @(
    'Multimodal Architecture and Training',
    'Pre-training, Alignment, and Adaptation',
    'Reasoning, Inference, and Test-Time Scaling',
    'Efficient VLMs and Deployment',
    'Grounding, Spatial, and Pixel Understanding',
    'Video, Temporal, and 4D Understanding',
    'Hallucination Mitigation and Faithfulness',
    'Safety, Security, Privacy, and Robustness',
    'Evaluation and Benchmarks',
    'Domain-Specific VLMs and Applications'
)

function Get-PaperSection {
    param([string]$Title)

    if ($Title -match '(?i)hallucin|faithful|semantic grounding errors') { return 'Hallucination Mitigation and Faithfulness' }
    if ($Title -match '(?i)safety|jailbreak|adversarial|backdoor|privacy|security|copyright|watermark|robust|bias|unlearn|calibrat') { return 'Safety, Security, Privacy, and Robustness' }
    if ($Title -match '(?i)benchmark|evaluat|probing|assess|diagnos|measure|judge|leaderboard') { return 'Evaluation and Benchmarks' }
    if ($Title -match '(?i)video|temporal|streaming|motion|spatio-temporal|4D|scene segmentation') { return 'Video, Temporal, and 4D Understanding' }
    if ($Title -match '(?i)ground|segmentation|detection|locali[sz]|spatial|3D|point cloud|depth|pixel|region|referring|OCR|layout|geometric') { return 'Grounding, Spatial, and Pixel Understanding' }
    if ($Title -match '(?i)token pruning|token compression|token reduction|token merging|quantiz|accelerat|efficient|lightweight|distill|deployment|serving|memory-efficient|\bedge\b|\bfast\b|speed') { return 'Efficient VLMs and Deployment' }
    if ($Title -match '(?i)reason|inference|test[- ]time|chain[- ]of[- ]thought|\bCoT\b|reward|GRPO|reinforcement|planning|think') { return 'Reasoning, Inference, and Test-Time Scaling' }
    if ($Title -match '(?i)pre[- ]train|alignment|prompt|adapt|fine[- ]tun|continual|transfer|representation learning|encoder') { return 'Pre-training, Alignment, and Adaptation' }
    if ($Title -match '(?i)medical|biomed|clinical|pathology|health|remote sensing|autonomous driving|robot|document|aerial|geospatial|forensics|industrial|art|music') { return 'Domain-Specific VLMs and Applications' }
    return 'Multimodal Architecture and Training'
}
