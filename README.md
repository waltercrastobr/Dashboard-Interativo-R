# Dashboard Interativo R
## Dashboard de Evolução da COVID-19 nos EUA

Este dashboard interativo em Shiny exibe a evolução da COVID-19 nos Estados Unidos, utilizando um dataset que fornece os dados diários acumulados de casos e mortes por COVID-19 em cada estado.

Ele permite que os usuários selecionem um estado específico, escolham um intervalo de datas e visualizem dados de casos ou mortes.

### Funcionalidades:
- Seleção de Estado: Use o menu suspenso para selecionar um estado dos Estados Unidos.
- Intervalo de Datas: Escolha um intervalo de datas para visualizar os dados.
- Tipo de Dado: Selecione entre visualizar dados de casos ou mortes.
- Gráfico de Linhas: Exibe a evolução dos dados selecionados para o estado escolhido.
- Histograma: Mostra a distribuição dos dados selecionados em forma de histograma.
- Boxplot: Apresenta a distribuição dos dados selecionados através de um boxplot.
- Tabela de Resumo: Exibe estatísticas descritivas dos dados selecionados.

### Como Usar:

- Instalação de Pacotes: Certifique-se de ter os pacotes shiny e shinydashboard instalados. Você pode instalá-los executando o seguinte código em seu console R:

install.packages("shiny")
install.packages("shinydashboard")
Carregamento do Dataset: Certifique-se de que o arquivo CSV States.csv esteja presente no mesmo diretório que o seu script R.

- Execução do Aplicativo: Execute o script R e acesse o aplicativo Shiny no seu navegador.

- Seleção de Estado, Intervalo de Datas e Tipo de Dado: Use os controles disponíveis no painel lateral para selecionar um estado, um intervalo de datas e o tipo de dado (casos ou mortes) a ser visualizado.

- Visualização dos Dados: O dashboard exibirá o gráfico de linhas, histograma, boxplot e a tabela de resumo de acordo com as suas seleções.

### Arquivos no Repositório:

- Link do Site Kaggle para obtenção do dataset: https://www.kaggle.com/datasets/imoore/us-covid19-dataset-live-hourlydaily-updates?select=States.csv
- States.csv: O arquivo CSV contendo os dados da COVID-19 nos Estados Unidos por estado e data.
- meuapp.R: O script R que define o aplicativo Shiny.

### Créditos

Este aplicativo foi criado pelo alunos: Walter de Crasto, Francisco Gabriel, Ivo Neto, Pedro Fischer e Getúlio Junqueira como parte do projeto do curso de Estatística do 2 período do curso de Ciêcia da Computação da UFPE.
