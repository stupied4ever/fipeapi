module FipeApi
  module ObjetoComConstrutor
    def initialize(opts = {})
      opts.keys.each do |key|
        self.send("#{key}=", opts[key])
      end
    end
  end
end
