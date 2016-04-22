require 'spec_helper'

describe FipeApi::Veiculo do
  subject(:veiculo) do
    described_class.new(tipo_do_veiculo, id_marca)
  end

  let(:id_marca) { 'id_marca' }
  let(:tipo_do_veiculo) { FipeApi::TIPOS_DE_VEICULOS.sample }

  describe '#new' do
    it 'seta o tipo de veiculo' do
      expect(veiculo.tipo).to eq(tipo_do_veiculo)
    end

    it 'seta o id da marca' do
      expect(veiculo.id_marca).to eq(id_marca)
    end
  end

  describe '.por_marca' do
    subject(:veiculos) { described_class.por_marca(tipo_do_veiculo, id_marca) }

    let(:json_do_veiculo) { [{}] }
    let(:veiculo) { double(:veiculo) }
    let(:resposta_da_api) do
      double(:resposta_da_api, parsed_response: json_do_veiculo)
    end

    it 'busca tipo de veiculos por marca' do
      expect(HTTParty).to receive(:get)
        .with(marca_veiculos_urls(tipo_do_veiculo, id_marca))
        .and_return(resposta_da_api)

      veiculos
    end

    it 'retorna objetos Veiculo' do
      expect(HTTParty).to receive(:get)
        .and_return(resposta_da_api)

      expect(FipeApi::Veiculo).to receive(:new)
        .with(tipo_do_veiculo, id_marca, json_do_veiculo.first)
        .and_return(veiculo)

      expect(veiculos).to eq([veiculo])
    end
  end

  private

  def marca_veiculos_urls(tipo_do_veiculo, id_marca)
    "#{FipeApi::API_URL}/#{tipo_do_veiculo}/veiculos/#{id_marca}.json"
  end
end
