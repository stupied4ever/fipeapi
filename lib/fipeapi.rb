require 'fipeapi/version'
require 'httparty'

require 'active_support/inflector'
require_relative './core_ext/myparty'
require_relative 'fipeapi/objeto_com_construtor'
require_relative 'fipeapi/marca'
require_relative 'fipeapi/modelo'
require_relative 'fipeapi/ano'
require_relative 'fipeapi/valor'

module FipeApi
  API_URL = 'https://fipe-parallelum.rhcloud.com/api/v1'
  CARRO = 'carros'
  MOTO = 'motos'
  CAMINHAO = 'caminhoes'
  TIPOS_DE_VEICULOS = [CARRO, MOTO, CAMINHAO].freeze
end
