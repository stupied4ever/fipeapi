module FipeApi
  class Modelo
    include ObjetoComConstrutor

    attr_accessor :id_marca, :tipo_do_veiculo, :nome, :codigo

    def self.por_marca(tipo_do_veiculo, id_marca)
      HTTParty
        .get("#{API_URL}/#{tipo_do_veiculo}/marcas/#{id_marca}/modelos")
        .parsed_response['modelos'].map do |modelo|
          Modelo.new(tipo_do_veiculo, id_marca, modelo)
        end
    end

    def initialize(tipo_do_veiculo, id_marca, opts = {})
      self.tipo_do_veiculo = tipo_do_veiculo
      self.id_marca = id_marca
      super(opts)
    end

    def anos
      Ano.por_marca_e_modelo(
        tipo_do_veiculo,
        id_marca,
        codigo
      )
    end
  end
end
