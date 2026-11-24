# Capital Cities — checklist de distribuição e teste

## Pacote

- [ ] Gerar o ZIP com o [script Python](../tools/build-capital-cities.py).
- [ ] Conferir o nome `capital_cities_v<versão>_mc<versão-do-jogo>.zip` em `dist/`.
- [ ] Verificar a integridade do ZIP, a presença de `pack.mcmeta` na raiz e as referências internas de funções e dimensão.
- [ ] Manter o ZIP mais recente na raiz de dist/ e mover as versões anteriores para dist/version history/.
- [ ] Registrar as mudanças no [histórico de versões](release_changelog.md).

## Teste no Minecraft Java 1.21.11

- [ ] Instalar o ZIP em `datapacks` num mundo novo com comandos habilitados e reabrir o mundo.
- [ ] Anotar coordenadas seguras no Overworld, rodar `/function capital_cities:visit` e acompanhar com `/function capital_cities:status`.
- [ ] Conferir a planta e os percursos previstos nas [Criação da metrópole](discovery/metropole_creation.md).
- [ ] Voltar com `/execute in minecraft:overworld run tp @s <x> <y> <z>`.
- [ ] Com todos fora da dimensão da capital, rodar `/function capital_cities:reset`, aguardar a confirmação e visitar de novo.
