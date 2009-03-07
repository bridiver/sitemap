module Queso
  module Acts
    module Sitemap
   
      def self.included(base)
        base.extend ClassMethods  
      end
      
      module ClassMethods
        
        def has_sitemap
          after_save :ping_all_search_engines
          include Queso::Acts::Sitemap::InstanceMethods
        end
        
      end
      
      module InstanceMethods
        require 'open-uri'
        
        def ping_all_search_engines
          return true
          ensure
            ping_search_engine
        end
        
        def ping_search_engine
          if location = SitemapSetting.find(:first).xml_location
            response = open("http://www.google.com/webmasters/sitemaps/ping?sitemap=#{location}")
            response = open("http://webmaster.live.com/ping.aspx?siteMap=#{location}")
          end
        end
        
      end
    end
  end
end
