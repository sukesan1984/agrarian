class GaussianRandomize
  # 整数を取る
  def self.rand_int(mu, sigma, min, max)
    return RandomBell.new(mu: mu, sigma: sigma, range: min..max).rand.round
  end
end
