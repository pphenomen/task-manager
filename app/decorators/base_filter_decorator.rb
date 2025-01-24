class BaseFilterDecorator
	attr_reader :data

  def initialize(data)
    @data = data
  end

  def filter_by_field(data, field, value)
    data.where("#{field} ILIKE ?", "%#{value}%")
  end

  def filter(_params)
    raise NotImplementedError, "Метод filter должен быть переопределен в подклассахы"
  end
end
