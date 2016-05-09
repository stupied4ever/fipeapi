module FipeApi
  class Valor
    include ObjetoComConstrutor

    attr_accessor :valor, :marca, :modelo, :ano_modelo, :combustivel,
      :codigo_fipe, :mes_referencia, :tipo_veiculo, :sigla_combustivel

    def self.por_marca_modelo_e_id_fipe(
      tipo_do_veiculo,
      id_marca,
      id_modelo,
      id_fipe
    )
      Valor.new(
        parse_json_response(
          HTTParty
            .get(endpoint(tipo_do_veiculo, id_marca, id_modelo, id_fipe))
            .parsed_response
        )
      )
    end

    private

    def self.parse_json_response(json_response)
      Hash[json_response.map do |key, value|
        [key.underscore, value]
      end]
    end


    def self.endpoint(tipo_do_veiculo, id_marca, id_modelo, id_fipe)
      "#{FipeApi::API_URL}/#{tipo_do_veiculo}/marcas/#{id_marca}/" \
        "modelos/#{id_modelo}/anos/#{id_fipe}"
    end
  end
end
