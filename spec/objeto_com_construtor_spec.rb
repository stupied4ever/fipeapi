require 'spec_helper'

describe FipeApi::ObjetoComConstrutor do
  class ClasseFalsa
    attr_accessor :key, :id, :fipe_name, :name

    include FipeApi::ObjetoComConstrutor
  end

  let(:id) { '42' }
  let(:key) { 'foo' }

  let(:valores_iniciais) do
    { 'id' => id, 'key' => key }
  end

  describe '#new' do
    context 'sem nenhum valor inicial' do
      subject(:objeto_construido) { ClasseFalsa.new() }

      it 'cria atributos vazios' do
        expect(objeto_construido.id).to eq(nil)
        expect(objeto_construido.key).to eq(nil)
      end
    end

    context 'com valores iniciais' do
      subject(:objeto_construido) { ClasseFalsa.new(valores_iniciais) }

      it 'seta o atributo id' do
        expect(objeto_construido.id).to eq(id)
      end

      it 'seta o atributo key' do
        expect(objeto_construido.key).to eq(key)
      end
    end

    context 'when try to set a field that do not exists' do
      it 'raises a NoMethodError' do
        expect{ ClasseFalsa.new({ 'a' => 1 })}.to raise_error(NoMethodError)
      end
    end
  end
end
