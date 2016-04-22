module Fipeapi
  class Brand
    attr_accessor :key, :id, :fipe_name, :name

    def initialize(opts = {})
      opts.keys do |key|
        self.send(key, opts[:key])
      end
    end
  end
end
