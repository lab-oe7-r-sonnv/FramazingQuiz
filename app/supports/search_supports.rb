class SearchSupports
  attr_reader :searched_params

  def initialize searched_params
    @searched_params = searched_params
  end

  def value
    searched_params.base.conditions.first.values.first.value
  end

  def search_value_empty?
    searched_params.base.conditions.first ? false : true
  end
end
