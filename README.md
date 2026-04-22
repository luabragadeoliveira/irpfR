
<!-- README.md is generated from README.Rmd. Please edit that file -->

# irpfR <img src='man/figures/logo.png' align="right" height="139" />

<!-- badges: start -->

![alt
text](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)
![alt text](https://www.r-pkg.org/badges/version/irpfR)
[![R-CMD-check](https://github.com/luabragadeoliveira/irpfR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/luabragadeoliveira/irpfR/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of `irpfR` is to provide a seamless interface for accessing,
cleaning, and understanding the Personal Income Tax (IRPF) Open Data
provided by the Brazilian Federal Revenue (Receita Federal do Brasil -
RFB). Directly downloading data from the government portal often
involves dealing with inconsistently formatted CSV files, complex
encoding issues, and tricky numerical scales. `irpfR` automates this
engineering work, returning “tidy” data frames ready for economic and
social analysis.

## Features

- **Data Discovery**: Quickly list all available data sections (assets,
  debts, income brackets, etc.).
- **Built-in Dictionary**: Access detailed metadata and attribute
  descriptions without leaving R.
- **Automated Cleaning**: Standardized column names, UTF-8 encoding
  correction, and “tidy” (long) format conversion.
- **Smart Scaling**: Automatic conversion of financial values (from
  millions to absolute BRL) while preserving counts (number of
  taxpayers).

## Installation

You can install the development version of `irpfR` from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("luabragadeoliveira/irpfR")
```

## Quick Start

### 1. List Available Sections

Not sure what data is available? Use `get_sections()` to see the
catalog:

``` r
library(irpfR)

get_sections()
#> Fetching available sections for IRPF data...
#> # A tibble: 23 × 2
#>    secao                                 descricao                              
#>    <chr>                                 <chr>                                  
#>  1 bens_e_direitos                       Números das Declarações do Imposto de …
#>  2 faixa_de_base_de_calculo_anual        Resumo das declarações por faixa de ba…
#>  3 rendimentos_isentos_e_nao_tributaveis Agregado dos rendimentos isentos e não…
#>  4 residencia_capital                    Resumo das declarações dos contribuint…
#>  5 dividas_e_onus                        Total de valores declarados por tipo d…
#>  6 residencia_uf                         Resumo das declarações dos contribuint…
#>  7 base_calculo_sm_genero                Resumo das declarações por faixa de ba…
#>  8 doacoes_herancas                      Resumo das declarações por faixa de do…
#>  9 rendimento_tributavel_bruto           Resumo das declarações por faixa de re…
#> 10 rendimentos_totais                    Resumo das declarações por faixa de re…
#> # ℹ 13 more rows
```

### 2. Check Metadata

Before downloading, understand what each column in a specific section
means:

``` r
# Example for 'Assets and Rights' (Bens e Direitos)
get_metadata("bens_e_direitos")
#> Fetching metadata for section: 'bens_e_direitos'...
#> # A tibble: 61 × 2
#>    atributo                                              descricao              
#>    <chr>                                                 <chr>                  
#>  1 ano_calendario                                        Informa o ano calendár…
#>  2 acoes_inclusive_as_provenientes_de_linha_telefonica   Ações declaradas como …
#>  3 aeronave                                              Aeronaves declaradas.  
#>  4 apartamento                                           Apartamentos declarado…
#>  5 aplicacao_de_renda_fixa_cdb_rdb_e_outros              Aplicações de renda fi…
#>  6 bem_relacionado_com_o_exercicio_da_atividade_autonoma Bens de atividade autô…
#>  7 benfeitorias                                          Benfeitorias declarada…
#>  8 caderneta_de_poupanca                                 Saldo de cadernetas de…
#>  9 casa                                                  Casas declaradas.      
#> 10 consorcio_nao_contemplado                             Consórcios não contemp…
#> # ℹ 51 more rows
```

### 3. Download and Clean Data

Download the complete historical series for a section. The function
handles the connection, downloads a temporary file, and structures the
data into a tidy format:

``` r
# This will download and clean the "Assets and Rights" dataset
get_irpf("bens_e_direitos")
```

## Data Scale Note

Please note that financial values in the original RFB files are often
scaled (where numbers before the comma represent millions). `irpfR`
automatically detects financial columns and multiplies them by one
million to return absolute values in Reais (BRL), while keeping integer
columns.

## License

This package is licensed under the MIT License.
