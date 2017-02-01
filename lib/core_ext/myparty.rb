class MyParty
  def self.get(*args)
    response = HTTParty.get(*args)
    if response.code == 404
      raise HTTParty::Error
    else
      response
    end
  end
end
