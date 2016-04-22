module FipeApi
  class Marca
    include ObjetoComConstrutor

    attr_accessor :key, :id, :fipe_name, :name, :tipo_do_veiculo, :order

    def self.todas(tipo_do_veiculo=CARRO)
      HTTParty
        .get("#{API_URL}/#{tipo_do_veiculo}/marcas.json")
        .parsed_response.map { |marca| Marca.new(tipo_do_veiculo, marca) }
    end

    def initialize(tipo_do_veiculo, opts = {})
      self.tipo_do_veiculo = tipo_do_veiculo
      self.id = tipo_do_veiculo

      super(opts)
    end

    def veiculos
      Veiculo.por_marca(tipo_do_veiculo, id)
    end
  end
end
