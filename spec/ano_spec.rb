require 'spec_helper'

describe FipeApi::Ano do
  subject(:ano) do
    described_class.new(
      tipo_do_veiculo,
      id_marca,
      id_modelo,
      { 'codigo' => '1991-1', 'nome' => '1991 Gasolina' }
    )
  end

  let(:tipo_do_veiculo) { FipeApi::TIPOS_DE_VEICULOS.sample }
  let(:id_marca) { 'id_marca' }
  let(:id_modelo) { 'id_modelo' }

  let(:json_do_ano) { [{}] }
  let(:objeto_do_ano) { double(:objeto_do_ano) }

  let(:resposta_da_api) do
    double(:resposta_da_api, parsed_response: json_do_ano, code: 200)
  end

  describe '#new' do
    it 'seta o tipo do veiculo' do
      expect(ano.tipo_do_veiculo).to eq(tipo_do_veiculo)
    end

    it 'seta o id da marca' do
      expect(ano.id_marca).to eq(id_marca)
    end

    it 'seta o id do veiculo' do
      expect(ano.id_modelo).to eq(id_modelo)
    end
  end

  describe '#por_marca_e_id_do_veiculo' do
    subject(:anos) do
      described_class.por_marca_e_modelo(
        tipo_do_veiculo,
        id_marca,
        id_modelo
      )
    end

    it 'busca anos do veiculo' do
      expect(HTTParty).to receive(:get)
        .with(url_de_anos(tipo_do_veiculo, id_marca, id_modelo))
        .and_return(resposta_da_api)

      anos
    end

    it 'retorna objetos do tipo Ano' do
      expect(HTTParty).to receive(:get)
        .and_return(resposta_da_api)

      expect(FipeApi::Ano).to receive(:new)
        .with(tipo_do_veiculo, id_marca, id_modelo, json_do_ano.first)
        .and_return(objeto_do_ano)

      expect(anos).to eq([objeto_do_ano])
    end
  end

  private

  def url_de_anos(tipo_do_veiculo, id_marca, id_modelo)
    "#{FipeApi::API_URL}/#{tipo_do_veiculo}/marcas/#{id_marca}/" \
      "modelos/#{id_modelo}/anos"
  end
end
