module FipeApi
  class Preco
    include ObjetoComConstrutor

    attr_accessor :referencia, :fipe_codigo, :name, :combustivel, :marca,
      :ano_modelo, :preco, :key, :time, :veiculo, :id

    def self.por_marca_codigo_do_veiculo_e_ano(
      tipo_do_veiculo,
      id_marca,
      id_veiculo,
      key_preco
    )
      Preco.new(
        HTTParty
        .get(endpoint(tipo_do_veiculo, id_marca, id_veiculo, key_preco))
        .parsed_response
      )
    end

    private

    def self.endpoint(tipo_do_veiculo, id_marca, id_veiculo, key_preco)
      "#{FipeApi::API_URL}/#{tipo_do_veiculo}/veiculo/#{id_marca}/" \
        "#{id_veiculo}/#{key_preco}.json"
    end
  end
end
