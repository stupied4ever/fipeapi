require 'spec_helper'

describe FipeApi::Preco do
  describe '#por_marca_codigo_do_veiculo_e_ano' do
    subject(:preco) do
      described_class.por_marca_codigo_do_veiculo_e_ano(
        tipo_do_veiculo,
        id_marca,
        id_veiculo,
        key_preco
      )
    end

    let(:tipo_do_veiculo) { FipeApi::TIPOS_DE_VEICULOS.sample }
    let(:id_marca) { 'id_marca' }
    let(:id_veiculo) { 'id_veiculo' }
    let(:key_preco) { 'key_preco' }

    let(:json_do_preco) { {} }
    let(:objeto_do_preco) { double(:objeto_do_preco) }

    let(:resposta_da_api) do
      double(:resposta_da_api, parsed_response: json_do_preco)
    end

    it 'busca o preco na api' do
      expect(HTTParty).to receive(:get)
        .with(
          url_de_preco(
            tipo_do_veiculo,
            id_marca,
            id_veiculo,
            key_preco
          )
        ).and_return(resposta_da_api)

      preco
    end

    it 'retorna objetos Preco' do
      expect(HTTParty).to receive(:get)
        .and_return(resposta_da_api)

      expect(FipeApi::Preco).to receive(:new)
        .with(json_do_preco)
        .and_return(objeto_do_preco)

      expect(preco).to eq(objeto_do_preco)
    end
  end

  private

  def url_de_preco(tipo_do_veiculo, id_marca, id_veiculo, id_do_preco)
    "#{FipeApi::API_URL}/#{tipo_do_veiculo}" \
      "/veiculo/#{id_marca}/#{id_veiculo}/#{id_do_preco}.json"
  end
end
