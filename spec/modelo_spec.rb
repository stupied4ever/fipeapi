require 'spec_helper'

describe FipeApi::Modelo do
  subject(:modelo) do
    described_class.new(
      tipo_do_veiculo,
      id_marca,
      id_veiculo,
      { 'key' => 'id_do_preco' }
    )
  end

  let(:tipo_do_veiculo) { FipeApi::TIPOS_DE_VEICULOS.sample }
  let(:id_marca) { 'id_marca' }
  let(:id_veiculo) { 'id_veiculo' }

  let(:json_do_modelo) { [{}] }
  let(:objeto_do_modelo) { double(:objeto_do_modelo) }

  let(:resposta_da_api) do
    double(:resposta_da_api, parsed_response: json_do_modelo)
  end

  describe '#new' do
    it 'seta o tipo do veiculo' do
      expect(modelo.tipo_do_veiculo).to eq(tipo_do_veiculo)
    end

    it 'seta o id da marca' do
      expect(modelo.id_marca).to eq(id_marca)
    end

    it 'seta o id do veiculo' do
      expect(modelo.id_veiculo).to eq(id_veiculo)
    end
  end

  describe '#por_marca_e_id_do_veiculo' do
    subject(:modelos) do
      described_class.por_marca_e_id_do_veiculo(
        tipo_do_veiculo,
        id_marca,
        id_veiculo
      )
    end

    it 'busca modelos do veiculo' do
      expect(HTTParty).to receive(:get)
        .with(url_de_modelos(tipo_do_veiculo, id_marca, id_veiculo))
        .and_return(resposta_da_api)

      modelos
    end

    it 'retorna objetos Modelo' do
      expect(HTTParty).to receive(:get)
        .and_return(resposta_da_api)

      expect(FipeApi::Modelo).to receive(:new)
        .with(tipo_do_veiculo, id_marca, id_veiculo, json_do_modelo.first)
        .and_return(objeto_do_modelo)

      expect(modelos).to eq([objeto_do_modelo])
    end
  end

  private

  def url_de_modelos(tipo_do_veiculo, id_marca, id_veiculo)
    "#{FipeApi::API_URL}/#{tipo_do_veiculo}/veiculo/#{id_marca}/" \
      "#{id_veiculo}.json"
  end
end
