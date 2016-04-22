require 'fipeapi/version'
require 'httparty'
require_relative 'fipeapi/objeto_com_construtor'
require_relative 'fipeapi/marca'
require_relative 'fipeapi/veiculo'
require_relative 'fipeapi/modelo'
require_relative 'fipeapi/preco'

module FipeApi
  API_URL = 'http://fipeapi.appspot.com/api/1'
  CARRO = 'carros'
  MOTO = 'motos'
  CAMINHAO = 'caminhoes'
  TIPOS_DE_VEICULOS = [CARRO, MOTO, CAMINHAO].freeze
end
