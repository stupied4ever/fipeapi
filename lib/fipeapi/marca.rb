module FipeApi
  class Marca
    include ObjetoComConstrutor

    attr_accessor :codigo, :nome, :tipo_do_veiculo

    def self.todas(tipo_do_veiculo=CARRO)
      HTTParty
        .get("#{API_URL}/#{tipo_do_veiculo}/marcas")
        .parsed_response.map { |marca| Marca.new(tipo_do_veiculo, marca) }
    end

    def initialize(tipo_do_veiculo, opts = {})
      self.tipo_do_veiculo = tipo_do_veiculo
      self.codigo = tipo_do_veiculo

      super(opts)
    end

    def modelos
      Modelo.por_marca(tipo_do_veiculo, codigo)
    end
  end
end
