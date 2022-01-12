class EstyService
  def repo
    get_url("/repos/kevingloss/little-esty-shop")
  end

  def contributor
    get_url("/repos/kevingloss/little-esty-shop/contributors")
  end

  def get_url(url)
    response = HTTParty.get("https://api.github.com#{url}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
