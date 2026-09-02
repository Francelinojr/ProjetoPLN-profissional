# Detecção de Discurso de Ódio em Português Brasileiro

> Comparação de embeddings textuais, instruções e classificadores lineares para detecção de discurso ofensivo em comentários brasileiros.

[![Python](https://img.shields.io/badge/Python-3.10%2B-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![NLP](https://img.shields.io/badge/NLP-Embeddings-6A1B9A)](https://huggingface.co/models)
[![Sentence Transformers](https://img.shields.io/badge/Sentence--Transformers-Models-FFB000)](https://www.sbert.net/)
[![scikit-learn](https://img.shields.io/badge/scikit--learn-Classification-F7931E?logo=scikit-learn&logoColor=white)](https://scikit-learn.org/)

## Visão geral

Este projeto avalia como diferentes representações semânticas influenciam a classificação de comentários em português brasileiro. O pipeline utiliza o corpus **HateBR**, gera embeddings com modelos multilíngues e em português, compara condições sem instrução, com instrução manual e com instrução gerada automaticamente, e treina classificadores para medir desempenho e analisar erros.

O foco não está apenas na métrica final. O projeto também registra a divisão treino/validação/teste, identifica erros compartilhados entre modelos, mantém cache versionado por hashes e permite estudar o impacto da formulação das instruções em modelos de embeddings instrucionais.

> **Aviso ético:** o corpus contém linguagem ofensiva. Os resultados devem ser interpretados como experimento acadêmico e não como sistema pronto para moderar pessoas ou tomar decisões automatizadas de alto impacto.

## Perguntas de pesquisa

| Pergunta | Estratégia |
| --- | --- |
| O uso de instruções melhora a classificação? | Comparação entre embeddings sem instrução, com instrução manual e com instrução automática. |
| Modelos multilíngues e específicos para português têm comportamentos diferentes? | Avaliação de diferentes encoders e dimensões de representação. |
| Onde os modelos erram? | Matrizes de confusão, relatórios de classificação e análise de erros compartilhados. |
| Os resultados são reproduzíveis? | Seed fixa, divisão persistida, SHA-256 da base e cache identificado por configuração. |

## Resultados registrados

A tabela de resultados versionada em `results/resultados_comparativos.csv` registra 19 avaliações entre modelos, condições e partições. No conjunto de teste disponível, o melhor F1 ponderado foi **0,9019**, obtido pelo `e5_large_instruct` sem instrução; a condição manual do mesmo modelo alcançou **0,8986**. O `bertimbau_pt` com instrução manual alcançou F1 ponderado de **0,8914** no teste.

Esses números são resultados do artefato fornecido e não devem ser comparados diretamente com outros trabalhos sem controlar corpus, divisão, pré-processamento, versão dos modelos e protocolo de avaliação.

## Estrutura do repositório

```text
.
├── data/
│   └── README.md                 # Como obter a base HateBR
├── docs/
│   ├── projeto_pln.pdf           # Documento acadêmico
│   ├── projeto_pln.docx
│   ├── notebook_experimental.ipynb
│   └── referencias.md
├── notebooks/
│   ├── 01_pipeline_unificado_colab.ipynb
│   └── 02_analise_completa.ipynb
├── results/
│   ├── resultados_comparativos.csv
│   ├── analise_erros.csv
│   ├── analise_erros_detalhada.csv
│   └── comparacao_erros_entre_modelos.csv
├── src/
│   └── pipeline_pln.py
├── .gitignore
├── LICENSE
├── Makefile
├── README.md
└── requirements.txt
```

Embeddings, modelos serializados e caches de dezenas de megabytes não são versionados. Eles podem ser regenerados pelo pipeline e estão ignorados para manter o repositório leve.

## Como executar

### Instalação

```bash
python -m venv .venv
# Linux/macOS
source .venv/bin/activate
# Windows PowerShell: .venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

### Execução local

```bash
python src/pipeline_pln.py
```

O script baixa o `HateBR.csv` da fonte oficial quando o arquivo não está em `data/`, cria cache em `cache/` e grava novos resultados em `results/generated/`. A execução pode exigir bastante memória, armazenamento e tempo, especialmente ao gerar embeddings para múltiplos modelos.

### Execução no Google Colab

Abra `notebooks/01_pipeline_unificado_colab.ipynb` no Google Colab. O notebook reúne instalação, download, auditoria, divisão dos dados, embeddings, classificação, métricas e análise de erros. A geração de instruções automáticas por LLM permanece opcional.

## Modelos avaliados

O registro de modelos no pipeline inclui encoders E5, BERTimbau e Sentence Transformers multilíngues. Cada configuração informa dimensão, idioma, suporte a instruções, estilo de entrada e fonte do modelo. Isso evita comparar embeddings sem registrar o protocolo utilizado.

## Reprodutibilidade e limitações

A análise utiliza seed fixa e guarda o hash SHA-256 da base. Ainda assim, resultados podem variar conforme versões de PyTorch, Transformers, Sentence Transformers, hardware e disponibilidade dos modelos. A classificação é feita com um modelo linear sobre embeddings congelados; portanto, não representa um fine-tuning completo do encoder.

O corpus contém linguagem ofensiva e suas anotações refletem um contexto específico de comentários de Instagram. Métricas agregadas não garantem desempenho uniforme entre grupos, temas, dialetos ou formas novas de linguagem. Qualquer uso aplicado exigiria validação adicional, revisão humana e análise de viés.

## Autoria e referências

Projeto desenvolvido por **Francelino Teotonio Júnior** e colaboradores no contexto acadêmico de Processamento de Linguagem Natural.

Consulte `docs/referencias.md` para as fontes dos dados e modelos.
