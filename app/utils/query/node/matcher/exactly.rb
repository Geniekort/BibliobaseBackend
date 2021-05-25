module Query::Node::Matcher
  class Exactly < Matcher

    def validate
      if node_key != "exactly"
        errors.add(:node_key, :invalid)
        return false
      end

      super
    end
  end  
end
