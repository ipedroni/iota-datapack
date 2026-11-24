# Tarefas do Iota — decisões e andamento

Atualizado em 22/11/2026.

Os 50 IDs e status refletem as notas da coluna J da planilha e as decisões registradas posteriormente neste documento. Os links apontam para as regras e verificações atuais. Há 29 tarefas concluídas, 18 abertas (incluindo as adiadas que permanecem na fila), 2 transferidas para ideias futuras e 1 retirada do escopo.

**Como ler os status:** “Concluída” se refere à tarefa descrita. Um catálogo ou estudo concluído não significa que a mudança já esteja implementada ou publicada no datapack. As notas indicam essas diferenças.

Este documento registra o estado da planilha em 22/11/2026 e as validações de P01 a P09 em 23/11/2026.

## Profissões e ofertas

### P01 — Ofertas do Toolsmith

**Status:** Concluída.

O [template do Toolsmith](trading_toolsmith_template.md) foi validado em 23/11/2026. A atualização do catálogo gerado segue em C02.

### P02 — Ofertas do Armorer

**Status:** Concluída.

O [catálogo do Armorer](trading_profession_catalog_draft.md#armorer) foi validado em 23/11/2026. Horse Armor encantada segue condicionada ao teste funcional. A atualização do catálogo gerado segue em C02.

### P03 — Ofertas do Weaponsmith

**Status:** Concluída.

O [catálogo do Weaponsmith](trading_profession_catalog_draft.md#weaponsmith) foi validado em 23/11/2026. O percentual da chance reduzida de Mending segue em aberto. A atualização do catálogo gerado segue em C02.

### P04 — Ofertas do Fletcher

**Status:** Concluída.

O [catálogo do Fletcher](trading_profession_catalog_draft.md#fletcher) foi validado em 23/11/2026. A atualização do catálogo gerado segue em C02.

### P05 — Ofertas do Leatherworker

**Status:** Concluída.

O [catálogo do Leatherworker](trading_profession_catalog_draft.md#leatherworker) foi validado em 23/11/2026. O contrato de compra de equipamento em Journeyman e a calibração de pesos, preços e lotes seguem em aberto. A venda de armaduras de animais encantadas depende de teste funcional. A atualização do catálogo gerado segue em C02.

### P06 — Ofertas do Farmer

**Status:** Concluída.

O [catálogo do Farmer](trading_profession_catalog_draft.md#farmer) foi validado em 23/11/2026. Os preços e lotes seguem para calibração e checagem de revenda. A atualização do catálogo gerado segue em C02.

### P07 — Ofertas do Shepherd

**Status:** Concluída.

O [catálogo do Shepherd](trading_profession_catalog_draft.md#shepherd) foi validado em 23/11/2026. Os preços e lotes seguem para calibração e checagem de revenda. A atualização do catálogo gerado segue em C02.

### P08 — Ofertas do Librarian

**Status:** Concluída.

O [catálogo do Librarian](trading_profession_catalog_draft.md#librarian) foi validado em 23/11/2026, com três ou quatro vendas de livros encantados ao chegar a Master. O mapa de Tesouro por tipo de aldeão foi aprovado, com 75% para a especialidade local e 25% para outro Tesouro. Os demais pesos, preços e lotes seguem em calibração. A atualização do catálogo gerado segue em C02.

### P09 — Ofertas do Butcher

**Status:** Concluída.

O [catálogo do Butcher](trading_profession_catalog_draft.md#butcher) foi validado em 23/11/2026. Comida preparada entra em Expert e Rabbit Stew é opção de Master. As vendas de peixe ficam com o Fisherman. As condições de compra do Iron Axe, os preços e os lotes seguem em aberto. A atualização do catálogo gerado segue em C02.

### P10 — Ofertas do Fisherman

**Status:** Aguardando decisão.

Na revisão de cinco níveis, preservar a identidade de pesca e a regra de não comprar peixe. Consultar as tabelas anteriores no catálogo de profissões.

### P11 — Ofertas do Cartographer

**Status:** Aguardando decisão.

Na revisão de cinco níveis, rever mapas, serviços e o preço da Recovery Compass. Consultar as tabelas anteriores no catálogo de profissões.

### P12 — Ofertas do Cleric

**Status:** Aguardando decisão.

Na revisão de cinco níveis, rever os reagentes, poções e as antigas opções Wind Charge e Ghast Tear. Consultar as tabelas anteriores no catálogo de profissões.

### P13 — Ofertas do Mason

**Status:** Aguardando decisão.

Na revisão de cinco níveis, manter Flint cedo e rever materiais em volume e acabamentos. Consultar as tabelas anteriores no catálogo de profissões.

## Trocas regionais

### R01 — Produtos de cada região

**Status:** Concluída.

A matriz inicial está na [economia regional](trading_design_directions.md#regional-economy).

### R02 — Distâncias entre biomas

**Status:** Concluída.

Ver as [amostras de distância por bioma](../research_index.md#pesquisas-disponíveis).

### R03 — Origem e localização do comerciante

**Status:** Concluída.

A proposta de identidade e localização está na [economia regional](trading_design_directions.md#regional-economy). Implementação e testes em C05.

### R04 — Ofertas regionais extras

**Status:** Concluída.

Consultar a [regra aprovada de vagas regionais](trading_design_directions.md#ordinary-and-regional-slots).

### R05 — Lucro com produtos importados

**Status:** Concluída.

Consultar a [calibração candidata de importações](trading_design_directions.md#regional-economy).

### R06 — Como identificar produtos importados

**Status:** Concluída.

Consultar o [critério de produto importado](trading_design_directions.md#regional-economy).

## Ofertas especiais e reputação

### S01 — Redistribuição das ofertas especiais para Master

**Status:** Aguardando decisão.

Rever quais ofertas especiais entram em Master e como serão sorteadas. Percentuais antigos de Secret são históricos. Ainda não há percentual aprovado para Netherite.

### S02 — Reputação, cura e defesa da vila

**Status:** Retirada do escopo.

A progressão de comércio dispensa os antigos requisitos de reputação, cura e defesa da vila que desbloqueavam Secret. Esses requisitos ficam registrados no histórico.

### S03 — Disponibilidade de Mending

**Status:** Concluída.

Consultar [acesso a Mending](trading_design_directions.md#reputation-and-maintenance-access) e a [regra de espadas e bestas](trading_profession_catalog_draft.md#weaponsmith).

## Economia e descontos

### T01 — Descontos nas trocas

**Status:** A pesquisar.

Fechar o tratamento de Hero of the Village e validar os lotes na [calibração econômica](trading_design_directions.md#working-price-and-stock-calibration).

### E01 — Estoque dos ferreiros

**Status:** Concluída.

Consultar [estoque dos ferreiros](trading_design_directions.md#working-price-and-stock-calibration).

### E02 — Preço da Recovery Compass

**Status:** Concluída.

Consultar [calibração da Recovery Compass](trading_design_directions.md#working-price-and-stock-calibration).

### E03 — Preços e revenda

**Status:** A validar.

Validar os [critérios econômicos](trading_design_directions.md#economic-criteria--approved) com os preços e lotes candidatos.

### E04 — Esforço para construir e operar farms

**Status:** Concluída.

Encerrada por decisão do usuário. Preservar os dados do benchmark sem continuar a medir esforço humano de construir ou operar farms.

### E05 — Simulação da economia

**Status:** Concluída.

Os cenários, premissas e resultados estão nas [simulações de mercado arquivadas](../research_index.md#medições-de-farm-e-simulações-arquivadas).

## Implementação do comércio

### C01 — Compra de equipamentos encantados

**Status:** Concluída.

Validação experimental concluída. Integrar após decidir os [contratos atuais](trading_design_directions.md#enchanted-equipment-purchases).

### C02 — Atualização dos catálogos e previews

**Status:** A fazer.

Reaberta para o redesenho. Os catálogos e previews antigos ficam como evidência. Atualizar após fechar as novas tabelas e a economia.

### C03 — Identidade e evolução do villager

**Status:** A fazer.

Concluir a [identidade e o plano de ofertas](trading_design_directions.md#identity-and-offer-state). Ver [escopo do protótipo](../../../modules/experimental/trades/readme.md).

### C04 — Reposição de estoque

**Status:** A fazer.

Implementar e validar [reposição, trabalho e sono](trading_design_directions.md#working-price-and-stock-calibration).

### C05 — Implementação regional

**Status:** A fazer.

Implementar e validar a camada regional.

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

### B04 — Reparo completo com um material

**Status:** Concluída.

A pesquisa confirmou que a bigorna repara até 25% por material. Um protótipo na Smithing Table conseguiu reparar tudo com uma unidade e preservar os dados. Essa alternativa não foi adotada como regra do pack nem muda a bigorna.

## Maldições e loot

### V01 — Remoção de maldições

**Status:** Concluída.

Testes nativos concluídos no escopo registrado. Ver a [regra preparada para 1.0.35](../../design_directions.md#curse-suppression--staged-for-1035).

### V02 — Drops de ferro e ouro

**Status:** Concluída.

Amostragem nativa concluída. Ver [drops preparados](../../design_directions.md#staged-metal-drops--not-yet-packaged) e [escopo dos testes](../../release_checklist.md#automated-research-evidence--2026-11-20).

### L01 — Revisão das fontes de loot

**Status:** Concluída.

A primeira revisão das tabelas de loot foi feita. A proposta preserva fontes naturais de equipamentos e livros, evita vender materiais de chefes e mantém rotas especiais de encantamento. Não foram aplicadas novas reduções de loot nessa revisão.

## Documentação e publicação

### D01 — Consolidação do design de Trading

**Status:** Concluída.

Regras vigentes, propostas e histórico foram consolidados. Os geradores serão alinhados após fechar os catálogos, em C02.

### D02 — Verificações para publicação

**Status:** A validar.

Falta concluir a verificação dos arquivos e das referências entre funções. O guia deve distinguir o que os testes automáticos comprovam do que precisa ser observado dentro do Minecraft.

### D03 — Geração dos ZIPs

**Status:** Adiada.

Os ZIPs finais serão gerados depois das verificações necessárias. Ainda não foi publicado um novo pacote reunindo todas essas mudanças.

### D04 — Revisão dos documentos

**Status:** Concluída.

A revisão editorial dos documentos selecionados foi concluída: informações antigas foram identificadas, regras atuais esclarecidas e links corrigidos. Dados brutos e backups ficaram fora da revisão. Isso não substitui os testes do datapack.

### D05 — Encantamentos dos artesãos

**Status:** Aguardando decisão.

A classificação, a progressão de quantidade e potência e os cinco catálogos de artesãos foram aprovados. Restam as decisões sobre encantamentos mistos nas compras, o limite de um Tesouro por item e as armaduras de animais encantadas, condicionadas ao teste funcional. A calibração de Mending segue em aberto. A atualização do catálogo gerado segue em C02.

### D06 — Organização das pastas

**Status:** Concluída.

Concluída conforme confirmação do usuário em 21/11/2026. Drafts, pesquisas e experimentos estão em docs/discovery; os guias de testes e changelog, na raiz de docs; e as dependências, em vendor. A conferência dos caminhos não permanece como pendência desta tarefa.

### E06 — Classificação dos encantamentos

**Status:** Concluída.

Ver a [classificação aprovada](../../design_directions.md#shared-enchantment-classification). Aplicação aos artesãos em D05.

## Qualidade de vida e pets

### Q01 — Proteção de blocos contra mobs

**Status:** A fazer.

Impedir Endermen de retirar blocos e Creepers de destruir blocos ao explodir. A solução deve preservar os outros comportamentos dos mobs; desligar mobGriefing para tudo pode afetar sistemas que queremos manter.

### Q02 — Proteção dos pets

**Status:** Transferida para ideias futuras.

Consultar [F-029 — Friendly fire protection for pets and villagers](../../future_directions.md#f-029--friendly-fire-protection-for-pets-and-villagers).

### Q03 — Chamada de pets distantes

**Status:** Transferida para ideias futuras.

Consultar [F-036 — Call distant pets](../../future_directions.md#f-036--call-distant-pets).
