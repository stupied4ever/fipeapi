require 'fipeapi'


FipeApi::Marca.todas.each do |brand|
  brand.modelos.each do |modelo|
    modelo.anos.each do |ano|
      p '========='
      p brand.codigo
      p modelo.codigo
      p ano.codigo
    end
  end
end
