module FipeApi
  class Veiculo
    include ObjetoComConstrutor

    attr_accessor :fipe_marca, :marca, :key, :id, :fipe_name, :tipo, :id_marca,
      :name

    def self.por_marca(tipo_do_veiculo, id_marca)
      HTTParty
        .get("#{API_URL}/#{tipo_do_veiculo}/veiculos/#{id_marca}.json")
        .parsed_response.map do |veiculo|
          Veiculo.new(tipo_do_veiculo, id_marca, veiculo)
        end
    end

    def initialize(tipo, id_marca, opts = {})
      self.tipo = tipo
      self.id_marca = id_marca
      super(opts)
    end

    def modelos
      Modelo.por_marca_e_id_do_veiculo(
        tipo,
        id_marca,
        id
      )
    end
  end
end
