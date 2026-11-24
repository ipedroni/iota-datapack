# Capital Cities

## Hierarquia de assentamentos

| Tipo | Escala | Papel no mapa |
|---|---|---|
| Capital | Porte variável e área bem maior que o protótipo 0.1 | Centro regional com bairros, mercado, fortificações e fazendas periféricas |
| Cidade menor | Porte variável, sempre abaixo do porte de uma capital | Núcleo intermediário nas rotas entre capitais |
| Acampamento | Menor que uma vila vanilla | Parada de rota ou pequeno posto isolado |

A versão 0.2 preserva o perímetro de teste de 88 × 88 blocos. A expansão da capital, as cidades menores e os acampamentos ficam no escopo futuro.

## População inicial

- A área dos lotes profissionais determina o orçamento de vagas. Fazendas e forte têm vagas próprias.
- Cada profissão sorteada tem pelo menos um villager com cama e posto de trabalho em um prédio compatível. Vagas disponíveis de uma mesma profissão podem ser compartilhadas no prédio existente.
- Nitwits podem representar até 40% da população inicial. O teto é o menor valor entre o número de camas residenciais reservadas e o piso de dois terços do número de profissionais. Com 30 profissionais, cabem até 20 nitwits, totalizando até 50 moradores.
- A versão 0.2 sorteia a quantidade de nitwits entre zero e o teto e reserva 20 camas em cinco residências.

## Planta inicial da capital de planície

O primeiro protótipo ocupa **800 × 800 blocos**, incluindo o núcleo murado e o entorno rural imediato. A planta começa em terreno plano, com ruas, perímetro e lotes marcados no chão. As cotas internas são hipóteses para testar a circulação e a leitura da cidade.

```text
                              NORTE
           +--------------------------------------+
           |    T============================T    |
           |    | Casas e oficinas   Forte   |    |
           |    |       +------------+       |    |
           |    |       |  Mercado   |       |    |
           |    |       +-----+------+       |    |
           |    | Casas       |     Oficinas |    |
           |    T========[ Portão ]==========T    |
           |    |||||||||     |     |||||||||     |
           |    Lavouras      |      Lavouras     |
           |    |||||||||     |     |||||||||     |
           +------------------+-------------------+
                               SUL
```

Vista esquemática. **T** indica uma reserva para torre de canto. O portão sul recebe a estrada rural e dá acesso direto à praça.

As coordenadas são locais, de 0 a 799 em cada eixo. X cresce para leste e Z para sul. Os intervalos incluem as duas pontas.

| Elemento | Coordenadas ou cota |
|---|---|
| Núcleo murado | X 120–679, Z 64–455. Perímetro de 560 × 392 blocos, inicialmente retangular. |
| Portão sul e barracas | Reserva em X 376–423, Z 424–455. O vão central se alinha à estrada. As barracas da guarnição ficam nas alas laterais do conjunto. |
| Praça do mercado | X 352–447, Z 256–319. Área de 96 × 64 blocos. |
| Eixo fazenda–portão–mercado | X 394–405, Z 320–799. Via principal com 12 blocos de largura, livre de lotes e barracas. |
| Forte | X 512–615, Z 104–191. Acesso pela rede de ruas internas. |
| Lavouras | Oito faixas paralelas de 48 × 280 blocos entre Z 496 e 775. Quatro a oeste do eixo começam em X 140, 192, 244 e 296. Quatro a leste começam em X 456, 508, 560 e 612. Dentro de cada grupo, caminhos de serviço de 4 blocos separam faixas vizinhas. |

Uma via transversal em **Z 480–487** liga as cabeceiras das lavouras à estrada rural. Ela permite chegar ao portão sem cruzar o plantio. A oeste e a leste da praça, reservar ruas secundárias de **5 blocos** para ligar as quadras ao mercado e ao forte. Espalhar casas de aldeões em ambos os lados da cidade, intercaladas com oficinas e perto dos postos de trabalho. Usar fachadas comerciais ao longo da rua principal e deixar a faixa junto à muralha livre para futuros acessos às torres e ao adarve.

## Evolução da capital

O foco atual são as cidades-estado de inspiração europeia medieval, com muralha, portão, praça de mercado, oficinas e moradias. A capital de planície é a base dos próximos protótipos.

- **Fortificações.** Elevar a muralha e ligar torres de canto e torres de guarda intermediárias por um adarve contínuo. Prever parapeitos, aberturas para arqueiros e acessos internos. Integrar barracas da guarnição aos portões e reservar espaço para circulação entre o nível da rua e o topo da muralha.
- **Prédios de profissão.** Criar um modelo reconhecível por profissão, tomando as construções de vila vanilla como base para fachadas, volumes e materiais. Manter o posto de trabalho acessível e distribuir as camas nas moradias próximas.
- **Referências visuais.** Usar o contraste entre um núcleo murado compacto e as lavouras externas, a sequência de fachadas comerciais entre portão e praça e a repetição de talhões compridos. Cais e pontes servem de referência para a variante de oceano.

### Traçado da muralha

Manter a área de 800 × 800 blocos e o eixo lavouras → portão sul → mercado. Na próxima revisão, testar um perímetro poligonal com chanfros nos cantos e dois recuos assimétricos nos flancos. Usar trechos diagonais em degraus largos, com torres nas mudanças de direção e caminho de ronda contínuo. Preservar um trecho reto no portão sul para acomodar as barracas da guarnição e manter a entrada visível desde as lavouras.

Usar os espaços irregulares entre a muralha e as quadras para pátios e pequenas praças. Manter os talhões longos, paralelos e próximos entre si. Avaliar a nova silhueta caminhando pela estrada rural e verificar se cada mudança de direção permite percorrer a muralha sem interrupções.

### Relevo e altura dos edifícios

Na planta padrão, variar a elevação por trecho e por bairro, independentemente da distância ao centro. Alternar aclives prolongados, descidas e desníveis bruscos, encaixando ruas e quadras nas cotas locais. Conectar os níveis com rampas e escadas e testar a circulação dos aldeões entre casas e postos de trabalho antes de fixar as cotas.

Na cidadela de inspiração chinesa, manter o terreno predominantemente plano e a silhueta baixa. Distribuir pequenos palacetes entre pátios, jardins e praças amplas. Usar portões e pavilhões para marcar a sequência de espaços, com elevações pontuais nas plataformas dos edifícios.

### Instalações para animais

- Prever canis e estábulos na capital.
- Avaliar um pequeno zoológico para abrigar animais resgatados.

| Variante regional | Adaptação da planta |
|---|---|
| Planície | Terreno de referência para a planta. Talhões paralelos e entrada terrestre pelo sul. |
| Deserto | Lavouras alongadas junto a canais e quadras mais sombreadas. |
| Montanha | Quadras em terraços e talhões compridos acompanhando as curvas de nível. |
| Floresta | Quadras em clareiras conectadas e lavouras agrupadas numa abertura junto ao portão. |
| Selva | Ruas elevadas onde houver áreas alagadas e faixas de plantio em terreno firme. |
| Oceano | Cais ligado ao mercado por uma via principal e plantio em faixas reunidas na costa ou em plataformas próximas. |

No primeiro teste, marcar as áreas no chão e percorrer **lavoura → portão → mercado** e **casa → posto de trabalho**. Medir os tempos a pé, conferir os acessos aos lotes e, ao ocupar uma quadra de teste, observar se os aldeões chegam às camas e estações. Dimensionar a população depois de validar esses trajetos.

## Curvas e interior da fortaleza — 0.6 e 0.7

- Evoluir a variação de traçado da 0.5 com arcos largos, trechos arredondados e curvas assimétricas. Representar as curvas em blocos com degraus de comprimentos variados. Manter os grandes desvios da muralha e preservar o alinhamento entre lavouras, portão sul e mercado.
- Usar muros internos e paredes de contenção para dividir a fortaleza em pátios de tamanhos e alturas diferentes. Alternar arcos, passagens estreitas, escadarias em curva e pequenos espaços abertos. Desencontrar as entradas para que cada pátio apareça aos poucos, à medida que o jogador sobe.
- Usar as imagens como referência visual para muralhas que acompanham o relevo, pátios encaixados entre construções e subidas estreitas de pedra. No próximo teste, percorrer a fortaleza do portão interno ao pátio superior e verificar a continuidade do caminho de ronda nas curvas.

## Próxima planta baixa — cidade moldada pelo terreno

Usar os 800 × 800 blocos como área de estudo. Desenhar primeiro o relevo, as margens do rio e as travessias. Em seguida, traçar as ruas e dividir em lotes os espaços que elas delimitam. Manter a chegada pelas lavouras, pelo portão sul e pelo mercado. O esquema mostra uma planta de teste, com o norte no topo.

```text
              NORTE
       Fortaleza alta     Cisterna ══ aqueduto ══ Nascente alta
            /                   │       ~~~
    Bairro em terraços ~ praça alta     ~~~
          /  ruelas             │       ~~~
    Casas com pátio ~~ praça do mercado ═ ponte ═ Bairro ribeirinho
                                │       ~~~
       Oficinas e sobrados ~~ rua larga ~~~
                                │          ~~~ → saída a leste
                           Portão sul
                                │
         Lavouras curvas ~~ estrada rural ~~ Lavouras curvas
               SUL
```

### Cotas e circulação

| Elemento | Proposta para a primeira planta |
|---|---|
| Rio | Corredor no flanco leste. Entra ao norte, faz meandros e sai pela lateral leste antes da faixa das lavouras. Testar um leito de 14 a 24 blocos e reservar margem livre em cada lado. |
| Aqueduto | Levar água de uma nascente alta a uma cisterna na cota da praça alta. Cruzar o vale sobre arcos, com altura livre para o caminho junto à água. |
| Ruas largas | 12 a 18 blocos livres no eixo comercial e na ligação à ponte. Alargar nos encontros com as praças. |
| Ruas de bairro | 5 a 9 blocos, acompanhando os terraços e contornando os lotes. Usar rampas ou escadas onde cruzarem cotas. |
| Ruelas | 3 a 4 blocos entre edifícios. Usar passagens curtas para ligar ruas próximas, com pelo menos duas saídas nas rotas entre moradias e postos de trabalho. |
| Praças | Praça de mercado de cerca de 96 × 64 blocos e praça alta de cerca de 48 × 36 blocos. Acrescentar pequenas aberturas junto a fontes, escadas e encontros de rua. |

Manter as áreas baixas junto ao rio mais abertas. Assentar os bairros em terraços nas cotas intermediárias e reservar a cota alta para o forte e edifícios oficiais. Usar os trechos íngremes para escadarias, muros de contenção e mirantes. Posicionar os lotes a partir das testadas das ruas e das plataformas disponíveis, com profundidades e orientações variadas.

### Lotes e volumes

Começar com uma hipótese de **60 a 90 lotes residenciais** na planta, além de oficinas e edifícios oficiais. Dimensionar as camas e a população depois do teste de circulação.

| Tipo | Implantação |
|---|---|
| Sobrado alto e estreito | Testada de 6 a 9 blocos e 3 a 4 pavimentos. Concentrar na rua comercial e em ruas próximas às praças. |
| Casa baixa e larga | Testada de 12 a 18 blocos e 1 a 2 pavimentos. Usar nos terraços mais largos, com pátios e jardins. |
| Casa pequena | Testada de 5 a 8 blocos, com espaço para poucos moradores. Distribuir pelas ruelas e perto das oficinas. |
| Edifício oficial | Implantar volumes maiores junto às praças ou em patamares que dominem o bairro. Reservar espaço para uma sede cívica e um celeiro público no primeiro estudo. |

Projetar balanços de 1 a 3 blocos nos pavimentos superiores. Alternar os avanços em lados opostos da rua para que as fachadas se intercalem em planta. Reservar cruzamentos pontuais sobre ruelas para galerias que liguem dois prédios. Manter pelo menos 4 blocos de altura livre sob passagens cobertas, conferir colisões entre volumes e orientar varandas para o rio, as praças ou os desníveis.

### Variação entre capitais

- Sortear uma semente a cada nova criação e armazená-la com a planta. Permitir reproduzir uma cidade informando a mesma semente.
- Variar primeiro o relevo e os meandros, depois a posição da ponte, da praça alta e das ruas secundárias. A partir da rede de ruas, sortear a divisão em lotes, a mistura de edifícios e os balanços.
- Conferir em cada planta os percursos portão → mercado, mercado → ponte e casa → oficina. Validar passagens sob balanços, desníveis transitáveis, encaixe dos lotes e continuidade do aqueduto.
- No primeiro ensaio, comparar três plantas de sementes diferentes. A diferença deve aparecer no traçado do rio, na posição das travessias e no desenho das quadras, além dos edifícios.

## Teste da 0.9

A muralha tem pilastras em intervalos regulares, torres de diferentes alturas e larguras e passagens abobadadas para a água sob o caminho de ronda. Cada planta inclui uma torre de magos circular com cobertura pontuda. O relevo do bairro varia por rua, com acessos em rampa escalonada e terraços de alturas diferentes.

A geração sorteia separadamente 12 traçados de rio e 12 malhas de bairro, com 144 combinações possíveis. O reset força a troca dos dois componentes. As demais partes da capital ainda usam a base comum.

## Regra de terreno e acabamento — 0.10

Distribuir lavouras pelos quatro lados da capital. Fazer cada faixa subir e descer com o terreno ao longo do próprio comprimento, com trechos suaves e degraus quando a cota muda. Manter as ruelas agrícolas estreitas e na cota dos talhões. A estrada principal continua como ligação entre o portão e a travessia rural.

Usar uma base escura de ardósia profunda, pedra e musgo nas faixas intermediárias, e tufo com andesito no alto da muralha e dos muros do forte. Distribuir rachaduras, peças cinzeladas, lajes e escadas parcialmente embutidas na face da parede. Dar às pilastras base escalonada, fuste estreito e capitel.

A 0.10 combina 16 traçados de rio com 16 variantes de bairro. A forma geral da muralha e o arranjo das lavouras ainda fazem parte da planta comum.

## Ideias para futuras cidades

**Tipos de planta.** Porto de canais com pontes e cais; cidade de encosta em terraços; cidade-oásis organizada por canais de irrigação; cidade de duas margens ligada por pontes; cidade radial com ruas convergindo para a praça; cidade de pátios com praças menores entre grupos de edifícios.

| Inspiração arquitetônica | Ideia para explorar |
|---|---|
| Chinesa | Cidadela baixa com pequenos palacetes entre pátios e jardins amplos. |
| Árabe | Medina com souk parcialmente coberto e moradias voltadas para pátios internos. |
| Japonesa | Cidade-castelo com fossos, pontes e portões desencontrados no caminho para o castelo. |
| Andina | Capital em terraços de pedra, com faixas de plantio e uma praça aberta. |
| Suaíli | Cidade portuária com cais, armazéns e casas mercantis de pedra. |
| Mesoamericana | Praças cerimoniais ligadas por calçadas elevadas, com plataformas escalonadas. |
| Saheliana | Edifícios de terra com contrafortes e oficinas agrupadas em pátios sombreados. |
