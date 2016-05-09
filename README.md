# FipeApi

Bom, se você precisa consultar em tempo real a base da FIPE, esse é o projeto
que você quer usar.

Nós usamos a [FipeApi](http://deividfortuna.github.io/fipe/), uma api para a
base da FIPE e devolvemos objetos para todos os requests.

OBS: *Não temos como garantir a disponibilidade da API, e nem nós, nem os
programadores responsáveis pela API nos responsabilizamos por danos gerados pela
instabilidade no serviço*

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fipeapi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fipeapi

## Usage

```
[1] pry(main)> marca = FipeApi::Marca.todas.first
=> #<FipeApi::Marca:0x00000002192830 @codigo=1, @nome="Acura", @tipo_do_veiculo="carros">
[2] pry(main)>
[3] pry(main)> modelo = FipeApi::Modelo.por_marca(marca.tipo_do_veiculo, marca.codigo).first
=> #<FipeApi::Modelo:0x00000002f70740 @codigo=1, @id_marca=1, @nome="Integra GS 1.8", @tipo_do_veiculo="carros">
[4] pry(main)>
[5] pry(main)> ano = FipeApi::Ano.por_marca_e_modelo(modelo.tipo_do_veiculo, modelo.id_marca, modelo.codigo).first
=> #<FipeApi::Ano:0x000000020d5960 @codigo="1992-1", @id_marca=1, @id_modelo=1, @nome="1992 Gasolina", @tipo_do_veiculo="carros">
[6] pry(main)>
[7] pry(main)> valor = FipeApi::Valor.por_marca_modelo_e_id_fipe(ano.tipo_do_veiculo, ano.id_marca, ano.id_modelo, ano.codigo)
=> #<FipeApi::Valor:0x0000000206f9d0
 @ano_modelo=1992,
 @codigo_fipe="038003-2  ",
 @combustivel="Gasolina",
 @marca="Acura",
 @mes_referencia="maio de 2016",
 @modelo="Integra GS 1.8",
 @sigla_combustivel="G",
 @tipo_veiculo=1,
 @valor="R$ 13.198,00">
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

