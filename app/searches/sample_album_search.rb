class SampleAlbumSearch < Lupa::Search
  class Scope
    
    def orientation
      scope.where(orientation: search_attributes[:orientation])
    end
    
    def has_memo
      scope.where(has_memo: search_attributes[:has_memo])
    end
    
    def max_page
      scope.where(max_page: search_attributes[:max_page])
    end
    
    def photo_per_page
      scope.where(photo_per_page: search_attributes[:photo_per_page])
    end
    
  end
end