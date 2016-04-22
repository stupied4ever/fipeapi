# FipeApi

Bom, se você precisa consultar em tempo real a base da FIPE, esse é o projeto
que você quer usar.

Nós usamos a [fipeapi.appspot](http://fipeapi.appspot.com/), uma api para a
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
=> #<FipeApi::Marca:0x0000000330ca20 @fipe_name="Audi", @id=6, @key="audi-6", @name="AUDI", @order=2, @tipo_do_veiculo="carros">
[2] pry(main)> veiculo = FipeApi::Veiculo.por_marca('carro', '21').first
=> #<FipeApi::Veiculo:0x00000003534b68
 @fipe_marca="Fiat",
 @fipe_name="147 C/ CL",
 @id="437",
 @id_marca="21",
 @key="147-437",
 @marca="FIAT",
 @name="147 C/ CL",
 @tipo="carro">
[3] pry(main)> modelo = FipeApi::Modelo.por_marca_e_id_do_veiculo('carro', '21', '4828').first
=> #<FipeApi::Modelo:0x00000001a92f30
 @fipe_codigo="2014-1",
 @fipe_marca="Fiat",
 @id="2014-1",
 @id_marca="21",
 @id_veiculo="4828",
 @key="2014-1",
 @marca="FIAT",
 @name="2014 Gasolina",
 @tipo_do_veiculo="carro",
 @veiculo="Palio 1.0 ECONOMY Fire Flex 8V 4p">
[4] pry(main)> preco = FipeApi::Preco.por_marca_codigo_do_veiculo_e_ano('carro', '21', '4828', '2014-1')
=> #<FipeApi::Preco:0x00000003670db0
 @ano_modelo="2014",
 @combustivel="Gasolina",
 @fipe_codigo="001267-0",
 @id="2014",
 @key="palio-2014",
 @marca="Fiat",
 @name="Palio 1.0 ECONOMY Fire Flex 8V 4p",
 @preco="R$ 24.541,00",
 @referencia="abril de 2016",
 @time=0.0,
 @veiculo="Palio 1.0 ECONOMY Fire Flex 8V 4p">
[5] pry(main)>
[6] pry(main)> marca = FipeApi::Marca.todas.first
=> #<FipeApi::Marca:0x000000034f7470 @fipe_name="Audi", @id=6, @key="audi-6", @name="AUDI", @order=2, @tipo_do_veiculo="carros">
[7] pry(main)> veiculo = marca.veiculos.first
=> #<FipeApi::Veiculo:0x000000031e3590
 @fipe_marca="Audi",
 @fipe_name="100 2.8 V6",
 @id="43",
 @id_marca=6,
 @key="100-43",
 @marca="AUDI",
 @name="100 2.8 V6",
 @tipo="carros">
[8] pry(main)> modelo = veiculo.modelos.first
=> #<FipeApi::Modelo:0x000000030c2ad0
 @fipe_codigo="1995-1",
 @fipe_marca="Audi",
 @id="1995-1",
 @id_marca=6,
 @id_veiculo="43",
 @key="1995-1",
 @marca="AUDI",
 @name="1995 Gasolina",
 @tipo_do_veiculo="carros",
 @veiculo="100 2.8 V6">
[9] pry(main)> preco = modelo.preco
=> #<FipeApi::Preco:0x000000030051b0
 @ano_modelo="1995",
 @combustivel="Gasolina",
 @fipe_codigo="008030-6",
 @id="1995",
 @key="100-1995",
 @marca="Audi",
 @name="100 2.8 V6",
 @preco="R$ 14.980,00",
 @referencia="abril de 2016",
 @time=0.009999999999990905,
 @veiculo="100 2.8 V6">
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

