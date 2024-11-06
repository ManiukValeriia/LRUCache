class LRUCache
  def initialize(capacity)
    @capacity = capacity
    @cache = {}
    @usage_order = []
  end

  # Метод для отримання значення по ключу
  def get(key)
    return "nil" unless @cache.key?(key)  # Повертаємо рядок "nil"
    
    # Оновлюємо порядок використання
    @usage_order.delete(key)
    @usage_order << key
    @cache[key]
  end

  # Метод для додавання пари ключ-значення
  def put(key, value)
    if @cache.key?(key)
      # Оновлюємо значення та порядок використання
      @usage_order.delete(key)
    elsif @cache.size >= @capacity
      # Видаляємо найменш недавно використовуваний елемент
      oldest_key = @usage_order.shift
      @cache.delete(oldest_key)
    end

    # Додаємо нове значення та оновлюємо порядок використання
    @cache[key] = value
    @usage_order << key
  end
end

# Приклад використання
cache = LRUCache.new(2)
cache.put(1, 1)
cache.put(2, 2)
puts cache.get(1)  # Виведе 1
cache.put(3, 3)    # Видалить ключ 2, оскільки він найменш недавно використовуваний
puts cache.get(2)  # Виведе "nil", оскільки ключ 2 був видалений
puts cache.get(3)  # Виведе 3
