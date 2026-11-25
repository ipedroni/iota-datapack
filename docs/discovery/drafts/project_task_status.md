# Tarefas do Iota — decisões e andamento

Atualizado em 24/11/2026.

As entradas da planilha mantêm os IDs originais.

## Pendências do pacote base — 24/11/2026

- **Tools** — Igualar a durabilidade das lanças à das espadas do mesmo material. Ajustar a velocidade de mineração para 64% abaixo da vanilla em madeira e pedra e 8% acima da vanilla em netherita. Definir a encantabilidade das ferramentas de ouro em 48.
- **Recipes** — Auditar todos os tipos de tijolo e de pedra para verificar se as receitas seguem as regras de construção que exigem o cortador de pedras.
- **World** — Fazer o sono diurno avançar até o início da noite e o sono noturno avançar até o amanhecer.

## Economia e descontos

### T01 — Descontos nas trocas

**Status:** Regra aprovada, a validar.

A [regra de Hero of the Village](../../design_directions.md#hero-of-the-village) foi publicada no World. O desconto de Hero foi mantido. A revenda direta comum ou local exige margem positiva mesmo sob Hero V, com a exceção regional aprovada. Falta validar preços efetivos e lotes inteiros na [calibração econômica](trading_design_directions.md#working-price-and-stock-calibration).

### E03 — Preços e revenda

**Status:** A validar.

Validar os [critérios econômicos](trading_design_directions.md#economic-criteria--approved) com os preços e lotes candidatos das 13 profissões. Conferir revenda direta entre comerciantes com os descontos aplicáveis, incluindo Hero V, e impedir lucro em ciclos reversíveis de fabricação. Preservar a remuneração por fabricação útil e a exceção regional aprovada. A primeira rodada de [preços e lotes candidatos](trading_design_directions.md#candidate-quotes-for-the-validated-pools) cobre metais, Diamond, Netherite Scrap, argila, peixe e ingredientes do Cleric. A segunda rodada adicionou [29 cotações compartilhadas](trading_design_directions.md#shared-candidate-quotes-for-overlapping-offers), checou conversões de metais, tinta, couro e livros, e reduziu a margem do peixe sob Hero V. A terceira rodada incluiu [26 cotações agrícolas, têxteis e de suprimentos](trading_design_directions.md#candidate-farm-textile-and-supply-quotes), com checagem das tintas de Master, trigo e lã. A quarta rodada incluiu [17 cotações de equipamento e navegação](trading_design_directions.md#candidate-equipment-and-navigation-quotes), com checagens de fundição de ferramentas e fabricação de bússolas e relógios. A quinta rodada incluiu [21 cotações de alimentos, munição e recipientes](trading_design_directions.md#candidate-food-ammunition-and-container-quotes), com checagens de recuperação de baldes e frascos e fabricação de flechas espectrais. A sexta rodada cotou [as especialidades do Mason](trading_design_directions.md#candidate-mason-specialty-quotes) e calculou o ponto de equilíbrio da fabricação de flechas com poção. A sétima rodada adicionou [cotações de exploração e do Librarian](trading_design_directions.md#candidate-exploration-and-librarian-quotes) e estimou o custo das quatro poções de flechas. A oitava rodada incluiu [preços para variantes de equipamento](trading_design_directions.md#candidate-prices-for-equipment-variants), com verificação do pagamento em dois campos e do estoque de lingotes. A nona rodada aplicou [pisos de fabricação](trading_design_directions.md#equipment-manufacturing-floors) a 47 receitas de equipamento e recalculou a margem sob Hero. A décima rodada definiu [estoques candidatos de fabricação](trading_design_directions.md#candidate-manufacturing-stock-and-native-trade-checks) e confirmou quatro ofertas injetadas sob Hero V na interface nativa de Java 1.21.11. A [auditoria de conversões em cadeia](trading_design_directions.md#multi-step-conversion-audit) cobriu 26 itens comprados no recorte inicial e corrigiu o preço de Sand para impedir lucro na rota de Glass Bottles sob Hero V. O [teste reproduzível de conversões](../tests/audit-trading-conversions.mjs) expandiu 199 tags em 1.646 receitas e alcançou 82 itens de compra nos seis estados de Hero. Ajustes em Bone e Magma Cream eliminaram os resultados inesperados do teste. Restam as rotas fora desse modelo e os testes integrados com catálogos, modificadores e reposição. Após balancear as farms de Iron Golem e de piglins para ouro, recalibrar preços e lotes de Iron Ingot, Gold Ingot, suas pepitas e ofertas de equipamento afetadas. A revisão fica para depois da conclusão da etapa de Trading. Usar a produção observada com os drops finais do Iota e rodar novamente a auditoria de revenda sob Hero, inclusive nas conversões entre lingotes e pepitas.

## Implementação do comércio

### C02 — Atualização dos catálogos e previews

**Status:** Em andamento.

C02 iniciada com o [catálogo do Toolsmith](trading_toolsmith_catalog.json) e seu [preview](trading_toolsmith_preview.html), gerados a partir da tabela validada e das cotações candidatas. O [Armorer](trading_armorer_preview.html) e o [Weaponsmith](trading_weaponsmith_preview.html) também já têm catálogo e preview. As cotações de ferro e ouro seguem provisórias em E03. As [13 profissões](trading_catalog_previews.html) têm catálogos JSON e previews com os grupos, regras e cotações candidatas. Foram feitas 9.954 comparações de revenda direta com Hero desligado e nos níveis I–V. O preview inclui 98 exemplos de encantamentos. Os oito mapas foram gerados com coordenadas de estruturas reais em Java 1.21.11. Foram aprovados os pesos de 50/50 do Mason, os critérios de compra de equipamento do Butcher e do Fisherman e a vaga pendente quando nenhum destino elegível de mapa for localizado. O Leatherworker compra uma peça de armadura de couro de jogador em Journeyman, sem encantamentos e com durabilidade cheia. Na venda de Journeyman, Leather e Rabbit Hide têm peso 2 cada e o grupo de tintas tem peso 1. Os mapas já são resolvidos e publicados no Cartographer experimental. Faltam a ativação de produção e as validações integradas. Os catálogos históricos permanecem arquivados.

### C03 — Identidade e evolução do villager

**Status:** Adiada.

O protótipo publicou em jogo um plano injetado de Toolsmith e liberou Apprentice com 10 XP comercial, mantendo a oferta anterior e o nome personalizado. O [sorteador](../../../tools/trading-offer-plan.mjs) gerou 1.300 planos de teste para as 13 profissões, com regras de histórico e variantes. As prévias incluem um exemplo de carreira. A integração experimental do Toolsmith agora sorteia e persiste um de 16 planos do catálogo atual no primeiro vínculo. Um teste nativo confirmou a compra de Flint, o crédito de XP, a promoção após fechar o menu, a persistência após reload e a reposição com posto de trabalho. O recorte usa compras de materiais. O protótipo foi ampliado a 12 profissões e 124 planos de teste. Em jogo, as 12 publicaram as quantidades previstas em Novice e Master e conservaram os planos após reload. O Cartographer agora entra no protótipo, totalizando 13 profissões e 132 planos de teste. O [teste nativo do Cartographer](../tests/native-cartographer-plan.mjs) confirmou mapas com destinos distintos, persistência após reload e três vagas pendentes quando nenhum destino elegível foi localizado. Os planos de teste agora incluem compras de equipamento. O [teste nativo](../tests/native-current-equipment-trades.mjs) validou oito casos de durabilidade, contratos sem encantamentos e Básicos I–II com efeitos adicionais. O teste também confirmou que um segundo jogador não abre o mesmo aldeão ocupado, que um marcador antigo é recalculado após alteração do item com o menu aberto e que um item largado é transferido sem os marcadores temporários. A suíte de qualificação passou em 12 cenários, incluindo dois jogadores com menus simultâneos em aldeões diferentes, um aceito e outro recusado sem interferência. Itens com componentes de terceiros nos campos reservados do protótipo foram preservados e recusados. No protótipo atual, identidades acima de 64 agora registram uso, estoque e XP por aldeão a partir das ofertas nativas. O [teste com IDs 100 e 101](../tests/native-trading-high-resident.mjs) confirmou trocas simultâneas, correção de uma redução externa de usos e reposição independente. Acima de 64, o protótipo ainda não atribui XP por jogador. A leitura de ofertas agora ignora listas iguais e distribui checagens de aldeões distantes. O [benchmark de 64 Masters](../tests/benchmark-trading-poll.mjs) registrou medianas de 31,3 ms por tick com o jogador distante e 39,8 ms com o jogador perto do grupo. O Cartographer agora processa no máximo um destino por tick do servidor. Os testes nativos confirmaram a seleção de destinos distintos e a preservação após reload e reposição. O sorteio em jogo por oferta foi incluído no ZIP de teste. A busca em terreno ainda não explorado e os casos de mudanças de estoque entre ticks ficam para a próxima versão. Ver [escopo do protótipo](../../../modules/experimental/trades/readme.md).

### C04 — Reposição de estoque

**Status:** Em andamento.

A reposição experimental agora percorre a lista do plano do aldeão. O teste nativo confirmou o limite de 30 minutos com crédito de sono, a exigência de posto de trabalho e a preservação de encantamentos e demanda. A reposição verifica o bloco da profissão entre os 13 postos. No Cartographer, um Stonecutter impediu a reposição e a Cartography Table correta liberou o estoque sem trocar os mapas. Ainda falta verificar sono real com World ligado e desligado e a coexistência com a reposição vanilla. Revisar a duração do reestoque depois de concluir os testes da etapa.

### C05 — Implementação regional

**Status:** Adiada.

Comércio regional fora da etapa atual. Retomar separadamente quando priorizado.

### ZIP de teste — Java 1.21.11

O [ZIP de teste](../../../dist/iota_trading_test_mc1.21.11.zip) contém o sorteio nativo das 13 profissões, com candidatos por vaga, histórico, preços provisórios e variantes de encantamento. O comando `/function iota_trades:production/test_spawn` cria um aldeão novo para teste. O teste em mundo isolado confirmou o vínculo natural a um posto e quatro ofertas de Novice. Aldeões existentes e sem a tag de teste preservam o estado.

Validado em Java 1.21.11 a partir do ZIP. O Toolsmith sorteou oito planos distintos e preservou os oito após reload. O aldeão antigo manteve ofertas, XP e nome. O Cartographer manteve os mapas após reload e reposição, e deixou três vagas pendentes no End. O exame das tabelas compiladas completou 20 mil planos de amostra sem uma vaga vazia fora da exceção de mapas.

Para a próxima versão ficam a revisão de preços de ferro e ouro após o balanceamento das farms, a revisão do reestoque e o desempenho da busca do Cartographer. Comércio regional segue adiado.

## Equipamentos Broken e reparo

### B01 — Preservação de equipamentos Broken

**Status:** A pesquisar.

A ampliação está no código de [Tool Mastery 0.0.2](../../design_directions.md#broken-equipment--staged-for-002). Falta validação final.

### B02 — Retirada automática de armaduras Broken

**Status:** A validar.

Validar a retirada de armadura e o inventário cheio no [checklist de Broken](../../release_checklist.md#broken-state-fixture-regression).

### B03 — Testes de quebra e reparo

**Status:** A validar.

Executar o [checklist de Broken](../../release_checklist.md#broken-state-fixture-regression) na versão integrada.
