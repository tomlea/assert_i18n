module AssertI18n
  class << self
    # Walks a given tree of hashes, returning an array of possible walks through the tree.
    # flatten_hash_tree_keys({:a => { :b => 3, :c => 4 } }) # => [ [:a, :b], [:a, :c] ]
    def flatten_hash_tree_keys(tree, ancestors = [])
      tree.inject([]){|acc, (key, value)|
        if value.is_a? Hash
          acc + flatten_hash_tree_keys(value, ancestors + [key])
        else
          acc + [ancestors + [key]]
        end
      }
    end
  end
end
