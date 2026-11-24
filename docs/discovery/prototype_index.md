# Índice de protótipos do Iota

O [índice mestre](research_index.md) reúne as pesquisas. O [checklist de publicação](../release_checklist.md) registra as verificações vigentes.

## Disponíveis

| Protótipo ou fixture | Implementação, reprodução e evidência |
| --- | --- |
| [Broken](research/prototypes/broken_tool_prototype.md) | Procedimento da picareta e escopo de Tool Mastery 0.0.2. [Fixture de equipamento](research/outputs/trading_execution-2026-11-20/broken-equipment-poc/), [gerador](tests/build-broken-equipment.mjs), [teste nativo](tests/native-broken-equipment.mjs) e [resultados de ciclo de vida](research/outputs/trading_execution-2026-11-20/broken-equipment-lifecycle-results.json). |
| Quebra e captura de armadura | [Fixtures e resultados](research/outputs/trading_execution-2026-11-20/) de retirada, captura e armadura Broken. [Teste de captura nativa](tests/native-break-capture.mjs) e [cenários com jogador](tests/player-armor-capture.mjs). |
| Bigorna e reparo | [Fixture de persistência](tests/anvil-persistence/readme.md), [reparo experimental por Smithing](research/outputs/trading_execution-2026-11-20/smithing-repair-poc/), [gerador e teste nativo](tests/native-repair-probe.mjs) e [teste de GUI](tests/native-repair-gui.mjs). |
| Qualificação e execução de Trading | [Fixture de qualificação](research/outputs/trading_execution-2026-11-20/qualification-poc/), [teste de qualificação](tests/native-qualification-poc.mjs), [gerador de Trades](tests/build-trades-runtime.mjs) e [teste de execução](tests/native-trades-runtime.mjs). Os [catálogos e previews iniciais](research/outputs/trading_profession-drafts-2026-11-19/) são insumos de reprodução. |
| Módulos experimentais | [Trades](../../modules/experimental/trades/readme.md) e [Mastery Orb](../../modules/experimental/mastery_orb_experimental/readme.md). O segundo registra o experimento histórico de transferência de XP. |
| Módulos experimentais | [Trades](../../modules/experimental/trades/readme.md) e [Mastery Orb](../../modules/experimental/mastery_orb_experimental/readme.md). O segundo registra o experimento histórico de transferência de XP. |

## Arquivados

| ZIP | Caminho interno e conteúdo |
| --- | --- |
| [Consolidação de discovery](../backups/discovery-consolidation-2026-11-22.zip) | `docs/discovery/research/prototypes/broken_tool_prototype.md` — original das notas de Broken antes desta revisão. |
| [Histórico de pesquisa](../backups/research-history-2026-11-22.zip) | `docs/discovery/research/outputs/trading-execution-2026-11-20/source-before-broken-integration/` — código anterior à integração de Broken. |

Extraia a entrada desejada em uma pasta de consulta, mantendo o caminho interno. Consulte também os [backups anteriores](research_index.md#backups-anteriores) para revisões mais antigas do fixture.
