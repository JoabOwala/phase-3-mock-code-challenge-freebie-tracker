class Company < ActiveRecord::Base
    has_many :freebies
    has_many :devs, through: :freebies

    def freebies
        Freebies.where(company_id: id)
    end

    def devs
        Dev.joins(:freebies).where(freebies: { company_id: id })
    end

    def give_freebie(dev, item_name, value)
        freebies.create(dev: dev, item_name: item_name, value: value)
    end

    def self.oldest_company
        order(:founding_year).first
    end


end
