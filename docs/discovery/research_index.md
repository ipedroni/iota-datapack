# Índice mestre de pesquisas do Iota

Atualizado em 23/11/2026. O [guia de design](../design_directions.md), as [direções de Trading](drafts/trading_design_directions.md) e as [tarefas](drafts/project_task_status.md) descrevem o trabalho atual. As pesquisas abaixo registram evidências, hipóteses e versões anteriores. Consulte também o [índice de relatórios](report_index.md) e o [índice de protótipos](prototype_index.md).

## Pesquisas disponíveis de Trading e encantamentos

| Pesquisa | Quando consultar e o que contém |
| --- | --- |
| [Dados da matriz econômica](research/outputs/trading_economy-discovery-2026-11-19/) | Valores, receitas, fontes de itens e custos de atividades. A [pasta da planilha](research/outputs/01a1e661-66fd-7850-8264-8da8e32c1749/trading_economy-discovery/) guarda as verificações e visualizações. |
| [Dados de comércio regional](research/outputs/trading_biome-trade-research-2026-11-20/local-evidence.json) | Evidência local de produtos e procedência. Consulte as [amostras de distância por bioma](research/outputs/trading_execution-2026-11-20/biome-distance-samples.json) para conferir o seed estudado. |
| [Dados de encantamentos](research/outputs/enchantment-reference-2026-11-22/reference.json) | Cálculos por família. A [regra vigente de quantidade e progressão](drafts/trading_design_directions.md#artisan-equipment-enchantments) substitui a nota antiga sobre garantia de Master. |
| [Execução experimental de Trading](research/outputs/trading_execution-2026-11-20/) | Para recuperar preços, estoque, testes de identidade, cura, GUI, ItemCost, metal, maldições e protótipos de reparo/Broken. Os catálogos de seis níveis e os contratos mínimo/OU são evidência da versão anterior. |
| [Primeiros catálogos de profissões](research/outputs/trading_profession-drafts-2026-11-19/) | Para reproduzir o gerador experimental de 20/11 e seus previews, que leem arquivos dessa pasta. O catálogo de cinco níveis está nos drafts de Trading. |

O [plano de retomada](drafts/project_next_steps.md) indica a ordem de trabalho. As ofertas atuais estão no [template do Toolsmith](drafts/trading_toolsmith_template.md) e no [catálogo das demais profissões](drafts/trading_profession_catalog_draft.md).

O [diretório de testes](tests/) guarda os scripts e fixtures de reprodução, incluindo fazenda, bigorna, encantamentos e execução experimental de Trading. A planilha vigente e o JSON de planejamento continuam na [pasta de planejamento](research/outputs/01a1e661-66fd-7850-8264-8da8e32c1749/planning/).

## Pesquisas arquivadas de Quality

### Friendly fire contra pets e villagers

O [ZIP de pesquisa de Quality](../backups/quality-friendly-fire-research-2026-11-23.zip) preserva o relatório integral `docs/discovery/research/reports/quality_mobs_and_pets.md`. Consulte [F-029 em Mudanças futuras](../future_directions.md#f-029--friendly-fire-protection-for-pets-and-villagers) para retomar a feature.

O estudo documenta os vínculos vanilla de 13 tipos com referência nativa de dono e os casos de raposa, ocelote, Allay e Happy Ghast. Identificou sinais de autoria para alguns ataques. O bloqueio seletivo antes da perda de vida e a atribuição confiável de fogo propagado e quedas ainda precisam de protótipo.

O relatório também preserva os ensaios anteriores de aproximação com lobo e cavalo. A decisão de usar `minecraft:mob_griefing false` para Endermen e Creepers está no [guia de World](../design_directions.md#world).

### Recuperação de animais

O [ZIP de recuperação de animais](../backups/quality-pet-recovery-research-2026-11-23.zip) preserva o relatório integral `docs/discovery/research/reports/quality_pet_beds.md`. Os testes em Java 1.21.11 documentam cliques com Lead e mão vazia, o uso normal da cama com uma hitbox, o transporte de gatos, lobos e papagaios pelos UUIDs originais após carregamento temporário do chunk e a captura da posição real de respawn do dono. Os ensaios de aproximação anteriores estão no [arquivo de friendly fire](#friendly-fire-contra-pets-e-villagers).

A iniciativa está pausada. Ao retomar, [F-033](../future_directions.md#f-033--animal-recovery-with-a-placed-orb-and-charm) propõe um orbe craftável e colocável como destino. O jogador usa o Animal Charm primeiro no animal e depois no orbe. O estudo de camas fica como histórico.

## Histórico de pesquisa e documentação

Para recuperar documentos por título, consulte os [relatórios arquivados](report_index.md#arquivados) e os [protótipos arquivados](prototype_index.md#arquivados).

O [histórico de pesquisa](../backups/research-history-2026-11-22.zip) também guarda os dados e scripts abaixo. Os caminhos da tabela são relativos a `docs/discovery/research/` dentro do ZIP. Extraia apenas o material necessário em uma pasta de consulta.

| Caminho dentro da pesquisa | Quando recuperar |
| --- | --- |
| outputs/design-audit-2026-11-19/ | Registro, gerador e resumo da auditoria histórica de decisões, tags e cobertura de documentação. |
| outputs/documentation-review-2026-11-20/ | Para recuperar inventário, proposta de organização, revisão de linguagem e validação de caminhos anteriores à estrutura atual. |
| outputs/toolsmith-template-2026-11-19/ | Para recuperar a primeira tabela de ofertas e preços do Toolsmith. |
| outputs/01a1e661-66fd-7850-8264-8da8e32c1749/planning/ | Para consultar a planilha anterior ao ajuste de escopo, imagens de revisão e relatórios de inspeção antigos. |

## Medições de farm e simulações arquivadas

[ZIP de medições de farm e simulações](../backups/trading_farm-measurement-and-simulations-2026-11-22.zip). Os caminhos internos preservam as pastas originais. Consulte somente para verificar uma premissa ou recuperar um resultado histórico.

| Pesquisa | O que recuperar |
| --- | --- |
| Iron Farm | Relatório, medições, amostras, comandos, cenários de retorno de materiais, testes e mundo isolado. A produção foi medida no jogo. O tempo humano de construir e operar ficou fora do estudo. |
| Capacidade de farm | Relatório, planilha, fontes, método e premissas de escala. O JSON por item permanece disponível porque o gerador experimental de Trading o usa. |
| Simulações de mercado | Scripts, validação e resultados completos das 200 mil jornadas iniciais de 100 h e das 200 mil jornadas de 24 h com estoque individual, sono, transporte e Hero. A auditoria de preços que apontou 434 pares lucrativos com Hero V continua na pasta de execução de Trading. |

## Backups anteriores

[docs-backups-history-2026-11-22.zip](../backups/docs-backups-history-2026-11-22.zip) reúne as 20 pastas datadas de 20 a 22/11. Os caminhos internos começam em docs/backups e mantêm os nomes originais.

- **20/11** — tabelas anteriores à sincronização dos catálogos e à atualização das evidências.
- **21/11** — versões anteriores à reorganização, revisão de linguagem, fusão de testes/changelog e atualização da planilha. Inclui os resumos de retomada antigos.
- **22/11, 2026-11-22-design-consolidation** — originais anteriores ao redesenho consolidado de Trading, incluindo tabelas de Secret, regra de 65% e planejamento anterior.
