require_relative 'linkedlist'
class HashMap
  attr_accessor :buckets, :quantity, :capacity, :n

  def initialize
    @buckets = Array.new(16)
    @capacity = 16
    @quantity = 0
    @load_factor = 0.75
    @n = @load_factor * @capacity
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code % @capacity
  end

  def set(key, value)
    return overwrite(key, value) if has?(key)

    hashcode = hash(key)
    @buckets[hashcode] = LinkedList.new if @buckets[hashcode].nil?

    @buckets[hashcode].append([key, value])
    @quantity += 1
    grow if @quantity > @n
  end

  def get(key)
    hashcode = hash(key)
    return nil if @buckets[hashcode].nil?

    current_node = @buckets[hashcode].head
    current_node = current_node.next until current_node.nil? || current_node.value[0] == key
    current_node.value[1] unless current_node.nil?
  end

  def has?(key)
    return false if get(key).nil?

    true
  end

  def remove(key)
    return nil unless has?(key)

    bucket = @buckets[hash(key)]
    removed_entry = [key, get(key)]
    bucket.remove_at(bucket.find(removed_entry))
    @quantity -= 1
  end

  def length
    @quantity
  end

  def keys
    keys = []

    @buckets.each do |element|
      next if element.nil?

      current_node = element.head
      until current_node.nil?
        keys.push(current_node.value[0])
        current_node = current_node.next
      end
    end
    keys
  end

  def values
    values = []

    @buckets.each do |element|
      next if element.nil?

      current_node = element.head
      until current_node.nil?
        values.push(current_node.value[1])
        current_node = current_node.next
      end
    end
    values
  end

  def clear
    @buckets = []
    @quantity = 0
  end

  def grow
    old_entries = entries
    clear
    @buckets = Array.new(@capacity * 2)
    @capacity = @buckets.length
    @n = @capacity * @load_factor
    old_entries.each do |element|
      set(element[0], element[1])
    end
  end

  def entries
    entries = []

    @buckets.each do |element|
      next if element.nil?

      current_node = element.head
      until current_node.nil?
        entries.push(current_node.value)
        current_node = current_node.next
      end
    end
    entries
  end

  def overwrite(key, value)
    remove(key)
    @buckets[hash(key)].append([key, value])
    @quantity += 1
  end
end
