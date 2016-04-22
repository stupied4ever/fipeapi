module FipeApi
  class Modelo
    include ObjetoComConstrutor

    attr_accessor :fipe_marca, :fipe_codigo, :name, :marca, :key, :veiculo,
      :id, :id_veiculo, :tipo_do_veiculo, :id_marca

    def initialize(tipo_do_veiculo, id_marca, id_veiculo, opts = {})
      self.tipo_do_veiculo = tipo_do_veiculo
      self.id_marca = id_marca
      self.id_veiculo = id_veiculo

      super(opts)
    end

    def self.por_marca_e_id_do_veiculo(
      tipo_do_veiculo,
      id_marca,
      codigo_veiculo
    )
      HTTParty
        .get(endpoint(tipo_do_veiculo, id_marca, codigo_veiculo))
        .parsed_response.map do |modelo|
          Modelo.new(tipo_do_veiculo, id_marca, codigo_veiculo, modelo)
        end
    end

    def preco
      Preco.por_marca_codigo_do_veiculo_e_ano(
        tipo_do_veiculo,
        id_marca,
        id_veiculo,
        key
      )
    end

    private

    def self.endpoint(tipo_do_veiculo, id_marca, codigo_veiculo)
      "#{FipeApi::API_URL}/#{tipo_do_veiculo}/veiculo/#{id_marca}/" \
        "#{codigo_veiculo}.json"
    end
  end
end
