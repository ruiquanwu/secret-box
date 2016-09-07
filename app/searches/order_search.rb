class OrderSearch < Lupa::Search
  class Scope
    def name
      scope.where(status: search_attributes[:status])
    end
  end
end