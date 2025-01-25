class BaseDecorator
  def initialize(object)
    @object = object
  end

  # получение значения атрибута
  def value_for(attr)
    if respond_to?(attr, true)
      send(attr)
    elsif @object.respond_to?(attr)
      @object.public_send(attr)
    else
      nil
    end
  end

  # локализация атрибутов
  def self.column_names_rus
    raise NotImplementedError, "Метод `column_names_rus` должен быть реализован в подклассе"
  end

  private

  attr_reader :object
end
