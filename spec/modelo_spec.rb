require 'spec_helper'

describe FipeApi::Modelo do
  subject(:modelo) do
    described_class.new(tipo_do_veiculo, id_marca)
  end

  let(:id_marca) { 'id_marca' }
  let(:tipo_do_veiculo) { FipeApi::TIPOS_DE_VEICULOS.sample }

  describe '#new' do
    it 'seta o tipo de veiculo' do
      expect(modelo.tipo_do_veiculo).to eq(tipo_do_veiculo)
    end

    it 'seta o id da marca' do
      expect(modelo.id_marca).to eq(id_marca)
    end
  end

  describe '.por_marca' do
    subject(:modelos) { described_class.por_marca(tipo_do_veiculo, id_marca) }

    let(:json_do_modelo) { [{}] }
    let(:modelo) { double(:modelo) }
    let(:resposta_da_api) do
      double(
        :resposta_da_api, parsed_response: { 'modelos' => json_do_modelo }
      )
    end

    it 'busca tipo de modelos por marca' do
      expect(HTTParty).to receive(:get)
        .with(marca_modelos_urls(tipo_do_veiculo, id_marca))
        .and_return(resposta_da_api)

      modelos
    end

    it 'retorna objetos Modelo' do
      expect(HTTParty).to receive(:get)
        .and_return(resposta_da_api)

      expect(FipeApi::Modelo).to receive(:new)
        .with(tipo_do_veiculo, id_marca, json_do_modelo.first)
        .and_return(modelo)

      expect(modelos).to eq([modelo])
    end
  end

  private

  def marca_modelos_urls(tipo_do_veiculo, id_marca)
    "#{FipeApi::API_URL}/#{tipo_do_veiculo}/marcas/#{id_marca}/modelos"
  end
end
