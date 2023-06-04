class Dev < ActiveRecord::Base
    has_many :companies
    has_many :freebies, through: :companies

    def freebies
        Freebie.where(dev_id: id)
      end
    
      def companies
        Company.joins(:freebies).where(freebies: { dev_id: id })
      end

      def received_one?(item_name)
        freebies.exists?(item_name: item_name)
      end
    
      def give_away(dev, freebie)
        if freebie.dev == self
          freebie.update(dev: dev)
        end
      end
end
