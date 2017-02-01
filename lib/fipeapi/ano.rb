module FipeApi
  class Ano
    include ObjetoComConstrutor

    attr_accessor :id_marca, :id_modelo, :tipo_do_veiculo, :nome, :codigo

    def initialize(tipo_do_veiculo, id_marca, id_modelo, opts = {})
      self.tipo_do_veiculo = tipo_do_veiculo
      self.id_marca = id_marca
      self.id_modelo = id_modelo

      super(opts)
    end

    def self.por_marca_e_modelo(
      tipo_do_veiculo,
      id_marca,
      id_modelo
    )
      MyParty
        .get(endpoint(tipo_do_veiculo, id_marca, id_modelo))
        .parsed_response.map do |ano|
          Ano.new(tipo_do_veiculo, id_marca, id_modelo, ano)
        end
    rescue HTTParty::Error
      nil
    end

    def valor
      Valor.por_marca_modelo_e_ano(
        tipo_do_veiculo,
        id_marca,
        id_modelo,
        codigo
      )
    end

    private

    def self.endpoint(tipo_do_veiculo, id_marca, id_modelo)
      "#{FipeApi::API_URL}/#{tipo_do_veiculo}/marcas/#{id_marca}/" \
        "modelos/#{id_modelo}/anos"
    end
  end
end
