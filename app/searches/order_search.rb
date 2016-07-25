class OrderSearch < Lupa::Search
  class scope
    def name
      scope.where(status: search_attributes[:status])
    end
  end
end