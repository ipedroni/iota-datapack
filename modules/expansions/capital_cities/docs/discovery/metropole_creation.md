# Capital Cities — criação da metrópole

## Planta de teste

O próximo protótipo representa um assentamento menor entre capitais e usa um mapa de **400 × 400 blocos**. Manter a escala da cidade fortificada da 0.12.6 e expandir a cidade externa e a área rural.

| Área | Proporção do assentamento |
|---|---:|
| Rural | 50% |
| Urbana sem muralhas | 40% |
| Urbana fortificada | 10% |

Medir as proporções dentro da cerca externa. O terreno livre entre a cerca e os limites do mapa fica fora da conta. Para a medição, incluir o fosso e suas margens na faixa urbana externa. Tomar os cerca de 4.600 blocos² delimitados pelo traçado da muralha atual como referência para dimensionar as outras áreas.

1. **Escopo.** Cidade-estado medieval de inspiração europeia.
2. **Planta baixa.** A cidade fortificada fica acima da cidade externa. O castelo fica no centro da fortificação, num patamar ainda mais alto. A cidade sem muralhas ocupa o restante do perímetro urbano. Fazendas, plantações e estradas de terra compõem o perímetro rural no entorno.
3. **Cercas.** Uma cerca rústica contorna todo o perímetro, incluindo as áreas rurais. Usar curvas pequenas e grandes, mudanças de altura e recuos assimétricos. Usar folhas, troncos e cercas. A cerca tem 1 a 2 blocos de largura, com 5 blocos livres de cada lado. Usar a paleta do chão da cidade externa nessas faixas. Nos dois lados da cerca rural, distribuir pontualmente cerca de madeira e folhas de 1 a 2 blocos de altura, pedra, pedregulho e lajes desses materiais. Deixar algumas falhas na cerca externa sem preenchimento. Separar fazendas vizinhas com cercas. Evitar quadrados 2 × 2 de cercas ou blocos de muro e usar blocos inteiros nas quebras de direção.
4. **Muros baixos.** Um muro de 1 a 3 blocos contorna o perímetro urbano. Usar pedra, tijolos de pedra, pedregulho, muros desses materiais, cercas de madeira e folhas. Misturar blocos com musgo, rachados e cinzelados, lajes e escadas normais ou invertidas.
5. **Muralha.** Contornar a cidade fortificada com curvas pequenas e grandes, mudanças de altura e recuos assimétricos. Distribuir pilastras a intervalos regulares, com base escalonada, fuste estreito e capitel. Usar ardósia profunda na base, tufo no meio e pedra mais clara no topo, com a mesma variação de alvenaria dos muros baixos. Fazer um caminho de ronda contínuo com 3 a 5 blocos livres. Usar abeto com variações de tom e desgaste só na faixa central de circulação, com bordas e ameias em pedra. Colocar escadas nas mudanças de altura do adarve e usar arcos de escadas invertidas e lajes onde ele atravessa torres. Reservar os blocos cinzelados para detalhes pontuais da muralha, dos muros, das torres e do castelo. Distribuir merlões e crenas a intervalos regulares e usar blocos de muro nas crenelações.
6. **Fosso.** Contornar a muralha com um fosso de 16 blocos de largura, com uma faixa rasa estreita junto às margens, seguida por uma descida rápida até perto da profundidade máxima. Misturar pedra, pedregulho, pedregulho com musgo e blocos de musgo nas bordas, paredes e fundo, com mais musgo na parte baixa. Preencher com blocos-fonte de água e testar 8 blocos de chão entre a margem interna do fosso e a face externa da fortificação, medidos a partir da ponta das pilastras onde houver saliências. Manter cerca de 3 blocos na margem externa. Intercalar pedra elevada e blocos de muro sobre as margens. Ligar os portões à cidade externa por pontes baixas, com apoios de pedra nas margens, miolo de abeto e guarda-corpos sobre blocos inteiros.
7. **Portão.** Adicionar alguns portões ao longo da muralha.
8. **Torres de guarda.** Posicionar algumas torres nas interseções da muralha e aplicar a mesma paleta de blocos.
9. **Castelo.** Posicionar o castelo no centro da cidade fortificada e aplicar o mesmo gradiente e desgaste da muralha.
10. **Cidade sem fortificação.** Usar um visual rústico, com a paleta dos muros e cercas. As casas são menores e mais espaçadas.
11. **Lavouras.** Formar um cinturão contínuo nos quatro lados ao redor da cidade fortificada. Cada trecho começa no nível do terreno. Alternar culturas sem grandes vazios. Deixar 3 blocos livres entre as estradas e os canteiros, de cada lado da estrada. Usar tijolos de lama, lama compactada e terracota nas contenções apenas onde o canteiro elevado encontra uma área sem plantio. Distribuir árvores de copa larga e galhos variados em grupos irregulares junto às estradas, nas lavouras e na cidade externa. Usar principalmente blocos de caminho nas estradas.

**Geração e reset.** Gerar por setores e permitir limpar a área para testar outra planta. Com setores de 80 × 80 blocos, o mapa de teste ocupa 25 setores.

### Chão urbano

- **Cidade fortificada.** Predominam pedra, pedregulho, pedregulho com musgo, tufo, ardósia profunda e cascalho. Terra, terra infértil e grama entram em manchas menores.
- **Cidade externa.** Grama e terra simples dominam. Terra infértil, cascalho e pedra entram em manchas menores. Cascalho, pedra, pedregulho e pedregulho com musgo aparecem em menor proporção.

### Ordem de implantação

- Marcar o castelo no centro e desenhar o contorno da cidade fortificada.
- Reservar o espaço para o fosso e encaixar as pontes nos acessos dos portões.
- Delimitar a cidade sem muralhas pelo muro baixo e situar as casas rústicas nessa faixa urbana.
- Implantar as estradas de terra e as lavouras no entorno rural. Fechar o perímetro externo com a cerca rústica e separar as fazendas vizinhas.

As dimensões internas e a quantidade de portões e torres ficam em aberto. O tamanho da metrópole final e o detalhamento dos estilos estão em [Direções futuras](../future_directions.md).

## Profissões

O sistema atual de profissões está validado e é suficiente para esta etapa. O [registro de população inicial](../backups/metropole_800_blocos.md#população-inicial) reúne as regras de vagas, camas, postos de trabalho e nitwits.
