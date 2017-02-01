require 'spec_helper'

describe FipeApi::Marca do
  subject(:marca) do
    described_class.new(tipo_do_veiculo, { 'id' => id_marca })
  end

  let(:tipo_do_veiculo) { FipeApi::TIPOS_DE_VEICULOS.sample }
  let(:id_marca) { 'id_marca' }

  describe '#new' do
    subject(:marca) { described_class.new(tipo_do_veiculo) }

    it 'set the veiculo type' do
      expect(marca.tipo_do_veiculo).to eq(tipo_do_veiculo)
    end
  end

  describe '.todas' do
    let(:marca_json) do
      { 'codigo' => 2, 'nome' => 'Agrale' }
    end

    let(:objeto_marca) { double(:objeto_marca) }
    let(:api_response) do
      double(:api_response, parsed_response: [marca_json], code: 200)
    end

    context 'quando não recebe o tipo do veiculo' do
      it 'usa o tipo carros' do
        expect(HTTParty).to receive(:get)
          .with(marca_urls('carros'))
          .and_return(api_response)

        FipeApi::Marca.todas
      end
    end

    context 'quando recebe o tipo do veiculo' do
      subject(:marcas) { FipeApi.marcas(tipo_do_veiculo) }
      let(:tipo_do_veiculo) { 'foo' }

      it 'pega as marcas do tipo passado' do
        expect(HTTParty).to receive(:get)
          .with(marca_urls(tipo_do_veiculo))
          .and_return(api_response)

        FipeApi::Marca.todas(tipo_do_veiculo)
      end

      it 'retorna objetos de Marca' do
        expect(HTTParty).to receive(:get)
          .and_return(api_response)

        expect(FipeApi::Marca).to receive(:new)
          .with(tipo_do_veiculo, marca_json)
          .and_return(objeto_marca)

        expect(FipeApi::Marca.todas(tipo_do_veiculo)).to eq([objeto_marca])
      end
    end
  end

  private

  def marca_urls(tipo_do_veiculo)
    "#{FipeApi::API_URL}/#{tipo_do_veiculo}/marcas"
  end
end
