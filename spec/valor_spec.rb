require 'spec_helper'

describe FipeApi::Valor do
  describe '#por_marca_codigo_do_veiculo_e_ano' do
    subject(:valor) do
      described_class.por_marca_modelo_e_ano(
        tipo_do_veiculo,
        id_marca,
        id_modelo,
        ano
      )
    end

    let(:tipo_do_veiculo) { FipeApi::TIPOS_DE_VEICULOS.sample }
    let(:id_marca) { 'id_marca' }
    let(:id_modelo) { 'id_modelo' }
    let(:ano) { 'ano' }

    let(:json_do_valor) do
      {
        'Valor' => 'R$ 12.269,00', 'Marca' => 'Acura',
        'Modelo' => 'Integra GS 1.8', 'AnoModelo' => 1991,
        'Combustivel' => 'Gasolina', 'CodigoFipe' => '038003-2',
        'MesReferencia' => 'maio de 2016', 'TipoVeiculo' => 1,
        'SiglaCombustivel' => 'G'
      }
    end

    let(:json_do_valor_undrescore) do
      {
        'valor' => 'R$ 12.269,00', 'marca' => 'Acura',
        'modelo' => 'Integra GS 1.8', 'ano_modelo' => 1991,
        'combustivel' => 'Gasolina', 'codigo_fipe' => '038003-2',
        'mes_referencia' => 'maio de 2016', 'tipo_veiculo' => 1,
        'sigla_combustivel' => 'G'
      }
    end

    let(:objeto_do_valor) { double(:objeto_do_valor) }

    let(:resposta_da_api) do
      double(:resposta_da_api, parsed_response: json_do_valor)
    end

    it 'busca o valor na api' do
      expect(HTTParty).to receive(:get)
        .with(
          url_de_valor(
            tipo_do_veiculo,
            id_marca,
            id_modelo,
            ano
          )
        ).and_return(resposta_da_api)

      valor
    end

    it 'retorna objetos Valor' do
      expect(HTTParty).to receive(:get)
        .and_return(resposta_da_api)

      expect(FipeApi::Valor).to receive(:new)
        .with(json_do_valor_undrescore)
        .and_return(objeto_do_valor)

      expect(valor).to eq(objeto_do_valor)
    end
  end

  private

  def url_de_valor(tipo_do_veiculo, id_marca, id_modelo, ano)
    "#{FipeApi::API_URL}/#{tipo_do_veiculo}/marcas/#{id_marca}/" \
      "modelos/#{id_modelo}/anos/#{ano}"
  end
end
